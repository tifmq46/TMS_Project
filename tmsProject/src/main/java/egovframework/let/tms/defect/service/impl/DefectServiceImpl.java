package egovframework.let.tms.defect.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.tms.defect.service.DefectDefaultVO;
import egovframework.let.tms.defect.service.DefectFileVO;
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

	@Override
	public List<?> selectUser() {
		// TODO Auto-generated method stub
		return defectDAO.selectUser();
	}


	@Override
	public List<?> searchDefect(DefectDefaultVO searchVO) {
		// TODO Auto-generated method stub
		return defectDAO.searchDefect(searchVO);
	}


	@Override
	public int selectActionComplete() {
		// TODO Auto-generated method stub
		return defectDAO.selectActionComplete();
	}


	@Override
	public int selectActionNotComplete() {
		// TODO Auto-generated method stub
		return defectDAO.selectActionNotComplete();
	}


	@Override
	public Map<String, Object> selectDefectImg(String defectIdSq) {
		// TODO Auto-generated method stub
		return defectDAO.selectDefectImg(defectIdSq);
	}


	@Override
	public void insertDefectImageMap(Map<String, Object> hmap) {
		defectDAO.insertDefectImageMap(hmap);
		
	}


	@Override
	public Map<String, Object> downloadDefectImg(String defectIdSq) {
		// TODO Auto-generated method stub
		return defectDAO.downloadDefectImg(defectIdSq);
	}


	@Override
	public DefectFileVO selectDefectImgOne(int defectIdSq) {
		// TODO Auto-generated method stub
		return defectDAO.selectDefectImgOne(defectIdSq);
	}


	@Override
	public void deleteDefectImg(int defectIdSq) {
		// TODO Auto-generated method stub
		defectDAO.deleteDefectImg(defectIdSq);
	}


	@Override
	public int selectDefectIdSqToFileTb(int defectIdSq) {
		// TODO Auto-generated method stub
		return defectDAO.selectDefectIdSqToFileTb(defectIdSq);
	}


	@Override
	public HashMap<String, Object> selectDefectStats() {
		// TODO Auto-generated method stub
		return defectDAO.selectDefectStats();
	}


	@Override
	public List<?> selectPjtMember() {
		// TODO Auto-generated method stub
		return defectDAO.selectPjtMember();
	}


	@Override
	public List<?> selectTaskByActionProgression() {
		// TODO Auto-generated method stub
		return defectDAO.selectTaskByActionProgression();
	}


	@Override
	public List<?> selectTaskByDefectGbCnt() {
		// TODO Auto-generated method stub
		return defectDAO.selectTaskByDefectGbCnt();
	}


	@Override
	public List<?> selectTaskByActionStCnt() {
		// TODO Auto-generated method stub
		return defectDAO.selectTaskByActionStCnt();
	}


	@Override
	public List<?> selectDayByDefectCnt() {
		// TODO Auto-generated method stub
		return defectDAO.selectDayByDefectCnt();
	}
	
	public List<?> selectMonthByDefectCnt(){
		return defectDAO.selectMonthByDefectCnt();
	}


	@Override
	public List<String> selectTaskByStats(String taskGbList) {
		// TODO Auto-generated method stub
		return defectDAO.selectTaskByStats(taskGbList);
	}


	@Override
	public List<String> selectTaskGbByDefect() {
		// TODO Auto-generated method stub
		return defectDAO.selectTaskGbByDefect();
	}


	@Override
	public List<String> selectPgIdByDefect() {
		// TODO Auto-generated method stub
		return defectDAO.selectPgIdByDefect();
	}


	@Override
	public List<String> selectPgByStats(String pgIdList) {
		// TODO Auto-generated method stub
		return defectDAO.selectPgByStats(pgIdList);
	}


	@Override
	public List<String> selectUserTestIdByDefect() {
		// TODO Auto-generated method stub
		return defectDAO.selectUserTestIdByDefect();
	}


	@Override
	public List<String> selectUserTestByStats(String userTestList) {
		// TODO Auto-generated method stub
		return defectDAO.selectUserTestByStats(userTestList);
	}


	@Override
	public List<String> selectUserDevIdByDefect() {
		// TODO Auto-generated method stub
		return defectDAO.selectUserDevIdByDefect();
	}


	@Override
	public List<String> selectUserDevByStats(String userDevList) {
		// TODO Auto-generated method stub
		return defectDAO.selectUserDevByStats(userDevList);
	}

}
