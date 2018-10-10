package egovframework.let.tms.dev.service;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

@SuppressWarnings("serial")
public class TempVO implements Serializable{
	
	/** 프로그램 아이디 */
	private String pgId;
	
	/** 프로그램 아이디 */
	private String userDevId;
	
	/** 프로그램 아이디 */
	private String userDevNm;
	
	/**  계획완료일자 */
	private String planEndDt;

	public String getPgId() {
		return pgId;
	}

	public void setPgId(String pgId) {
		this.pgId = pgId;
	}

	public String getUserDevId() {
		return userDevId;
	}

	public void setUserDevId(String userDevId) {
		this.userDevId = userDevId;
	}

	public String getUserDevNm() {
		return userDevNm;
	}

	public void setUserDevNm(String userDevNm) {
		this.userDevNm = userDevNm;
	}

	public String getPlanEndDt() {
		return planEndDt;
	}

	public void setPlanEndDt(String planEndDt) {
		this.planEndDt = planEndDt;
	}

	
}
