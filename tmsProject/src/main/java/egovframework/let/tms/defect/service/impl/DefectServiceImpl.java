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
import egovframework.rte.psl.dataaccess.util.EgovMap;

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
	public List<?> selectDefect(DefectDefaultVO searchVO, int status) {
		return defectDAO.selectDefect(searchVO, status);
	}


	@Override
	public int selectDefectTotCnt(DefectDefaultVO searchVO, int status) {
		// TODO Auto-generated method stub
		return defectDAO.selectDefectTotCnt(searchVO, status);
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
	public int selectActionComplete(DefectDefaultVO searchVO) {
		// TODO Auto-generated method stub
		return defectDAO.selectActionComplete(searchVO);
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
	public List<HashMap<String,String>> selectTaskByStats(String taskGbList) {
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
	public List<HashMap<String,String>> selectPgByStats(String pgIdList) {
		// TODO Auto-generated method stub
		return defectDAO.selectPgByStats(pgIdList);
	}


	@Override
	public List<String> selectUserTestIdByDefect() {
		// TODO Auto-generated method stub
		return defectDAO.selectUserTestIdByDefect();
	}


	@Override
	public List<HashMap<String,String>> selectUserTestByStats(String userTestList) {
		// TODO Auto-generated method stub
		return defectDAO.selectUserTestByStats(userTestList);
	}


	@Override
	public List<String> selectUserDevIdByDefect() {
		// TODO Auto-generated method stub
		return defectDAO.selectUserDevIdByDefect();
	}


	@Override
	public List<HashMap<String,String>> selectUserDevByStats(String userDevList) {
		// TODO Auto-generated method stub
		return defectDAO.selectUserDevByStats(userDevList);
	}


	@Override
	public String selectUserNm(String userTestId) {
		// TODO Auto-generated method stub
		return defectDAO.selectUserNm(userTestId);
	}


	@Override
	public void updateDefectIdSq() {
		// TODO Auto-generated method stub
		defectDAO.updateDefectIdSq();
	}


	@Override
	public List<EgovMap> selectSysByDefectCnt() {
		// TODO Auto-generated method stub
		return defectDAO.selectSysByDefectCnt();
	}


	@Override
	public List<?> selectTaskByDefectCnt(String sysNm) {
		// TODO Auto-generated method stub
		return defectDAO.selectTaskByDefectCnt(sysNm);
	}


	@Override
	public List<?> selectUserByDefectCnt() {
		// TODO Auto-generated method stub
		return defectDAO.selectUserByDefectCnt();
	}


	@Override
	public HashMap<String, Object> selectSysAllByActionCnt() {
		// TODO Auto-generated method stub
		return defectDAO.selectSysAllByActionCnt();
	}


	@Override
	public List<EgovMap> selectSysByActionCnt() {
		// TODO Auto-generated method stub
		return defectDAO.selectSysByActionCnt();
	}


	@Override
	public List<?> selectTaskByActionCnt() {
		// TODO Auto-generated method stub
		return defectDAO.selectTaskByActionCnt();
	}


	@Override
	public List<?> selectTaskByActionCntForSysGb(String sysGb) {
		// TODO Auto-generated method stub
		return defectDAO.selectTaskByActionCntForSysGb(sysGb);
	}


	@Override
	public List<EgovMap> selectSysByDefectCntAll() {
		// TODO Auto-generated method stub
		return defectDAO.selectSysByDefectCntAll();
	}


	@Override
	public List<?> selectSysByMainStats() {
		// TODO Auto-generated method stub
		return defectDAO.selectSysByMainStats();
	}


	@Override
	public List<EgovMap> selectUserDevPgIdByStats() {
		// TODO Auto-generated method stub
		return defectDAO.selectUserDevPgIdByStats();
	}


	@Override
	public List<EgovMap> selectSysGbByStats() {
		// TODO Auto-generated method stub
		return defectDAO.selectSysGbByStats();
	}


}
