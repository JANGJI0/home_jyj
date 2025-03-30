<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
	// 로그인 되었는지 아닌지?
	Integer staffId = (Integer)(session.getAttribute("loginStaff"));
			
	if(staffId != null) { // 로그인 상태라면
		response.sendRedirect("/homeWork/index.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
 <style>
    body {
      font-family: 'Arial', sans-serif;
      padding: 40px;
      background-color: #f9f9f9;
    }
    table {
      width: 350px;
      margin: 0 auto;
      border-collapse: collapse;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      background-color: #fff;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 12px 16px;
      text-align: left;
    }
    th {
      background-color: #e0e0e0; /* 진한회색으로 */
      font-weight: bold;
      font-size: 16px;
    }
    td {
      background-color: #f0f0f0; /* 밝은 회색 */
      font-weight: 600;
      color: #444;
    }
    tr:nth-child(even) {
      background-color: #fafafa;
     }
    .center {
    text-align: center;
    margin-top: 20px;
    }
  </style>
  	<div class="center">
	<h1>관리자 로그인</h1>
	</div>
	<form action="/homeWork/loginAction.jsp">
	<table>
		<tr>
			<th>관리자 아이디</th>
			<td><input type="text" name="staffId"></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="password"></td>
		</tr>
	</table>
	<div class="center">
	<button style="text-align:center;" type="submit">로그인</button>
	</div>
	</form>
</body>
</html>