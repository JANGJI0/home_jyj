<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql. *" %>
<%@ page import="dto.Film" %>
<!-- controller 단 -->
<%
	// 페이징 변수
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * rowPerPage;
%>
<!-- model 단 -->
<%
	// 1) mysql 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
		// 디버깅
		System.out.println("드라이버 로딩 성공");
	// 변수 받기
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	// 페이징 변수 받기
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	
	// 2) sql 준비(문자열 변수 선언)
	String sql = "select f.film_id filmId, f.title title, f.description fdc, c.name cn FROM film f JOIN film_category fc ON f.film_id = fc.film_id JOIN category c ON fc.category_id = c.category_id ORDER BY f.film_id ASC";
	String sql2 = "select count(*) cnt from film";
		// 디버깅
		System.out.println("sql: " + sql);
		System.out.println("sql2: " + sql2);
	
	// 3) connection(접속)하기
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
		//디버깅
		System.out.println("DB 연결성공: " + conn);
	// 4) 쿼리 생성
	stmt = conn.prepareStatement(sql);
	stmt2 = conn.prepareStatement(sql2);
	// 5) 쿼리 실행
	
	rs = stmt.executeQuery();
	rs2 = stmt2.executeQuery();
		// 디버깅
		System.out.println("PreparedStatement 생성 완료");
		System.out.println("쿼리 실행 완료: " + rs);
	rs2.next();
		
	// 배열리스트 작성
	ArrayList<Film> list = new ArrayList<>();
	while(rs.next()) { // db의 결과를 java 컬렉션으로 변환
		Film f = new Film();
		f.film_id = rs.getInt("filmId");
		f.title = rs.getString("title");
		f.description = rs.getString("fdc");
		f.name = rs.getString("cn");
		
		list.add(f); // 리스트에 하나씩 담는다
	}
%>

<!-- view 단 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>영화 목록</h1>
	<style>
		table {
			border-collapse: collapse;
			width: 100%
		}
		th, td {
			border: 1px solid black;
			padding: 8px;
		}
	</style>
	
	<table>
		<tr>
			<th>NO</th>
			<th>영화제목</th>
			<th>줄거리</th>
			<th>카테고리</th>
		</tr>
		<%
			for(Film f : list) {
		%>
			<tr>
				<td><%=f.film_id %></td>
				<td>
					<a href="/web0324/filmDetail.jsp?filmId=<%=f.film_id%>"><%=f.title %></a>
				</td>
				<td><%=f.description%></td>
				<td><%=f.name%></td>
			</tr>
		<%
		
			}
		%>
	</table>
</body>
</html>