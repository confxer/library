<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정해요</title>
</head>
<body>
	<h2>공지사항 수정</h2>

	<form action="${pageContext.request.contextPath}/notice/update" method="post">
		<input type ="hidden" name="num" value="${notice.num}"/>
		
		 <p>
            <label for="title">제목:</label><br>
            <input type="text" name="title" id="title" value="${notice.title}" required style="width: 20%; padding: 8px; box-sizing: border-box;" />
        </p>
        <p>
            <label for="content">내용:</label><br>
            <textarea name="content" id="content" rows="10" cols="50" required>${notice.content}</textarea>
        </p>
        <p>	
			<button type="submit">수정</button>
			<a href="${pageContext.request.contextPath}/notice/detail?num=${notice.num}">
			<button type="button">취소</button>
			</a>		
		</p>
		
	</form>


</body>
</html>