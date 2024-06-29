<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "Header.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>포스트 내용</title>
    <!-- jQuery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div id="postBoard"></div>

<div id="comentlist"></div>

<form id="comentporm">
    <div id="coment-write">
        <input type="Nickname" id="comentNickname" name="comentNickname" placeholder="닉네임"><br>
        <input type="password" id="comentPW" name="comentPW" placeholder="비밀번호"><br>
        <textarea id="comentContent" name="comentContent"></textarea>
        <input type="button" value="등록" onclick="submitComment()"><br>
    </div>
    <input type="button" value="게시판 이동" onclick="index2()">
    <input type="button" value="삭제" onclick="">
</form>



<script>
$(document).ready(function() {
    // 페이지 로드시 자동으로 포스트 내용 불러오기
    loadPostContent();
    loadCommentlist();
});

function loadPostContent() {
    // URL에서 포스트 넘버 가져오기
    var postNo = decodeURIComponent(getParameterByName('postNo'));
    
    // AJAX를 통해 해당 포스트의 내용 가져오기
    $.ajax({
                type: "GET",
                url: "/logs/Nos",
                data: { postNo: postNo },
                contentType: "application/json",
                success: function(response) {

                response.forEach(function(post) {
                // 각 포스트를 게시판 형식으로 출력
                var postHTML = '<div class="postNo" data-id="' + post.postNo + '">';
                postHTML += '<h2 >' + post.postName + '</h2>';
                postHTML += '<p>작성자: ' + post.userNickname + '</p>';
                postHTML += '<p>' + post.postContent + '</p>';
                postHTML += '</div>';
                
                $("#postBoard").append(postHTML);
            });
                },
                error: function(xhr, status, error) {
                    alert("에러 입니다: " + error);
        }
    });
}

function getParameterByName(name, url) { // URL에서 특정 이름(name)의 쿼리 파라미터(parameter) 값을 추출하는 함수
    if (!url) url = window.location.href; // URL이 주어지지 않았을 경우, 기본값으로 현재 창의 URL을 사용
    name = name.replace(/[\[\]]/g, "\\$&"); // 추출하려는 쿼리 파라미터의 이름에 대괄호([])가 포함되어 있을 수 있으므로 이스케이프 처리
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"), // URL에서 쿼리 파라미터를 추출하기 위한 정규표현식 생성
        results = regex.exec(url); // 정규표현식을 사용하여 URL에서 쿼리 파라미터를 추출
    if (!results) return null; // 쿼리 파라미터가 발견되지 않았을 경우, null 반환
    if (!results[2]) return ''; // 쿼리 파라미터의 값이 없을 경우, 빈 문자열 반환
    return decodeURIComponent(results[2].replace(/\+/g, " ")); // 쿼리 파라미터의 값을 디코딩하여 반환
}

function showReplyForm(comentNo) {
    var replyForm = $("#replyForm-" + comentNo);
    if (replyForm.css("display") === "none") {
        replyForm.show();
    } else {
        replyForm.hide();
    }
}

function loadCommentlist() {
    // URL에서 포스트 넘버 가져오기
    var postNo = decodeURIComponent(getParameterByName('postNo'));

    $.ajax({
        type: "GET",
        url: "/logs/Clist",
        data: { postNo: postNo },
        contentType: "application/json",
        success: function(response) {
            $("#comentlist").empty(); // 기존 댓글 삭제
            response.forEach(function(coment) {
                var comentHTML = '<div class="postNo" data-id="' + coment.postNo + '">';
                    comentHTML += '<h2>' + coment.comentNickname + '</h2>';
                    comentHTML += '<p class="comentContent" onclick="showReplyForm(' + coment.comentNo + ')">' + coment.comentContent + '</p>';
                    comentHTML += '<p>' + coment.comentCreateDate + '</p>';
                    comentHTML += '<button onclick="showDeletePasswordForm(' + coment.postNo + ', ' + coment.comentNo + ')">삭제</button>';
                    comentHTML += '<div id="replyForm-' + coment.comentNo + '" style="display:none;">';
                    comentHTML += '<input type="text" id="replyNickname-' + coment.comentNo + '" placeholder="닉네임">';
                    comentHTML += '<input type="password" id="replyPW-' + coment.comentNo + '" placeholder="비밀번호">';
                    comentHTML += '<textarea id="replyContent-' + coment.comentNo + '" placeholder="답글 내용"></textarea>';
                    comentHTML += '<button onclick="submitReply(' + coment.postNo + ', ' + coment.comentNo + ', ' + (Number(coment.comentDepth) + 1) + ')">답글 제출</button>';
                    comentHTML += '</div>';
                     comentHTML += '</div>';
                $("#comentlist").append(comentHTML);
            });
        },
        error: function(xhr, status, error) {
            alert("에러 입니다: " + error);
        }
    });
}

