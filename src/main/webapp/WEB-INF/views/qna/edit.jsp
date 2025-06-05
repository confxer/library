<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A 수정</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { color: #333; }
        form { background-color: #f9f9f9; padding: 20px; border-radius: 8px; max-width: 600px; margin: 0 auto; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"],
        input[type="password"],
        textarea,
        select {
            width: calc(100% - 22px); /* Padding + Border */
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box; /* 패딩과 보더를 포함한 너비 계산 */
        }
        textarea { resize: vertical; min-height: 150px; }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .message {
            color: green;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>

    <h2>Q&A 수정</h2>

    <c:if test="${not empty errorMessage}">
        <p class="error-message">${errorMessage}</p>
    </c:if>
    <c:if test="${not empty message}">
        <p class="message">${message}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/qna/edit" method="post">
        <%-- hidden input: Q&A ID는 수정할 게시글을 식별하는 데 사용됩니다. --%>
        <input type="hidden" name="qnaId" value="${qna.qnaId}">

        <label for="title">제목:</label>
        <input type="text" id="title" name="title" value="${qna.title}" required><br>

        <label for="writer">작성자:</label>
        <%-- 작성자는 수정 불가능하도록 readonly로 설정 --%>
        <input type="text" id="writer" name="writer" value="${qna.writer}" readonly><br>

        <label for="content">내용:</label>
        <textarea id="content" name="content" rows="10" cols="50" required>${qna.content}</textarea><br>

        <label for="openYn">공개 여부:</label>
        <select id="openYn" name="openYn">
            <option value="Y" ${qna.openYn eq 'Y' ? 'selected' : ''}>공개</option>
            <option value="N" ${qna.openYn eq 'N' ? 'selected' : ''}>비공개</option>
        </select><br>

        <label for="password">비밀번호 (수정 시 입력, 비공개 글의 경우 확인용):</label>
        <%-- 비밀번호 필드는 보안상 value를 채우지 않으며, 수정 시에만 입력합니다. --%>
        <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요"><br>

        <label for="status">처리 상태:</label>
        <select id="status" name="status">
            <option value="대기중" ${qna.status eq '대기중' ? 'selected' : ''}>대기중</option>
            <option value="완료" ${qna.status eq '완료' ? 'selected' : ''}>완료</option>
        </select><br>

        <input type="submit" value="수정 완료">
    </form>

    <p class="back-link"><a href="${pageContext.request.contextPath}/qna/detail?qnaId=${qna.qnaId}">상세 보기로 돌아가기</a></p>
    <p class="back-link"><a href="${pageContext.request.contextPath}/qna/list">목록으로</a></p>

</body>
</html>