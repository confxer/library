<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세 보기</title> <%-- 제목 변경 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        /* detail.jsp만을 위한 스타일 */
        .notice-detail-container { /* 클래스명 변경 */
            width: 70%;
            margin: 30px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .notice-detail-header { /* 클래스명 변경 */
            border-bottom: 2px solid #009879;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        .notice-detail-header h2 { /* 클래스명 변경 */
            color: #333;
            font-size: 2.2em;
            margin-bottom: 5px;
        }
        .notice-info { /* 클래스명 변경 */
            font-size: 0.9em;
            color: #777;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .notice-info span { /* 클래스명 변경 */
            margin-right: 15px;
        }
        .notice-content { /* 클래스명 변경 */
            padding: 20px 0;
            line-height: 1.8;
            color: #444;
            border-bottom: 1px dashed #ddd;
            word-wrap: break-word; /* 긴 텍스트 줄바꿈 */
            white-space: pre-wrap; /* 줄바꿈 및 공백 유지 */
        }
        .notice-content p { /* 클래스명 변경 */
            margin-bottom: 1em;
        }
        /* Q&A의 답변 관련 스타일 (.qa-answer, .reply-section 등)은 공지사항에 필요 없으므로 제거 */
        .notice-buttons { /* 클래스명 변경 */
            text-align: right;
            margin-top: 30px;
        }
        .notice-buttons a, .notice-buttons button { /* 클래스명 변경 */
            background-color: #6c757d;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.95em;
            text-decoration: none;
            margin-left: 10px;
            transition: background-color 0.2s ease;
        }
        .notice-buttons a:hover, .notice-buttons button:hover { /* 클래스명 변경 */
            background-color: #5a6268;
        }
        .notice-buttons .edit-btn { /* 클래스명 변경 */
            background-color: #007bff;
        }
        .notice-buttons .edit-btn:hover { /* 클래스명 변경 */
            background-color: #0056b3;
        }
        .notice-buttons .delete-btn { /* 클래스명 변경 */
            background-color: #dc3545;
        }
        .notice-buttons .delete-btn:hover { /* 클래스명 변경 */
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <jsp:include page="../includes/header.jsp" />

    <div class="container">
        <div class="notice-detail-container"> <%-- 클래스명 변경 --%>
            <c:if test="${not empty errorMessage}">
                <p style="color: red; text-align: center;">${errorMessage}</p>
            </c:if>
            <c:if test="${not empty message}">
                <p style="color: green; text-align: center;">${message}</p>
            </c:if>

            <c:if test="${empty notice}"> <%-- 모델 속성명 변경 --%>
                <div style="text-align: center; padding: 50px; color: #555;">
                    <p>죄송합니다. 요청하신 공지사항을 찾을 수 없습니다.</p> <%-- 텍스트 변경 --%>
                    <p><a href="${pageContext.request.contextPath}/notice/list" style="color: #007bff; text-decoration: none;">공지사항 목록으로 돌아가기</a></p> <%-- URL 및 텍스트 변경 --%>
                </div>
            </c:if>

            <c:if test="${not empty notice}"> <%-- 모델 속성명 변경 --%>
                <div class="notice-detail-header"> <%-- 클래스명 변경 --%>
                    <h2>${notice.title}</h2> <%-- 필드명 변경 --%>
                    <div class="notice-info"> <%-- 클래스명 변경 --%>
                        <span>작성일: ${notice.regDate}</span>
                        <span>조회수: ${notice.viewCount}</span>
                        <%-- Q&A 상태 관련 로직 제거 --%>
                        <%-- <span>상태:
                            <c:choose>
                                <c:when test="${not empty qna.answerContent}"> 
                                    <span style="color: blue; font-weight: bold;">답변 완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: red; font-weight: bold;">대기중</span>
                                </c:otherwise>
                            </c:choose>
                        </span> --%>
                    </div>
                </div>

                <div class="notice-content"> <%-- 클래스명 변경 --%>
                    <p>${notice.content}</p> <%-- 필드명 변경 --%>
                </div>

                <%-- Q&A 답변 섹션 제거 --%>
                <%-- <c:if test="${not empty qna.answerContent}">
                    <div class="qa-answer">
                        <h3>관리자 답변</h3>
                        <p>${qna.answerContent}</p>
                    </div>
                </c:if> --%>

                <div class="notice-buttons"> <%-- 클래스명 변경 --%>
                    <a href="${pageContext.request.contextPath}/notice/list">목록으로</a> <%-- URL 변경 --%>
                    <c:if test="${loggedInMember.role == 'ADMIN'}"> <%-- 관리자 권한 확인 (유지) --%>
                        <a href="${pageContext.request.contextPath}/notice/edit/${notice.noticeId}" class="edit-btn">수정</a> <%-- URL 및 필드명 변경 --%>
                        <form action="${pageContext.request.contextPath}/notice/delete" method="post" style="display: inline-block;"> <%-- URL 변경 --%>
                            <input type="hidden" name="num" value="${notice.num}"> <%-- name 및 value 필드명 변경 --%>
                            <button type="submit" class="delete-btn" onclick="return confirm('정말로 이 공지사항을 삭제하시겠습니까?');">삭제</button> <%-- 텍스트 변경 --%>
                        </form>
                    </c:if>
                </div>

                <%-- Q&A 답변 관리 섹션 제거 --%>
                <%-- <hr>
                <div class="reply-section">
                    <h3>답변 관리</h3>
                    <c:if test="${not empty sessionScope.adminUser}">
                        <div class="reply-form">
                            <form action="${pageContext.request.contextPath}/qa/answer" method="post">
                                <input type="hidden" name="qaId" value="${qna.qaId}">
                                <input type="hidden" name="writer" value="admin">
                                <textarea name="answerContent" placeholder="답변 내용을 입력하세요.">${qna.answerContent}</textarea>
                                <input type="submit" value="답변 등록/수정">
                            </form>
                        </div>
                        <div style="clear: both;"></div>
                    </c:if>
                    <c:if test="${not empty qna.answerContent}">
                        <ul class="reply-list">
                            <li class="reply-item">
                                <div class="reply-item-header">
                                    <span>작성자: 관리자</span>
                                    <span>작성일: ${qna.formattedRegDate} (Q&A 작성일)</span>
                                </div>
                                <div class="reply-content">
                                    <p>${qna.answerContent}</p>
                                </div>
                            </li>
                        </ul>
                    </c:if>
                    <c:if test="${empty qna.answerContent && not empty sessionScope.adminUser}">
                         <p style="text-align: center; color: #555;">아직 등록된 답변이 없습니다.</p>
                    </c:if>
                </div> --%>

            </c:if>
        </div>
    </div>

    <jsp:include page="../includes/footer.jsp" />
</body>
</html>