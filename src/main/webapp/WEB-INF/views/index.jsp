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
    <script src="https://cdn.ckeditor.com/ckeditor5/41.3.1/classic/ckeditor.js"></script>
    <%-- 이미지 업로드 어댑터 --%>
    <script src="https://ckeditor.com/apps/ckfinder/3.5.0/ckfinder.js"></script>
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
// CKEditor 5 초기화
ClassicEditor
    .create(document.querySelector('#postContent'), {
                ckfinder: {
                uploadUrl : '/logs/temp'
            }
    })
    .then(createdEditor => {
        console.log('CKEditor 5 initialized:', createdEditor);
        editor = createdEditor; // 에디터를 전역 변수에 할당
    })
    .catch(error => {
        console.error('CKEditor 5 initialization failed:', error);
    });

    window.addEventListener("beforeunload", function(event) {
    navigator.sendBeacon("/logs/cleanup");
    return '';
    });

function submitForm() {
    var editorData = editor.getData();
    var parser = new DOMParser();
    var doc = parser.parseFromString(editorData, 'text/html');
    var images = doc.querySelectorAll('img');

    images.forEach(function(img) {
        var src = img.src.replace('http://localhost:8080', '');
        img.src = src.replace('/temp/', '/upload/');
    });

    var updatedEditorData = doc.body.innerHTML;

    var formData = {
        "postName": $("#postName").val(),
        "postContent": updatedEditorData,
        "userNickname": $("#userNickname").val(),
        "userPW": $("#userPW").val()
    };

    var fileNames = getFileNames(images);

    console.log("Form Data:", formData);
    console.log("File Names:", fileNames);

    $.ajax({
        type: "POST",
        url: "/logs/moveFiles",
        contentType: "application/json",
        data: JSON.stringify(fileNames),
        success: function(response) {
            $.ajax({
                type: "POST",
                url: "/logs/save",
                contentType: "application/json",
                data: JSON.stringify(formData),
                success: function(response) {
                    alert("저장성공.");
                },
                error: function(xhr, status, error) {
                    alert("저장에 실패했습니다: " + xhr.responseText);
                }
            });
        },
        error: function(xhr, status, error) {
            console.error("파일 이동에 실패했습니다: ", xhr.responseText);
            alert("파일 이동에 실패했습니다: " + xhr.responseText);
        }
    });
}

function getFileNames(images) {
    var fileNames = [];
    images.forEach(function(img) {
        var src = img.src;
        var fileName = src.substring(src.lastIndexOf('/') + 1);
        fileNames.push(fileName);
    });
    return fileNames;
}

function index2() {
    window.location.href = "/logs/index2";
}
</script>
</body>
</html>