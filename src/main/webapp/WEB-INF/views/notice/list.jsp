<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        /* list.jsp만을 위한 스타일 */
        .notice-board { /* 클래스명 변경 */
            width: 100%;
            margin: 30px auto;
            border-collapse: collapse;
            font-size: 1em;
            min-width: 400px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
        }
        .notice-board thead tr { /* 클래스명 변경 */
            background-color: #009879;
            color: black;
            text-align: left;
            font-weight: bold;
        }
        .notice-board th, /* 클래스명 변경 */
        .notice-board td { /* 클래스명 변경 */
            padding: 12px 15px;
            border: 1px solid #dddddd;
        }
        .notice-board tbody tr { /* 클래스명 변경 */
            border-bottom: 1px solid #dddddd;
        }
        .notice-board tbody tr:nth-of-type(even) { /* 짝수 행 배경색 */
            background-color: #f3f3f3;
        }
        .notice-board tbody tr:last-of-type { /* 마지막 행 테두리 */
            border-bottom: 2px solid #009879;
        }
        .notice-board tbody tr:hover { /* 호버 시 배경색 */
            background-color: #f0f0f0;
            cursor: pointer;
        }
        .notice-title a { /* 클래스명 변경 */
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        .notice-title a:hover { /* 클래스명 변경 */
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
        .no-notice-message { /* 클래스명 변경 */
            width: 100%;
            margin: 20px auto;
            text-align: center;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            color: #555;
        }
        /* 페이징 스타일 유지 */
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
        <h2>공지사항 게시판</h2> <%-- 제목 변경 --%>
		<c:if test="${loggedInMember.role == 'ADMIN' }">
        <div class="write-button-area">
            <a href="${pageContext.request.contextPath}/notice/write" class="write-button">공지사항 등록</a> <%-- 텍스트 및 URL 변경 --%>
        </div>
		</c:if>

        <c:if test="${not empty message}">
            <p style="color: green; font-weight: bold; text-align: center;">${message}</p>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <p style="color: red; font-weight: bold; text-align: center;">${errorMessage}</p>
        </c:if>

        <table class="notice-board"> <%-- 클래스명 변경 --%>
            <thead>
                <tr>
                    <th style="width: 10%;">번호</th>
                    <th style="width: 60%;">제목</th> <%-- 폭 조정 (상태 컬럼 제거로 인해) --%>
                    <th style="width: 15%;">작성일</th>
                    <th style="width: 15%;">조회수</th>
                    <%-- <th>상태</th> --%> <%-- 상태 컬럼 제거 --%>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty noticelist}"> <%-- 모델 속성명 변경 --%>
                        <c:forEach var="notice" items="${noticelist}"> <%-- 변수명 및 아이템 변경 --%>
                            <tr>
                                <td>${notice.num}</td> <%-- 필드명 변경 --%>
                                <td class="notice-title"> <%-- 클래스명 변경 --%>
                                    <a href="${pageContext.request.contextPath}/notice/detail/${notice.num}"> <%-- URL 및 필드명 변경 --%>
                                        ${notice.title} <%-- 필드명 변경 --%>
                                        <%-- Q&A 답변 관련 로직 제거 --%>
                                        <%-- <c:if test="${not empty qna.answerContent}"> 
                                            <span style="color: blue; font-size: 0.8em;"> [답변 완료]</span>
                                        </c:if> --%>
                                    </a>
                                </td>
                                <td>${notice.regDate}</td>
                                <td>${notice.viewCount}</td>
                                <%-- 상태 관련 로직 제거 --%>
                                <%-- <td>
                                    <c:choose>
                                        <c:when test="${not empty qna.answerContent}">답변 완료</c:when>
                                        <c:otherwise>대기중</c:otherwise>
                                    </c:choose>
                                    <c:if test="${not empty sessionScope.adminUser}">
                                    </c:if>
                                </td> --%>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="4" class="no-notice-message">등록된 공지사항이 없습니다.</td> <%-- colspan 및 메시지 변경 --%>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <%-- 페이징 영역 --%>
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/notice/list?page=${currentPage - 1}&pageSize=${pageSize}">&laquo;</a> <%-- URL 변경, 검색 파라미터 제거 --%>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i eq currentPage}">
                        <strong>${i}</strong>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/notice/list?page=${i}&pageSize=${pageSize}">${i}</a> <%-- URL 변경, 검색 파라미터 제거 --%>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/notice/list?page=${currentPage + 1}&pageSize=${pageSize}">&raquo;</a> <%-- URL 변경, 검색 파라미터 제거 --%>
            </c:if>
        </div>

    </div>

    <jsp:include page="../includes/footer.jsp" />
</body>
</html>