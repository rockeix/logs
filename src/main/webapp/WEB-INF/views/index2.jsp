<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8"%>
<%@ include file = "Header.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello</title>
    <!-- jQuery 추가 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<div id="postBoard">
</div>

<script>
$(document).ready(function() {
    // 페이지 로드시 자동으로 데이터 불러오기
    loadPostData();

     // 브라우저 뒤로가기/앞으로가기 이벤트 처리
    window.addEventListener('popstate', function() {
        loadPostData();
        });
});

function loadPostData() {
    $.ajax({
        type: "GET",
        url: "/logs/all",
        contentType: "application/json",
        success: function(response) {
            // 받아온 데이터를 반복문을 통해 출력
            $("#postBoard").empty(); // 기존 내용 삭제
            response.forEach(function(post) {
                // 각 포스트를 게시판 형식으로 출력
                var postHTML = '<div class="postNo" data-id="' + post.postNo + '">';
                postHTML += '<h2 >' + post.postName + '</h2>';
                postHTML += '<p>작성자: ' + post.userNickname + '</p>';
                postHTML += '<p>' + post.postContent + '</p>';
                postHTML += '</div>';
                
                $("#postBoard").append(postHTML);
            });
                $(".postNo").click(function() {
                var postNo = $(this).data("id"); // 클릭한 포스트의 넘버 가져오기
                window.location.href = "/logs/index3?postNo=" + encodeURIComponent(postNo);
            });
            // URL을 변경합니다.
            index2urlchange();
        },
        error: function(xhr, status, error) {
            alert("에러 입니다: " + error);
        }
    });
}
function index2urlchange() {
    // 새로운 URL을 지정합니다.
    var newURL = "/postBoard";
    
    // history.pushState() 메서드를 사용하여 URL을 변경합니다.
    history.pushState({}, '', newURL);
}
</script>
</body>
</html>
