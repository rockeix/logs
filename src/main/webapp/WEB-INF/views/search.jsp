<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8"%>
<%@ include file = "Header.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello</title>
    <!-- jQuery 추가 -->
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
                                var resultHtml = '<div class="result">' +
                                    item.postNo + '<br>' +
                                    item.postName + '<br>' +
                                    item.postContent + '<br>' +
                                    item.userNickname + '<br>' +
                                    '</div>';
                                resultsDiv.append(resultHtml);
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
