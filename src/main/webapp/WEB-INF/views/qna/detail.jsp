<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- fmt 태그 라이브러리는 더 이상 날짜 포맷팅에 사용되지 않으므로, 주석 처리하거나 제거할 수 있습니다. --%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${qna.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        /* detail.jsp만을 위한 스타일 */
        .qa-detail-container {
            width: 70%;
            margin: 30px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .qa-detail-header {
            border-bottom: 2px solid #009879;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        .qa-detail-header h2 {
            color: #333;
            font-size: 2.2em;
            margin-bottom: 5px;
        }
        .qa-info {
            font-size: 0.9em;
            color: #777;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .qa-info span {
            margin-right: 15px;
        }
        .qa-content {
            padding: 20px 0;
            line-height: 1.8;
            color: #444;
            border-bottom: 1px dashed #ddd;
            word-wrap: break-word; /* 긴 텍스트 줄바꿈 */
            white-space: pre-wrap; /* 줄바꿈 및 공백 유지 */
        }
        .qa-content p {
            margin-bottom: 1em;
        }
        .qa-answer {
            background-color: #f9f9f9;
            border: 1px solid #eee;
            padding: 25px;
            margin-top: 20px;
            border-radius: 5px;
            position: relative;
            white-space: pre-wrap; /* 줄바꿈 및 공백 유지 */
        }
        .qa-answer h3 {
            color: #009879;
            margin-bottom: 15px;
            font-size: 1.5em;
        }
        .qa-answer::before {
            content: "A";
            position: absolute;
            top: 10px;
            left: 10px;
            font-size: 2em;
            color: #009879;
            opacity: 0.2;
            font-weight: bold;
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
            transition: background-color 0.2s ease;
        }
        .qa-buttons a:hover, .qa-buttons button:hover {
            background-color: #5a6268;
        }
        .qa-buttons .edit-btn {
            background-color: #007bff;
        }
        .qa-buttons .edit-btn:hover {
            background-color: #0056b3;
        }
        .qa-buttons .delete-btn {
            background-color: #dc3545;
        }
        .qa-buttons .delete-btn:hover {
            background-color: #c82333;
        }

        /* Reply Section Styles */
        .reply-section {
            margin-top: 40px;
            border-top: 2px solid #009879;
            padding-top: 30px;
        }
        .reply-section h3 {
            color: #333;
            font-size: 1.8em;
            margin-bottom: 20px;
        }
        .reply-form textarea {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            min-height: 80px;
            resize: vertical;
        }
        .reply-form input[type="submit"] {
            background-color: #009879;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 1em;
            float: right;
        }
        .reply-form input[type="submit"]:hover {
            background-color: #007b66;
        }
        .reply-list {
            list-style: none;
            padding: 0;
            margin-top: 20px;
        }
        .reply-item {
            background-color: #f0f0f0;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 10px;
            border: 1px solid #e0e0e0;
        }
        .reply-item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            font-size: 0.9em;
            color: #666;
        }
        .reply-item-header span {
            font-weight: bold;
            color: #333;
        }
        .reply-content {
            line-height: 1.6;
            color: #444;
            white-space: pre-wrap; /* 줄바꿈 및 공백 유지 */
        }
        .reply-actions {
            text-align: right;
            margin-top: 10px;
        }
        .reply-actions a, .reply-actions button {
            background-color: #6c757d;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 0.8em;
            text-decoration: none;
            margin-left: 5px;
        }
        .reply-actions .edit-btn {
            background-color: #007bff;
        }
        .reply-actions .delete-btn {
            background-color: #dc3545;
        }
        .reply-actions a:hover, .reply-actions button:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <jsp:include page="../includes/header.jsp" />

    <div class="container">
        <div class="qa-detail-container">
            <c:if test="${not empty errorMessage}">
                <p style="color: red; text-align: center;">${errorMessage}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p style="color: green; text-align: center;">${message}</p>
            </c:if>

            <c:if test="${empty qna}">
                <div style="text-align: center; padding: 50px; color: #555;">
                    <p>죄송합니다. 요청하신 Q&A를 찾을 수 없습니다.</p>
                    <p><a href="${pageContext.request.contextPath}/qna/list" style="color: #007bff; text-decoration: none;">Q&A 목록으로 돌아가기</a></p>
                </div>
            </c:if>

            <c:if test="${not empty qna}">
                <div class="qa-detail-header">
                    <h2>${qna.title}</h2>
                    <div class="qa-info">
                        <%-- ⭐⭐⭐ 이 부분이 변경되었습니다! ⭐⭐⭐ --%>
                        <span>작성일: ${qna.regDate}</span>
                        <span>조회수: ${qna.viewCount}</span>
                        <span>상태:
                            <c:choose>
                                <c:when test="${not empty replies}"> 
                                    <span style="color: blue; font-weight: bold;">답변 완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: red; font-weight: bold;">대기중</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>

                <div class="qa-content">
                    <p>${qna.content}</p>
                </div>

                <c:if test="${not empty replies}">
                    <div class="qa-answer">
                        <h3>관리자 답변</h3>
                        <p>${replies.content}</p>
                    </div>
                </c:if>

                <div class="qa-buttons">
                    <a href="${pageContext.request.contextPath}/qna/list">목록으로</a>
                    <c:if test="${loggedInMember.name == qna.writer}">
                        <a href="${pageContext.request.contextPath}/qna/edit/${qna.qnaId}" class="edit-btn">수정</a>
                        <form action="${pageContext.request.contextPath}/qna/delete" method="post" style="display: inline-block;">
                            <input type="hidden" name="qnaId" value="${qna.qnaId}">
                            <button type="submit" class="delete-btn" onclick="return confirm('정말로 이 Q&A를 삭제하시겠습니까?');">삭제</button>
                        </form>
                    </c:if>
                </div>

                <hr>

                <div class="reply-section">
                    <h3>답변 관리</h3>

                    <c:if test="${loggedInMember.role == 'ADMIN' && empty replies}">
                        <div class="reply-form">
                            <form action="${pageContext.request.contextPath}/reply" method="post">
                                <input type="hidden" name="qnaId" value="${qna.qnaId}">
                                <input type="hidden" name="writer" value="admin">
                                <textarea name="content" placeholder="답변 내용을 입력하세요."></textarea>
                                <input type="submit" value="답변 등록/수정">
                            </form>
                        </div>
                        <div style="clear: both;"></div>
                    </c:if>

                    <c:if test="${not empty replies}">
                        <ul class="reply-list">
                            <li class="reply-item">
                                <div class="reply-item-header">
                                    <span>작성자: 관리자</span>
                                    <%-- answerRegDate 필드가 QnaDto에 없으므로, 현재는 Q&A 작성일로 대체합니다. --%>
                                    <span>작성일: ${replies.regDate} (Q&A 작성일)</span>
                                </div>
                                <div class="reply-content">
                                    <p>${replies.content}</p>
                                </div>
                                <%-- ReplyDto가 있다면 여기에 ReplyController의 수정/삭제 버튼 추가 --%>
                            </li>
                        </ul>
                    </c:if>
                    <c:if test="${empty replies && loggedInMember.role == 'USER'}">
                         <p style="text-align: center; color: #555;">아직 등록된 답변이 없습니다.</p>
                    </c:if>
                </div>

            </c:if>
        </div>
    </div>

    <jsp:include page="../includes/footer.jsp" />
</body>
</html>