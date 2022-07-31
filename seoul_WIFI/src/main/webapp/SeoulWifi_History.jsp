<%@page import="seoul_WIFI.DBCon"%>
<%@page import="seoul_WIFI.History_DTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울시 공공데이터 WIFI 구하기_HISTORY</title>
<style>
#customers {
	font-family: Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
	margin-top: 20px;
}

#customers td, #customers th {
	border: 1px solid #ddd;
	padding: 6px;
}

#customers tr:nth-child(even) {
	background-color: #f1ede8;
}

#customers tr:hover {
	background-color: #ddd;
}

#customers th {
	padding-top: 10px;
	padding-bottom: 10px;
	text-align: center;
	background-color: #fd9d30;
	color: white;
}

@import
	url("https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800,900&display=swap")
	;

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	text-align: center;
	padding: 50px;
	background: whitesmoke;
	display: block;
}
</style>
</head>
<h1>위치 히스토리 목록</h1>
<body>
	<div>

		<a href="SeoulWifi_Home.jsp">홈 | </a> <a href="SeoulWifi_History.jsp">위치
			히스토리 목록 | </a> <a href="SeoulWifi_Insert.jsp">OpenAPI 와이파이 정보 가져오기</a>

	</div>


	<%
	DBCon sht = new DBCon();
	List<History_DTO> list = sht.list();
	
	%>

	<div></div>

	<table id="customers">
		<thead>
			<tr>

				<th>ID</th>
				<th>X좌표</th>
				<th>Y좌표</th>
				<th>조회일자</th>
				<th>비고</th>

			</tr>
		</thead>
		<tbody>
			<tr>
				<%
				for (History_DTO dto : list) {
				%>
			
			<tr>
				<td><%=dto.getId()%></td>
				<td><%=dto.getLat()%></td>
				<td><%=dto.getLnt()%></td>
				<td><%=dto.getSerch_date()%></td>
				<td>
					<button type=submit onclick="location.href='SeoulWifi_Delete.jsp?id=<%=dto.getId() %>'">
					삭제</button>&nbsp;&nbsp; 
				
				</td>
					
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

</body>
</html>