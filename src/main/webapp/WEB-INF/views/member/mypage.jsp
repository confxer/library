<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 이 줄이 꼭 있어야 날짜 포맷팅이 됩니다 --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${member.name}님의 마이 페이지</title>
    <style>
        /* 기존 CSS는 그대로 유지하고 아래 추가 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            flex-direction: column;
        }
        .mypage-container, .loan-list-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 800px;
            margin-bottom: 20px;
            text-align: center;
        }
        h2 { margin-bottom: 20px; color: #333; }
        .info-group { margin-bottom: 15px; text-align: left; }
        .info-group label { display: block; margin-bottom: 5px; color: #555; font-weight: bold; }
        .info-group p { background-color: #e9e9e9; padding: 10px; border-radius: 4px; color: #333; margin-top: 0; }
        .btn-group { margin-top: 30px; }
        .btn-group a {
            display: inline-block; padding: 10px 20px; margin: 0 10px;
            background-color: #007bff; color: white; border: none;
            border-radius: 4px; cursor: pointer; font-size: 16px; text-decoration: none;
        }
        .btn-group a:hover { background-color: #0056b3; }
        .btn-group a.btn-logout { background-color: #dc3545; }
        .btn-group a.btn-logout:hover { background-color: #c82333; }

        /* 대출 목록 테이블 스타일 */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .loan-status-ongoing { color: #007bff; font-weight: bold; }
        .loan-status-returned { color: #28a745; font-weight: bold; }
    </style>
</head>
<body>
    <div class="mypage-container">
        <h2>${member.name}님의 마이 페이지</h2>

        <c:if test="${not empty message}">
            <p style="color: green;">${message}</p>
        </c:if>

        <div class="info-group">
            <label>아이디:</label>
            <p>${member.memberId}</p>
        </div>
        <div class="info-group">
            <label>이름:</label>
            <p>${member.name}</p>
        </div>
        <div class="info-group">
            <label>이메일:</label>
            <p>${member.email}</p>
        </div>
        <div class="info-group">
            <label>전화번호:</label>
            <p>${member.phone}</p> <%-- 여기가 phoneNumber -> phone 으로 수정되었습니다. --%>
        </div>
        <div class="info-group">
            <label>역할:</label>
            <p>${member.role}</p>
        </div>
        <div class="info-group">
            <label>주소:</label> <%-- address 필드 추가 --%>
            <p>${member.address}</p>
        </div>
        <div class="info-group">
            <label>상태:</label> <%-- status 필드 추가 --%>
            <p>${member.status}</p>
        </div>
        <div class="info-group">
            <label>가입일:</label>
            <p><fmt:formatDate value="${member.regDate}" pattern="yyyy-MM-dd HH:mm"/></p>
        </div>

        <div class="btn-group">
            <a href="/library/member/edit">정보 수정</a>
            <a href="/library/member/logout" class="btn-logout">로그아웃</a>
            <a href="/library/">메인으로</a>
            <c:if test="${loggedInMember.role == 'ADMIN' }">
            <a onclick="modal.showModal()" >관리자 페이지</a>
            <dialog id="modal">
            	<div style="width:250px; height: 50px;" display="block">
	            	<a style="background-color: green; width:50px; height: 80px; display:inline;" onclick = "members.showModal()">회원</a>
	            	<a style="background-color: green; width:50px; height: 80px; display:inline;" onclick = "borrows.showModal()">대출 현황</a>
            	</div>
            	<dialog style="width: 500px; heigth: 700px;" id="borrows">
            		<table>
		                    <thead>
		                        <tr>
		                            <th>책 번호</th>
		                            <th>아이디</th>
		                            <th>날짜</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <c:forEach var="memBor" items="${memBor}">
		                        	<form action="/library/book/${borrow.seqNo }/return" method="post"> 
			                            <tr>
			                                <td>${memBor.bookSeqNo}</td>
			                                <td>${memBor.userId}</td>
											<td>${memBor.borrowDate }</td>
			                            </tr>
		                        	</form>
		                        </c:forEach>
		                    </tbody>
		                </table>
            		<a onclick ="borrows.close()">닫기</a>
            	</dialog>
            	<dialog style="width: 500px; heigth: 700px;" id="members">
		                <table>
		                    <thead>
		                        <tr>
		                            <th>아이디</th>
		                            <th>이름</th>
		                            <th>역할</th>
		                            <th>부여하기</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <c:forEach var="member" items="${members}">
		                        	<form action="/library/book/${borrow.seqNo }/return" method="post"> 
			                            <tr>
			                                <td>${member.memberId}</td>
			                                <td>${member.name}</td>
			                                <td>
												<select onchange="submit()">
													<option><input type ="hidden" name = "ADMIN" value="ADMIN">ADMIN</option>
													<option><input type ="hidden" name = "USER" value="USER">USER</option>
												</select>
											</td>
			                                <td>부여하기</td>
			                            </tr>
		                        	</form>
		                        </c:forEach>
		                    </tbody>
		                </table>
            		<a  onclick="members.close()">닫기</a>
            	</dialog>
            	<a onclick="modal.close()">닫기</a>
            </dialog>
            </c:if>
            <a onclick="borrow.showModal()">대출 보기</a>
            <dialog id="borrow">
			    <div class="loan-list-container">
			        <h3>나의 대출 내역</h3>
			        <c:choose>
			            <c:when test="${not empty borrows && not empty borrowed}">
			                <table>
			                    <thead>
			                        <tr>
			                            <th>도서 제목</th>
			                            <th>저자</th>
			                            <th>반납</th>
			                        </tr>
			                    </thead>
			                    <tbody>
			                        <c:forEach var="borrow" items="${borrows}">
			                        	<form action="/library/book/${borrow.seqNo }/return" method="post"> 
				                            <tr>
				                                <td>${borrow.title}</td>
				                                <td>${borrow.author}</td>
				                                <td><button type="submit">반납하기</button></td>
					                        </c:forEach>
					                        <c:forEach var="borrowed" items="${borrowed }">
				                        	<input type="hidden" id="borrowId" name="borrowId" value="${borrowed.borrowId }"  >
					                        </c:forEach>
				                            </tr>
			                        	</form>
			                    </tbody>
			                </table>
			            </c:when>
			            <c:otherwise>
			                <p>대출 내역이 없습니다.</p>
			            </c:otherwise>
			        </c:choose>
			    </div>
            	
            	<a onclick="borrow.close()">닫기</a>
            </dialog>
        </div>
    </div>
	<script type="text/javascript">
		function submit(){
			
		}
	</script>
</body>
</html>