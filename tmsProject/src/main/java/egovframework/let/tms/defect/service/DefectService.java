package egovframework.let.tms.defect.service;

import java.util.List;

public interface DefectService {
	
	public List<?> selectDefect(DefectDefaultVO searchVO) throws Exception;;
	
	public int selectDefectTotCnt(DefectDefaultVO searchVO) throws Exception;;
	
	public List<?> selectOneDefect(DefectVO defectVO) throws Exception;;	
	
	public int selectDefectIdSq();
	
	public List<?> selectDefectGb();
	
	public void insertDefect(DefectVO defectVO);
	
	public int updateDefect(DefectVO defectVO);
	
	public int deleteDefect(DefectVO defectVO);
}
