<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- 이 파일은 완전한 HTML 구조(<html>, <head>, <body>)를 포함하지 않습니다. --%>
<%-- 단지 웹 페이지의 상단 메뉴 부분만 포함합니다. --%>

<nav class="main-nav">
    <ul>
        <li><a href="<c:url value="/"/>">홈</a></li>
        <li><a href="<c:url value="/notice/list"/>">공지사항</a></li>
        <li><a href="<c:url value="/qna/list"/>">Q&A</a></li>
        
        <%-- ⭐ 커뮤니티 드롭다운 메뉴 (유지) ⭐ --%>
        <li class="dropdown">
            <a href="<c:url value="/board/list"/>">커뮤니티</a>
        </li>
        <%-- ⭐ 커뮤니티 드롭다운 메뉴 끝 ⭐ --%>
        
        <c:if test="${empty loggedInMember }">
	       <li><a href="<c:url value="/member/login"/>">로그인</a></li>
	       <li><a href="<c:url value="/member/register"/>">회원가입</a></li>
        </c:if>
        <c:if test="${not empty loggedInMember }">
	       <li><a href="<c:url value="/member/mypage"/>">마이페이지</a></li>
        	<li><a href="/library/member/logout">로그아웃</a></li>
        </c:if>
    </ul>
</nav>

<style>
    /* header.jsp에 포함될 main-nav 관련 CSS */
    .main-nav {
        background-color: #f8f8f8;
        padding: 15px 0;
        border-bottom: 1px solid #e0e0e0;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        text-align: center;
    }

    .main-nav ul {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        max-width: 1200px;
        margin: 0 auto;
    }

    .main-nav li {
        margin: 0 20px;
        position: relative; /* 드롭다운을 위해 추가 */
    }

    .main-nav a {
        color: #555;
        text-decoration: none;
        font-weight: bold;
        font-size: 1.1em;
        padding: 10px 15px;
        border-radius: 5px;
        transition: background-color 0.3s ease, color 0.3s ease;
        display: block; /* 드롭다운 버튼으로 사용될 때 전체 클릭 영역 확보 */
    }

    .main-nav a:hover {
        background-color: #e0f2f7;
        color: #2c3e50;
    }

    /* ⭐ 드롭다운 관련 CSS (더욱 컴팩트하게 조정) ⭐ */
    .dropdown .dropbtn {
        /* 드롭다운 버튼 자체의 스타일은 기본 main-nav a 스타일을 따릅니다. */
    }

    .dropdown-content {
        display: none; /* 기본적으로 숨김 */
        position: absolute;
        background-color: #f9f9f9;
        min-width: 140px; /* ⭐ 최소 너비 조정: 텍스트가 한 줄에 들어갈 정도로만 */
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1; /* 다른 요소 위에 표시 */
        border-radius: 5px;
        top: 100%; /* 부모 li 아래에 위치 */
        left: 50%; /* 중앙 정렬을 위해 */
        transform: translateX(-50%); /* 중앙 정렬 */
        padding: 0; /* ⭐ 내부 여백 완전 제거 */
        overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
    }

    .dropdown-content a {
        color: black;
        padding: 7px 10px; /* ⭐ 내부 패딩 더 줄임 */
        text-decoration: none;
        display: block;
        text-align: center; /* ⭐ 텍스트를 중앙 정렬하여 깔끔하게 */
        font-weight: normal;
        font-size: 0.9em; /* ⭐ 폰트 크기 더 줄임 */
        border-radius: 0;
        white-space: nowrap; /* ⭐ 텍스트가 줄바꿈되지 않도록 강제 */
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .dropdown-content a:hover {
        background-color: #e0f2f7;
        color: #2c3e50;
    }

    .dropdown:hover .dropdown-content {
        display: block; /* 마우스 오버 시 표시 */
    }
    /* ⭐ 드롭다운 관련 CSS 끝 ⭐ */

    /* 반응형 (옵션) */
    @media (max-width: 768px) {
        .main-nav ul {
            flex-wrap: wrap;
            justify-content: center;
        }
        .main-nav li {
            margin: 5px 10px;
        }
        .dropdown-content {
            position: static; /* 모바일에서는 정적으로 배치 */
            transform: none;
            width: 100%; /* 모바일에서는 전체 너비 사용 */
            text-align: center;
        }
    }
</style>