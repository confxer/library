<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <form action="/library/qna/private/${qna.qnaId }" method="post">
	    <input type="password" id="password" name ="password">
    	<button type="submit">입력</button>
    </form>
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