package egovframework.let.tms.test.service;

import java.util.HashMap;
import java.util.List;


public interface TestService {

	/**
	 * 테스트케이스를 등록한다.
	 * @param vo - 등록할 정보가 담긴 TestCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertTestCase(TestCaseVO testCaseVO) throws Exception;

	
	/**
	 * 테스트시나리오를 등록한다.
	 * @param vo - 등록할 정보가 담긴 TestScenarioVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertTestScenario(TestScenarioVO testScenarioVO) throws Exception;

	/**
	 * 테스트케이스를 수정한다.
	 * @param vo - 수정할 정보가 담긴 TestCaseVO
	 * @return void형
	 * @exception Exception
	 */
	
	public void updateTestCase(TestCaseVO testCaseVO) throws Exception;


	/**
	 * 테스트시나리오를 수정한다.
	 * @param vo - 수정할 정보가 담긴 TestScenarioVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateTestScenario(TestScenarioVO testScenarioVO) throws Exception;
	
	/**
	 * 테스트 시나리오 결과만 수정한다.
	 * @param vo - 수정할 정보가 담긴 TestScenarioVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateTestScenarioResult(TestScenarioVO testScenarioVO) throws Exception;
	
	
	/**
	 * 테스트케이스를 삭제한다.
	 * @param String - 삭제할 정보가 담긴 testcaseId
	 * @return void형
	 * @exception Exception
	 */
	public void deleteTestCase(String testcaseId) throws Exception;
	
	/**
	 * 테스트 케이스를 멀티로 삭제한다.
	 * @param checkedMenuNoForDel String
	 * @exception Exception
	 */
	void deleteMultiTestCase(String checkedMenuNoForDel) throws Exception;

	
	/**
	 * 삭제하려는 케이스를 참조하고 있는 시나리오가 있는지 개수를 확인한다.
	 * @param checkedMenuNoForDel  String
	 * @return 
	 * @exception Exception
	 */
	
	public int selectScenarioCntReferringToCase(String checkedMenuNoForDel) throws Exception;
	
	
	
	/**
	 * 테스트시나리오를 삭제한다.
	 * @param String - 삭제할 정보가 담긴 testscenarioId
	 * @return void형
	 * @exception Exception
	 */
	public void deleteTestScenario(String testscenarioId) throws Exception;
	
	
	/**
	 * 테스트 시나리오를 멀티로 삭제한다.
	 * @param checkedMenuNoForDel String
	 * @exception Exception
	 */
	void deleteMultiTestScenario(String checkedMenuNoForDel) throws Exception;


	
	/**
	 * 테스트케이스에 대한 상세정보를 조회한다.
	 * @param vo - 조회할 정보가 담긴 TestVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public HashMap<String,Object> selectTestCase(String testcaseId) throws Exception; 
	
	

	/**
	 * 테스트 케이스의 진행상태를 가져온다. (통계 대시보드용)
	 * @param vo - 조회할 정보가 담긴 TestVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public HashMap<String,Object> selectTestCaseProgressStatus(String testcaseGb) throws Exception; 
	
	
	
	/**
	 * 테스트시나리오에 대한 상세정보를 조회한다.
	 * @param vo - 조회할 정보가 담긴 TestVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public TestScenarioVO selectTestScenario(String testscenarioId) throws Exception; 


	/**
	 * 테스트케이스 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<?> selectTestCaseList(TestDefaultVO searchVO) throws Exception;
	
	
	/**
	 * 테스트케이스 개수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public int selectTestCaseListTotCnt(TestDefaultVO searchVO)throws Exception;
	
	/**
	 * 테스트시나리오 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<?> selectTestScenarioList(String testcaseId) throws Exception;
	
	
	/**
	 * 테스트시나리오 개수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public int selectTestScenarioListTotCnt(String testcaseId)throws Exception;
	
	/**
	 * 단위,통합 테스트 케이스 통계 정보를 가져온다
	 * @param String - 조회할 정보가 담긴 testcaseGb
	 * @return HashMap<String,Object>
	 * @exception Exception
	 */
	
	public HashMap<String, Integer> selectTestCaseStats(String testcaseGb)throws Exception;
	
	
	/**
	 * 업무별 '전체' 단위 테스트 케이스 통계 정보를 가져온다
	 * @param 
	 * @return List<?>
	 * @exception Exception
	 */
	public List<?> selectTestCaseStatsListByTaskGbTotal()  throws Exception;
	
	
	/**
	 * 업무별 단위 테스트 케이스 통계 정보를 가져온다
	 * @param 
	 * @return List<?>
	 * @exception Exception
	 */
	public List<?> selectTestCaseStatsListByTaskGb(String sysNm)  throws Exception;
	
	
	/**
	 * 업무별 단위 테스트 케이스 통계 정보를 가져온다
	 * @param 
	 * @return List<?>
	 * @exception Exception
	 */
	public List<?> selectTestCaseStatsListBySysGb()  throws Exception;
	
	
	/**
	 * 테스트 현황 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<?> selectTestCurrent(TestDefaultVO searchVO) throws Exception;
	
	
	/**
	 * 테스트 현황 목록 개수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return int
	 * @exception Exception
	 */
	public int selectTestCurrentTotCnt(TestDefaultVO searchVO)throws Exception;
	
	/**
	 * 테스트 현황 목록 개수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return HashMap<String, Object>
	 * @exception Exception
	 */
	public HashMap<String, Object> selectTestCurrentCnt(TestDefaultVO searchVO) throws Exception;
	
	
	
	/**
	 * 테스트 통계(통계표)을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<?> selectTestStatsTable(TestDefaultVO searchVO) throws Exception;
}
