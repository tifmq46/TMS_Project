package egovframework.com.cmm;

import java.io.Serializable;

/**
 * @Class Name : LoginVO.java
 * @Description : Login VO class
 * @Modification Information
 * @
 * @  수정일         수정자                   수정내용
 * @ -------    --------    ---------------------------
 * @ 2009.03.03    박지욱          최초 생성
 *
 *  @author 공통서비스 개발팀 박지욱
 *  @since 2009.03.03
 *  @version 1.0
 *  @see
 *  
 */
public class TmsLoginVO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8274004534207618049L;
	/** 아이디 */
	private String EMPLYR_ID;
	/** 기관 */
	private String ORGNZT_ID;
	/** 역할 */
	private String ROLE;
	/** 이름 */
	private String USER_NM;
	/** 비밀번호 */
	private String PASSWORD;
	/** 역할코드 */
	private String ESNTL_ID;
	public String getEMPLYR_ID() {
		return EMPLYR_ID;
	}
	public void setEMPLYR_ID(String eMPLYR_ID) {
		EMPLYR_ID = eMPLYR_ID;
	}
	public String getORGNZT_ID() {
		return ORGNZT_ID;
	}
	public void setORGNZT_ID(String oRGNZT_ID) {
		ORGNZT_ID = oRGNZT_ID;
	}
	public String getROLE() {
		return ROLE;
	}
	public void setROLE(String rOLE) {
		ROLE = rOLE;
	}
	public String getUSER_NM() {
		return USER_NM;
	}
	public void setUSER_NM(String uSER_NM) {
		USER_NM = uSER_NM;
	}
	public String getPASSWORD() {
		return PASSWORD;
	}
	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}
	public String getESNTL_ID() {
		return ESNTL_ID;
	}
	public void setESNTL_ID(String eSNTL_ID) {
		ESNTL_ID = eSNTL_ID;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "TmsLoginVO [EMPLYR_ID=" + EMPLYR_ID + ", ORGNZT_ID=" + ORGNZT_ID + ", ROLE=" + ROLE + ", USER_NM="
				+ USER_NM + ", PASSWORD=" + PASSWORD + ", ESNTL_ID=" + ESNTL_ID + "]";
	}

	
	
}
