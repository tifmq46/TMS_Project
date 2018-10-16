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
	private String pjtId;
	/** 기관 */
	private String pjtNm;
	/** 이름 */
	private String pjtType;
	/** 비밀번호 */
	private String pjtSt;
	
	private String pjtPm;
	/** 역할코드 */
	private int pjtPrice = 0;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date devStartDt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date devEndDt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")	
	private Date pjtStartDt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")	
	private Date pjtEndDt;
	
	private String pjtContent;

	public String getPjtId() {
		return pjtId;
	}

	public void setPjtId(String pJT_ID) {
		pjtId = pJT_ID;
	}

	public String getPjtNm() {
		return pjtNm;
	}

	public void setPjtNm(String pJT_NM) {
		pjtNm = pJT_NM;
	}

	public String getPjtType() {
		return pjtType;
	}

	public void setPjtType(String pJT_TYPE) {
		pjtType = pJT_TYPE;
	}

	public String getPjtSt() {
		return pjtSt;
	}

	public void setPjtSt(String pJT_ST) {
		pjtSt = pJT_ST;
	}

	public String getPjtPm() {
		return pjtPm;
	}

	public void setPjtPm(String pJT_PM) {
		pjtPm = pJT_PM;
	}

	public int getPjtPrice() {
		return pjtPrice;
	}

	public void setPjtPrice(int pJT_PRICE) {
		pjtPrice = pJT_PRICE;
	}

	public Date getDevStartDt() {
		return devStartDt;
	}

	public void setDevStartDt(Date dEV_START_DT) {
		devStartDt = dEV_START_DT;
	}

	public Date getDevEndDt() {
		return devEndDt;
	}

	public void setDevEndDt(Date dEV_END_DT) {
		devEndDt = dEV_END_DT;
	}

	public Date getPjtStartDt() {
		return pjtStartDt;
	}

	public void setPjtStartDt(Date pJT_START_DT) {
		pjtStartDt = pJT_START_DT;
	}

	public Date getPjtEndDt() {
		return pjtEndDt;
	}

	public void setPjtEndDt(Date pJT_END_DT) {
		pjtEndDt = pJT_END_DT;
	}

	public String getPjtContent() {
		return pjtContent;
	}

	public void setPjtContent(String pJT_CONTENT) {
		pjtContent = pJT_CONTENT;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "TmsProjectManageVO [pjtId=" + ", PJT_NM=" + pjtNm + ", PJT_TYPE=" + pjtType + ", PJT_ST="
				+ pjtSt + ", PJT_PM=" + pjtPm + ", PJT_PRICE=" + pjtPrice + ", DEV_START_DT=" + devStartDt
				+ ", DEV_END_DT=" + devEndDt + ", PJT_START_DT=" + pjtStartDt + ", PJT_END_DT=" + pjtEndDt
				+ ", PJT_CONTENT=" + pjtContent + "]";
	}

	
	
	
	
	
	
	
}
