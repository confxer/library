<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        /* write.jsp만을 위한 스타일 */
        .qa-form-container {
            width: 60%;
            margin: 30px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .qa-form-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
            font-size: 2em;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }
        .form-group input[type="text"],
        .form-group textarea {
            width: calc(100% - 22px); /* padding 고려 */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
            box-sizing: border-box; /* padding이 width에 포함되도록 */
        }
        .form-group textarea {
            resize: vertical; /* 세로 크기 조절 가능 */
            min-height: 150px;
        }
        .button-group {
            text-align: center;
            margin-top: 30px;
        }
        .button-group button,
        .button-group a {
            background-color: #009879;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            margin: 0 10px;
            text-decoration: none; /* <a> 태그 스타일 */
            display: inline-block;
            transition: background-color 0.2s ease;
        }
        .button-group button[type="reset"] {
            background-color: #6c757d;
        }
        .button-group button:hover,
        .button-group a:hover {
            background-color: #007b66;
        }
        .button-group button[type="reset"]:hover {
            background-color: #5a6268;
        }
        .error-message {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
        .success-message {
            color: green;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <jsp:include page="../includes/header.jsp" />

    <div class="container">
        <div class="qa-form-container">
            <h2>Q&A 작성</h2>

            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p class="success-message">${message}</p>
            </c:if>

            <form action="${pageContext.request.contextPath}/qna/write" method="post">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required placeholder="질문 제목을 입력해주세요.">
                </div>
               	<input type="hidden" id="writer" name="writer" value="${loggedInMember.name }">
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="content" required placeholder="질문 내용을 상세히 입력해주세요."></textarea>
                </div>
                <div class="button-group">
                    <button type="submit">등록</button>
                    <button type="reset">초기화</button>
                    <a href="${pageContext.request.contextPath}/qna/list">목록으로</a>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="../includes/footer.jsp" />
</body>
</html>