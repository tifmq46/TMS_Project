package egovframework.let.tms.dev.service.impl;

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
	public DevPlanDefaultVO selectDevPlan(DevPlanDefaultVO defaultVO) throws Exception {
		return (DevPlanDefaultVO) select("DevPlanDAO.selectDevPlan", defaultVO);
	}

	/**
	 * 개발계획 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 목록
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	public List<DevPlanDefaultVO> selectDevPlans(DevPlanDefaultVO defaultVO) throws Exception {
		return (List<DevPlanDefaultVO>) list("DevPlanDAO.selectDevPlans", defaultVO);
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

	public DevPlanDefaultVO selectDevPlanPreview(DevPlanDefaultVO defaultVO) throws Exception {
		return null;
	    }
	
	@SuppressWarnings("unchecked")
    public List<DevPlanDefaultVO> selectDevPlansByCode(DevPlanDefaultVO defaultVO) throws Exception {
		return (List<DevPlanDefaultVO>) list("DevPlanDAO.selectDevPlansByCode", defaultVO);
    }
	
	public List<?> selectDevResultList(DevPlanDefaultVO searchVO) throws Exception {
		return list("devPlanDAO.selectDevResultList", searchVO);
	}
	
	
}
