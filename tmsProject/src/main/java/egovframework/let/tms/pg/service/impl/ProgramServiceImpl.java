package egovframework.let.tms.pg.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.let.tms.pg.service.PgCurrentVO;
import egovframework.let.tms.pg.service.ProgramDefaultVO;
import egovframework.let.tms.pg.service.ProgramService;
import egovframework.let.tms.pg.service.ProgramVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("ProgramService")
public class ProgramServiceImpl extends EgovAbstractServiceImpl implements ProgramService{

		/** DevPlanDAO */
	
	
	/*TODO ibatis 사용*/
	@Resource(name = "ProgramDAO")
	private ProgramDAO ProgramDAO;
	
	
	/*TODO mybatis 사용
	@Resource(name="ProgramMapper")
	private ProgramMapper ProgramDAO;
	*/
	
	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;
	
	@Override
	public void insertPg(ProgramVO vo) throws Exception {
		// TODO Auto-generated method stub
		ProgramDAO.insertPg(vo);
	}

	@Override
	public void updatePg(ProgramVO vo) throws Exception {
		// TODO Auto-generated method stub
		ProgramDAO.updatePg(vo);
		
	}

	@Override
	public void deletePg(ProgramVO vo) throws Exception {
		// TODO Auto-generated method stub
		ProgramDAO.deletePg(vo);
	}

	@Override
	public ProgramVO selectPg(ProgramVO vo) throws Exception {
		ProgramVO resultVO = ProgramDAO.selectPg(vo);
		if(resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}

	@Override
	public List<?> selectPgList(ProgramDefaultVO searchVO) throws Exception {
		return ProgramDAO.selectPgList(searchVO);
	}
	
	
	@Override
	public ProgramVO selectProgramInf(ProgramVO vo) throws Exception {
		ProgramVO resultVO = ProgramDAO.selectProgramInf(vo);
		if(resultVO == null)
			throw processException("info.nodata.msg");
		return resultVO;
	}
	
	@Override
	public int selectPgListTotCnt(ProgramDefaultVO searchVO) {
		return ProgramDAO.selectPgListTotCnt(searchVO);
	}
	
	@Override
	public int selectTotCntUseYn(ProgramDefaultVO searchVO) {
		return ProgramDAO.selectTotCntUseYn(searchVO);
	}
	
	@Override
	public List<?> selectPgCurrentList(ProgramVO searchVO) throws Exception {
		return ProgramDAO.selectPgCurrentList(searchVO);
	}
	
	@Override
	public List<?> selectPgCurrentExcelList(ProgramDefaultVO searchVO) throws Exception {
		return ProgramDAO.selectPgCurrentExcelList(searchVO);
	}

	@Override
	public int count1(String i) throws Exception {
		// TODO Auto-generated method stub
		return ProgramDAO.count1(i);
	}
	@Override
	public int count2(String i) throws Exception {
		// TODO Auto-generated method stub
		return ProgramDAO.count2(i);
	}
	@Override
	public int count3(String i) throws Exception {
		// TODO Auto-generated method stub
		return ProgramDAO.count3(i);
	}
	
}
