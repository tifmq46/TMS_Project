package egovframework.let.tms.test.service;

import java.io.Serializable;
import java.util.Date;

@SuppressWarnings("serial")
public class TestCaseVO implements Serializable{

	

	/** 테스트케이스 아이디 */
	private String testcaseId;
	
	/** 테스트케이스 내용 */
	private String testcaseContent;
	
	/** 테스트케이스 구분 */
	private String testcaseGb;
	
	/** 화면 아이디 */
	private String pgId;
	
	/** 업무구분  */
	private String taskGb;
	
	/** 작성자 아이디 */
	private String userId;
	
	/** 등록일자 */
	private Date enrollDt;
	
	/** 전제조건 */
	private String precondition;
	
	/** 1차 테스트 완료여부 */
	private String firstTestResultYn;
	
	/** 2차 테스트 완료여부 */
	private String secondTestResultYn;
	
	/** 3차 테스트 완료여부 */
	private String thirdTestResultYn;
	
	/** 최종 완료여부 */
	private String completeYn;
	
	/** 최종 완료일자 */
	private Date completeDt;
	

	public String getTestcaseId() {
		return testcaseId;
	}

	public void setTestcaseId(String testcaseId) {
		this.testcaseId = testcaseId;
	}

	public String getTestcaseContent() {
		return testcaseContent;
	}

	public void setTestcaseContent(String testcaseContent) {
		this.testcaseContent = testcaseContent;
	}

	public String getTestcaseGb() {
		return testcaseGb;
	}

	public void setTestcaseGb(String testcaseGb) {
		this.testcaseGb = testcaseGb;
	}

	public String getPgId() {
		return pgId;
	}

	public void setPgId(String pgId) {
		this.pgId = pgId;
	}

	public String getTaskGb() {
		return taskGb;
	}

	public void setTaskGb(String taskGb) {
		this.taskGb = taskGb;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public Date getEnrollDt() {
		return enrollDt;
	}

	public void setEnrollDt(Date enrollDt) {
		this.enrollDt = enrollDt;
	}

	public String getPrecondition() {
		return precondition;
	}

	public void setPrecondition(String precondition) {
		this.precondition = precondition;
	}

	public String getFirstTestResultYn() {
		return firstTestResultYn;
	}

	public void setFirstTestResultYn(String firstTestResultYn) {
		this.firstTestResultYn = firstTestResultYn;
	}

	public String getSecondTestResultYn() {
		return secondTestResultYn;
	}

	public void setSecondTestResultYn(String secondTestResultYn) {
		this.secondTestResultYn = secondTestResultYn;
	}

	public String getThirdTestResultYn() {
		return thirdTestResultYn;
	}

	public void setThirdTestResultYn(String thirdTestResultYn) {
		this.thirdTestResultYn = thirdTestResultYn;
	}

	public String getCompleteYn() {
		return completeYn;
	}

	public void setCompleteYn(String completeYn) {
		this.completeYn = completeYn;
	}

	public Date getCompleteDt() {
		return completeDt;
	}

	public void setCompleteDt(Date completeDt) {
		this.completeDt = completeDt;
	}
}
