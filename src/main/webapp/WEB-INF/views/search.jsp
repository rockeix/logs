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
<input type="text" id="searchBox" placeholder="Search...">
<div id="results"></div>
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
                            data.forEach(function(item) {
                                var resultHtml = '<div class="result" data-id="' + item.postNo + '">' +
                                    item.postNo + '<br>' +
                                    item.postName + '<br>' +
                                    item.postContent + '<br>' +
                                    item.userNickname + '<br>' +
                                    '</div>';
                                resultsDiv.append(resultHtml);
                            });
                            $(".result").click(function() {
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
