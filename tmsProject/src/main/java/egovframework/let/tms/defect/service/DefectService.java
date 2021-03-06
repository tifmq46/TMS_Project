package egovframework.let.tms.defect.service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface DefectService {
	
	public List<?> selectDefect(DefectDefaultVO searchVO, int status) throws Exception;;
	
	public int selectDefectTotCnt(DefectDefaultVO searchVO, int status) throws Exception;;
	
	public List<?> selectOneDefect(DefectVO defectVO) throws Exception;;	
	
	public int selectDefectIdSq();
	
	public List<?> selectTaskGb();
	
	public List<?> selectDefectGb();
	
	public List<?> selectActionSt();
	
	public List<?> selectUser(int status);
	
	public List<?> searchDefect(DefectDefaultVO searchVO);
	
	public HashMap<String, Object> selectActionComplete(DefectDefaultVO searchVO);
	
	public int selectActionNotComplete();
	
	public void insertDefect(DefectVO defectVO);
	
	public int updateDefect(DefectVO defectVO);
	
	public int deleteDefect(DefectVO defectVO);
	
	public void insertDefectImageMap(Map<String, Object> hmap);
	
	public Map<String, Object> selectDefectImg(String defectIdSq);
	
	public Map<String, Object> downloadDefectImg(String defectIdSq);
	
	public DefectFileVO selectDefectImgOne(int defectIdSq);
	
	public void deleteDefectImg(int defectIdSq);
	
	public int selectDefectIdSqToFileTb(int defectIdSq);
	
	public HashMap<String, Object> selectDefectStats();
	
	public List<?> selectPjtMember();
	
	public List<?> selectTaskByActionProgression();
	
	public List<?> selectTaskByDefectGbCnt();
	
	public List<?> selectTaskByActionStCnt();
	
	public List<?> selectDayByDefectCnt();
	
	public List<?> selectMonthByDefectCnt();
	
	public List<HashMap<String,String>> selectTaskByStats(String taskGbList);
	
	public List<String> selectTaskGbByDefect();
	
	public List<String> selectPgIdByDefect();
	
	public List<HashMap<String,String>> selectPgByStats(String pgIdList);
	
	public List<String> selectUserTestIdByDefect();
	
	public List<HashMap<String,String>> selectUserTestByStats(String userTestList);
	
	public List<String> selectUserDevIdByDefect();
	
	public List<HashMap<String,String>> selectUserDevByStats(String userDevList);

	public String selectUserNm(String userTestId);
	
	public void updateDefectIdSq();
	
	public List<EgovMap> selectSysByDefectCnt();

	public List<?> selectTaskByDefectCnt(String sysNm);
	
	public List<?> selectUserByDefectCnt();
	
	public HashMap<String, Object> selectSysAllByActionCnt();
	
	public List<EgovMap> selectSysByActionCnt();

	public List<?> selectTaskByActionCnt();
	
	public List<?> selectTaskByActionCntForSysGb(String sysGb);
	
	public List<EgovMap> selectSysByDefectCntAll();
	
	public List<?> selectSysByMainStats();
	
	public List<EgovMap> selectUserDevPgIdByStats();
	
	public List<EgovMap> selectSysGbByStats();
}
