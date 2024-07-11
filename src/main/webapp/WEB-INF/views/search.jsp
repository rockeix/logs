<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8"%>
<%@ include file = "Header.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello</title>

    <link rel="stylesheet" href="/CSS/Search.css">
    <!-- jQuery 추가 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<body>

<div class="container" id=searchresult>
    <div class="container-fluid">
        <div class="col-12">
            <input type="text"  class="form-control" id="searchBox" placeholder="검색">
        </div>
    </div>
    <div class="container">
        <div class="search-results">
            <div id="results"></div>
        </div>
    </div>
</div>

<script>
     $(document).ready(function() {
            $('#searchBox').on('input', function() {
                var query = $(this).val();
                if (query.length > 0) {
                    $.ajax({
                        url: '/logs/Pon',
                        type: 'GET',
                        data: { search: query },
                        success: function(data) {
                            var resultsDiv = $('#results');
                            resultsDiv.empty();
                            data.forEach(function(post) {
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
                                postHTML += '<p class="createdate">생성날짜: ' + post.postCreateDate + '</p>';
                                postHTML += '<p class="writer">작성자: ' + post.userNickname + '</p>';
                                postHTML += '</div>';
                                resultsDiv.append(postHTML);
                            });
                            $(".postNo").click(function() {
                                var postNo = $(this).data("id"); // 클릭한 포스트의 넘버 가져오기
                                window.location.href = "/logs/index3?postNo=" + encodeURIComponent(postNo);
                            });
                        }
                    });
                } else {
                    $('#results').empty();
                }
            });
        });
</script>

</body>
</html>
