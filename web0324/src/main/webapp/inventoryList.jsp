<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("currentPage :" + currentPage);
	
	int rowPerPage = 10;
	int startRow = (currentPage -1 ) * rowPerPage;
	System.out.println("rowPerPage :" + rowPerPage);
	System.out.println("startRow :" + startRow);
	
	Connection conn = null;
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	// 데이터 전체 개수 
	String sql = "SELECT COUNT(*) "
				+ "FROM (SELECT i.inventory_id, f.title FROM inventory i "
			    + "INNER JOIN film f ON i.film_id = f.film_id) t1 LEFT "
				+ "OUTER JOIN (SELECT inventory_id, rental_date, CASE WHEN return_date IS NULL THEN '대여불가' ELSE '대여가능' END isRental "
			    + "FROM rental WHERE (inventory_id, rental_date) "
			    + "IN (SELECT inventory_id, MAX(rental_date) FROM rental "
			    + "GROUP BY inventory_id)) t2 ON t1.inventory_id = t2.inventory_id";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	rs.next();
	
	int totalCnt = rs.getInt("count(*)");
	int lastPage = totalCnt / rowPerPage;
		if(totalCnt % rowPerPage != 0) {
			lastPage ++; 
		}
	System.out.println("lastPage :" + lastPage);

		//데이터 정보 
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "select t1.inventory_id, t1.title, t2.isRental "
			+ "FROM (SELECT i.inventory_id, f.title FROM inventory i "
		    + "INNER JOIN film f ON i.film_id = f.film_id) t1 LEFT "
			+ "OUTER JOIN (SELECT inventory_id, rental_date, CASE WHEN return_date IS NULL THEN '대여불가' ELSE '대여가능' END isRental "
		    + "FROM rental WHERE (inventory_id, rental_date) "
		    + "IN (SELECT inventory_id, MAX(rental_date) FROM rental "
		    + "GROUP BY inventory_id)) t2 ON t1.inventory_id = t2.inventory_id order by inventory_id limit ?, ?";
	
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, startRow);
	stmt2.setInt(2, rowPerPage);
	rs2 = stmt2.executeQuery();
	
	System.out.println("lastPage :" + lastPage);	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs2.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("inventoryId", rs2.getInt("inventory_id"));
		map.put("title", rs2.getString("title"));
		map.put("isRental", rs2.getString("isRental"));
		list.add(map);
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>Inventory List</h1>
	
	<table border="1">
		<tr>
			<th>일련번호</th>
			<th>제목</th>
			<th>반납일자</th>
			<th>대여</th>
		<tr>
		<%
		for (HashMap<String, Object> map : list) {
		%>
		<tr>
			<td><%=map.get("inventoryId")%></td>
			<td><%=map.get("title")%></td>
			<td><%=map.get("isRental")%></td>
			<td>
             	<%
 				    String isRental = (String) map.get("isRental");
 				
 				    // returnDate가 null인 경우를 체크
 				    if (isRental != null && !isRental.equals("대여불가")) { 
 				%>
 				        <a href="/sakila/d0327/inventoryList.jsp">[대여하기]</a>
 				<%
 				    }
 				%>
             </td>
		</tr>
		<%
		}
		%>
	</table>
	
	<!-- 페이징 --> 
	<a href="/web0324/inventoryList.jsp?currentPage=1">[처음으로]</a>
	<%
		if(currentPage > 1) {
	%>
	<a href="/web0324/inventoryList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
	<%
		}
	%>
	
	<%=currentPage%> / <%=lastPage%> 페이지
	
	<%
		if(currentPage < lastPage) {
	%>
	<a href="/web0324/inventoryList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
	<%
		}
	%>
	<a href="/web0324/inventoryList.jsp?currentPage=<%=lastPage%>">[마지막으로]</a>
	
</body>
</html>