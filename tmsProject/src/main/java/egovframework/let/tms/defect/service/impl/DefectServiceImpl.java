package egovframework.let.tms.defect.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.tms.defect.service.DefectDefaultVO;
import egovframework.let.tms.defect.service.DefectService;
import egovframework.let.tms.defect.service.DefectVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("defectService")
public class DefectServiceImpl extends EgovAbstractServiceImpl implements DefectService{

	/** DefectDAO */
	
	// TODO ibatis 사용
	@Resource(name = "defectDAO")
	private DefectDAO defectDAO;
	

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;


	@Override
	public List<?> selectDefect(DefectDefaultVO searchVO) {
		return defectDAO.selectDefect(searchVO);
	}


	@Override
	public int selectDefectTotCnt(DefectDefaultVO searchVO) {
		// TODO Auto-generated method stub
		return defectDAO.selectDefectTotCnt(searchVO);
	}


	@Override
	public void insertDefect(DefectVO defectVO) {
		// TODO Auto-generated method stub
		defectDAO.insertDefect(defectVO);
	}


	@Override
	public List<?> selectOneDefect(DefectVO defectVO) {
		// TODO Auto-generated method stub
		return defectDAO.selectOneDefect(defectVO);
	}


	@Override
	public int updateDefect(DefectVO defectVO) {
		// TODO Auto-generated method stub
		return defectDAO.updateDefect(defectVO);		
	}


	@Override
	public int deleteDefect(DefectVO defectVO) {
		// TODO Auto-generated method stub
		return defectDAO.deleteDefect(defectVO);
	}


	@Override
	public int selectDefectIdSq() {
		// TODO Auto-generated method stub
		return defectDAO.selectDefectIdSq();
	}


	@Override
	public List<?> selectDefectGb() {
		// TODO Auto-generated method stub
		return defectDAO.selectDefectGb();
	}


	@Override
	public List<?> selectActionSt() {
		// TODO Auto-generated method stub
		return defectDAO.selectActionSt();
	}


	@Override
	public List<?> selectTaskGb() {
		// TODO Auto-generated method stub
		return defectDAO.selectTaskGb();
	}
	
}
