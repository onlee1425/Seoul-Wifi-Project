<%@page import="java.text.DecimalFormat"%>
<%@page import="seoul_WIFI.DistanceLogic"%>
<%@page import="seoul_WIFI.DBCon"%>
<%@page import="seoul_WIFI.Api_DTO"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울시 공공데이터 WIFI 구하기_READ</title>
<style>
#customers {
	font-family: Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

#get_mylatlnt {
	position: absolute;
	top: 135px;
	left: 50%;
}

#ip_lat, #ip_lnt {
	padding: 4px;
}

#customers td, #customers th {
	border: 1px solid #ddd;
	padding: 18px;
}

#customers tr:nth-child(even) {
	background-color: #f2f2f2;
}

#customers tr:hover {
	background-color: #ddd;
}

#customers th {
	padding-top: 10px;
	padding-bottom: 10px;
	text-align: left;
	background-color: #23376a;
	color: white;
}

.wrap_navi {
	overflow: hidden;
	width: 68%;
	margin: 0 auto;
}

.wrap_latlnt {
	float: left;
	width: 50%;
	padding-top: 30px;
}

.near_wifi {
	float: right;
	width: 20%;
	margin-right: 32px;
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

button {
	margin: 20px;
}

.w-btn {
	position: relative;
	border: none;
	display: inline-block;
	padding: 15px 30px;
	border-radius: 15px;
	font-family: "paybooc-Light", sans-serif;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
	text-decoration: none;
	font-weight: 600;
	transition: 0.25s;
}

.w-btn-green {
	background-color: #2e3783;
	color: #f7f7f7;
}

.w-btn:hover {
	letter-spacing: 2px;
	transform: scale(1.2);
	cursor: pointer;
}

.w-btn:active {
	transform: scale(1.5);
}

.w-btn-outline:active {
	transform: scale(1.5);
}

.w-btn-gra-anim {
	background-size: 400% 400%;
	animation: gradient1 5s ease infinite;
}

div box {
	padding: 50px;
	border: 1px solid #4CAF50;
}

.my_lat, .my_lnt {
	visibility: hidden;
}
</style>
</head>
<h1>와이파이 정보 구하기</h1>
<body>

	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<%
		String lat = request.getParameter("lat");
		String lnt = request.getParameter("lnt");

		   //근처 wifi 조회시 history저장
		   DBCon Ihs = new DBCon();
		   Ihs.InsertHistory(lat, lnt);
	%>

	<%
	//근처 WIFI 조회 
	   List<Api_DTO> list = Ihs.nearList();
	   DistanceLogic dl = new DistanceLogic();
	%>

	<i class="fa-solid fa-wifi"></i>
	<div>

		<a href="SeoulWifi_Home.jsp">홈 | </a> <a href="SeoulWifi_History.jsp">위치
			히스토리 목록 | </a> <a href="SeoulWifi_Insert.jsp">OpenAPI 와이파이 정보 가져오기</a>

	</div>

	<span class="my_lat">37.7433793</span>
	<span class="my_lnt">127.0633932</span>

	<button class="w-btn w-btn-green" type="submit" id="get_mylatlnt">
		내 위치 가져오기</button>



	<form method="get" action="SeoulWifi_Read.jsp">
		<div class="wrap_navi">
			<div class="wrap_latlnt">
				LAT : <input type="text" name="lat" id="ip_lat" value=<%=lat%>>
				LNT : <input type="text" name="lnt" id="ip_lnt"value=<%=lnt%>>
			</div>
			<button class="w-btn w-btn-green " type=submit>근처
				Wifi 정보보기</button>
		</div>
	</form>

	<table id="customers">
		<thead>
			<tr>

				<th>거리(Km)</th>
				<th>관리번호</th>
				<th>자치구</th>
				<th>와이파이명</th>
				<th>도로명주소</th>
				<th>상세주소</th>
				<th>설치위치(층)</th>
				<th>설치유형</th>
				<th>설치기관</th>
				<th>서비스구분</th>
				<th>망종류</th>
				<th>설치년도</th>
				<th>실내외구분</th>
				<th>WIFI접속환경</th>
				<th>X좌표</th>
				<th>Y좌표</th>
				<th>작업일자</th>
			</tr>
		</thead>

		<tbody>
			<tr>
				<%
				for(Api_DTO api : list){
				%>
			
			<tr>
				<td>
					<%
				
					double lat1 = Double.parseDouble(request.getParameter("lat"));
					double lnt1 = Double.parseDouble(request.getParameter("lnt"));
					double lat2 = Double.parseDouble(api.getLat());
					double lnt2 = Double.parseDouble(api.getLnt());
					String unit = "kilometer";
					
					double distanceKiloMeter = dl.distance(lat1,lnt1,lat2,lnt2,unit);
					DecimalFormat df = new DecimalFormat("0.0000"); //소수점 4자리수까지 반환
					String result = df.format(distanceKiloMeter);
					
					
					out.println(result); //웹에서 출력
					%>


				</td>
				<td><%=api.getX_swifi_mgr_no()%></td>
				<td><%=api.getX_swifi_wrdofc() %></td>
				<td><%=api.getX_swifi_main_nm()%></td>
				<td><%=api.getX_swifi_adres1()  %></td>
				<td><%=api.getX_swifi_adres2()  %></td>
				<td><%=api.getX_swifi_instl_floor()  %></td>
				<td><%=api.getX_swifi_instl_ty()  %></td>
				<td><%=api.getX_swifi_instl_mby()  %></td>
				<td><%=api.getX_swifi_svc_se()  %></td>
				<td><%=api.getX_swifi_cmcwr()  %></td>
				<td><%=api.getX_swifi_cnstc_year()  %></td>
				<td><%=api.getX_swifi_inout_door()  %></td>
				<td><%=api.getX_swifi_remars3()  %></td>
				<td><%=api.getLat()  %></td>
				<td><%=api.getLnt()  %></td>
				<td><%=api.getWork_dttm()  %></td>

			</tr>

			<%
		     		 }
				
				%>

		</tbody>
	</table>
	<script>const $table = document.getElementById('customers');
			if($table.rows.length<3){
				alert('주변에 조회 가능한 Wi-fi가 없습니다. 서울 내의 좌표로 조회해주세요.');
			}
	</script>
</body>
</html>