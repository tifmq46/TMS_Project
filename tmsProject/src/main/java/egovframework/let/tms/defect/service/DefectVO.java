package egovframework.let.tms.defect.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class DefectVO{

	/** 결함 아이디 (시퀀스) */
	private int defectIdSq;
	
	/** 결함 제목*/
	private String defectTitle;
	
	/** 결함 내용 */
	private String defectContent;
	
	/** 프로그램 아이디 */
	private String pgId;
	
	/** 테스터 아이디 */
	private String userTestId;
	
	/** 결함 유형 구분 */
	private String defectGb;
	
	/** 등록일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date enrollDt;
	
	/** 조치내용 */
	private String actionContent;
	
	/** 조치상태 */
	private String actionSt;
	
	/** 조치일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date actionDt;

	/** 테스트시나리오 아이디 */
	private String testscenarioId;
	
	public int getDefectIdSq() {
		return defectIdSq;
	}

	public void setDefectIdSq(int defectIdSq) {
		this.defectIdSq = defectIdSq;
	}

	public String getDefectTitle() {
		return defectTitle;
	}

	public void setDefectTitle(String defectTitle) {
		this.defectTitle = defectTitle;
	}

	public String getDefectContent() {
		return defectContent;
	}

	public void setDefectContent(String defectContent) {
		this.defectContent = defectContent;
	}

	public String getPgId() {
		return pgId;
	}

	public void setPgId(String pgId) {
		this.pgId = pgId;
	}

	public String getUserTestId() {
		return userTestId;
	}

	public void setUserTestId(String userTestId) {
		this.userTestId = userTestId;
	}

	public String getDefectGb() {
		return defectGb;
	}

	public void setDefectGb(String defectGb) {
		this.defectGb = defectGb;
	}

	public Date getEnrollDt() {
		return enrollDt;
	}

	public void setEnrollDt(Date enrollDt) {
		this.enrollDt = enrollDt;
	}

	public String getActionContent() {
		return actionContent;
	}

	public void setActionContent(String actionContent) {
		this.actionContent = actionContent;
	}

	public String getActionSt() {
		return actionSt;
	}

	public void setActionSt(String actionSt) {
		this.actionSt = actionSt;
	}

	public Date getActionDt() {
		return actionDt;
	}

	public void setActionDt(Date actionDt) {
		this.actionDt = actionDt;
	}

	public String getTestscenarioId() {
		return testscenarioId;
	}

	public void setTestscenarioId(String testscenarioId) {
		this.testscenarioId = testscenarioId;
	}

	@Override
	public String toString() {
		return "DefectVO [defectIdSq=" + defectIdSq + ", defectTitle=" + defectTitle + ", defectContent="
				+ defectContent + ", pgId=" + pgId + ", userTestId=" + userTestId + ", defectGb=" + defectGb
				+ ", enrollDt=" + enrollDt + ", actionContent=" + actionContent + ", actionSt=" + actionSt
				+ ", actionDt=" + actionDt + ", testscenarioId=" + testscenarioId + "]";
	}
	
}
