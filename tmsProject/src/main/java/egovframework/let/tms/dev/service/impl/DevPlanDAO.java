package egovframework.let.tms.dev.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.cop.com.service.TemplateInfVO;
import egovframework.let.tms.dev.service.DevPlanDefaultVO;
import egovframework.let.tms.dev.service.DevPlanVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("devPlanDAO")
public class DevPlanDAO extends EgovAbstractDAO{
	/**
	 * 개발계획을 등록한다.
	 * @param vo - 등록할 정보가 담긴 DevPlanVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertDevPlan(DevPlanVO vo) throws Exception {
		insert("DevPlanDAO.insertDevPlan", vo);
	}

	/**
	 * 개발계획을 수정한다.
	 * @param vo - 수정할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateDevPlan(DevPlanVO vo) throws Exception {
		update("DevPlanDAO.updateDevPlan", vo);
	}

	/**
	 * 개발계획을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void deleteDevPlan(DevPlanVO vo) throws Exception {
		delete("DevPlanDAO.deleteDevPlan", vo);
	}

	/**
	 * 개발계획의 상세정보를 조회한다.
	 * @param vo - 조회할 정보가 담긴 DevPlanVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public List<?> selectDevPlan(DevPlanDefaultVO defaultVO) throws Exception {
		return list("DevPlanDAO.selectDevPlan", defaultVO);
	}

	/**
	 * 개발계획 전체조회
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<?> selectDevPlans(DevPlanDefaultVO searchVO) throws Exception {
		return list("devPlanDAO.selectDevPlans", searchVO);
	}

	/**
	 * 개발계획 목록 전체 건수 조회
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 총 갯수
	 * @exception
	 */
	public int selectDevPlanListTotCnt(DevPlanDefaultVO defaultVO) throws Exception {
		return (Integer) select("DevPlanDAO.selectDevPlanListTotCnt", defaultVO);
	}

	
	@SuppressWarnings("unchecked")
    public List<DevPlanDefaultVO> selectDevPlansByCode(DevPlanDefaultVO defaultVO) throws Exception {
		return (List<DevPlanDefaultVO>) list("DevPlanDAO.selectDevPlansByCode", defaultVO);
    }
	
	public List<?> selectDevResultList(DevPlanDefaultVO searchVO) throws Exception {
		return list("devPlanDAO.selectDevResultList", searchVO);
	}
	
	/**
	 * 개발결과의 상세정보를 조회한다.
	 * @param vo - 조회할 정보가 담긴 DevPlanVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public List<?> selectDevResult(DevPlanDefaultVO defaultVO) throws Exception {
		return list("DevPlanDAO.selectDevResult", defaultVO);
	}
	
	

	/**
	 * 개발결과를 수정한다.
	 * @param vo - 수정할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateDevResult(DevPlanVO vo) throws Exception {
		update("DevPlanDAO.updateDevResult", vo);
	}

	/**
	 * 개발결과를 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void deleteDevResult(DevPlanVO vo) throws Exception {
		update("DevPlanDAO.deleteDevResult", vo);
	}

	public List<?> selectDevPeriod() throws Exception{
		return list("DevPlanDAO.selectDevPeriod");
	}

	public void insertWeek(int i) {
		insert("DevPlanDAO.insertWeek", i);
	}

	public void deleteWeek() {
		delete("DevPlanDAO.deleteWeek");
		
	}

	public String ifNullDevPlan(String b) {
		return (String) select("DevPlanDAO.ifNullDevPlan",b);
	}

	public int selectDevResultListTotCnt(DevPlanDefaultVO searchVO) {
		return (Integer) select("DevPlanDAO.selectDevResultListTotCnt" ,searchVO);
	}

	public List<HashMap<String, String>> selectDevCurrent(DevPlanDefaultVO searchVO) {
		return (List<HashMap<String, String>>) list("devPlanDAO.selectDevCurrent",searchVO);
	}

	public void updateRate(DevPlanDefaultVO searchVO) {
		update("DevPlanDAO.updateRate", searchVO);
	}

	public HashMap<String, String> DevPlanAvg() {
		return (HashMap<String, String>)select("DevPlanDAO.DevPlanAvg");
	}
}
