<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마을 도서관 - 도서 목록</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f0f4f8; /* 은은한 푸른 계열 배경 */
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* 상단 정렬 */
            align-items: center;
            min-height: 100vh;
            color: #333;
            overflow-x: hidden; /* 가로 스크롤 방지 */
        }
        .header {
            width: 100%;
            padding: 20px 0;
            background-color: #4CAF50; /* 도서관 로고/이름 부분 배경색 */
            color: white;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .header h1 {
            margin: 0;
            font-size: 3em;
            letter-spacing: 2px;
        }
        .header h1 i {
            margin-right: 15px;
            color: #FFEB3B; /* 책 아이콘 색상 */
        }
        .main-content {
            background-color: #ffffff;
            padding: 50px 80px;
            border-radius: 12px;
            box-shadow: 0 6px 30px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 900px; /* index.jsp보다 조금 더 넓게 */
            width: 90%;
            margin: 40px auto;
            animation: fadeIn 1s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            color: #1565C0;
            margin-bottom: 30px;
            font-weight: 700;
        }
        .book-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); /* 반응형 그리드 */
            gap: 25px;
            margin-top: 30px;
        }
        .book-item {
            background-color: #e3f2fd;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
            text-align: left;
            transition: transform 0.3s ease;
        }
        .book-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }
        .book-item h3 {
            font-size: 1.3em;
            color: #333;
            margin-top: 0;
            margin-bottom: 10px;
        }
        .book-item p {
            font-size: 0.95em;
            color: #555;
            margin-bottom: 5px;
            line-height: 1.4;
        }
        .book-item .author {
            font-weight: 500;
            color: #666;
        }
        .book-item .isbn {
            font-size: 0.85em;
            color: #888;
        }
        .footer {
            margin-top: 50px;
            padding: 20px;
            color: #777;
            font-size: 0.95em;
            text-align: center;
            width: 100%; /* 푸터 너비 조정 */
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .header h1 {
                font-size: 2.2em;
            }
            .main-content {
                padding: 30px 40px;
                margin: 20px auto;
            }
            h2 {
                font-size: 1.8em;
            }
            .book-list {
                grid-template-columns: 1fr; /* 한 줄에 한 개씩 */
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <h1><i class="fas fa-book-reader"></i> 마을 도서관</h1>
    </div>

    <div class="main-content">
        <h2><i class="fas fa-books"></i> 현재 보유 도서 목록</h2>
        <div class="book-list">
            <%-- 예시 도서 데이터 (실제로는 Spring Controller에서 Model에 담아 전달) --%>
            <div class="book-item">
                <h3>스프링 부트 완벽 가이드</h3>
                <p class="author">저자: 김철수</p>
                <p class="isbn">ISBN: 978-89-000-0000-1</p>
            </div>
            <div class="book-item">
                <h3>자바 프로그래밍의 정석</h3>
                <p class="author">저자: 이영희</p>
                <p class="isbn">ISBN: 978-89-000-0000-2</p>
            </div>
            <div class="book-item">
                <h3>클린 코드</h3>
                <p class="author">저자: 로버트 C. 마틴</p>
                <p class="isbn">ISBN: 978-89-000-0000-3</p>
            </div>
            <div class="book-item">
                <h3>객체지향의 사실과 오해</h3>
                <p class="author">저자: 조영호</p>
                <p class="isbn">ISBN: 978-89-000-0000-4</p>
            </div>
            <%--
            <c:forEach var="book" items="${bookList}">
                <div class="book-item">
                    <h3>${book.title}</h3>
                    <p class="author">저자: ${book.author}</p>
                    <p class="isbn">ISBN: ${book.isbn}</p>
                </div>
            </c:forEach>
            --%>
            <p style="grid-column: 1 / -1; margin-top: 30px; font-size: 1.1em; color: #666;">
                더 많은 도서가 추가될 예정입니다.
            </p>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2025 마을 도서관. All rights reserved.</p>
        <p>문의: contact@villagelibrary.org</p>
    </div>
</body>
</html>