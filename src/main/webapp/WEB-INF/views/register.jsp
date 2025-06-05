<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 20px; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .container { background-color: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); width: 100%; max-width: 400px; }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 8px; color: #555; font-weight: bold; }
        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="email"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1em;
        }
        .form-group input[type="text"]:focus,
        .form-group input[type="password"]:focus,
        .form-group input[type="email"]:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }
        .btn-register {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-register:hover {
            background-color: #0056b3;
        }
        .message {
            text-align: center;
            margin-top: 20px;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>회원가입</h2>
        <form action="${pageContext.request.contextPath}/member/register" method="post">
            <div class="form-group">
                <label for="memberId">아이디:</label>
                <input type="text" id="memberId" name="memberId" required>
            </div>
            <div class="form-group">
                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="passwordConfirm">비밀번호 확인:</label>
                <input type="password" id="passwordConfirm" name="passwordConfirm" required>
            </div>
            <div class="form-group">
                <label for="name">이름:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">이메일:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">전화번호:</label> <input type="text" id="phone" name="phone"> </div>
            <div class="form-group">
                <label for="address">주소:</label>
                <input type="text" id="address" name="address">
            </div>
            <button type="submit" class="btn-register">회원가입</button>
        </form>

        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>
    </div>

    <script>
        // 클라이언트 측 비밀번호 확인 로직 (선택 사항)
        document.querySelector('form').addEventListener('submit', function(event) {
            const password = document.getElementById('password').value;
            const passwordConfirm = document.getElementById('passwordConfirm').value;

            if (password !== passwordConfirm) {
                alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
                event.preventDefault(); // 폼 제출 방지
            }
        });
    </script>
</body>
</html>