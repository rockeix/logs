<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "Header.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>포스트 내용</title>
    <link rel="stylesheet" href="/CSS/index3.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- jQuery 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div class="container" id="postpage">
<div id="postBoard"></div>

<div id="comentlist"></div>

<div class="container"  id="comentporm">
    <div class="row" id="comentwrite">
        <div class="col-9">
            <textarea class="form-control" id="comentContent" name="comentContent"></textarea><br>
        </div>
        <div class="col-3">
            <input type="Nickname" class="form-control mb-2" id="comentNickname" name="comentNickname" placeholder="닉네임">
            <input type="password" class="form-control mb-2" id="comentPW" name="comentPW" placeholder="비밀번호">
            <input type="button" class="btn btn-primary mx-auto d-block" id="subit_btn" value="등록" onclick="submitComment()">
        </div>
    </div>
</div>
</div>
<div class="d-flex justify-content-between align-items-center">
<input type="button" id="index2_btn" value="목록" onclick="index2()">
<input type="button" id="index_btn" value="글쓰기" onclick="">
</div>


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
                var postHTML = '<div class="card bg-white" data-id="' + post.postNo + '">';
                postHTML += '<div class="card-header bg-white">';
                postHTML += '<h2>' + post.postName + '</h2>';
                postHTML += '</div>';
                postHTML += '<div class="card-body d-flex justify-content-between align-items-center">';
                postHTML += '<p>작성자: ' + post.userNickname + '</p>';
                postHTML += '<p>' + post.postCreateDate + '</p>';
                postHTML += '</div>';
                postHTML += '<div class="card-footer bg-white">';
                postHTML += '<p>' + post.postContent + '</p>';
                postHTML += '</div>';
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
    var replyForm = $("#replyForm" + comentNo);
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
            // 댓글을 트리 구조로 변환
            var comentsMap = {};
            var rootComents = [];

            response.forEach(function(coment) {
                coment.children = [];
                comentsMap[coment.comentNo] = coment;

                if (coment.comentDepth === "0") {
                    rootComents.push(coment);
                } else {
                    var parentComent = comentsMap[coment.cocomentNo];
                    if (parentComent) {
                        parentComent.children.push(coment);
                    }
                }
            });

            $("#comentlist").empty(); // 기존 댓글 삭제

            // 트리 구조를 바탕으로 HTML 생성
            function generateComentHTML(coment, comentDepth = 0) {
                 var marginValue = 20 - (comentDepth * 2); // 깊이에 따라 마진 줄이기 (2px 단위로 줄임)
                if (marginValue < 5) marginValue = 5; // 최소 마진 값 설정
                var comentHTML = '<div class="card" data-id="' + coment.postNo + '" style="margin-left: ' + (comentDepth * 20) + 'px; margin-top: ' + marginValue + 'px;">'; // 깊이에 따라 들여쓰기 및 마진 적용
                comentHTML += '<div class="card-header d-flex justify-content-between align-items-center">';
                comentHTML += '<h5 class="mb-0">' + coment.comentNickname + '</h5>';
                comentHTML += '<div class="d-flex justify-content-between align-items-center">';
                comentHTML += '<p class="mb-0 me-2">' + coment.comentCreateDate + '</p>';
                if (coment.comentDelete === "0") {
                    comentHTML += '<button onclick="showDeletePasswordForm(' + coment.postNo + ', ' + coment.comentNo + ')">삭제</button>';  
                }
                comentHTML += '</div>';
                comentHTML += '</div>';
                comentHTML += '<div class="card-body">';

                // 삭제된 댓글에는 onclick 이벤트를 추가하지 않음
                if (coment.comentDelete !== "0") {
                    comentHTML += '<p class="card-text text-muted"><i>삭제된 댓글입니다.</i></p>';
                } else {
                    comentHTML += '<p class="card-text" onclick="showReplyForm(' + coment.comentNo + ')">' + coment.comentContent + '</p>';
                    // 깊이가 12를 초과하면 답글을 달 수 없음을 알리는 메시지 출력
                if (comentDepth<12) {  
                    comentHTML += '<div id="replyForm' + coment.comentNo + '" style="display:none;" class="mt-3">';
                    comentHTML += '<div class="row">';
                    comentHTML += '<div class="col-9 ">';
                    comentHTML += '<textarea id="replyContent' + coment.comentNo + '" class="form-control " placeholder="답글 내용"></textarea>';
                    comentHTML += '</div>';
                    comentHTML += '<div class="col-3">';
                    comentHTML += '<input type="text" id="replyNickname' + coment.comentNo + '" class="form-control mb-2" placeholder="닉네임">';
                    comentHTML += '<input type="password" id="replyPW' + coment.comentNo + '" class="form-control mb-2" placeholder="비밀번호">';
                    comentHTML += '<button class="btn btn-primary mx-auto d-block" onclick="submitReply(' + coment.postNo + ', ' + coment.comentNo + ', ' + (Number(coment.comentDepth) + 1) + ')">답글 제출</button>';
                    comentHTML += '</div>';
                    comentHTML += '</div>';
                    comentHTML += '</div>';
                }else{
                    comentHTML += '<p class="text-danger mt-2">더 이상 답글을 달 수 없습니다.</p>';
                }
                }
                comentHTML += '</div>';
                comentHTML += '</div>';

                // 대댓글이 있으면 재귀적으로 HTML 생성
                if (coment.children.length > 0) {
                    coment.children.forEach(function(childComent) {
                        comentHTML += generateComentHTML(childComent, comentDepth + 1); // 깊이를 증가시키며 재귀 호출
                    });
                }

                return comentHTML;
            }

            rootComents.forEach(function(coment) {
                var comentHTML = generateComentHTML(coment);
                $("#comentlist").append(comentHTML);
            });
        },
        error: function(xhr, status, error) {
            alert("에러 입니다: " + error);
        }
    });
}

