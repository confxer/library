<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도서 세부 정보 - ${book.title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    <main class="container mx-auto p-6 flex-grow">
        <div class="bg-white shadow-md rounded-lg p-6 max-w-2xl mx-auto">
            <h2 class="text-xl font-semibold mb-4">${book.title}</h2>
            <div class="mb-2"><strong>저자:</strong> ${book.author}</div>
            <div class="mb-2"><strong>출판사:</strong> ${book.publisher}</div>
            <div class="mb-2"><strong>출판일:</strong>
            
            ${book.publicationDate.equals('0000-00-00') ? '?' : book.publicationDate}</div>
            <div class="mb-2"><strong>도서 소개:</strong> <p class="text-gray-700">${book.introduction}</p></div>
            <div class="mb-4"><strong>대출 상태:</strong> 
                <span class="${book.portalExists == 'Y' ? 'text-green-600' : 'text-red-600'}">
                    ${book.portalExists == 'Y' ? '대출 가능' : '대출 중'}
                </span>
            </div>
            <c:if test="${book.portalExists == 'Y' && not empty loggedInMember}">
                <form action="/library/book/${book.seqNo}/borrow" method="post" class="mb-4">
                	<input type="hidden" id = "userId" name = "userId" value = "${loggedInMember.memberId }">
                    <button type="submit" 
                            class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md">
                        대출하기
                    </button>
                </form>
            </c:if>
            <a href="/library/list" class="text-blue-600 hover:underline">목록으로 돌아가기</a>

            <hr class="my-6">

            <c:if test="${not empty loggedInMember && hasBorrowed}">
                <form action="/library/book/${book.seqNo}/review" method="post" class="mb-6">
                    <textarea name="content" rows="4" 
                              class="w-full p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400" 
                              placeholder="리뷰를 작성하세요" required></textarea>
                    <button type="submit" 
                            class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md mt-2">
                        리뷰 제출
                    </button>
                </form>
            </c:if>
            <c:if test="${empty loggedInMember}">
                <p class="text-gray-500 mb-4">리뷰를 작성하려면 로그인하세요.</p>
            </c:if>
            <div class="space-y-4">
                <c:forEach var="review" items="${reviews}">
                    <div class="border-b pb-2">
                        <p class="text-gray-700">${review.content}</p>
                        <p class="text-sm text-gray-500">작성일: ${review.createdAt}</p>
                    </div>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <p class="text-gray-500">아직 리뷰가 없습니다.</p>
                </c:if>
            </div>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>