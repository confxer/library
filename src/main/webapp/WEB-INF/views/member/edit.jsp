<%-- src/main/webapp/WEB-INF/views/member/edit.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f0f2f5; color: #333; line-height: 1.6; }
        .header { background-color: #28a745; color: white; padding: 20px 0; text-align: center; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2); margin-bottom: 30px;}
        .header h1 { margin: 0; font-size: 2.5em; letter-spacing: 1px; }
        .container { width: 90%; max-width: 700px; margin: 30px auto; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); }
        h2 { font-size: 2.2em; color: #28a745; text-align: center; margin-bottom: 25px; padding-bottom: 10px; border-bottom: 3px solid #eee; position: relative; }
        h2::after { content: ''; display: block; width: 60px; height: 3px; background-color: #28a745; position: absolute; bottom: -3px; left: 50%; transform: translateX(-50%); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        input[type="text"], input[type="password"], input[type="email"] {
            width: calc(100% - 22px); padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 1em;
        }
        input[readonly] { background-color: #e9ecef; cursor: not-allowed; }
        .button-group { text-align: center; margin-top: 30px; }
        button { padding: 12px 25px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 1.1em; font-weight: bold; transition: background-color 0.3s ease; margin: 0 10px; }
        button:hover { background-color: #0056b3; }
        .back-link { display: block; text-align: center; margin-top: 20px; font-size: 1em; }
        .back-link a { color: #28a745; text-decoration: none; font-weight: bold; }
        .back-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="header">
        <h1>library</h1>
    </div>
    <div class="container">
        <h2>회원 정보 수정</h2>
        <p style="text-align: center; color: #777; margin-bottom: 30px;">아래 정보를 수정하고 저장할 수 있습니다.</p>
        <form action="/library/member/update" method="post">
            <input type="hidden" name="memberId" value="${member.memberId}">

            <div class="form-group">
                <label for="memberId">아이디:</label>
                <input type="text" id="memberId" value="${member.memberId}" readonly>
            </div>

            <div class="form-group">
                <label for="userName">이름:</label>
                <input type="text" id="userName" name="name" value="${member.name}">
            </div>

            <div class="form-group">
                <label for="userEmail">이메일:</label>
                <input type="email" id="userEmail" name="email" value="${member.email}">
            </div>

            <div class="form-group">
                <label for="userPhone">전화번호:</label>
                <input type="text" id="userPhone" name="phone" value="${member.phone}">
            </div>

            <div class="form-group">
                <label for="userAddress">주소:</label>
                <input type="text" id="userAddress" name="address" value="${member.address}">
            </div>

            <div class="form-group">
                <label for="password">새 비밀번호 (변경 시 입력):</label>
                <input type="password" id="password" name="password" placeholder="비밀번호 변경 시에만 입력하세요">
            </div>

            <div class="button-group">
                <button type="submit">정보 수정</button>
            </div>
        </form>
        <p class="back-link"><a href="/library/member/mypage">마이페이지로 돌아가기</a></p>
    </div>
</body>
</html>