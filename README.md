# Seoul-Wifi-Project
서울시 Open API를 활용한 사용자 주변 와이파이 설치 장소 조회 서비스

# 프로젝트 목적
Open Api의 데이터를 추출/가공 하여 사용자에게 제공 ,
웹 구동방식의 이해

# 프로젝트 기능
- Home <SeoulWifi_Home.jsp>
  - 기본화면내용 출력 (홈/위치 히스토리 목록/OpenAPI 와이파이 정보가져오기)
  - 내 위치 가져오기 button click 시 geolocation API 를 통해 사용자의 위치를 불러온다.
  - 근처 Wifi 정보보기 buttion click 시 내 위치 가져오기 Input Tag value 파라미터 SeoulWifi_Insert.jsp 로 전달하여, READ page로 이동한다.
  - 위치 히스토리 목록 click 시 SeoulWifi_History.jsp 로 이동한다.
  - OpenAPI 와이파이 정보가져오기 click 시 SeoulWifi_Insert.jsp 로 이동한다.

- Insert <SeoulWifi_Insert.jsp>
  - JSON 파일을 통해 받은 서울시 공공 와이파이 위치정보 API 데이터를 DB serch 테이블에 저장한다.

- READ <SeoulWifi_Read.jsp>
  - 입력된 내 위치 LAT/LNT 기준 소수점 2자리까지 일치하는 20개의 결과를 최대 20개까지 조회한다.
  - 근처 Wifi 정보보기 button을 통한 접근 시 DB history 테이블에 내 위치,ID,접근시간을 DB에 저장한다.

- History <SeoulWifi_History.jsp>
  - DB history 테이블에 저장된 기록을 조회한다.
  - 삭제 buttion click 시 SeoulWifi_Delete.jsp 로 이동하며, 선택된 히스토리 ID를 전달한다.   

- Delete <SeoulWifi_Delete.jsp>
  - 삭제 button click을 통해 SeoulWifi_History.jsp 에서 전달받은 ID와 일치하는 데이터를 삭제한다.
  - 삭제 후 SeoulWifi_History.jsp 로 reload 된다.
