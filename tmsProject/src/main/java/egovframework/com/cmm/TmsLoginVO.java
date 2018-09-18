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
	private String EMPLYR_ID = null;
	/** 기관 */
	private String ORGNZT_ID;
	/** 이름 */
	private String USER_NM;
	/** 비밀번호 */
	private String PASSWORD;
	
	private String CONFIRM_PASSWORD;
	/** 역할코드 */
	private String ESNTL_ID;
	
	private String EMAIL_ADRES;
	
	private String EMPLYR_STTUS_CODE;
	
	
	
	public String getCONFIRM_PASSWORD() {
		return CONFIRM_PASSWORD;
	}
	public void setCONFIRM_PASSWORD(String cONFIRM_PASSWORD) {
		CONFIRM_PASSWORD = cONFIRM_PASSWORD;
	}
	public String getEMAIL_ADRES() {
		return EMAIL_ADRES;
	}
	public void setEMAIL_ADRES(String eMAIL_ADRES) {
		EMAIL_ADRES = eMAIL_ADRES;
	}
	public String getEMPLYR_STTUS_CODE() {
		return EMPLYR_STTUS_CODE;
	}
	public void setEMPLYR_STTUS_CODE(String eMPLYR_STTUS_CODE) {
		EMPLYR_STTUS_CODE = eMPLYR_STTUS_CODE;
	}
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
		return "TmsLoginVO [EMPLYR_ID=" + EMPLYR_ID + ", ORGNZT_ID=" + ORGNZT_ID + ", USER_NM=" + USER_NM
				+ ", PASSWORD=" + PASSWORD + ", ESNTL_ID=" + ESNTL_ID + ", EMAIL_ADRES=" + EMAIL_ADRES
				+ ", EMPLYR_STTUS_CODE=" + EMPLYR_STTUS_CODE + "]";
	}
	
	
}
