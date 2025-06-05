<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- fmt 태그 라이브러리는 더 이상 날짜 포맷팅에 사용되지 않으므로, 주석 처리하거나 제거할 수 있습니다. --%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A 게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        /* list.jsp만을 위한 스타일 */
        .qa-board {
            width: 100%;
            margin: 30px auto;
            border-collapse: collapse;
            font-size: 1em;
            min-width: 400px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
        }
        .qa-board thead tr {
            background-color: #009879;
            color: #ffffff;
            text-align: left;
            font-weight: bold;
        }
        .qa-board th,
        .qa-board td {
            padding: 12px 15px;
            border: 1px solid #dddddd;
        }
        .qa-board tbody tr {
            border-bottom: 1px solid #dddddd;
        }
        .qa-board tbody tr:nth-of-type(even) { /* 짝수 행 배경색 */
            background-color: #f3f3f3;
        }
        .qa-board tbody tr:last-of-type { /* 마지막 행 테두리 */
            border-bottom: 2px solid #009879;
        }
        .qa-board tbody tr:hover { /* 호버 시 배경색 */
            background-color: #f0f0f0;
            cursor: pointer;
        }
        .qa-title a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .qa-title a:hover {
            color: #009879;
            text-decoration: underline;
        }
        .write-button-area {
            text-align: right;
            width: 100%;
            margin: 10px auto;
        }
        .write-button {
            background-color: #009879;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            text-decoration: none; /* <a> 태그 스타일 */
        }
        .write-button:hover {
            background-color: #007b66;
        }
        .no-qa-message {
            width: 80%;
            margin: 20px auto;
            text-align: center;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            color: #555;
        }
        .status-button {
            background-color: #4CAF50; /* Green */
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 0.8em;
            margin-left: 5px;
        }
        .status-button.waiting {
            background-color: #f44336; /* Red */
        }
        .status-button:hover {
            opacity: 0.8;
        }
        /* 페이징 스타일 추가 */
        .pagination {
            text-align: center;
            margin: 20px 0;
        }
        .pagination a, .pagination strong {
            display: inline-block;
            padding: 8px 16px;
            text-decoration: none;
            color: #009879;
            border: 1px solid #ddd;
            margin: 0 4px;
            border-radius: 5px;
        }
        .pagination strong {
            background-color: #009879;
            color: white;
            border: 1px solid #009879;
        }
        .pagination a:hover:not(.active) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <jsp:include page="../includes/header.jsp" />

    <div class="container" style="width: 64%">
        <h2>Q&A 게시판</h2>
        <c:if test="${not empty loggedInMember }">
	        <div class="write-button-area" >
	            <a href="${pageContext.request.contextPath}/qna/write" class="write-button">질문 등록</a>
	        </div>
        </c:if>

        <c:if test="${not empty message}">
            <p style="color: green; font-weight: bold; text-align: center;">${message}</p>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p style="color: red; font-weight: bold; text-align: center;">${errorMessage}</p>
        </c:if>

        <table class="qa-board">
            <thead>
                <tr>
                    <th style="width: 10%;">번호</th>
                    <th style="width: 40%;">제목</th>
                    <th style="width: 15%;">작성일</th>
                    <th style="width: 10%;">조회수</th>
                    <th style="width: 10%;">상태</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty qnaList}">
                        <c:forEach var="qna" items="${qnaList}">
                            <tr>
                                <td>${qna.qnaId}</td>
                                <td class="qa-title">
                                    <a href="${pageContext.request.contextPath}/qna/detail/${qna.qnaId}">
                                        ${qna.title}
                                        <c:if test="${not empty replies}"> 
                                            <span style="color: blue; font-size: 0.8em;"> [답변 완료]</span>
                                        </c:if>
                                    </a>
                                </td>
                                <%-- ⭐⭐⭐ 이 부분이 변경되었습니다! ⭐⭐⭐ --%>
                                <td>${qna.regDate}</td>
                                <td>${qna.viewCount}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty repleies}">답변 완료</c:when>
                                        <c:otherwise>대기중</c:otherwise>
                                    </c:choose>

                                    <c:if test="${not empty sessionScope.adminUser}">
                                        <%-- 상태 변경 폼은 현재 DB 컬럼 부재로 주석 처리 유지 --%>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="no-qa-message">등록된 Q&A가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <%-- 페이징 영역 --%>
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/qna/list?page=${currentPage - 1}&pageSize=${pageSize}&searchKeyword=${searchKeyword}&searchCategory=${searchCategory}">&laquo;</a>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i eq currentPage}">
                        <strong>${i}</strong>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/qna/list?page=${i}&pageSize=${pageSize}&searchKeyword=${searchKeyword}&searchCategory=${searchCategory}">${i}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/qna/list?page=${currentPage + 1}&pageSize=${pageSize}&searchKeyword=${searchKeyword}&searchCategory=${searchCategory}">&raquo;</a>
            </c:if>
        </div>

    </div>

    <jsp:include page="../includes/footer.jsp" />
</body>
</html>