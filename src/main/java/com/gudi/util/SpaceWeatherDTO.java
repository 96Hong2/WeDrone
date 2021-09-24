package com.gudi.util;

import java.util.ArrayList;
import java.util.List;

public class SpaceWeatherDTO {

	private String error;
	private String lastUpdate;
	private String formatLastUpdate;
	private String errorCode;
	private List<Recent> recent;
	private String time;
	private String currentP;
	private String currentK;
	private String max24P;
	private String max24K;

	private static final SpaceWeatherDTO instance = new SpaceWeatherDTO();

	private SpaceWeatherDTO() { 
		if(recent==null) {
			this.recent=new ArrayList<SpaceWeatherDTO.Recent>();
		}
	}

	public static SpaceWeatherDTO getInstance() {
	            return instance;
	}
	
	    

	
	public class Recent {
		private String subTime;
		private String kp;
		private String kk;

		public String getSubTime() {
			return subTime;
		}

		public void setSubTime(String subTime) {
			this.subTime = subTime;
		}

		public String getKp() {
			return kp;
		}

		public void setKp(String kp) {
			this.kp = kp;
		}

		public String getKk() {
			return kk;
		}

		public void setKk(String kk) {
			this.kk = kk;
		}

		@Override
		public String toString() {
			return "Recent [subTime=" + subTime + ", kp=" + kp + ", kk=" + kk + "]";
		}
		

	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getLastUpdate() {
		return lastUpdate;
	}

	public void setLastUpdate(String lastUpdate) {
		this.lastUpdate = lastUpdate;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public List<Recent> getRecent() {
		return recent;
	}

	public void setRecent(List<Recent> recent) {
		this.recent = recent;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getCurrentP() {
		return currentP;
	}

	public void setCurrentP(String currentP) {
		this.currentP = currentP;
	}

	public String getCurrentK() {
		return currentK;
	}

	public void setCurrentK(String currentK) {
		this.currentK = currentK;
	}

	public String getMax24P() {
		return max24P;
	}

	public void setMax24P(String max24p) {
		max24P = max24p;
	}

	public String getMax24K() {
		return max24K;
	}

	public void setMax24K(String max24k) {
		max24K = max24k;
	}

	public String getFormatLastUpdate() {
		return formatLastUpdate;
	}

	public void setFormatLastUpdate(String formatLastUpdate) {
		this.formatLastUpdate = formatLastUpdate;
	}

	@Override
	public String toString() {
		return "SpaceWeatherDTO [error=" + error + ", lastUpdate=" + lastUpdate + ", formatLastUpdate="
				+ formatLastUpdate + ", errorCode=" + errorCode + ", recent=" + recent + ", time=" + time
				+ ", currentP=" + currentP + ", currentK=" + currentK + ", max24P=" + max24P + ", max24K=" + max24K
				+ "]";
	}


	

}
