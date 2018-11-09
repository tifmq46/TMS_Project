package egovframework.let.tms.test.service;

import java.util.HashMap;
import java.util.List;

/**
 * 테스트(단위/통합)관리  서비스 인터페이스 클래스
 * @since 2018.10.01
 * @version 1.0
 * @see
 */

public interface TestService {

	public void insertTestCase(TestCaseVO testCaseVO) throws Exception;

	public void insertTestScenario(TestScenarioVO testScenarioVO) throws Exception;
	
	public void updateTestCase(TestCaseVO testCaseVO) throws Exception;

	public void updateTestScenario(TestScenarioVO testScenarioVO) throws Exception;

	public void updateTestScenarioResult(TestScenarioVO testScenarioVO) throws Exception;
	
	public void deleteTestCase(String testcaseId) throws Exception;

	public void deleteMultiTestCase(String checkedMenuNoForDel) throws Exception;

	public int selectScenarioCntReferringToCase(String checkedMenuNoForDel) throws Exception;
	
	public void deleteTestScenario(String testscenarioId) throws Exception;
	
	public void deleteMultiTestScenario(String checkedMenuNoForDel) throws Exception;

	public HashMap<String,Object> selectTestCase(String testcaseId) throws Exception; 
	
	public HashMap<String,Object> selectTestCaseProgressStatus(String testcaseGb) throws Exception; 
	
	public TestScenarioVO selectTestScenario(String testscenarioId) throws Exception; 

	public List<?> selectTestCaseList(TestDefaultVO searchVO) throws Exception;
	
	public int selectTestCaseListTotCnt(TestDefaultVO searchVO)throws Exception;
	
	public List<?> selectTestScenarioList(String testcaseId) throws Exception;
	
	public int selectTestScenarioListTotCnt(String testcaseId)throws Exception;

	public HashMap<String, Integer> selectTestCaseStats(String testcaseGb)throws Exception;
	
	public HashMap<String, Integer> selectTestScenarioStats(String testcaseId)throws Exception;
	
	public List<?> selectTestCaseStatsListByTaskGb(TestDefaultVO searchVO)  throws Exception;
	
	public List<?> selectTestCaseStatsListBySysGb(TestDefaultVO searchVO)  throws Exception;
	
	public List<?> selectTestCurrent(TestDefaultVO searchVO) throws Exception;
	
	public int selectTestCurrentTotCnt(TestDefaultVO searchVO)throws Exception;
	
	public HashMap<String, Object> selectTestCurrentCnt(TestDefaultVO searchVO) throws Exception;
	
	public List<?> selectTestStatsTable(TestDefaultVO searchVO) throws Exception;
}
