<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/library/notice/list" method="post"/>
	
		<c:if test="${loggedInMember.role == ''}">
			<a href="/notice/write">글쓰기</a>
			<a href="/notice/admin-logout">로그아웃</a>
        </c:if>
</body>
</html>