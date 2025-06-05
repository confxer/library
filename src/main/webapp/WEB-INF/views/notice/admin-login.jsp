<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 접속</title>
</head>
<body>

 <h2> 🔐 관리자 로그인 </h2>
 		<form action="/library/notice/admin-login" method="post" >
   	     	<label>아이디:</label>
 			<input type="text" name="username" placeholder="관리자 계정의 ID"  required><br>
	        <label>비밀번호:</label>
 			<input type="password" name="password" placeholder="관리자 계정의 Password" required><br>
 			<button type="submit">관리자 로그인</button>
 		</form>
 		 		
 			<c:if test="${not empty error}">
        	<div style="color:red">${error}</div>
        	</c:if>
 		
</body>
</html>