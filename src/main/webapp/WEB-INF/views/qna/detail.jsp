<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A 상세 보기 - ${qna.title}</title>
    <style>
        body {
            background: #f6f9fc;
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0; padding: 0;
        }
        .container {
            width: 70%;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        }
        .qa-detail-header {
            border-bottom: 2px solid #007b7f;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        .qa-detail-header h2 {
            color: #007b7f;
            font-size: 2em;
            margin: 0;
        }
        .qa-info {
            display: flex;
            justify-content: space-between;
            font-size: 0.9em;
            color: #555;
            margin-top: 8px;
        }
        .qa-content {
            padding: 20px 0;
            line-height: 1.8;
            color: #333;
            border-bottom: 1px dashed #ddd;
            white-space: pre-wrap;
        }
        .qa-answer {
            background-color: #f0f8ff;
            border: 1px solid #ddeeff;
            padding: 25px;
            margin-top: 20px;
            border-radius: 6px;
            white-space: pre-wrap;
        }
        .qa-answer h3 {
            color: #007b7f;
            margin-bottom: 15px;
            font-size: 1.4em;
        }
        .qa-buttons {
            text-align: right;
            margin-top: 30px;
        }
        .qa-buttons a, .qa-buttons button {
            background-color: #6c757d;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.95em;
            text-decoration: none;
            margin-left: 10px;
        }
        .qa-buttons .edit-btn { background-color: #007b7f; }
        .qa-buttons .delete-btn { background-color: #dc3545; }

        .reply-section { margin-top: 50px; padding-top: 30px; border-top: 2px solid #007b7f; }
        .reply-section h3 { font-size: 1.5em; margin-bottom: 20px; color: #007b7f; }
        .reply-list { list-style: none; padding: 0; margin: 0; }
        .reply-item { background-color: #fafafa; border: 1px solid #ddd; border-radius: 5px; padding: 12px 16px; margin-bottom: 10px; }
        .reply-meta { display: flex; justify-content: space-between; font-size: 0.85em; color: #555; margin-bottom: 8px; }
        .reply-writer.admin { color: #007bff; font-weight: bold; }
        .reply-date { font-style: italic; }
        .reply-content { white-space: pre-wrap; color: #333; margin-top: 4px; }

        .admin-answer-form, .reply-form {
            margin-top: 30px;
            background: #f9f9f9;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 6px;
        }
        .admin-answer-form textarea, .reply-form textarea {
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
            resize: vertical;
        }
        .admin-answer-form button, .reply-form button {
            background-color: #007b7f;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            margin-top: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <div class="qa-detail-header">
        <h2>${qna.title}</h2>
        <div class="qa-info">
            <span>작성자: ${qna.writer}</span>
            <span>작성일: <fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd"/></span>
            <span>조회수: ${qna.viewCount}</span>
            <span>상태:
                <c:choose>
                    <c:when test="${not empty qna.answer}">
                        답변 완료
                    </c:when>
                    <c:when test="${not empty replies && fn:contains(replyWriters, 'admin')}">
                        답변 완료
                    </c:when>
                    <c:otherwise>
                        대기중
                    </c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>

    <!-- 본문 -->
    <c:choose>
        <c:when test="${qna.openYn eq 'Y'}">
            <div class="qa-content">${qna.content}</div>
        </c:when>
        <c:when test="${sessionScope.loggedInMember != null && (sessionScope.loggedInMember.memberId eq qna.writer || sessionScope.loggedInMember.role eq 'admin')}">
            <div class="qa-content">${qna.content}</div>
        </c:when>
        <c:otherwise>
            <div class="qa-content">🔒 비공개 글입니다. 권한이 없습니다.</div>
        </c:otherwise>
    </c:choose>

    <!-- 관리자 답변 -->
    <c:if test="${not empty qna.answer}">
        <div class="qa-answer">
            <h3>관리자 답변</h3>
            <p>${qna.answer}</p>
        </div>
    </c:if>

    <!-- 관리자 답변 등록 폼 -->
    <c:if test="${sessionScope.loggedInMember != null && sessionScope.loggedInMember.role eq 'admin' && empty qna.answer}">
        <div class="admin-answer-form">
            <h3>관리자 답변 작성</h3>
            <form action="${pageContext.request.contextPath}/qna/answer/${qna.qnaId}" method="post">
                <textarea name="answer" rows="5" placeholder="답변 내용을 입력하세요." required></textarea>
                <button type="submit">답변 등록</button>
            </form>
        </div>
    </c:if>

    <!-- 댓글 목록 -->
    <div class="reply-section">
        <h3>댓글</h3>
        <ul class="reply-list">
            <c:set var="replyWriters" value="" />
            <c:forEach var="reply" items="${replies}">
                <c:set var="replyWriters" value="${replyWriters},${reply.writer}" />
                <li class="reply-item">
                    <div class="reply-meta">
                        <span class="reply-writer ${reply.writer == 'admin' ? 'admin' : ''}">
                            ${reply.writer == 'admin' ? '관리자 댓글' : reply.writer}
                        </span>
                        <span class="reply-date">
                            <fmt:formatDate value="${reply.regDate}" pattern="yyyy-MM-dd HH:mm"/>
                        </span>
                    </div>
                    <div class="reply-content">${reply.content}</div>
                </li>
            </c:forEach>
        </ul>

        <c:if test="${empty replies}">
            <p>등록된 댓글이 없습니다.</p>
        </c:if>
    </div>

    <!-- 댓글 작성 폼 -->
    <c:if test="${sessionScope.loggedInMember != null}">
        <div class="reply-form">
            <h3>댓글 작성</h3>
            <form action="${pageContext.request.contextPath}/qna/reply/${qna.qnaId}" method="post">
                <textarea name="content" rows="3" placeholder="댓글을 입력하세요." required></textarea>
                <button type="submit">댓글 등록</button>
            </form>
        </div>
    </c:if>

    <!-- 버튼 영역 -->
    <div class="qa-buttons">
        <a href="${pageContext.request.contextPath}/qna/list">목록으로</a>
        <c:if test="${sessionScope.loggedInMember != null && (sessionScope.loggedInMember.memberId eq qna.writer || sessionScope.loggedInMember.role eq 'admin')}">
            <a href="${pageContext.request.contextPath}/qna/edit/${qna.qnaId}" class="edit-btn">수정</a>
            <form action="${pageContext.request.contextPath}/qna/delete/${qna.qnaId}" method="post" style="display:inline;">
                <button type="submit" class="delete-btn" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
            </form>
        </c:if>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
</body>
</html>
