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
    // 에디터에서 가져온 내용을 변수에 저장
    var editorData = editor.getData();

    // DOMParser를 사용하여 HTML 문자열을 파싱
    var parser = new DOMParser();
    var doc = parser.parseFromString(editorData, 'text/html');

    // 이미지 태그를 모두 찾아서 src 속성을 변경
    var images = doc.querySelectorAll('img');
    images.forEach(function(img) {
        // 절대 경로에서 베이스 URL을 제거
        var src = img.src.replace('http://localhost:8080', '');

        // /temp/를 /upload/로 변경
        img.src = src.replace('/temp/', '/upload/');
    });

    // 수정된 HTML을 다시 문자열로 변환
    var updatedEditorData = doc.body.innerHTML;


    // 서브밋 폼 데이터 설정
    var formData = {
        "postName": $("#postName").val(),
        "postContent": updatedEditorData, // 에디터에서 가져온 내용 사용
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