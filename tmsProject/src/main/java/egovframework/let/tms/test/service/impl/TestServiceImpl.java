package egovframework.let.tms.test.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.let.tms.test.service.TestDefaultVO;
import egovframework.let.tms.test.service.TestScenarioVO;
import egovframework.let.tms.test.service.TestService;
import egovframework.let.sym.mnu.mpm.service.MenuManageVO;
import egovframework.let.tms.test.service.TestCaseVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("testService")
public class TestServiceImpl extends EgovAbstractServiceImpl implements TestService{

	private static final Logger LOGGER = LoggerFactory.getLogger(TestServiceImpl.class);
	
	
	/** TestDAO */
	// TODO ibatis 사용
	@Resource(name = "testDAO")
	private TestDAO testDAO;
	
	
	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;
	
	
	@Override
	public void insertTestCase(TestCaseVO testCaseVO) throws Exception {
		LOGGER.debug(testCaseVO.toString());

		/** ID Generation Service */
		//String id = egovIdGnrService.getNextStringId();
		LOGGER.debug(testCaseVO.toString());

		testDAO.insertTestCase(testCaseVO);
	}
	
	
	@Override
	public void insertTestScenario(TestScenarioVO testScenarioVO) throws Exception {
		LOGGER.debug(testScenarioVO.toString());

		/** ID Generation Service */
		//String id = egovIdGnrService.getNextStringId();
		LOGGER.debug(testScenarioVO.toString());

		testDAO.insertTestScenario(testScenarioVO);
	}
	
	
	@Override
	public void updateTestCase(TestCaseVO testCaseVO) throws Exception {
		testDAO.updateTestCase(testCaseVO);
		
	}
	
	
	@Override
	public void updateTestScenario(TestScenarioVO testScenarioVO) throws Exception {
		testDAO.updateTestScenario(testScenarioVO);
		
	}
	
	@Override
	public void updateTestScenarioResult(TestScenarioVO testScenarioVO) throws Exception{
		testDAO.updateTestScenarioResult(testScenarioVO);
	}
	
	
	@Override
	public void deleteTestCase(String testcaseId) throws Exception {
		testDAO.deleteTestCase(testcaseId);
		
	}

	@Override
	public void deleteMultiTestCase(String checkedMenuNoForDel) throws Exception {

		String[] delMenuNo = checkedMenuNoForDel.split(",");

		if (delMenuNo == null || (delMenuNo.length == 0)) {
			throw new java.lang.Exception("String Split Error!");
		}
		for (int i = 0; i < delMenuNo.length; i++) {
			testDAO.deleteTestCase(delMenuNo[i]);
		}
	}
	
	
	@Override
	public int selectScenarioCntReferringToCase(String checkedMenuNoForDel) throws Exception {

		String[] delMenuNo = checkedMenuNoForDel.split(",");
		int scenarioCount = 0; //각 케이스별로 케이스를 참조하고 있는 시나리오의 개수
		int totalCount = 0; //시나리오가 있는 케이스들의 총 개수
		
		if (delMenuNo == null || (delMenuNo.length == 0)) {
			throw new java.lang.Exception("String Split Error!");
		}
		for (int i = 0; i < delMenuNo.length; i++) {
			
			scenarioCount = testDAO.selectScenarioCntReferringToCase(delMenuNo[i]);
			
			if(scenarioCount > 0)
				totalCount++;
		}
		return totalCount;
	}
	
	
	
	@Override
	public void deleteTestScenario(String testscenarioId) throws Exception {
		testDAO.deleteTestScenario(testscenarioId);
		
	}

	@Override
	public void deleteMultiTestScenario(String checkedMenuNoForDel) throws Exception {

		String[] delMenuNo = checkedMenuNoForDel.split(",");

		if (delMenuNo == null || (delMenuNo.length == 0)) {
			throw new java.lang.Exception("String Split Error!");
		}
		for (int i = 0; i < delMenuNo.length; i++) {
			testDAO.deleteTestScenario(delMenuNo[i]);
		}
	}
	
	/**
	 * 테스트 케이스 상세 정보 조회
	 */
	@Override
	public HashMap<String,Object> selectTestCase(String testcaseId) throws Exception {
		return testDAO.selectTestCase(testcaseId);
	}
	
	
	/**
	 * 테스트 케이스 진행 상태 상세 정보 조회(통계 대시보드)
	 */
	@Override
	public HashMap<String,Object> selectTestCaseProgressStatus(String testcaseGb) throws Exception {
		return testDAO.selectTestCaseProgressStatus(testcaseGb);
	}
	
	
	/**
	 * 테스트 시나리오 상세 정보 조회
	 */
	@Override
	public TestScenarioVO selectTestScenario(String testscenarioId) throws Exception {
		return testDAO.selectTestScenario(testscenarioId);
	}
	
	
	/**
	 * 목록 조회
	 */
	
	@Override
	public int selectTestCaseListTotCnt(TestDefaultVO searchVO) throws Exception {
		return testDAO.selectTestCaseListTotCnt(searchVO);
	}


	@Override
	public List<?> selectTestCaseList(TestDefaultVO searchVO) throws Exception {
		return testDAO.selectTestCaseList(searchVO);
	}
	
	
	@Override
	public int selectTestScenarioListTotCnt(String testcaseId) throws Exception {
		return testDAO.selectTestScenarioListTotCnt(testcaseId);
	}


	@Override
	public List<?> selectTestScenarioList(String testcaseId) throws Exception {
		return testDAO.selectTestScenarioList(testcaseId);
	}
	
	@Override
	public HashMap<String, Integer> selectTestCaseStats(String testcaseGb)throws Exception{
		return testDAO.selectTestCaseStats(testcaseGb);
	}
	
	@Override
	public List<?> selectTestCaseStatsListByTaskGb()  throws Exception{
		return testDAO.selectTestCaseStatsListByTaskGb();
	}

	@Override
	public List<?> selectTestCurrent(TestDefaultVO searchVO) throws Exception {
		return testDAO.selectTestCurrent(searchVO);
	}
	
	@Override
	public int selectTestCurrentTotCnt(TestDefaultVO searchVO) throws Exception {
		return testDAO.selectTestCurrentTotCnt(searchVO);
	}

	@Override
	public HashMap<String, Object> selectTestCurrentCnt(TestDefaultVO searchVO) throws Exception {
		return testDAO.selectTestCurrentCnt(searchVO);
	}
	
	@Override
	public List<?> selectTestStatsTable(TestDefaultVO searchVO) throws Exception {
		return testDAO.selectTestStatsTable(searchVO);
	}
}
