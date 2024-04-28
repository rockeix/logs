<%@ page language="java" contentType="text/html; charset=UTF-8"     pageEncoding="UTF-8"%>

<%
String content = request.getParameter("content");
%>

<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello</title>
</head>
<body>
<%=content %>
    <button type="button" onclick="location.href='/'">이동</button>

</body>
</html>
