<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: calc(100% - 22px); /* Padding 고려 */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box; /* 패딩이 너비에 포함되도록 */
        }
        .btn-login {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-login:hover {
            background-color: #0056b3;
        }
        .register-link {
            margin-top: 20px;
            font-size: 14px;
            color: #777;
        }
        .register-link a {
            color: #007bff;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
        .error-message {
            color: red;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>로그인</h2>

        <c:if test="${not empty message}">
            <p class="error-message">${message}</p>
        </c:if>

        <form action="/library/member/login" method="post">
         <input type="hidden" name="redirectUrl" value="${redirectUrl}">
            <div class="form-group">
                <label for="memberId">아이디</label>
                <input type="text" id="memberId" name="memberId" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn-login">로그인</button>
        </form>

        <div class="register-link">
            계정이 없으신가요? <a href="/library/member/register">회원가입</a>
        </div>
    </div>
</body>
</html>