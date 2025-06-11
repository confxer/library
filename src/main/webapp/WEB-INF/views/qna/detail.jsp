<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A 상세 보기 - ${qna.title}</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f4f6f9;
            margin: 0;
        }
        .container {
            width: 70%;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        }
        .title { font-size: 1.8em; color: #007b7f; margin-bottom: 10px; }
        .meta span { margin-right: 20px; font-size: 0.9em; color: #555; }
        .status { color: #555; font-weight: bold; }
        .content { white-space: pre-wrap; padding: 20px 0; border-top: 1px solid #ccc; border-bottom: 1px solid #ccc; color: #333; }

        .answer-box {
            background: #f0f8ff;
            padding: 20px;
            margin-top: 25px;
            border-left: 4px solid #007b7f;
        }
        .answer-box h3 { color: #007b7f; margin-bottom: 10px; }

        .reply-section { margin-top: 40px; }
        .reply-section h3 { font-size: 1.4em; color: #007b7f; margin-bottom: 15px; }
        .reply-item {
            background: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 12px;
            margin-bottom: 10px;
        }
        .reply-meta {
            display: flex;
            justify-content: space-between;
            font-size: 0.85em;
            color: #777;
        }
        .reply-writer.admin { color: #007bff; font-weight: bold; }
        .reply-content { margin-top: 6px; color: #333; }

        .reply-actions {
            margin-top: 6px;
        }
        .reply-actions form {
            display: inline-block;
        }
        .reply-actions input[type="text"] {
            width: 60%;
            padding: 2px;
            font-size: 0.8em;
        }
        .reply-actions button {
            font-size: 0.7em;
            padding: 2px 6px;
            margin-left: 5px;
            border: none;
            border-radius: 4px;
            color: white;
            cursor: pointer;
        }
        .edit-btn { background-color: #007b7f; }
        .delete-btn { background-color: #dc3545; }

        .btn-group {
            margin-top: 30px;
            text-align: right;
        }
        .btn-group a, .btn-group button {
            background-color: #6c757d;
            color: white;
            padding: 10px 16px;
            margin-left: 10px;
            border-radius: 5px;
            text-decoration: none;
            border: none;
        }
        .edit-main-btn { background-color: #007b7f; }
        .delete-main-btn { background-color: #dc3545; }

        .reply-form textarea {
            width: 100%;
            height: 60px;
            margin-top: 10px;
        }
        .reply-form button {
            margin-top: 30px;
            padding: 6px 12px;
        }
    </style>
</head>
<body>

<jsp:include page="../includes/header.jsp"/>

<div class="container">
    <div class="title">${qna.title}</div>
    <div class="meta">
        <span>작성자: ${qna.writer}</span>
        <span>작성일: <fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd"/></span>
        <span>조회수: ${qna.viewCount}</span>
        <span class="status">
            상태: ${qna.status }
            
        </span>
    </div>
    <div class="content">
        ${qna.content}
    </div>

 <c:choose>
   
    <c:when test="${not empty qna.answer}">
        <div class="answer-box">
            <h3>관리자 답변</h3>
            <p>${qna.answer}</p>

          
            <c:if test="${sessionScope.loggedInMember != null && sessionScope.loggedInMember.role == 'ADMIN'}">
                <form action="${pageContext.request.contextPath}/qna/answer/update" method="post" class="reply-form" style="margin-top: 15px;">
                    <input type="hidden" name="qnaId" value="${qna.qnaId}" />
                    <textarea name="answer" style="width:100%; height:60px;">${qna.answer}</textarea>
                    <button type="submit">답변 수정</button>
                </form>
            </c:if>
        </div>
    </c:when>

  
    <c:otherwise>
        <c:if test="${sessionScope.loggedInMember != null && sessionScope.loggedInMember.role == 'ADMIN'}">
            <form action="${pageContext.request.contextPath}/qna/answer/${qna.qnaId}" method="post" class="reply-form">
                <h3>🔧 관리자 답변 작성</h3>
                <textarea name="answer" placeholder="답변 내용을 입력하세요." style="width:100%; height:60px;"></textarea>
                <button type="submit">답변 등록</button>
            </form>
        </c:if>
    </c:otherwise>
</c:choose>

    <!-- 댓글 목록 -->
    <div class="reply-section">
        <h3>댓글</h3>
        <c:forEach var="reply" items="${replies}">
            <div class="reply-item">
                <div class="reply-meta">
                    <span class="${reply.writer == 'admin' ? 'reply-writer admin' : 'reply-writer'}">
                        ${reply.writer == 'admin' ? '관리자 댓글' : reply.writer}
                    </span>
                    <span><fmt:formatDate value="${reply.regDate}" pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
                <div class="reply-content">${reply.content}</div>

                <c:if test="${sessionScope.loggedInMember != null &&
                             (reply.writer == sessionScope.loggedInMember.memberId || sessionScope.loggedInMember.role == 'ADMIN')}">
                    <div class="reply-actions">
                        <form action="${pageContext.request.contextPath}/reply/update" method="post">
                            <input type="hidden" name="replyId" value="${reply.replyId}" />
                            <input type="hidden" name="qnaId" value="${qna.qnaId}" />
                            <input type="text" name="content" value="${reply.content}" />
                            <button type="submit" class="edit-btn">수정</button>
                        </form>

                        <form action="${pageContext.request.contextPath}/reply/delete" method="post">
                            <input type="hidden" name="replyId" value="${reply.replyId}" />
                            <input type="hidden" name="qnaId" value="${qna.qnaId}" />
                            <button type="submit" class="delete-btn" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
                        </form>
                    </div>
                </c:if>
            </div>
        </c:forEach>

        <c:if test="${empty replies}">
            <p>등록된 댓글이 없습니다.</p>
        </c:if>
    </div>

    <!-- 댓글 작성 -->
    <c:if test="${sessionScope.loggedInMember != null}">
        <form action="${pageContext.request.contextPath}/reply/add" method="post" class="reply-form">
            <input type="hidden" name="qnaId" value="${qna.qnaId}" />
            <textarea name="content" placeholder="댓글을 입력하세요."></textarea>
            <button type="submit">댓글 등록</button>
        </form>
    </c:if>
    <!-- 하단 버튼 -->
    <div class="btn-group">
        <a href="${pageContext.request.contextPath}/qna/list">목록</a>
        <c:if test="${sessionScope.loggedInMember != null &&
                     (sessionScope.loggedInMember.memberId == qna.writer || sessionScope.loggedInMember.role == 'ADMIN')}">
            <a href="${pageContext.request.contextPath}/qna/edit/${qna.qnaId}" class="edit-main-btn">수정</a>
            <form action="${pageContext.request.contextPath}/qna/delete/${qna.qnaId}" method="post" style="display:inline;">
                <button type="submit" class="delete-main-btn" onclick="return confirm('삭제하시겠습니까?')">삭제</button>
            </form>
        </c:if>
    </div>
</div>

<jsp:include page="../includes/footer.jsp"/>
</body>
</html>
