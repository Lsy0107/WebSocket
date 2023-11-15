<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<body>
    <h1>Main.jsp</h1>

    <button>채팅페이지 1</button>

    <button onclick="chatPage2()">채팅페이지 2</button>

</body>
<script type="text/javascript">
    function chatPage2(){
        let chatId = prompt('사용자이름 입력');
        console.log(chatId);
        location.href="chatPage2?chatId="+chatId;
    }
</script>
</html>