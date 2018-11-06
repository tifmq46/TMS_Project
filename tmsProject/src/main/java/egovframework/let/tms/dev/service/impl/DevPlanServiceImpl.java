package egovframework.let.tms.dev.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.let.tms.dev.service.DevPlanDefaultVO;
import egovframework.let.tms.dev.service.DevPlanService;
import egovframework.let.tms.dev.service.DevPlanVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("devPlanService")
public class DevPlanServiceImpl extends EgovAbstractServiceImpl implements DevPlanService{

	private static final Logger LOGGER = LoggerFactory.getLogger(DevPlanServiceImpl.class);
	
	/** DevPlanDAO */
	
	// TODO ibatis 사용
	@Resource(name = "devPlanDAO")
	private DevPlanDAO devPlanDAO;
	
	
	/*TODO mybatis 사용*/
	/*@Resource(name="devPlanMapper")
	private DevPlanMapper devPlanDAO;*/

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;
	
	@Override
	public void insertDevPlan(DevPlanVO vo) throws Exception {
		devPlanDAO.insertDevPlan(vo);
	}

	@Override
	public void updateDevPlan(DevPlanVO vo) throws Exception {
		devPlanDAO.updateDevPlan(vo);
		
	}

	@Override
	public void deleteDevPlan(DevPlanVO vo) throws Exception {
		devPlanDAO.deleteDevPlan(vo);
	}

	/**
	 * 목록 조회
	 */

	@Override
	public List<HashMap<String,String>> selectDevPlans(DevPlanDefaultVO searchVO) throws Exception {
		return devPlanDAO.selectDevPlans(searchVO);
		
	}
	/**
	 * 미리보기 정보 조회
	 */
	
	public DevPlanDefaultVO selectDevPlanPreview(DevPlanDefaultVO defaultVO) throws Exception{
		
		//DevPlanDefaultVO vo = new DevPlanDefaultVO();
		
		//vo = devPlanDAO.selectDevPlanPreview(defaultVO);
		
		return defaultVO;
	}
	
	public List<?> selectDevPlansByCode(DevPlanDefaultVO searchVO) throws Exception{
		return devPlanDAO.selectDevPlansByCode(searchVO);
	}
	
	
	
	@Override
	public int selectDevPlanListTotCnt(DevPlanDefaultVO searchVO) throws Exception {
		return devPlanDAO.selectDevPlanListTotCnt(searchVO);
	}


	@Override
	public List<HashMap<String, String>> selectDevResultList(DevPlanDefaultVO searchVO) throws Exception {
		return devPlanDAO.selectDevResultList(searchVO);
	}

	@Override
	public String selectSTART() throws Exception {
		return devPlanDAO.selectSTART();
	}
	
	@Override
	public String selectEND() throws Exception {
		return devPlanDAO.selectEND();
	}

	@Override
	public void updateDevResult(DevPlanVO vo) throws Exception {
		devPlanDAO.updateDevResult(vo);
		
	}
	
	@Override
	public void deleteDevResult(DevPlanVO vo) throws Exception {
		devPlanDAO.deleteDevResult(vo);
		
	}
	
	@Override
	public void insertWeek(int i) {
		devPlanDAO.insertWeek(i);
		
	}

	@Override
	public void deleteWeek() throws Exception {
		devPlanDAO.deleteWeek();
	}

	@Override
	public String ifNullDevPlan(String b) {
		return devPlanDAO.ifNullDevPlan(b);
	}

	@Override
	public int selectDevResultListTotCnt(DevPlanDefaultVO searchVO) throws Exception {
		
		return devPlanDAO.selectDevResultListTotCnt(searchVO);
	}

	@Override
	public List<HashMap<String, String>> selectDevCurrent(DevPlanDefaultVO searchVO) {
		return devPlanDAO.selectDevCurrent(searchVO);
	}

	@Override
	public void updateRate(DevPlanDefaultVO searchVO) {
		devPlanDAO.updateRate(searchVO);
		
	}

	@Override
	public HashMap<String,String> DevPlanAvg(DevPlanDefaultVO searchVO) {
		return devPlanDAO.DevPlanAvg(searchVO);
	}

	@Override
	public int selectDevCurrentTotCnt(DevPlanDefaultVO searchVO) {
		return devPlanDAO.selectDevCurrentTotCnt(searchVO);
	}

	@Override
	public void insertDates(String dates) {
		devPlanDAO.insertDates(dates);
	}

	@Override
	public void deleteDates() {
		devPlanDAO.deleteDates();
		
	}

	@Override
	public void insertDayDiff(DevPlanDefaultVO searchVO) {
		devPlanDAO.insertDayDiff(searchVO);
		
	}

	@Override
	public List<String> selectUserList() {
		return devPlanDAO.selectUserList();
	}

	@Override
	public List<String> selectPeriod() {
		return devPlanDAO.selectPeriod();
	}

	@Override
	public List<?> selectDevPlanByMainStats() {
		// TODO Auto-generated method stub
		return devPlanDAO.selectDevPlanByMainStats();
	}

	@Override
	public List<?> selectSysByStats() {
		// TODO Auto-generated method stub
		return devPlanDAO.selectSysByStats();
	}

	@Override
	public List<String> selectPeriodWeek() {
		return devPlanDAO.selectPeriodWeek();
	}

	@Override
	public List<HashMap<String, String>> selectUserWeekStats(HashMap<String, String> test) {
		return devPlanDAO.selectUserWeekStats(test);
	}

	@Override
	public int selectSysGbCnt() {
		return devPlanDAO.selectSysGbCnt();
	}

	@Override
	public List<String> selectTaskGbList() {
		return devPlanDAO.selectTaskGbList();
	}

	@Override
	public List<HashMap<String, String>> selectTaskWeekStats(HashMap<String, String> taskPlan) {
		return devPlanDAO.selectTaskWeekStats(taskPlan);
	}

	@Override
	public List<String> selectPeriodMonthWeek() {
		return devPlanDAO.selectPeriodMonthWeek();
	}
	
	@Override
	public List<HashMap<String, String>> selectThisWeekStats(HashMap<String, String> type) {
		return devPlanDAO.selectThisWeekStats(type);
	}

	@Override
	public List<HashMap<String, String>> selectTotalStats(HashMap<String, String> type) {
		return devPlanDAO.selectTotalStats(type);
	}

	@Override
	public List<HashMap<String, String>> selectAccumulateStats(HashMap<String, String> type) {
		return devPlanDAO.selectAccumulateStats(type);

	}

	@Override
	public List<EgovMap> selectStatsTable() {
		return devPlanDAO.selectStatsTable();
	}

	@Override
	public List<HashMap<String, String>> searchBySys(String s) {
		return devPlanDAO.searchBySys(s);
	}

	@Override
	public HashMap<String, Object> selectTotalByProgressRate() {
		return devPlanDAO.selectTotalByProgressRate();
	}

	@Override
	public List<?> selectSysByProgressRate() {
		return devPlanDAO.selectSysByProgressRate();
	}

	@Override
	public List<?> selectTaskByProgressRate(String sysGb) {
		return devPlanDAO.selectTaskByProgressRate(sysGb);
	}

	@Override
	public List<?> selectTaskTotalProgressRate() {
		return devPlanDAO.selectTaskTotalProgressRate();
	}

	@Override
	public List<?> selectUserDevByDevStats() {
		return devPlanDAO.selectUserDevByDevStats();
	}

}
