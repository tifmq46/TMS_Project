package egovframework.let.tms.dev.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		LOGGER.debug(vo.toString());

		/** ID Generation Service */
		//String id = egovIdGnrService.getNextStringId();
		vo.setPgId(vo.getPgId());
		LOGGER.debug(vo.toString());

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
	public DevPlanDefaultVO selectDevPlan(DevPlanDefaultVO defaultVO) throws Exception {
		DevPlanDefaultVO vo = devPlanDAO.selectDevPlan(defaultVO);

		return vo;
	}
	
	/**
	 * 목록 조회
	 */

	@Override
	public Map<String,Object> selectDevPlans(DevPlanDefaultVO defaultVO) throws Exception {
		List<DevPlanDefaultVO> result = devPlanDAO.selectDevPlans(defaultVO);
		int cnt = devPlanDAO.selectDevPlanListTotCnt(defaultVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
		
		return map;
		
	}
	/**
	 * 미리보기 정보 조회
	 */
	
	public DevPlanDefaultVO selectDevPlanPreview(DevPlanDefaultVO defaultVO) throws Exception{
		
		DevPlanDefaultVO vo = new DevPlanDefaultVO();
		
		vo = devPlanDAO.selectDevPlanPreview(defaultVO);
		
		return vo;
	}
	
	@SuppressWarnings("unchecked")
	public List<DevPlanDefaultVO> selectDevPlansByCode(DevPlanDefaultVO defaultVO) throws Exception{
		return devPlanDAO.selectDevPlansByCode(defaultVO);
	}
	
	
	
	@Override
	public int selectDevPlanListTotCnt(DevPlanDefaultVO searchVO) throws Exception {
		return devPlanDAO.selectDevPlanListTotCnt(searchVO);
	}


	@Override
	public List<?> selectDevResultList(DevPlanDefaultVO searchVO) throws Exception {
		return devPlanDAO.selectDevResultList(searchVO);
	}
	
}
