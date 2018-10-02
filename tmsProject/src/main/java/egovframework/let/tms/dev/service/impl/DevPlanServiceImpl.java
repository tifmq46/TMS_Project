package egovframework.let.tms.dev.service.impl;

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
		/*LOGGER.debug(vo.toString());

		*//** ID Generation Service *//*
		//String id = egovIdGnrService.getNextStringId();
		vo.setPgId(vo.getPgId());
		LOGGER.debug(vo.toString());

		devPlanDAO.insertDevPlan(vo);*/
		
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
	 * 상세 정보 조회
	 */
	@Override
	public List<?> selectDevPlan(DevPlanDefaultVO defaultVO) throws Exception {
		return devPlanDAO.selectDevPlan(defaultVO);
	}
	
	/**
	 * 목록 조회
	 */

	@Override
	public List<?> selectDevPlans(DevPlanDefaultVO searchVO) throws Exception {
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
	public List<?> selectDevResultList(DevPlanDefaultVO searchVO) throws Exception {
		return devPlanDAO.selectDevResultList(searchVO);
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
	public List<?> selectDevResult(DevPlanDefaultVO defaultVO) throws Exception {
		return devPlanDAO.selectDevResult(defaultVO);
	}

	@Override
	public List<?> selectDevPeriod() throws Exception {
		return devPlanDAO.selectDevPeriod();
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
	
}
