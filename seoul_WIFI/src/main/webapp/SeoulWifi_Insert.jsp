<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="seoul_WIFI.DBCon"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html ; charset="UTF-8">
<title>서울시 공공데이터 WIFI 구하기_GET</title>
</head>
<body>
<%
DBCon conn = new DBCon();
conn.DBSearchInsert();
%>

<h1> 17795건의 데이터를 성공적으로 저장했습니다.</h1>
<div>
		<a href="SeoulWifi_Home.jsp">메인 화면으로 돌아가기</a>	
</div>


</body>
</html>