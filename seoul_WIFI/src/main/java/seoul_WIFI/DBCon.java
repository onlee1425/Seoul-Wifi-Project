package seoul_WIFI;

import java.io.FileReader;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class DBCon {//DB insert,serch
	public void DBSearchInsert() {// [api데이터 serch테이블에 저장] - SeoulWifi_Insert.jsp

		String url = "jdbc:mariadb://3.39.65.10:3306/seoulWIFI";
		String dbUserId = "root";
		String dbPassword = "zerobase";

		// db드라이버로드
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		// finally close를 위한 객체생성
		Connection connection = null;
		// 스테이트먼트 객체 생성
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Reader reader;
		try {
			// 커넥션 객체 생성
			connection = DriverManager.getConnection(url, dbUserId, dbPassword);
			reader = new FileReader(
					"C:\\Users\\enfle\\OneDrive\\바탕 화면\\코딩\\DB프로그램\\eclipsse-workspace\\seoul_WIFI\\src\\main\\java\\seoul_WIFI\\SeoulWifiAPI.json");
			// json file path

			// reader를 Object로 parse
			JSONParser parser = new JSONParser();
			JSONObject obj = (JSONObject) parser.parse(reader);
			JSONArray jsonArr = (JSONArray) obj.get("DATA");

			// JSON파일데이터 JSONObject로 객체 받기
			if (jsonArr.size() > 0) {
				for (int i = 0; i < jsonArr.size(); i++) {
					JSONObject data = (JSONObject) jsonArr.get(i);

					// 쿼리실행 : jdbc 쿼리문
					String sql = " insert into serch (x_swifi_mgr_no, X_SWIFI_WRDOFC, X_SWIFI_MAIN_NM, X_SWIFI_ADRES1,"
							+ "x_swifi_adres2,x_swifi_instl_floor,x_swifi_instl_ty,x_swifi_instl_mby,x_swifi_svc_se,x_swifi_cmcwr,"
							+ "x_swifi_cnstc_year,x_swifi_inout_door,x_swifi_remars3,lat,lnt,work_dttm) "
							+ " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?); ";

					// preraedStatement로 쿼리문 전달

					preparedStatement = connection.prepareStatement(sql);

					preparedStatement.setString(1, (String) data.get("x_swifi_mgr_no")); // setString(parameterIndex,String)
					preparedStatement.setString(2, (String) data.get("x_swifi_wrdofc"));
					preparedStatement.setString(3, (String) data.get("x_swifi_main_nm"));
					preparedStatement.setString(4, (String) data.get("x_swifi_adres1"));
					preparedStatement.setString(5, (String) data.get("x_swifi_adres2"));
					preparedStatement.setString(6, (String) data.get("x_swifi_instl_floor"));
					preparedStatement.setString(7, (String) data.get("x_swifi_instl_ty"));
					preparedStatement.setString(8, (String) data.get("x_swifi_instl_mby"));
					preparedStatement.setString(9, (String) data.get("x_swifi_svc_se"));
					preparedStatement.setString(10, (String) data.get("x_swifi_cmcwr"));
					preparedStatement.setString(11, (String) data.get("x_swifi_cnstc_year"));
					preparedStatement.setString(12, (String) data.get("x_swifi_inout_door"));
					preparedStatement.setString(13, (String) data.get("x_swifi_remars3"));
					preparedStatement.setString(14, (String) data.get("lat"));
					preparedStatement.setString(15, (String) data.get("lnt"));
					preparedStatement.setString(16, (String) data.get("work_dttm"));
					int affected = preparedStatement.executeUpdate();

					// 결과수행 : affected 행이 잘 insert되었는지 확인
					if (affected > 0) {
						System.out.println("저장 성공");
					} else {
						System.out.println("저장 실패");
					}
				}
			}
			System.out.println(jsonArr.size() + "건의 데이터를 성공적으로 저장했습니다.");
		} catch (SQLException e) {
			e.printStackTrace();

		} catch (Exception e) { // null value에 대한 예외처리
			e.printStackTrace();

			// 객체 연결 해제
		} finally {

			try {
				if (rs != null && !rs.isClosed()) {
					rs.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
			try {
				if (preparedStatement != null && preparedStatement.isClosed()) {
					preparedStatement.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
			try {
				if (connection != null && connection.isClosed()) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}

		}
	}

	public void InsertHistory(String lat, String lnt) {// [검색 좌표,lat,lnt,검색시간 history테이블에 저장] - SeoulWifi_Read.jsp

		String url = "jdbc:mariadb://3.39.65.10:3306/seoulWIFI";
		String dbUserId = "root"; // db유저 id 존재필요
		String dbPassword = "zerobase"; // password 필요

		// db드라이버로드
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		// finally close를 위한 객체생성
		Connection connection = null;
		// 스테이트먼트 객체 생성
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		try {
			// 커넥션 객체 생성
			connection = DriverManager.getConnection(url, dbUserId, dbPassword);

			// 쿼리실행 : jdbc 쿼리문
			String sql = " insert into history (LAT,LNT,SERCH_TIME) " + " VALUES (? , ? ,NOW() ) ; ";

			// preraedStatement로 쿼리문 전달

			preparedStatement = connection.prepareStatement(sql);

			preparedStatement.setString(1, lat);
			preparedStatement.setString(2, lnt);

			int affected = preparedStatement.executeUpdate();

			// 결과수행 : affected 행이 잘 insert되었는지 확인
			if (affected > 0) {
				System.out.println("저장 성공");
			} else {
				System.out.println("저장 실패");
			}

			System.out.println("검색결과를 성공적으로 저장했습니다.");
		} catch (SQLException e) {
			e.printStackTrace();

		} catch (Exception e) { // null value에 대한 예외처리
			e.printStackTrace();

			// 객체 연결 해제
		} finally {

			try {
				if (rs != null && !rs.isClosed()) {
					rs.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
			try {
				if (preparedStatement != null && preparedStatement.isClosed()) {
					preparedStatement.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
			try {
				if (connection != null && connection.isClosed()) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}

		}

	}

	public List<History_DTO> list() { // [history테이블 조회용] - SeoulWifi_Histort.jsp

		List<History_DTO> historyList = new ArrayList<>();

		String url = "jdbc:mariadb://3.39.65.10:3306/seoulWIFI";
		String dbUserId = "root";
		String dbPassword = "zerobase";

		// db드라이버로드
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		// finally close를 위한 객체생성
		Connection connection = null;
		// 스테이트먼트 객체 생성
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		try {
			// 커넥션 객체 생성
			connection = DriverManager.getConnection(url, dbUserId, dbPassword);

			// 쿼리실행 : jdbc 쿼리문
			String sql = " SELECT * " + " FROM history ;";

			// preraedStatement로 쿼리문 전달
			preparedStatement = connection.prepareStatement(sql);
			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				int id = rs.getInt("ID");
				String lat = rs.getString("LAT");
				String lnt = rs.getString("LNT");
				String serchtime = rs.getString("SERCH_TIME");

				History_DTO history = new History_DTO();

				history.setId(id);
				history.setLat(lat);
				history.setLnt(lnt);
				history.setSerch_date(serchtime);

				historyList.add(history);

				System.out.println("조회완료");

			}

		} catch (SQLException e) {
			e.printStackTrace();

		}

		// 객체 연결 해제
		finally {

			try {
				if (rs != null && !rs.isClosed()) {
					rs.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
			try {
				if (preparedStatement != null && preparedStatement.isClosed()) {
					preparedStatement.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
			try {
				if (connection != null && connection.isClosed()) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}

		}
		return historyList;
	}

	public List<Api_DTO> nearList() { // [serch테이블 조회용_근처wifi조회] - SeoulWifi_Read.jsp

		List<Api_DTO> apiList = new ArrayList<>();
		String url = "jdbc:mariadb://3.39.65.10:3306/seoulWIFI";
		String dbUserId = "root";
		String dbPassword = "zerobase";

		// db드라이버로드
		try {
			Class.forName("org.mariadb.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		// finally close를 위한 객체생성
		Connection connection = null;
		// 스테이트먼트 객체 생성
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		try {
			// 커넥션 객체 생성
			connection = DriverManager.getConnection(url, dbUserId, dbPassword);

			// 가장 최근 history테이블에 저장된 좌표의 소수점 두자리까지 잘라 인근 WIFI 조회
			String sql = "SELECT * " + "FROM serch " + "WHERE LAT REGEXP (SELECT FORMAT(LAT,2) " + "FROM history "
					+ "ORDER BY id DESC LIMIT 1) " + "AND  LNT REGEXP (SELECT FORMAT (LNT,2) " + "FROM history "
					+ "ORDER BY id DESC LIMIT 1) " + "LIMIT 20;";

			// preraedStatement로 쿼리문 전달

			preparedStatement = connection.prepareStatement(sql);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				String x_swifi_mgr_no = rs.getString("x_swifi_mgr_no");
				String X_SWIFI_WRDOFC = rs.getString("X_SWIFI_WRDOFC");
				String X_SWIFI_MAIN_NM = rs.getString("X_SWIFI_MAIN_NM");
				String X_SWIFI_ADRES1 = rs.getString("X_SWIFI_ADRES1");
				String x_swifi_adres2 = rs.getString("x_swifi_adres2");
				String x_swifi_instl_floor = rs.getString("x_swifi_instl_floor");
				String x_swifi_instl_ty = rs.getString("x_swifi_instl_ty");
				String x_swifi_instl_mby = rs.getString("x_swifi_instl_mby");
				String x_swifi_svc_se = rs.getString("x_swifi_svc_se");
				String x_swifi_cmcwr = rs.getString("x_swifi_cmcwr");
				String x_swifi_cnstc_year = rs.getString("x_swifi_cnstc_year");
				String x_swifi_inout_door = rs.getString("x_swifi_inout_door");
				String x_swifi_remars3 = rs.getString("x_swifi_remars3");
				String lat = rs.getString("lat");
				String lnt = rs.getString("lnt");
				String work_dttm = rs.getString("work_dttm");

				Api_DTO api = new Api_DTO();

				api.setX_swifi_mgr_no(x_swifi_mgr_no);
				api.setX_swifi_wrdofc(X_SWIFI_WRDOFC);
				api.setX_swifi_main_nm(X_SWIFI_MAIN_NM);
				api.setX_swifi_adres1(X_SWIFI_ADRES1);
				api.setX_swifi_adres2(x_swifi_adres2);
				api.setX_swifi_instl_floor(x_swifi_instl_floor);
				api.setX_swifi_instl_ty(x_swifi_instl_ty);
				api.setX_swifi_instl_mby(x_swifi_instl_mby);
				api.setX_swifi_svc_se(x_swifi_svc_se);
				api.setX_swifi_cmcwr(x_swifi_cmcwr);
				api.setX_swifi_cnstc_year(x_swifi_cnstc_year);
				api.setX_swifi_inout_door(x_swifi_inout_door);
				api.setX_swifi_remars3(x_swifi_remars3);
				api.setLat(lat);
				api.setLnt(lnt);
				api.setWork_dttm(work_dttm);

				apiList.add(api);

				System.out.println(x_swifi_mgr_no + ", " + work_dttm);

			}

		} catch (SQLException e) {
			e.printStackTrace();

		}

		// 객체 연결 해제
		finally {

			try {
				if (rs != null && !rs.isClosed()) {
					rs.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
			try {
				if (preparedStatement != null && preparedStatement.isClosed()) {
					preparedStatement.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}
			try {
				if (connection != null && connection.isClosed()) {
					connection.close();
				}
			} catch (SQLException e) {
				throw new RuntimeException(e);
			}

		}
		return apiList;
	}


}
