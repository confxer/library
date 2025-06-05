<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>새 글 작성 - 자유게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        /* 글쓰기 폼을 위한 스타일 */
        .write-container {
            width: 90%;
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        .write-container h2 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
            font-size: 2.5em;
            border-bottom: 2px solid #009879;
            padding-bottom: 15px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
            font-size: 1.1em;
        }
        .form-group input[type="text"],
        .form-group textarea {
            width: calc(100% - 22px); /* 패딩, 보더 고려 */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
            box-sizing: border-box; /* 패딩, 보더 포함 너비 계산 */
        }
        .form-group textarea {
            resize: vertical; /* 수직 방향으로만 크기 조절 가능 */
            min-height: 200px;
        }
        .button-area {
            text-align: center;
            margin-top: 30px;
        }
        .submit-button, .cancel-button {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            font-size: 1.1em;
            transition: background-color 0.3s ease;
            cursor: pointer;
            border: none;
            margin: 0 10px;
        }
        .submit-button {
            background-color: #009879;
            color: white;
        }
        .submit-button:hover {
            background-color: #007b66;
        }
        .cancel-button {
            background-color: #6c757d;
            color: white;
        }
        .cancel-button:hover {
            background-color: #5a6268;
        }
        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />

    <div class="container">
        <div class="write-container">
            <h2>새 글 작성</h2>

            <%-- 에러 메시지 표시 (컨트롤러에서 addFlashAttribute로 전달 시) --%>
            <c:if test="${not empty errorMessage}">
                <p class="error-message" style="text-align: center; margin-bottom: 20px;">${errorMessage}</p>
            </c:if>

            <%-- Spring 폼 태그 사용 --%>
            <form:form action="${pageContext.request.contextPath}/board/write" method="post" modelAttribute="post">
                <div class="form-group">
                    <label for="title">제목</label>
                    <form:input path="title" type="text" id="title" placeholder="제목을 입력하세요" required="true" />
                    <%-- <form:errors path="title" cssClass="error-message" /> --%>
                </div>
                <input type="hidden" id="writer" name="writer" value="${loggedInMember.name }">
                <div class="form-group">
                    <label for="content">내용</label>
                    <form:textarea path="content" id="content" placeholder="내용을 입력하세요" required="true" />
                    <%-- <form:errors path="content" cssClass="error-message" /> --%>
                </div>
                <%-- authorId는 컨트롤러에서 로그인 정보로 자동 설정되므로 폼에 직접 입력받지 않습니다. --%>
                
                <div class="button-area">
                    <button type="submit" class="submit-button">등록하기</button>
                    <button type="button" class="cancel-button" onclick="location.href='${pageContext.request.contextPath}/board/list'">취소</button>
                </div>
            </form:form>
        </div>
    </div>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>