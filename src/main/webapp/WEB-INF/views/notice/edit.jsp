<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title> <%-- 제목 변경 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css"> <%-- main.css 링크 추가 --%>
    <style>
        /* 기존 qna/edit.jsp의 인라인 스타일과 유사하게 적용. 필요시 main.css로 통합 */
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { color: #333; text-align: center; margin-bottom: 25px; font-size: 2em; } /* 제목 스타일 중앙 정렬 및 크기 조정 */
        form { background-color: #f9f9f9; padding: 20px; border-radius: 8px; max-width: 600px; margin: 0 auto; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1); } /* 폼 스타일 조정 */
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; } /* 레이블 스타일 조정 */
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
            font-size: 1em; /* 폰트 크기 조정 */
        }
        textarea { resize: vertical; min-height: 150px; }
        input[type="submit"] {
            background-color: #009879; /* 버튼 색상 변경 */
            color: white;
            padding: 12px 25px; /* 패딩 조정 */
            border: none;
            border-radius: 5px; /* 둥근 모서리 조정 */
            cursor: pointer;
            font-size: 1.1em; /* 폰트 크기 조정 */
            transition: background-color 0.2s ease; /* 호버 효과 추가 */
        }
        input[type="submit"]:hover {
            background-color: #007b66; /* 호버 색상 변경 */
        }
        .error-message {
            color: red;
            font-weight: bold;
            text-align: center; /* 중앙 정렬 */
            margin-bottom: 15px; /* 마진 조정 */
        }
        .message {
            color: green;
            font-weight: bold;
            text-align: center; /* 중앙 정렬 */
            margin-bottom: 15px; /* 마진 조정 */
        }
        .link-group { /* 링크 그룹화를 위한 클래스 추가 */
            text-align: center;
            margin-top: 20px;
        }
        .link-group a { /* 링크 스타일 조정 */
            display: inline-block;
            margin: 0 10px;
            color: #007bff;
            text-decoration: none;
        }
        .link-group a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="../includes/header.jsp" /> <%-- 헤더 포함 --%>

    <div class="container">
        <h2>공지사항 수정</h2> <%-- 제목 변경 --%>

        <c:if test="${not empty errorMessage}">
            <p class="error-message">${errorMessage}</p>
        </c:if>
        <c:if test="${not empty message}">
            <p class="message">${message}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/notice/edit" method="post"> <%-- URL 변경 --%>
            <%-- hidden input: noticeId는 수정할 게시글을 식별하는 데 사용됩니다. --%>
            <input type="hidden" name="noticeId" value="${notice.num}"> <%-- name 및 value 필드명 변경 --%>

            <div class="form-group"> <%-- 폼 그룹화 --%>
                <label for="title">제목:</label>
                <input type="text" id="title" name="title" value="${notice.title}" required> <%-- value 필드명 변경 --%>
            </div>

            <%-- 작성자 필드 제거 (공지사항에서는 일반적으로 작성자가 고정되거나 관리자로 설정) --%>
            <%-- <label for="writer">작성자:</label>
            <input type="text" id="writer" name="writer" value="${qna.writer}" readonly><br> --%>

            <div class="form-group">
                <label for="content">내용:</label>
                <textarea id="content" name="content" rows="10" cols="50" required>${notice.content}</textarea> <%-- value 필드명 변경 --%>
            </div>

            <%-- 공개 여부 필드 제거 (공지사항은 기본적으로 공개) --%>
            <%-- <label for="openYn">공개 여부:</label>
            <select id="openYn" name="openYn">
                <option value="Y" ${qna.openYn eq 'Y' ? 'selected' : ''}>공개</option>
                <option value="N" ${qna.openYn eq 'N' ? 'selected' : ''}>비공개</option>
            </select><br> --%>

            <%-- 비밀번호 필드 제거 (공지사항은 비밀번호로 접근하지 않음) --%>
            <%-- <label for="password">비밀번호 (수정 시 입력, 비공개 글의 경우 확인용):</label>
            <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요"><br> --%>

            <%-- 처리 상태 필드 제거 (Q&A에만 해당) --%>
            <%-- <label for="status">처리 상태:</label>
            <select id="status" name="status">
                <option value="대기중" ${qna.status eq '대기중' ? 'selected' : ''}>대기중</option>
                <option value="완료" ${qna.status eq '완료' ? 'selected' : ''}>완료</option>
            </select><br> --%>

            <input type="submit" value="수정 완료">
        </form>

        <div class="link-group"> <%-- 링크 그룹화 --%>
            <a href="${pageContext.request.contextPath}/notice/detail?num=${noticeDto.num}">상세 보기로 돌아가기</a> <%-- URL 및 필드명 변경 --%>
            <a href="${pageContext.request.contextPath}/notice/list">목록으로</a> <%-- URL 변경 --%>
        </div>
    </div>

    <jsp:include page="../includes/footer.jsp" /> <%-- 푸터 포함 --%>
</body>
</html>