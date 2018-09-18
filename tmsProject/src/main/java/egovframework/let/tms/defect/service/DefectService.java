package egovframework.let.tms.defect.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface DefectService {
	
	public List<?> selectDefect(DefectDefaultVO searchVO) throws Exception;;
	
	public int selectDefectTotCnt() throws Exception;;
	
	public List<?> selectOneDefect(DefectVO defectVO) throws Exception;;	
	
	public int selectDefectIdSq();
	
	public List<?> selectTaskGb();
	
	public List<?> selectDefectGb();
	
	public List<?> selectActionSt();
	
	public List<?> selectUser();
	
	public List<?> searchDefect(DefectDefaultVO searchVO);
	
	public int selectActionComplete();
	
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
}
