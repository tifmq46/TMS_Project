package egovframework.let.sym.prm.service;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

/** 
 * 프로그램목록 처리를 위한 VO 클래스르를 정의한다
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */

public class TmsProjectManageVO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8274004534207618049L;
	/** 아이디 */
	private String PJT_ID;
	/** 기관 */
	private String PJT_NM;
	/** 이름 */
	private String PJT_TYPE;
	/** 비밀번호 */
	private String PJT_ST;
	
	private String PJT_PM;
	/** 역할코드 */
	private int PJT_PRICE = 0;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date DEV_START_DT;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date DEV_END_DT;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")	
	private Date PJT_START_DT;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")	
	private Date PJT_END_DT;
	
	private String PJT_CONTENT;

	public String getPJT_ID() {
		return PJT_ID;
	}

	public void setPJT_ID(String pJT_ID) {
		PJT_ID = pJT_ID;
	}

	public String getPJT_NM() {
		return PJT_NM;
	}

	public void setPJT_NM(String pJT_NM) {
		PJT_NM = pJT_NM;
	}

	public String getPJT_TYPE() {
		return PJT_TYPE;
	}

	public void setPJT_TYPE(String pJT_TYPE) {
		PJT_TYPE = pJT_TYPE;
	}

	public String getPJT_ST() {
		return PJT_ST;
	}

	public void setPJT_ST(String pJT_ST) {
		PJT_ST = pJT_ST;
	}

	public String getPJT_PM() {
		return PJT_PM;
	}

	public void setPJT_PM(String pJT_PM) {
		PJT_PM = pJT_PM;
	}

	public int getPJT_PRICE() {
		return PJT_PRICE;
	}

	public void setPJT_PRICE(int pJT_PRICE) {
		PJT_PRICE = pJT_PRICE;
	}

	public Date getDEV_START_DT() {
		return DEV_START_DT;
	}

	public void setDEV_START_DT(Date dEV_START_DT) {
		DEV_START_DT = dEV_START_DT;
	}

	public Date getDEV_END_DT() {
		return DEV_END_DT;
	}

	public void setDEV_END_DT(Date dEV_END_DT) {
		DEV_END_DT = dEV_END_DT;
	}

	public Date getPJT_START_DT() {
		return PJT_START_DT;
	}

	public void setPJT_START_DT(Date pJT_START_DT) {
		PJT_START_DT = pJT_START_DT;
	}

	public Date getPJT_END_DT() {
		return PJT_END_DT;
	}

	public void setPJT_END_DT(Date pJT_END_DT) {
		PJT_END_DT = pJT_END_DT;
	}

	public String getPJT_CONTENT() {
		return PJT_CONTENT;
	}

	public void setPJT_CONTENT(String pJT_CONTENT) {
		PJT_CONTENT = pJT_CONTENT;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "TmsProjectManageVO [PJT_ID=" + PJT_ID + ", PJT_NM=" + PJT_NM + ", PJT_TYPE=" + PJT_TYPE + ", PJT_ST="
				+ PJT_ST + ", PJT_PM=" + PJT_PM + ", PJT_PRICE=" + PJT_PRICE + ", DEV_START_DT=" + DEV_START_DT
				+ ", DEV_END_DT=" + DEV_END_DT + ", PJT_START_DT=" + PJT_START_DT + ", PJT_END_DT=" + PJT_END_DT
				+ ", PJT_CONTENT=" + PJT_CONTENT + "]";
	}

	
	
	
	
	
	
	
}
