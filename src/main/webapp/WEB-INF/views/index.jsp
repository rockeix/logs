<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8"%>

<%
String content = request.getParameter("content");
%>

<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello</title>
    <!-- jQuery 추가 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<form id="logForm">
    <label for="postName">제목:</label><br>
    <input type="text" id="postName" name="postName"><br>
    <label for="postContent">내용:</label><br>
    <textarea id="postContent" name="postContent"></textarea><br>
    <label for="userNickname">닉네임:</label><br>
    <input type="text" id="userNickname" name="userNickname"><br>
    <label for="userPW">패스워드:</label><br>
    <input type="password" id="userPW" name="userPW"><br>
    <input type="button" value="저장하기" onclick="submitForm()"><br>
    <input type="button" value="게시판 이동" onclick= "index2()"><br>
</form>

<script>
function submitForm() {
    var formData = {
        "postName": $("#postName").val(),
        "postContent": $("#postContent").val(),
        "userNickname": $("#userNickname").val(),
        "userPW": $("#userPW").val()
    };
    
    $.ajax({
        type: "POST",
        url: "/logs/save",
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(response) {
            alert("저장되었습니다.");
        },
        error: function(xhr, status, error) {
            alert("저장에 실패했습니다: " + xhr.responseText);
        }
    });
}
function index2() {
    window.location.href = "/logs/index2";
}
</script>
</body>
</html>