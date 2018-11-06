package egovframework.let.tms.pg.service;

import java.util.HashMap;
import java.util.List;


public interface ProgramService {
	
	/**
	 * 개발계획을 등록한다.
	 * @param vo - 등록할 정보가 담긴 DevPlanVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	void insertPg(ProgramVO vo) throws Exception;

	/**
	 * 개발계획을 수정한다.
	 * @param vo - 수정할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	void updatePg(ProgramVO vo) throws Exception;

	/**
	 * 개발계획을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	void deletePg(ProgramVO vo) throws Exception;

	void full_deletePg() throws Exception;
	/**
	 * 개발계획을 조회한다.
	 * @param vo - 조회할 정보가 담긴 DevPlanVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	ProgramVO selectPg(ProgramVO vo) throws Exception;

	/**
	 * 개발계획 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	List<?> selectPgList(ProgramDefaultVO searchVO) throws Exception;

	
	ProgramVO selectProgramInf(ProgramVO vo) throws Exception;
	
	/**
	 * 개발계획 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	int selectPgListTotCnt(ProgramDefaultVO searchVO);
	
	int selectTotCntUseYn(ProgramDefaultVO searchVO);

	List<?> selectPgCurrentList(ProgramVO searchVO) throws Exception;
	
	List<?> selectPgCurrentExcelList(ProgramDefaultVO searchVO) throws Exception;
	
	int count1(String i) throws Exception;
	int count2(String i) throws Exception;
	int count3(String i) throws Exception;
}
