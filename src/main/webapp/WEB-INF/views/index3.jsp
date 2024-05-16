<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>포스트 내용</title>
    <!-- jQuery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div id="postBoard">
</div>
<input type="button" value="게시판 이동" onclick= "index2()"><br>
<script>
$(document).ready(function() {
    // 페이지 로드시 자동으로 포스트 내용 불러오기
    loadPostContent();
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

function index2() {
    window.location.href = "/logs/index2";
}
</script>
</body>
</html>