package egovframework.let.tms.pg.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.tms.pg.service.PgCurrentVO;
import egovframework.let.tms.pg.service.ProgramDefaultVO;
import egovframework.let.tms.pg.service.ProgramVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("ProgramDAO")
public class ProgramDAO extends EgovAbstractDAO{
	/**
	 * 개발계획을 등록한다.
	 * @param vo - 등록할 정보가 담긴 DevPlanVO
	 * @return등 등록 결과
	 * @exception Exception
	 */
	public void insertPg(ProgramVO vo) throws Exception {
		insert("ProgramDAO.insertPg", vo);
	}

	/**
	 * 개발계획을 수정한다.
	 * @param vo - 수정할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void updatePg(ProgramVO vo) throws Exception {
		update("ProgramDAO.updatePg", vo);
	}

	/**
	 * 개발계획을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 DevPlanVO
	 * @return void형
	 * @exception Exception
	 */
	public void deletePg(ProgramVO vo) throws Exception {
		delete("ProgramDAO.deletePg", vo);
	}

	/**
	 * 개발계획을 조회한다.
	 * @param vo - 조회할 정보가 담긴 DevPlanVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	public ProgramVO selectPg(ProgramVO vo) throws Exception {
		return (ProgramVO) select("ProgramDAO.selectPg", vo);
	}

	/**
	 * 개발계획 목록을 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 목록
	 * @exception Exception
	 */
	public List<?> selectPgList(ProgramDefaultVO searchVO) throws Exception {
		return list("ProgramDAO.selectPgList", searchVO);
	}

	
	public ProgramVO selectProgramInf(ProgramVO vo) throws Exception {
		return (ProgramVO) select("ProgramDAO.selectProgramInf", vo);
	}
	
	/**
	 * 개발계획 총 갯수를 조회한다.
	 * @param searchMap - 조회할 정보가 담긴 Map
	 * @return 글 총 갯수
	 * @exception
	 */
	public int selectPgListTotCnt(ProgramDefaultVO searchVO) {
		return (Integer) select("ProgramDAO.selectPgListTotCnt", searchVO);
	}
	
	public int selectPgCurrentTotCnt() {
		return (Integer) select("ProgramDAO.selectPgCurrentTotCnt");
	}

	public List<?> selectPgCurrentList(ProgramVO searchVO) throws Exception {
		return list("ProgramDAO.selectPgCurrentList", searchVO);
	}
	
	public List<?> selectPgCurrentExcelList(ProgramDefaultVO searchVO) throws Exception {
		return list("ProgramDAO.selectPgCurrentExcelList", searchVO);
	}
	
	public int count1(String i) throws Exception {
		return (int) select("ProgramDAO.count1", i);
	}
	public int count2(String i) throws Exception {
		return (int) select("ProgramDAO.count2", i);
	}
	public int count3(String i) throws Exception {
		return (int) select("ProgramDAO.count3", i);
	}
}
