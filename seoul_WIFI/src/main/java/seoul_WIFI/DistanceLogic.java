package seoul_WIFI;

import java.text.DecimalFormat;

public class DistanceLogic {

		public static void main(String[] args) { //거리계산확인용
			
			// 킬로미터(Kilo Meter) 단위
			double distanceKiloMeter = 
				distance(37.504198, 127.047967, 37.501025, 127.037701, "kilometer");
		
			DecimalFormat df = new DecimalFormat("0.0000"); 
			String result = df.format(distanceKiloMeter);
			
			System.out.println(result) ;
			
			
		}
		
		/**
		 * 두 지점간의 거리 계산
		 * 
		 * @param lat1 지점 1 위도
		 * @param lon1 지점 1 경도 
		 * @param lat2 지점 2 위도
		 * @param lon2 지점 2 경도
		 * @param unit 거리 표출단위 
		 * @return
		 */
		public static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
			
			double theta = lon1 - lon2;
			double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
			
			dist = Math.acos(dist);
			dist = rad2deg(dist);
			dist = dist * 60 * 1.1515;
			
			if (unit == "kilometer") {
				dist = dist * 1.609344;
			}

			return (dist);
		}
		

		// This function converts decimal degrees to radians
		public static double deg2rad(double deg) {
			return (deg * Math.PI / 180.0);
		}
		
		// This function converts radians to decimal degrees
		public static double rad2deg(double rad) {
			return (rad * 180 / Math.PI);
		}

	
}
