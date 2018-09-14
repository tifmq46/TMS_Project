package egovframework.let.tms.test.service;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

@SuppressWarnings("serial")
public class TestScenarioVO implements Serializable{


	/** 테스트시나리오 아이디 */
	private String testscenarioId;

	/** 테스트시나리오 순서 */
	private int testscenarioOrd;
	
	/** 수행절차 */
	private String testscenarioContent;

	/** 테스트케이스 아이디 */
	private String testcaseId;
	
	/** 테스터 아이디 */
	private String userTestId;

	/** 테스트 조건 */
	private String testCondition;
	
	/** 예상 결과 */
	private String expectedResult;

	/** 등록일자 */
	private Date enrollDt;

	/** 테스트 결과 */
	private String testResultYn;

	/** 테스트 일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date testDt;
	
	/** 테스트결과 내용 */
	private String testResultContent;
	
	

	public String getTestscenarioId() {
		return testscenarioId;
	}

	public void setTestscenarioId(String testscenarioId) {
		this.testscenarioId = testscenarioId;
	}

	public int getTestscenarioOrd() {
		return testscenarioOrd;
	}

	public void setTestscenarioOrd(int testscenarioOrd) {
		this.testscenarioOrd = testscenarioOrd;
	}

	public String getTestscenarioContent() {
		return testscenarioContent;
	}

	public void setTestscenarioContent(String testscenarioContent) {
		this.testscenarioContent = testscenarioContent;
	}

	public String getTestcaseId() {
		return testcaseId;
	}

	public void setTestcaseId(String testcaseId) {
		this.testcaseId = testcaseId;
	}

	public String getUserTestId() {
		return userTestId;
	}

	public void setUserTestId(String userTestId) {
		this.userTestId = userTestId;
	}

	public String getTestCondition() {
		return testCondition;
	}

	public void setTestCondition(String testCondition) {
		this.testCondition = testCondition;
	}

	public String getExpectedResult() {
		return expectedResult;
	}

	public void setExpectedResult(String expectedResult) {
		this.expectedResult = expectedResult;
	}

	public Date getEnrollDt() {
		return enrollDt;
	}

	public void setEnrollDt(Date enrollDt) {
		this.enrollDt = enrollDt;
	}

	public String getTestResultYn() {
		return testResultYn;
	}

	public void setTestResultYn(String testResultYn) {
		this.testResultYn = testResultYn;
	}

	public Date getTestDt() {
		return testDt;
	}

	public void setTestDt(Date testDt) {
		this.testDt = testDt;
	}

	public String getTestResultContent() {
		return testResultContent;
	}

	public void setTestResultContent(String testResultContent) {
		this.testResultContent = testResultContent;
	}

	
	
}
