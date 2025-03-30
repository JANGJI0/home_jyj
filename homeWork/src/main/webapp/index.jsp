<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 되었는지 아닌지?
			Integer staffId = (Integer)(session.getAttribute("loginStaff"));
			if(staffId == null) { // 로그아웃 상태라면
				response.sendRedirect("/homeWork/loginForm.jsp");
					return;
			}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
</head>
<body>
		<div>
			<%=staffId %>님 반갑습니다.
			<a href="/homeWork/logout.jsp">로그아웃</a>
			<a href="/homeWork/updatePasswordForm.jsp">비밀번호 수정</a>
		</div>
	<h1>Index</h1>
	
	<ol>
		<li><a href="/homeWork/rentalList.jsp">대여 목록</a></li> <!-- 3/25 -->
		<li><a href="/homeWork/filmList.jsp">영화 목록</a></li> <!-- 3/26 -->
		<li><a href="/homeWork/actorList.jsp">배우 목록</a></li> <!-- 3/25 -->
		
		<!--  3/27 : 인벤토리 리스트 + 영화제목 + 대여중 or 대여가능  -->
		<li><a href="/homeWork/inventoryList.jsp">인벤토리 목록</a></li><!-- 3/27 -->
	</ol>

</body>
</html>