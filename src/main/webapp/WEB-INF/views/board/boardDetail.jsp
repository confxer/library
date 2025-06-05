<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %> <%-- ⭐ 이 줄을 추가합니다 ⭐ --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${posts.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        /* 상세 보기 페이지를 위한 스타일 */
        /* (생략: 스타일 코드는 변경 없음) */
    </style>
    <script>
        function confirmDelete() {
            if (confirm("정말 이 게시글을 삭제하시겠습니까?")) {
                document.getElementById('deleteForm').submit();
            }
        }
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    <div class="container">
        <div class="detail-container">
            <c:if test="${empty post}">
                <p style="text-align: center; font-size: 1.2em; color: #dc3545;">게시글을 찾을 수 없거나 삭제되었습니다.</p>
                <div class="button-area">
                    <a href="${pageContext.request.contextPath}/board/boardList" class="action-button list-button">목록으로</a>
                </div>
            </c:if>
            <c:if test="${not empty post}">
                <h2>${post.title}</h2>
                <div class="post-info">
                    <span>작성자: ${post.writer}</span>
                    <span>
                        작성일: <fmt:parseDate value="${post.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedRegDate" />
                        <fmt:formatDate value="${parsedRegDate}" pattern="yyyy.MM.dd HH:mm" />
                    </span>
                </div>
                <div class="post-content">
                    <p>${post.content}</p>
                </div>

                <div class="button-area">
                    <a href="${pageContext.request.contextPath}/board/list" class="action-button list-button">목록으로</a>
                    
                    <%-- 로그인한 사용자와 작성자가 같을 때만 수정/삭제 버튼 표시 --%>
                    <%-- ⭐ sessionScope.loginUser가 Integer일 경우를 대비하여 String.valueOf를 사용한 명시적 타입 변환 추가 ⭐ --%>
                    <c:if test="${loggedInMember != null && fn:trim(post.writer) eq fn:trim(String.valueOf(loggedInMember.name))}">
                        <a href="${pageContext.request.contextPath}/board/edit/${post.id}" class="action-button edit-button">수정</a>
                        <button type="button" class="action-button delete-button" onclick="confirmDelete()">삭제</button>
                        <form id="deleteForm" action="${pageContext.request.contextPath}/board/delete/${post.id}" method="get" style="display: none;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                    </c:if>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>