function submitReply(postNo, comentNo, depth) {
    var replyContent = $("#replyContent" + comentNo).val().trim();
    var replyNickname = $("#replyNickname" + comentNo).val().trim();
    var replyPW = $("#replyPW" + comentNo).val().trim();

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
    $("#replyForm" + comentNo).toggle();
}

function showDeletePasswordForm(postNo, comentNo) {
    var deleteFormHTML = '<div id="deleteForm' + comentNo + '" class="deleteForm">';
    deleteFormHTML += '<h3>댓글 삭제</h3>';
    deleteFormHTML += '<input type="password" id="deletePW' + comentNo + '" placeholder="비밀번호">';
    deleteFormHTML += '<button onclick="deleteComment(' + postNo + ', ' + comentNo + ')">삭제</button>';
    deleteFormHTML += '<button onclick="hideDeleteForm(' + comentNo + ')">취소</button>';
    deleteFormHTML += '</div>';

     // 특정 댓글 요소 내부에 삭제 폼 추가
    $('#replyForm' + comentNo).after(deleteFormHTML);
}

function hideDeleteForm(comentNo) {
    $('#deleteForm' + comentNo).remove();
}


function deleteComment(comentPW,comentNo) {
    var comentPW = $('#deletePW' + comentNo).val();
    var postNo = decodeURIComponent(getParameterByName('postNo'));

    if (comentPW === '') {
        alert("비밀번호를 입력해주세요.");
        return;
    }

    $.ajax({
        type: "POST",
        url: "/logs/verify",  // 서버에서 비밀번호 검증을 처리하는 엔드포인트
        data: JSON.stringify({ comentNo: comentNo, comentPW: comentPW }),
        contentType: "application/json",
        success: function(response) {
            if (response.valid) {
                // 비밀번호가 유효하면 댓글 삭제 요청
                $.ajax({
                    type: "POST",
                    url: "/logs/update",  // 서버에서 댓글 삭제를 처리하는 엔드포인트
                    data: JSON.stringify({ comentNo: comentNo }),
                    contentType: "application/json",
                    success: function(response) {
                        alert("댓글이 삭제되었습니다.");
                        hideDeleteForm(comentNo);
                        loadCommentlist(postNo); // 댓글 리스트를 다시 로드하여 갱신
                    },
                    error: function(xhr, status, error) {
                        alert("댓글 삭제에 실패하였습니다.");
                    }
                });
            } else {
                alert("비밀번호가 올바르지 않습니다.");
            }
        },
        error: function(xhr, status, error) {
            alert("비밀번호 확인에 실패하였습니다.");
        }
    });
}

function index2() {
    window.location.href = "/logs/index2";
}
</script>
</body>
</html>