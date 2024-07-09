<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8"%>
<%@ include file = "Header.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello</title>
    <!-- jQuery 추가 -->
    <link rel="stylesheet" href="CSS/index2.css">
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
                postHTML += '<h2>' + post.postName + '</h2>';
                
                // 첫 번째 이미지를 추출
                var firstImage = post.postContent.match(/<img[^>]+src="([^">]+)"/);
                if (firstImage) {
                    postHTML += '<img src="' + firstImage[1] + '" alt="썸네일" class="thumbnail">';
                }

                // 이미지 태그를 제거한 텍스트만 추출
                var textContent = post.postContent.replace(/<img[^>]*>/g, '').replace(/<[^>]+>/g, '');

                // 글자 수 제한 및 ... 추가
                if (firstImage) {
                    if (textContent.length > 1) {
                        textContent = textContent.substring(0, 1) + '...';
                    }
                } else {
                    if (textContent.length > 3) {
                        textContent = textContent.substring(0, 3) + '...';
                    }
                }
                
                postHTML += '<p class="postContent">' + textContent + '</p>';
                postHTML += '<p class="writer">작성자: ' + post.userNickname + '</p>';
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
