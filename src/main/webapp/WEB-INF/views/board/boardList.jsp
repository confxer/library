<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 자유게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        /* 자유게시판 목록을 위한 스타일 */
        .board-container {
            width: 90%;
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        .board-container h2 {
            color: #333;
            margin-bottom: 30px;
            text-align: center;
            font-size: 2.5em;
            border-bottom: 2px solid #009879;
            padding-bottom: 15px;
        }
        .board-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .board-table th, .board-table td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: center;
        }
        .board-table th {
            background-color: #009879;
            color: white;
            font-weight: bold;
            font-size: 1.1em;
        }
        .board-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .board-table tr:hover {
            background-color: #e9f5f9;
        }
        .board-table td a {
            color: #333;
            text-decoration: none;
            font-weight: 500;
        }
        .board-table td a:hover {
            text-decoration: underline;
            color: #007b66;
        }
        .write-button-area {
            text-align: right;
            margin-bottom: 20px;
        }
        .write-button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .write-button:hover {
            background-color: #0056b3;
        }
        .pagination {
            text-align: center;
            margin-top: 30px;
        }
        .pagination a, .pagination strong {
            display: inline-block;
            padding: 8px 15px;
            margin: 0 4px;
            border: 1px solid #ddd;
            border-radius: 5px;
            text-decoration: none;
            color: #009879;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .pagination a:hover {
            background-color: #009879;
            color: white;
        }
        .pagination strong {
            background-color: #009879;
            color: white;
            border-color: #009879;
            font-weight: bold;
        }
        .no-posts {
            text-align: center;
            padding: 30px;
            font-size: 1.2em;
            color: #555;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />

    <div class="container">
        <div class="board-container">
            <h2>회원 자유게시판</h2>

            <div class="write-button-area">
            	<c:if test="${not empty loggedInMember }">
                <a href="${pageContext.request.contextPath}/board/write" class="write-button">새 글 작성</a>
                </c:if>
                <c:if test="${empty loggedInMember }">
                <a href="${pageContext.request.contextPath}/member/login" class="write-button">새 글 작성</a>
                </c:if>
            </div>

            <c:if test="${empty posts}">
                <p class="no-posts">등록된 게시글이 없습니다.</p>
            </c:if>
            <c:if test="${not empty posts}">
                <table class="board-table">
                    <thead>
                        <tr>
                            <th style="width: 10%;">번호</th>
                            <th style="width: 50%;">제목</th>
                            <th style="width: 10%;">작성자</th>
                            <th style="width: 15%;">작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="post" items="${posts}">
                            <tr>
                                <td>${post.id}</td>
                                <td style="text-align: left;"><a href="${pageContext.request.contextPath}/board/detail/${post.id}">${post.title}</a></td>
                                <td>${post.writer}</td>
                                <td><fmt:parseDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedRegDate" />
                        		
                        		<fmt:formatDate value="${parsedRegDate}" pattern="yyyy.MM.dd HH:mm" />
                        </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="<c:url value="/board/boardList?page=${currentPage - 1}&pageSize=${pageSize}"/>">&laquo; 이전</a>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="pageNo">
                    <c:choose>
                        <c:when test="${pageNo == currentPage}">
                            <strong>${pageNo}</strong>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value="/board/boardList?page=${pageNo}&pageSize=${pageSize}"/>">${pageNo}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="<c:url value="/board/boardList?page=${currentPage + 1}&pageSize=${pageSize}"/>">다음 &raquo;</a>
                </c:if>
            </div>
        </div>
    </div>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>