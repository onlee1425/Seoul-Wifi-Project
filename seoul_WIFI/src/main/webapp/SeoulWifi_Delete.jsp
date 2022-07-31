<%@page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>서울시 공공데이터 WIFI 구하기_Delete</title>
</head>
<body>
<%

String id = request.getParameter("id");
int ID = Integer.parseInt(id);
System.out.println(id + "번 삭제완료"); //콘솔확인용


String url = "jdbc:mariadb://3.39.65.10:3306/seoulWIFI";
String dbUserId = "root";
String dbPassword = "zerobase"; 

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	Class.forName("org.mariadb.jdbc.Driver");
    
    conn = DriverManager.getConnection(url, dbUserId, dbPassword);
    
    String sql = "DELETE from history " +
			"where id = ? ;";
			pstmt = conn.prepareStatement(sql);
    		pstmt.setInt(1, ID);
    		rs = pstmt.executeQuery();

            
} catch (SQLException e) {
	e.printStackTrace();
	
}

finally {

	try {
		if (rs != null && !rs.isClosed()) {
			rs.close();
		}
	} catch (SQLException e) {
		throw new RuntimeException(e);
	}
	try {
		if (pstmt != null && pstmt.isClosed()) {
			pstmt.close();
		}
	} catch (SQLException e) {
		throw new RuntimeException(e);
	}
	try {
		if (conn != null && conn.isClosed()) {
			conn.close();
		}
	} catch (SQLException e) {
		throw new RuntimeException(e);
	} }


%>
	<script>
		alert("삭제가 완료되었습니다.");
		location.href='SeoulWifi_History.jsp';
		location.reroad();
	</script>
</body>
</html>
