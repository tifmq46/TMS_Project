package egovframework.let.tms.dev.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.cop.com.service.TemplateInfVO;
import egovframework.let.tms.dev.service.DevPlanDefaultVO;
import egovframework.let.tms.dev.service.DevPlanVO;
import egovframework.let.tms.dev.service.TempVO;
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
	public List<HashMap<String,String>> selectDevPlans(DevPlanDefaultVO searchVO) throws Exception {
		return (List<HashMap<String, String>>) list("devPlanDAO.selectDevPlans", searchVO);
	}

	public String selectSTART() throws Exception {
		return (String) select("DevPlanDAO.selectSTART");
	}
	public String selectEND() throws Exception {
		return (String) select("DevPlanDAO.selectEND");
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
	
	public List<HashMap<String, String>> selectDevResultList(DevPlanDefaultVO searchVO) throws Exception {
		return (List<HashMap<String, String>>) list("devPlanDAO.selectDevResultList", searchVO);
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

	public void updateinput1(String s) throws Exception {
		update("DevPlanDAO.updateinput1", s);
	}
	public void updateinput2(String s) throws Exception {
		update("DevPlanDAO.updateinput2", s);
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

	public HashMap<String, String> DevPlanAvg(DevPlanDefaultVO searchVO) {
		return (HashMap<String, String>)select("DevPlanDAO.DevPlanAvg",searchVO);
	}

	public int selectDevCurrentTotCnt(DevPlanDefaultVO searchVO) {
		return (Integer) select("DevPlanDAO.selectDevCurrentTotCnt" ,searchVO);
	}

	public void insertDates(String dates) {
		insert("DevPlanDAO.insertDates", dates);
	}

	public void deleteDates() {
		delete("DevPlanDAO.deleteDates");
	}

	public void insertDayDiff(DevPlanDefaultVO searchVO) {
		update("DevPlanDAO.insertDayDiff", searchVO);
	}

	public List<String> selectUserList() {
		return (List<String>) list("DevPlanDAO.selectUserList");
	}

	public List<HashMap<String, String>> selectTempList() {
		return (List<HashMap<String, String>>) list("DevPlanDAO.selectTempList");
	}

	public void insertTemp(TempVO t) {
		insert("DevPlanDAO.insertTemp", t);
		
	}

	public void deleteTemp() {
		delete("DevPlanDAO.deleteTemp");
		
	}

	public List<String> selectPeriod() {
		return (List<String>) list("DevPlanDAO.selectPeriod");
	}

	public List<HashMap<String, String>> selectUserDevStats(HashMap<String, String> test) {
		return (List<HashMap<String, String>>) list("DevPlanDAO.selectUserDevStats",test);
	}
	
	public List<?> selectDevPlanByMainStats() {
		return list("DevPlanDAO.selectDevPlanByMainStats");
	}
	
	public List<?> selectSysAllByStats() {
		return list("DevPlanDAO.selectSysAllByStats");
	}
	
	public List<?> selectSysByStats() {
		return list("DevPlanDAO.selectSysByStats");
	}

	public List<HashMap<String, String>> selectUserDevWeekStats(HashMap<String, String> test) {
		return (List<HashMap<String, String>>) list("DevPlanDAO.selectUserDevWeekStats",test);
	}

	public List<String> selectPeriodWeek() {
		return (List<String>) list("DevPlanDAO.selectPeriodWeek");
	}

	public List<HashMap<String, String>> selectUserPlanWeekStats(HashMap<String, String> test) {
		return (List<HashMap<String, String>>) list("DevPlanDAO.selectUserPlanWeekStats",test);
	}

	public List<String> selectTaskGbList() {
		return (List<String>) list("DevPlanDAO.selectTaskGbList");
	}

	public List<HashMap<String, String>> selectTaskPlanWeekStats(HashMap<String, String> taskPlan) {
		return (List<HashMap<String, String>>) list("DevPlanDAO.selectTaskPlanWeekStats",taskPlan);
	}
}
