<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서울시 공공데이터 WIFI 구하기_HOME</title>
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

<body>

	<h1>와이파이 정보 구하기</h1>
	<div>

		<a href="SeoulWifi_Home.jsp">홈 | </a> <a href="SeoulWifi_History.jsp">위치
			히스토리 목록 | </a> <a href="SeoulWifi_Insert.jsp">OpenAPI 와이파이 정보 가져오기</a>

	</div>

	<span class="my_lat"></span>
	<span class="my_lnt"></span>

	<script>
   var lat = "";
   var lon = "";
   
   const posOptions = {
     enableHighAccuracy: false, 
     timeout: 10000,
     maximumAge: 60000
   };
 
   function success(pos) {
     const crd = pos.coords;
   
     console.log('Your current position is:');
     console.log('Latitude : ' + crd.latitude);
     console.log('Longitude: ' + crd.longitude);
     console.log('More or less ' + crd.accuracy + ' meters.');
   
     this.lat = crd.latitude;
     this.lon = crd.longitude;
   
     document.querySelector(".my_lat").innerHTML = lat;
     document.querySelector(".my_lnt").innerHTML = lon;
   };
   
   function error(err) {
     console.warn('ERROR(' + err.code + '): ' + err.message);
     alert('ERROR(' + err.code + '): ' + err.message);
   };
   
   if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(success, error, posOptions);
   }

</script>

	<button class="w-btn w-btn-green" type="submit" id="get_mylatlnt">
		내 위치 가져오기</button>



	<form method="get" action="SeoulWifi_Read.jsp">
		<div class="wrap_navi">
			<div class="wrap_latlnt">
				LAT : <input type="text" name="lat" id="ip_lat" value="">
				LNT : <input type="text" name="lnt" id="ip_lnt">
			</div>
			<button class="w-btn w-btn-green " type=submit>근처 Wifi 정보보기</button>
		</div>
	</form>
	<script>
   const m_lat = document.querySelector(".my_lat").innerHTML;
   const m_lnt = document.querySelector(".my_lnt").innerHTML;
   let get_my = document.getElementById("get_mylatlnt");
   get_my.addEventListener("click", function(){
      document.getElementById("ip_lat").value = lat;
      document.getElementById("ip_lnt").value = lon;
   });
</script>





	<div></div>

	<table id="customers">
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
			<th>x좌표</th>
			<th>Y좌표</th>
			<th>작업일자</th>
		</tr>
		<tr>
			<td rowspan="15" colspan="17" align="center">위치 정보를 입력한 후에
				조회해주세요.</td>
		</tr>

	</table>

</body>
</html>