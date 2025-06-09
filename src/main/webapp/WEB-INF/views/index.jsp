<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> <%-- JSTL Core URI를 jakarta.tags.core로 통일 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%-- !!! 이 라인을 추가합니다: JSTL Functions 라이브러리 선언 !!! --%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마을 도서관</title>
    <%-- resources/css/style.css 파일 링크 --%>
    <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
    <style>
        /* ==================================== */
        /* index.jsp 고유의 스타일 시작         */
        /* ==================================== */

        body {
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6;
            color: #333;
            display: flex; /* Flexbox 추가: 헤더-메인-푸터를 세로로 배치 */
            flex-direction: column; /* 세로 방향으로 아이템 배치 */
            min-height: 100vh; /* 뷰포트 높이만큼 최소 높이 설정 (푸터를 하단으로 밀어냄) */
        }

        /* 메인 배너 스타일 - 높이를 늘려 이미지가 덜 잘리도록 하고 메뉴를 위한 공간 확보 */
        .main-banner {
            position: relative;
            text-align: center;
            background-image: url('<c:url value="/resources/images/mylib.jpg"/>'); <%-- 이미지 경로 --%>
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 350px; /* 원본 175px에서 대폭 증가 */
            display: flex;
            flex-direction: column;
            justify-content: flex-start; /* ⭐ 변경: 콘텐츠를 상단으로 정렬 */
            align-items: center; /* 수평 중앙 정렬 유지 */
            border-radius: 0;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            color: white;
            padding-top: 80px; /* ⭐ 조정: 전체 콘텐츠를 상단에서 80px 떨어뜨립니다. (원하는 높이로 조절) */
            box-sizing: border-box; /* 패딩 포함 높이 계산 */
        }

        .main-banner h2 {
            font-size: 2.5em; /* 글씨 크기 약간 키움 */
            margin-top: 0; /* ⭐ 추가: 상단 마진 제거 */
            margin-bottom: 10px; /* ⭐ 조정: p 태그와의 간격 */
            text-shadow: 2px 2px 4px rgba(0,0,0,0.7);
            z-index: 2;
        }

        .main-banner p {
            font-size: 1.4em; /* 글씨 크기 약간 키움 */
            margin-top: 0; /* ⭐ 추가: 상단 마진 제거 */
            margin-bottom: 30px; /* ⭐ 조정: 검색창과의 간격 (원하는 만큼 늘림) */
            text-shadow: 1px 1px 3px rgba(0,0,0,0.7);
            z-index: 2;
            font-weight: bold; /* ⭐ 추가: 글자 굵게 */
            color: #FFFF99; /* ⭐ 추가: 글자 색상 밝은 노란색으로 강조 (필요 시 다른 색상으로 변경) */
        }

        /* 검색창 컨테이너 스타일 - 배너 중앙에 가깝게 조정 */
        .banner-search-container {
            /* ⭐ 아래 4가지 속성을 제거하거나 주석 처리합니다. Flexbox 흐름에 따르도록 변경 */
            /* position: absolute; */
            /* top: 70%; */
            /* left: 50%; */
            /* transform: translateX(-50%); */
            
            width: 90%;
            max-width: 800px;
            background-color: #fff;
            padding: 0;
            border-radius: 5px; /* 모서리를 약간 둥글게 */
            box-shadow: 0 6px 15px rgba(0,0,0,0.2); /* 그림자 진하게 */
            display: flex;
            align-items: center;
            z-index: 10;
            overflow: hidden; /* input, button의 border-radius 적용을 위해 */
        }
        .banner-search-container form {
            display: flex;
            width: 100%;
            border: none;
            border-radius: 5px; /* 모서리를 약간 둥글게 */
            overflow: hidden;
        }
        .banner-search-container input {
            flex-grow: 1;
            border: 1px solid #ccc !important; /* 테두리 추가 */
            outline: none !important;
            padding: 10px 15px !important; /* 패딩 늘림 */
            font-size: 17px; /* 글씨 크기 약간 키움 */
            border-radius: 5px 0 0 5px !important; /* 왼쪽만 둥글게 */
            background-color: #ffffff; /* 배경색 변경 */
            height: 45px !important; /* 높이 늘림 */
            box-sizing: border-box !important;
            line-height: normal !important;
            vertical-align: middle;
        }
        .banner-search-container button {
            background-color: #007bff; /* 파란색 계열로 변경 */
            color: white;
            border: 1px solid #007bff !important; /* 테두리 색상 일치 */
            padding: 10px 20px !important; /* 패딩 늘림 */
            border-radius: 0 5px 5px 0 !important; /* 오른쪽만 둥글게 */
            cursor: pointer;
            font-size: 17px; /* 글씨 크기 약간 키움 */
            margin-left: -1px !important; /* input과의 미세한 간격 조정 */
            transition: background-color 0.3s ease, border-color 0.3s ease;
            height: 45px !important; /* 높이 늘림 */
            box-sizing: border-box !important;
            line-height: normal !important;
            vertical-align: middle;
            white-space: nowrap;
            text-align: center;
        }
        .banner-search-container button:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        /* 메인 콘텐츠 레이아웃 */
        .main-layout {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            max-width: 1200px;
            margin: 20px auto; /* 중앙 정렬, 상단 여백 추가 */
            padding: 20px;
            flex-grow: 1; /* 남은 공간을 차지하여 푸터를 하단으로 밀어냄 */
        }

        .left-content, .right-content {
            flex: 1; /* 동일한 너비로 공간 분할 */
            display: flex;
            flex-direction: column;
            gap: 20px; /* 섹션 간의 간격 */
        }

        .section-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .section-container h3 {
            font-size: 1.5em;
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .section-container ul {
            list-style: none;
            padding: 0;
        }
        .section-container li {
            padding: 8px 0;
            border-bottom: 1px dashed #eee;
            font-size: 0.95em;
        }
        .section-container li:last-child {
            border-bottom: none;
        }
        .section-container a {
            text-decoration: none;
            color: #444;
            font-weight: 500;
            display: block;
        }
        .section-container a:hover {
            color: #3498db;
        }

        /* 추천 도서 영역 스타일 */
        .recommended-books {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap; /* 작은 화면에서 줄바꿈 */
            margin-top: 20px;
        }
        .recommended-item {
            width: 160px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
            background-color: #fff;
            padding-bottom: 10px;
            transition: transform 0.2s ease-in-out;
        }
        .recommended-item:hover {
            transform: translateY(-5px);
        }
        .recommended-item img {
            width: 100%;
            height: 220px; /* 이미지 높이 고정 */
            object-fit: cover; /* 이미지가 잘리지 않고 채워지도록 */
            border-bottom: 1px solid #eee;
            margin-bottom: 8px;
        }
        .recommended-item p {
            margin: 3px 8px;
            font-size: 0.85em;
            color: #555;
            word-break: keep-all; /* 단어가 잘리지 않도록 */
        }
        .recommended-item p:first-of-type {
            font-weight: bold;
            color: #333;
            font-size: 0.95em;
        }
        .recommended-item.placeholder-item img {
            opacity: 0.7; /* 준비중 이미지 흐리게 */
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .main-layout {
                flex-direction: column;
                padding: 10px;
            }
            .left-content, .right-content {
                width: 100%;
            }
            .main-banner {
                height: 300px;
                padding-top: 60px; /* ⭐ 모바일에서도 패딩 조절 */
            }
            .main-banner h2 {
                font-size: 2em;
            }
            .main-banner p {
                font-size: 1.1em;
            }
            .banner-search-container {
                /* top: 70%; ⭐ 모바일에서도 이 속성 제거 */
                width: 90%;
                max-width: 350px;
            }
            .banner-search-container input,
            .banner-search-container button {
                font-size: 15px;
                height: 40px !important;
            }
        }
        /* ==================================== */
        /* index.jsp 고유의 스타일 끝           */
        /* ==================================== */
    </style>
</head>
<body>
    <%-- 상단 메뉴 포함 (header.jsp는 보통 <body> 안에 포함됩니다. 배너 아래에 위치) --%>
    <%-- 경로: /mylibrary/src/main/webapp/WEB-INF/views/includes/header.jsp --%>
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

    <%-- 메인 배너 및 검색창 --%>
    <div class="main-banner">
        <h2>책과 함께하는 새로운 세상</h2>
        <p>마을 도서관에서 지식과 영감을 발견하세요.</p>
        <div class="banner-search-container">
            <form action="<c:url value="/list/search"/>" method="get">
                <input type="text" name="query" placeholder="도서 제목, 저자 검색?">
                <button type="submit">검색</button>
            </form>
        </div>
    </div>

    <main class="main-layout">
        <%-- 팝업 공지사항 (기존 위치 유지, CSS만 조정) --%>
        <c:if test="${not empty popupNotice}">
            <div id="popupNotice" style="display:block; position:fixed; top:20%; left:50%; transform:translate(-50%, -20%); background:white; padding:20px; border:1px solid #ccc; box-shadow:0 0 10px rgba(0,0,0,0.5); z-index:1000;">
                <h3>${popupNotice.title}</h3>
                <div>${popupNotice.content}</div>
                <button onclick="document.getElementById('popupNotice').style.display='none'">닫기</button>
            </div>
        </c:if>

        <%-- 왼쪽 섹션 (공지사항, Q&A) --%>
        <div class="left-content">
            <%-- 최근 공지사항 섹션 --%>
            <div class="section-container recent-notices">
                <h3>최근 공지사항</h3>
                <ul>
                    <c:choose>
                        <c:when test="${not empty notices}">
                            <c:forEach var="notice" items="${notices}" varStatus="status" begin="0" end="4">
                                <li><a href="<c:url value="/notice/detail?num=${notice.num}"/>">${notice.title}</a></li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li>공지사항이 없습니다.</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>

            <%-- Q&A 섹션 --%>
            <div class="section-container q-a">
                <h3>Q&A</h3>
                <ul>
                    <c:choose>
                        <c:when test="${not empty qnas}">
                            <c:forEach var="qa" items="${qnas}" varStatus="status" begin="0" end="4">
                                <li><a href="<c:url value="/qa/detail?num=${qa.qnaId}"/>">${qa.title}</a></li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li>Q&A가 없습니다.</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>

        <%-- 오른쪽 섹션 (추천 도서, 신작 도서) --%>
        <div class="right-content">
            <%-- 이번 달 추천 도서 섹션 --%>
            <div class="section-container recommended-books-section">
                <h3>이번 달 추천 도서</h3>
                <div class="recommended-books">
                    <c:forEach var="book" items="${recommendedBooks}" varStatus="status" begin="0" end="3">
                        <div class="recommended-item">
                            <%-- 이미지 경로를 실제 존재하는 이미지로 확인 또는 기본 이미지 사용 --%>
                            <img src="<c:url value="/resources/images/recommended_book_0${status.index + 1}.jpg"/>"
                                 alt="${book.title_nm}" class="book-cover">
                            <p>${book.title_nm}</p>
                            <p>${book.authr_nm}</p>
                        </div>
                    </c:forEach>
                    <c:if test="${empty recommendedBooks || fn:length(recommendedBooks) < 4}"> <%-- size() 대신 fn:length() 사용 --%>
                        <c:set var="numMissing" value="${4 - fn:length(recommendedBooks)}" /> <%-- size() 대신 fn:length() 사용 --%>
                        <c:forEach begin="1" end="${numMissing}">
                            <div class="recommended-item placeholder-item">
                                <%-- 기본 이미지 경로 확인 (필요 시 직접 파일 추가). 이 파일이 없다면 'default_book_cover.jpg' 파일을 /resources/images/ 에 추가해야 합니다. --%>
                                <img src="<c:url value="/resources/images/default_book_cover.jpg"/>" alt="준비중" class="book-cover">
                                <p>추천 도서 준비중</p>
                                <p></p>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>

            <%-- 신작 도서 섹션 --%>
            <div class="section-container new-books-section">
                <h3>신작 도서</h3>
                <ul>
                    <c:choose>
                        <c:when test="${not empty newBooks}">
                            <c:forEach var="book" items="${newBooks}" varStatus="status" begin="0" end="5">
                                <li><a href="<c:url value="/book/detail?seqNo=${book.seq_no}"/>">${book.title_nm} - ${book.authr_nm}</a></li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <li>신작 도서가 없습니다.</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </main>

    <%-- 푸터 포함 --%>
    <%-- 경로: /mylibrary/src/main/webapp/WEB-INF/views/includes/footer.jsp --%>
    <%@ include file="/WEB-INF/views/includes/footer.jsp" %>

    <script>
        // 필요 시 팝업 닫기 등의 스크립트 추가
    </script>
</body>
</html>