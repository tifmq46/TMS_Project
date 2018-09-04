package egovframework.let.tms.dev.service.impl;

import java.util.List;

import egovframework.let.tms.dev.service.DevPlanDefaultVO;
import egovframework.let.tms.dev.service.DevPlanVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("devPlanMapper")
public interface DevPlanMapper {
	
	String insertDevPlan(DevPlanVO vo) throws Exception;

	/**
	 * 글을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SampleVO
	 * @return void형
	 * @exception Exception
	 */
	void updateDevPlan(DevPlanVO vo) throws Exception;

	/**
	 * 글을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SampleVO
	 * @return void형
	 * @exception Exception
	 */
	void deleteDevPlan(DevPlanVO vo) throws Exception;

	/**
	 * 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SampleVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	DevPlanVO selectDevPlan(DevPlanVO vo) throws Exception;

	/**
	 * 글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectDevPlanList(DevPlanDefaultVO searchVO) throws Exception;

	/**
	 * 글 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	int selectDevPlanListTotCnt(DevPlanDefaultVO searchVO);


	/**
	 * 글 목록을 조회한다.
	 * @param searchVO - 개발결과 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectDevResultList(DevPlanDefaultVO searchVO) throws Exception;
	
}