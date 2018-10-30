package egovframework.let.tms.test.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.tms.test.service.TestDefaultVO;
import egovframework.let.tms.test.service.TestScenarioVO;
import egovframework.let.tms.test.service.TestCaseVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("testDAO")
public class TestDAO extends EgovAbstractDAO{

	/**
	 * 테스트 케이스를 등록한다.
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return void
	 * @exception Exception
	 */
	public void insertTestCase(TestCaseVO testCaseVO) throws Exception {
		insert("TestDAO.insertTestCase", testCaseVO);
	}
	
	/**
	 * 테스트 시나리오를 등록한다.
	 * @param vo - 등록할 정보가 담긴 testScenarioVO
	 * @return void
	 * @exception Exception
	 */
	public void insertTestScenario(TestScenarioVO testScenarioVO) throws Exception {
		insert("TestDAO.insertTestScenario", testScenarioVO);
	}
	
	/**
	 * 테스트 케이스를 수정한다.
	 * @param vo - 수정할 정보가 담긴 testCaseVO
	 * @return void
	 * @exception Exception
	 */
	public void updateTestCase(TestCaseVO testCaseVO) throws Exception {
		update("TestDAO.updateTestCase", testCaseVO);
	}

	
	/**
	 * 테스트 시나리오를 수정한다.
	 * @param vo - 수정할 정보가 담긴 testScenarioVO
	 * @return void
	 * @exception Exception
	 */
	public void updateTestScenario(TestScenarioVO testScenarioVO) throws Exception {
		update("TestDAO.updateTestScenario", testScenarioVO);
	}

	
	/**
	 * 테스트 시나리오를 복수로 수정한다.
	 * @param vo - 수정할 정보가 담긴 testScenarioVO
	 * @return void
	 * @exception Exception
	 */
	public void updateTestScenarioResult(TestScenarioVO testScenarioVO) throws Exception {
		update("TestDAO.updateTestScenarioResult", testScenarioVO);
	}
	
	
	/**
	 * 테스트 케이스를 삭제한다.
	 * @param String - 삭제할 정보가 담긴 testcaseId
	 * @return void
	 * @exception Exception
	 */
	public void deleteTestCase(String testcaseId) throws Exception {
		delete("TestDAO.deleteTestCase", testcaseId);
	}
	
	/**
	 * 테스트 시나리오를 삭제한다.
	 * @param String - 삭제할 정보가 담긴 testscenarioId
	 * @return void
	 * @exception Exception
	 */
	public void deleteTestScenario(String testscenarioId) throws Exception {
		delete("TestDAO.deleteTestScenario", testscenarioId);
	}
	
	/**
	 * 테스트 케이스의 상세정보를 조회한다.
	 * @param String - 조회할 정보가 담긴 testcaseId
	 * @return HashMap<String,Object>
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public HashMap<String,Object> selectTestCase(String testcaseId) throws Exception {
		return  (HashMap<String, Object>) select("TestDAO.selectTestCase", testcaseId);
	}
	
	
	/**
	 * 테스트 케이스의 진행상태를 가져온다.
	 * @param String - 조회할 정보가 담긴 testcaseGb
	 * @return HashMap<String,Object>
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public HashMap<String,Object> selectTestCaseProgressStatus(String testcaseGb) throws Exception {
		return  (HashMap<String, Object>) select("TestDAO.selectTestCaseProgressStatus", testcaseGb);
	}
	
	/**
	 * 테스트 시나리오의 상세정보를 조회한다.
	 * @param String - 조회할 정보가 담긴 testscenarioId
	 * @return TestScenarioVO
	 * @exception Exception
	 */
	public  TestScenarioVO selectTestScenario(String testscenarioId) throws Exception {
		return  (TestScenarioVO) select("TestDAO.selectTestScenario", testscenarioId);
	}
	
	
	/**
	 * 테스트 케이스 목록을 조회한다.
	 * @param vo - 조회할 정보가 담긴 searchVO
	 * @return List<?>
	 * @exception Exception
	 */
	public List<?> selectTestCaseList(TestDefaultVO searchVO) throws Exception {
		return list("TestDAO.selectTestCaseList", searchVO);
	}
	

	/**
	 * 테스트케이스 목록 전체 건수 조회
	 * @param vo - 조회할 정보가 담긴 searchVO
	 * @return int
	 * @exception
	 */
	