function submitReply(postNo, comentNo, depth) {
    var replyContent = $("#replyContent-" + comentNo).val().trim();
    var replyNickname = $("#replyNickname-" + comentNo).val().trim();
    var replyPW = $("#replyPW-" + comentNo).val().trim();

    if (replyContent === "" || replyNickname === "" || replyPW === "") {
        alert("내용, 닉네임을 모두 입력해주세요.");
        return; // 저장을 차단
    }

    var formData = {
        "postNo": postNo,
        "comentContent": replyContent,
        "comentNickname": replyNickname,
        "comentPW": replyPW,
        "comentNo": comentNo,
        "cocomentNo": comentNo, // 부모 댓글의 ID
        "comentDepth": depth, // 부모 댓글보다 1 증가
    };

    console.log("Form Data:", formData);

    $.ajax({
        type: "POST",
        url: "/logs/write",
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(response) {
            alert("답글 작성 성공.");
            loadCommentlist(); // 답글 작성 후 댓글 목록 다시 로드
        },
        error: function(xhr, status, error) {
            alert("답글 작성에 실패했습니다: " + xhr.responseText);
        }
    });
}

function submitComment() {
    // URL에서 포스트 넘버 가져오기
    var postNo = decodeURIComponent(getParameterByName('postNo'));
    var comentContent = $("#comentContent").val().trim();
    var comentNickname = $("#comentNickname").val().trim();
    var comentPW = $("#comentPW").val().trim();

        if (comentContent === "" || comentNickname === "" || comentPW ==="") {
        alert("내용, 닉네임을 모두 입력해주세요.");
        return; // 저장을 차단
    }

    var formData = {
        "postNo": postNo,
        "comentContent": comentContent,
        "comentNickname": comentNickname,
        "comentPW": comentPW,
        "cocomentNo": null,
        "comentDepth": 0,
    };

    console.log("Form Data:", formData);

    $.ajax({
        type:"POST",
        url:"/logs/write",
        contentType:"application/json",
        data:JSON.stringify(formData),
        success:function(response){
            alert("댓글 작성 성공.");
             loadCommentlist(); // 댓글 작성 후 댓글 목록 다시 로드
        },
        error: function(xhr, status, error) {
            alert("댓글 작성에 실패했습니다: " + xhr.responseText);
        }
    });
    
}

function showReplyForm(comentNo) {
    $("#replyForm-" + comentNo).toggle();
}

function showDeletePasswordForm(postNo, comentNo) {
    var deleteFormHTML = '<div id="deleteForm-' + comentNo + '" class="deleteForm">';
    deleteFormHTML += '<h3>댓글 삭제</h3>';
    deleteFormHTML += '<input type="password" id="deletePW-' + comentNo + '" placeholder="비밀번호">';
    deleteFormHTML += '<button onclick="deleteComment(' + postNo + ', ' + comentNo + ')">삭제</button>';
    deleteFormHTML += '<button onclick="hideDeleteForm(' + comentNo + ')">취소</button>';
    deleteFormHTML += '</div>';

     // 특정 댓글 요소 내부에 삭제 폼 추가
    $('#replyForm-' + comentNo).after(deleteFormHTML);
}

function hideDeleteForm(comentNo) {
    $('#deleteForm-' + comentNo).remove();
}


function deleteComment(comentPW,comentNo) {
    var comentPW = $('#deletePW-' + comentNo).val();

    if (comentPW === '') {
        alert("비밀번호를 입력해주세요.");
        return;
    }

    $.ajax({
        type: "POST",
        url: "/logs/update",  // 서버에서 댓글 삭제를 처리하는 엔드포인트
        data: JSON.stringify({ comentNo: comentNo, comentPW: comentPW }),
        contentType: "application/json",
        success: function(response) {
                alert("댓글이 삭제되었습니다.");
                hideDeleteForm(comentNo);
                loadCommentlist(); // 댓글 리스트를 다시 로드하여 갱신
        },
        error: function(xhr, status, error) {
            alert("비밀번호가 올바르지 않습니다.:" + error);
        }
    });
}

function index2() {
    window.location.href = "/logs/index2";
}
</script>
</body>
</html>