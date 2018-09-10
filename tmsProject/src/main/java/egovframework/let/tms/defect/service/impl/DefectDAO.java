package egovframework.let.tms.defect.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.let.tms.defect.service.DefectDefaultVO;
import egovframework.let.tms.defect.service.DefectVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("defectDAO")
public class DefectDAO extends EgovAbstractDAO{
	
	/*@SuppressWarnings("unchecked")
	public List<DefectDefaultVO> selectDefect(DefectDefaultVO searchVO) {
		return (List<DefectDefaultVO>) list("defectDAO.selectDefect", searchVO);
	}*/
	public List<?> selectDefect(DefectDefaultVO searchVO) {
		return list("defectDAO.selectDefect", searchVO);
	}
	
	public int selectDefectTotCnt(DefectDefaultVO searchVO) {
		return (int) select("defectDAO.selectDefectTotCnt", searchVO);
	}
	
	public int selectDefectIdSq(){
		return (int) select("defectDAO.selectDefectIdSq");
	}
	
	public void insertDefect(DefectVO defectVO) {
		insert("defectDAO.insertDefect", defectVO);
	}
	
	public List<?> selectOneDefect(DefectVO defectVO){
		return list("defectDAO.selectOneDefect", defectVO);
	}
	
	public int updateDefect(DefectVO defectVO) {
		return update("defectDAO.updateDefect", defectVO);
	}
	
	public int deleteDefect(DefectVO defectVO) {
		int result = delete("defectDAO.deleteDefect", defectVO);
		/** 시퀀스 재정렬 시작 */
		int result_defectIdSq = update("defectDAO.setDefectIdSq");
		int result_defectIdSqInfo = update("defectDAO.setDefectIdSqInfo");
		int result_defectIdSqImpl = update("defectDAO.setDefectIdSqImpl");
		/** 시퀀스 재정렬 끝 */
		return result;
	}
	
	public List<?> selectDefectGb() {
		return list("defectDAO.selectDefectGb");
	}
	
	public List<?> selectActionSt() {
		return list("defectDAO.selectActionSt");
	}
	
	public List<?> selectTaskGb() {
		return list("defectDAO.selectTaskGb");
	}
}
