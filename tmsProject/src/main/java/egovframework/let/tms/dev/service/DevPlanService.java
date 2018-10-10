package egovframework.let.tms.dev.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface DevPlanService {
	
	/**
	 * 개발계획을 등록한다.
	 * @param vo - 등록할 정보가 담긴 DevPlanVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	public void insertDevPlan(DevPlanVO vo) throws Exception;

	/**
	 * 개발계획을 수정한다.
	 * @param vo - 수정할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateDevPlan(DevPlanVO vo) throws Exception;

	/**
	 * 개발계획을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void deleteDevPlan(DevPlanVO vo) throws Exception;

	/**
	 * 개발계획에 대한 상세정보를 조회한다.
	 * @param vo - 조회할 정보가 담긴 DevPlanVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public List<?> selectDevPlan(DevPlanDefaultVO defaultVO) throws Exception; 

	/**
	 * 개발계획 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<HashMap<String,String>> selectDevPlans(DevPlanDefaultVO searchVO) throws Exception;
	
	
	/**
	 * 구분에 따른 목록을 조회
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	public List<?> selectDevPlansByCode(DevPlanDefaultVO searchVO) throws Exception;
	
	
	/**
	 * 미리보기 정보 조회 
	 * @param defaultVO
	 * @return
	 * @throws Exception
	 */
	public DevPlanDefaultVO selectDevPlanPreview(DevPlanDefaultVO defaultVO) throws Exception;


	public int selectDevPlanListTotCnt(DevPlanDefaultVO searchVO)throws Exception;
	
	public List<?> selectDevResultList(DevPlanDefaultVO searchVO) throws Exception;
	
	/**
	 * 개발결과에 대한 상세정보를 조회한다.
	 * @param vo - 조회할 정보가 담긴 DevPlanVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public List<?> selectDevResult(DevPlanDefaultVO defaultVO) throws Exception; 
	

	/**
	 * 개발결과를 수정한다.
	 * @param vo - 수정할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void updateDevResult(DevPlanVO vo) throws Exception;

	/**
	 * 개발결과를 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void deleteDevResult(DevPlanVO vo) throws Exception;
	
	/**
	 * 개발통계 기간 조회
	 */
	public List<?> selectDevPeriod() throws Exception;

	public void insertWeek(int i);

	public void deleteWeek()throws Exception;

	public String ifNullDevPlan(String b);

	public int selectDevResultListTotCnt(DevPlanDefaultVO searchVO)throws Exception;

	public List<HashMap<String, String>> selectDevCurrent(DevPlanDefaultVO searchVO);

	public void updateRate(DevPlanDefaultVO searchVO);

	public HashMap<String, String> DevPlanAvg(DevPlanDefaultVO searchVO);

	public int selectDevCurrentTotCnt(DevPlanDefaultVO searchVO);

	public void insertDates(String date);

	public void deleteDates();

	public void insertDayDiff(DevPlanDefaultVO searchVO);

	public List<String> selectUserList();

	public List<HashMap<String, String>> selectTempList(String a);

	public void insertTemp(TempVO t);

	public void deleteTemp();

	public List<String> selectPeriod();

	public List<HashMap<String, String>> selectUserDevStats(String period);
	
	public List<?> selectDevPlanByMainStats();
	
}
