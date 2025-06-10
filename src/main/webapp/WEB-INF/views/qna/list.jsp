<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>도서관 Q&A 게시판</title>
    <style>
        body {
            background: #f6f9fc;
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 70%;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        }
        h2 {
            font-size: 2em;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }
        .qa-board {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.9em;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .qa-board colgroup col:nth-child(1) { width: 5%; }
        .qa-board colgroup col:nth-child(2) { width: 15%; }
        .qa-board colgroup col:nth-child(3) { width: 40%; }
        .qa-board colgroup col:nth-child(4) { width: 12%; }
        .qa-board colgroup col:nth-child(5) { width: 8%; }
        .qa-board colgroup col:nth-child(6) { width: 10%; }
        .qa-board colgroup col:nth-child(7) { width: 10%; }
        .qa-board thead {
            background-color: #f9f9f9;
        }
        .qa-board thead th {
            color: #000;
            padding: 6px;
            text-align: center;
            border-bottom: 1px solid #eaeaea;
        }
        .qa-board th, .qa-board td {
            padding: 6px;
            text-align: center;
            border-bottom: 1px solid #eaeaea;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .qa-board tbody tr:hover {
            background-color: #eef9f9;
        }
        .qa-title {
            text-align: left;
            padding-left: 8px;
        }
        .qa-title a {
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
            overflow: hidden;
            text-overflow: ellipsis;
            line-height: 1.4em;
            max-height: calc(1.4em * 2);
            white-space: normal;
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }
        .qa-title span {
            margin-left: 4px;
            font-size: 0.85em;
            vertical-align: middle;
        }
        .search-form {
            text-align: right;
            margin-bottom: 15px;
        }
        .search-form input,
        .search-form select {
            padding: 5px;
            margin-left: 4px;
            font-size: 0.9em;
        }
        .search-form button {
            padding: 5px 10px;
            font-size: 0.9em;
        }
        .write-button-area {
            text-align: right;
            margin: 15px 0;
        }
        .write-button {
            background: #007b7f;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.9em;
            text-decoration: none;
        }
        .write-button:hover {
            background: #005f6a;
        }
        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a, .pagination strong {
            padding: 6px 10px;
            margin: 0 3px;
            border-radius: 6px;
            border: 1px solid #ddd;
            text-decoration: none;
            color: #007b7f;
            font-size: 0.9em;
        }
        .pagination strong {
            background-color: #007b7f;
            color: white;
        }
        .action-buttons {
            display: inline-flex;
            gap: 6px;
            justify-content: center;
        }
        .action-buttons form {
            display: inline;
            margin: 0;
            padding: 0;
        }
        .action-buttons button {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 0.9em;
            padding: 0;
        }
        .action-buttons button.edit {
            color: white;
            background-color: #007b7f;
            padding: 2px 6px;
            border-radius: 4px;
        }
        .action-buttons button.delete {
            background-color: #dc3545;
            color: white;
            padding: 2px 6px;
            border-radius: 4px;
        }
        .action-buttons button:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>

<jsp:include page="../includes/header.jsp" />

<div class="container">
    <h2>도서관 Q&A 게시판</h2>

    <!-- 검색 폼 -->
    <form method="get" action="${pageContext.request.contextPath}/qna/list" class="search-form">
        <input type="text" name="keyword" placeholder="검색어" value="${param.keyword}" />
        <select name="category">
            <option value="">전체</option>
            <option value="도서관 서비스" ${param.category eq '도서관 서비스' ? 'selected' : ''}>도서관 서비스</option>
            <option value="시설 문의" ${param.category eq '시설 문의' ? 'selected' : ''}>시설 문의</option>
        </select>
        <select name="sort">
            <option value="latest" ${param.sort eq 'latest' ? 'selected' : ''}>최신순</option>
            <option value="views" ${param.sort eq 'views' ? 'selected' : ''}>조회수순</option>
        </select>
        <button type="submit">검색</button>
    </form>

    <!-- 질문 등록 버튼 -->
    <div class="write-button-area">
        <c:choose>
            <c:when test="${not empty sessionScope.loggedInMember}">
                <a href="${pageContext.request.contextPath}/qna/write" class="write-button">✍️ 질문 등록</a>
            </c:when>
            <c:otherwise>
                <button class="write-button"
                        onclick="alert('로그인 후 이용 가능합니다.'); location.href='${pageContext.request.contextPath}/member/login';">
                    질문 등록
                </button>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Q&A 목록 테이블 -->
    <table class="qa-board">
        <colgroup>
            <col /><col /><col /><col /><col /><col /><col />
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>카테고리</th>
                <th>제목</th>
                <th>작성일</th>
                <th>조회수</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty qnaList}">
                    <c:forEach var="qna" items="${qnaList}">
                        <tr>
                            <td>${qna.qnaId}</td>
                            <td>${qna.category}</td>
                          <td class="qa-title">
    <c:choose>
        <c:when test="${qna.openYn eq 'N' 
            and (empty sessionScope.loggedInMember 
                or (sessionScope.loggedInMember.role ne 'admin' 
                    and sessionScope.loggedInMember.memberId ne qna.writer))}">
            <span style="color:#aaa;">🔒 비공개 글</span>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/qna/detail/${qna.qnaId}">
                ${qna.title}
            </a>
            <c:if test="${qna.openYn eq 'N'}"><span>🔒 비공개</span></c:if>
            <c:if test="${not empty qna.answer}"><span>✔️ 답변완료</span></c:if>
        </c:otherwise>
    </c:choose>
</td>
                            <td><fmt:formatDate value="${qna.regDate}" pattern="yyyy-MM-dd"/></td>
                            <td>${qna.viewCount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty qna.answer}">답변 완료</c:when>
                                    <c:otherwise>대기중</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
    <c:if test="${not empty sessionScope.loggedInMember 
                and (sessionScope.loggedInMember.role eq 'admin' 
                     or sessionScope.loggedInMember.memberId eq qna.writer)}">
        <div class="action-buttons">
            <c:if test="${sessionScope.loggedInMember.memberId eq qna.writer}">
                <form action="${pageContext.request.contextPath}/qna/edit/${qna.qnaId}" method="get">
                    <button type="submit" class="edit">수정</button>
                </form>
            </c:if>
            <form action="${pageContext.request.contextPath}/qna/delete/${qna.qnaId}" method="post"
                  onsubmit="return confirm('삭제하시겠습니까?');">
                <button type="submit" class="delete">삭제</button>
            </form>
        </div>
    </c:if>
</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="7" style="padding:12px; color:#555; text-align:center;">
                            등록된 Q&A가 없습니다.
                        </td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- 페이지네이션 -->
    <div class="pagination">
        <c:if test="${currentPage > 1}">
            <a href="?page=1&keyword=${param.keyword}&category=${param.category}&sort=${param.sort}">처음</a>
            <a href="?page=${currentPage - 1}&keyword=${param.keyword}&category=${param.category}&sort=${param.sort}">&laquo;</a>
        </c:if>
        <c:forEach var="i" begin="1" end="${totalPages}">
            <c:choose>
                <c:when test="${i eq currentPage}">
                    <strong>${i}</strong>
                </c:when>
                <c:otherwise>
                    <a href="?page=${i}&keyword=${param.keyword}&category=${param.category}&sort=${param.sort}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}&keyword=${param.keyword}&category=${param.category}&sort=${param.sort}">&raquo;</a>
            <a href="?page=${totalPages}&keyword=${param.keyword}&category=${param.category}&sort=${param.sort}">끝</a>
        </c:if>
    </div>
</div>

<jsp:include page="../includes/footer.jsp" />
</body>
</html>
