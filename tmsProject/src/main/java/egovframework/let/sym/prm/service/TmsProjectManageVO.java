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

	@DateTimeFormat(pattern="yyyy-MM-dd")	
	private Date inputStartDt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")	
	private Date inputEndDt;

	@DateTimeFormat(pattern="yyyy-MM-dd")	
	private Date planStartDt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")	
	private Date planEndDt;
	
	private String pjtContent;

	public String getPjtId() {
		return pjtId;
	}

	public void setPjtId(String pjtId) {
		this.pjtId = pjtId;
	}

	public String getPjtNm() {
		return pjtNm;
	}

	public void setPjtNm(String pjtNm) {
		this.pjtNm = pjtNm;
	}

	public String getPjtType() {
		return pjtType;
	}

	public void setPjtType(String pjtType) {
		this.pjtType = pjtType;
	}

	public String getPjtSt() {
		return pjtSt;
	}

	public void setPjtSt(String pjtSt) {
		this.pjtSt = pjtSt;
	}

	public String getPjtPm() {
		return pjtPm;
	}

	public void setPjtPm(String pjtPm) {
		this.pjtPm = pjtPm;
	}

	public int getPjtPrice() {
		return pjtPrice;
	}

	public void setPjtPrice(int pjtPrice) {
		this.pjtPrice = pjtPrice;
	}

	public Date getDevStartDt() {
		return devStartDt;
	}

	public void setDevStartDt(Date devStartDt) {
		this.devStartDt = devStartDt;
	}

	public Date getDevEndDt() {
		return devEndDt;
	}

	public void setDevEndDt(Date devEndDt) {
		this.devEndDt = devEndDt;
	}

	public Date getPjtStartDt() {
		return pjtStartDt;
	}

	public void setPjtStartDt(Date pjtStartDt) {
		this.pjtStartDt = pjtStartDt;
	}

	public Date getPjtEndDt() {
		return pjtEndDt;
	}

	public void setPjtEndDt(Date pjtEndDt) {
		this.pjtEndDt = pjtEndDt;
	}

	public String getPjtContent() {
		return pjtContent;
	}

	public void setPjtContent(String pjtContent) {
		this.pjtContent = pjtContent;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Date getInputStartDt() {
		return inputStartDt;
	}

	public void setInputStartDt(Date inputStartDt) {
		this.inputStartDt = inputStartDt;
	}

	public Date getInputEndDt() {
		return inputEndDt;
	}

	public void setInputEndDt(Date inputEndDt) {
		this.inputEndDt = inputEndDt;
	}

	public Date getPlanStartDt() {
		return planStartDt;
	}

	public void setPlanStartDt(Date planStartDt) {
		this.planStartDt = planStartDt;
	}

	public Date getPlanEndDt() {
		return planEndDt;
	}

	public void setPlanEndDt(Date planEndDt) {
		this.planEndDt = planEndDt;
	}

	@Override
	public String toString() {
		return "TmsProjectManageVO [pjtId=" + pjtId + ", pjtNm=" + pjtNm + ", pjtType=" + pjtType + ", pjtSt=" + pjtSt
				+ ", pjtPm=" + pjtPm + ", pjtPrice=" + pjtPrice + ", devStartDt=" + devStartDt + ", devEndDt="
				+ devEndDt + ", pjtStartDt=" + pjtStartDt + ", pjtEndDt=" + pjtEndDt + ", inputStartDt=" + inputStartDt
				+ ", inputEndDt=" + inputEndDt + ", planStartDt=" + planStartDt + ", planEndDt=" + planEndDt
				+ ", pjtContent=" + pjtContent + "]";
	}

	
}
