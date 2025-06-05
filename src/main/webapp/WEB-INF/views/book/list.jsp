<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>도서 목록</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">
    <jsp:include page="/WEB-INF/views/includes/header.jsp" />
    <main class="container mx-auto p-6 flex-grow">
        <div class="bg-white shadow-md rounded-lg overflow-hidden mb-4">
            <div class="p-4 flex justify-between items-center">
                <p class="text-gray-600">총 ${totalBooks}개의 도서</p>
                 <form action="/library/list/search" method="get" class="flex">
                <input type="text" name="query" placeholder="제목 또는 저자 검색" 
                       value="${query}" 
                       class="px-4 py-2 rounded-l-md border-none focus:outline-none focus:ring-2 focus:ring-blue-400">
                <button type="submit" 
                        class="bg-blue-800 hover:bg-blue-900 px-4 py-2 rounded-r-md text-white">
                    검색
                </button>
            </form>
                <form action="/library/list/search" method="get">
                    <input type="hidden" name="query" value="${query}">
                    <label for="pageSize" class="mr-2">페이지당 도서 수:</label>
                    <select id="pageSize" name="size" 
                            onchange="this.form.submit()" 
                            class="p-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-400">
                        <option value="30" ${pageSize == 30 ? 'selected' : ''}>30</option>
                        <option value="50" ${pageSize == 50 ? 'selected' : ''}>50</option>
                        <option value="100" ${pageSize == 100 ? 'selected' : ''}>100</option>
                        <option value="200" ${pageSize == 200 ? 'selected' : ''}>200</option>
                    </select>
                </form>
            </div>
            <table class="w-full table-auto">
                <thead class="bg-gray-200">
                    <tr>
                        <th class="px-4 py-2 text-left">번호</th>
                        <th class="px-4 py-2 text-left ">제목</th>
                        <th class="px-4 py-2 text-left ">저자</th>
                        <th class="px-4 py-2 text-left ">출판사</th>
                        <th class="px-4 py-2 text-left">리뷰</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="book" items="${books}">
                        <tr class="hover:bg-gray-50">
                            <td class="px-4 py-2">${book.seqNo}</td>
                            <td class="px-4 py-2 max-w-xs truncate" title="${book.title}">
                                <a href="/library/list/book/${book.seqNo}" 
                                   class="text-blue-600 hover:underline">${book.title}</a>
                            </td>
                            <td class="px-4 py-2 max-w-xs truncate" title="${book.author}">
                                ${book.author}
                            </td>
                            <td class="px-4 py-2 max-w-xs truncate" title="${book.publisher}">
                                ${book.publisher}
                            </td>
                            <td class="px-4 py-2 w-20">${book.reviewCount}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty books}">
                        <tr>
                            <td colspan="5" class="px-4 py-2 text-center text-gray-500">
                                검색 결과가 없습니다.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${not empty books}">
            <div class="flex justify-center space-x-2">
                <c:if test="${currentPage > 1}">
                    <a href="/library/list/search?query=${query}&page=${currentPage - 1}&size=${pageSize}" 
                       class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">
                        이전
                    </a>
                </c:if>
                <c:forEach begin="1" end="${(totalBooks + pageSize - 1) / pageSize}" var="i">
                    <a href="/library/list/search?query=${query}&page=${i}&size=${pageSize}" 
                       class="px-4 py-2 ${currentPage == i ? 'bg-blue-800 text-white' : 'bg-gray-200 text-gray-700'} rounded-md hover:bg-blue-600 hover:text-white">
                        ${i}
                    </a>
                </c:forEach>
                <c:if test="${currentPage < (totalBooks + pageSize - 1) / pageSize}">
                    <a href="/library/list/search?query=${query}&page=${currentPage + 1}&size=${pageSize}" 
                       class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">
                        다음
                    </a>
                </c:if>
            </div>
        </c:if>
    </main>
    <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
</body>
</html>