	public int selectTestCaseListTotCnt(TestDefaultVO searchVO) throws Exception {
		return (Integer) select("TestDAO.selectTestCaseListTotCnt", searchVO);
	}


	/**
	 * 테스트시나리오 목록을 조회한다.
	 * @param String - 조회할 정보가 담긴 testcaseId
	 * @return List<?> 
	 * @exception Exception
	 */
	public List<?> selectTestScenarioList(String testcaseId) throws Exception {
		return list("TestDAO.selectTestScenarioList", testcaseId);
	}
	

	/**
	 * 테스트시나리오 목록 전체 건수 조회
	 * @param String - 조회할 정보가 담긴 testcaseId
	 * @return int
	 * @exception
	 */
	
	public int selectTestScenarioListTotCnt(String testcaseId) throws Exception {
		return (Integer) select("TestDAO.selectTestScenarioListTotCnt", testcaseId);
	}
	
	
	/**
	 * 단위,통합 테스트 케이스 통계 정보를 가져온다
	 * @param String - 조회할 정보가 담긴 testcaseGb
	 * @return HashMap<String,Integer> 
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public HashMap<String,Integer> selectTestCaseStats(String testcaseGb) throws Exception {
		return  (HashMap<String, Integer>) select("TestDAO.selectTestCaseStats", testcaseGb);
	}
	
	
	/**
	 * 업무별 '전체' 단위 테스트 케이스 통계 정보를 가져온다
	 * @param 
	 * @return List<?>
	 * @exception Exception
	 */
	public List<?> selectTestCaseStatsListByTaskGbTotal() throws Exception {
		return  list("TestDAO.selectTestCaseStatsListByTaskGbTotal");
	}
	
	
	/**
	 * 업무별 단위 테스트 케이스 통계 정보를 가져온다
	 * @param 
	 * @return List<?>
	 * @exception Exception
	 */
	public List<?> selectTestCaseStatsListByTaskGb(String sysNm) throws Exception {
		return  list("TestDAO.selectTestCaseStatsListByTaskGb", sysNm);
	}
	
	
	/**
	 * 시스템별 단위 테스트 케이스 통계 정보를 가져온다
	 * @param 
	 * @return List<?>
	 * @exception Exception
	 */
	public List<?> selectTestCaseStatsListBySysGb() throws Exception {
		return  list("TestDAO.selectTestCaseStatsListBySysGb");
	}
	
	

	/**
	 * 테스트 현황 목록을 조회한다.
	 * @param vo - 조회할 정보가 담긴 searchVO
	 * @return List<?>
	 * @exception Exception
	 */
	public List<?> selectTestCurrent(TestDefaultVO searchVO) throws Exception {
		return list("TestDAO.selectTestCurrent", searchVO);
	}
	

	/**
	 * 테스트 현황 목록 전체 건수 조회
	 * @param vo - 조회할 정보가 담긴 searchVO
	 * @return int
	 * @exception
	 */
	public int selectTestCurrentTotCnt(TestDefaultVO searchVO) throws Exception {
		return (Integer) select("TestDAO.selectTestCurrentTotCnt", searchVO);
	}
	

	/**
	 * 삭제하려는 케이스를 참조하고 있는 시나리오가 있는지 개수 조회
	 * @param String checkedMenuNoForDel
	 * @return 시나리오 갯수
	 * @exception
	 */
	public int selectScenarioCntReferringToCase(String checkedMenuNoForDel) throws Exception {
		return (Integer) select("TestDAO.selectScenarioCntReferringToCase", checkedMenuNoForDel);
	}
	
	
	/**
	 * 테스트 현황 목록 전체 건수 조회
	 * @param TestDefaultVO - 조회할 정보가 담긴 searchVO
	 * @return 글 총 갯수
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectTestCurrentCnt(TestDefaultVO searchVO) throws Exception {
		return  (HashMap<String, Object>) select("TestDAO.selectTestCurrentCnt", searchVO);
	}
	
	
	/**
	 * 테스트 통계(통계표)를 조회한다.
	 * @param vo - 조회할 정보가 담긴 searchVO
	 * @return List<?>
	 * @exception Exception
	 */
	public List<?> selectTestStatsTable(TestDefaultVO searchVO) throws Exception {
		return (List<?>) list("TestDAO.selectTestStatsTable", searchVO);
	}
	
}
