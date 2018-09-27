package egovframework.let.tms.defect.service.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.let.tms.defect.service.DefectDefaultVO;
import egovframework.let.tms.defect.service.DefectFileVO;
import egovframework.let.tms.defect.service.DefectVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("defectDAO")
public class DefectDAO extends EgovAbstractDAO{
	
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
	public List<?> selectTaskGb2() {
		return list("defectDAO.selectTaskGb2");
	}
	
	public List<?> selectUser() {
		return list("defectDAO.selectUser");
	}
	
	public List<?> searchDefect(DefectDefaultVO searchVO) {
		return list("defectDAO.searchDefect", searchVO);
	}
	
	public int selectActionComplete() {
		return (int) select("defectDAO.selectActionComplete");
	}
	
	public int selectActionNotComplete() {
		return (int) select("defectDAO.selectActionNotComplete");
	}
	
	public void insertDefectImageMap(Map<String, Object> hmap){
		if(hmap.get("status").toString().equals("0")) { // 결함등록시 추가
			insert("defectDAO.insertDefectMap", hmap);
			insert("defectDAO.insertDefectImageMap", hmap);
		} else { // 결함수정시 추가
			System.out.println("!@#2");
			insert("defectDAO.insertDefectImageMap", hmap);
		}
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectDefectImg(String defectIdSq) {
		return (Map<String, Object>) select("defectDAO.selectDefectImg", defectIdSq);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> downloadDefectImg(String defectIdSq) {
		return (Map<String, Object>) select("defectDAO.downloadDefectImg", defectIdSq);
	}
	
	public DefectFileVO selectDefectImgOne(int defectIdSq) {
		return (DefectFileVO) select("defectDAO.selectDefectImgOne", defectIdSq);
	}
	
	public void deleteDefectImg(int defectIdSq){
		delete("defectDAO.deleteDefectImg", defectIdSq);
		update("defectDAO.setDefectFileSq");
		update("defectDAO.setDefectIdSqInfo");
		update("defectDAO.setDefectFileSqImpl");
	}
	
	/** 파일 시퀀스 반환*/
	public int selectDefectIdSqToFileTb(int defectIdSq){
		return (int) select("defectDAO.selectDefectIdSqToFileTb", defectIdSq);
	}
	
	@SuppressWarnings("unchecked")
	public HashMap<String, Object> selectDefectStats(){
		return (HashMap<String, Object>) select("defectDAO.selectDefectStats");
	}
	
	public List<?> selectUserId(){
		return list("defectDAO.selectUserId");
	}
	
	public List<?> selectPjtMember(){
		return list("defectDAO.selectPjtMember");
	}
	
	public List<?> selectTaskByActionProgression() {
		return list("defectDAO.selectTaskByActionProgression");
	}
	
	public List<?> selectTaskByDefectGbCnt() {
		return list("defectDAO.selectTaskByDefectGbCnt");
	}
	
	public List<?> selectTaskByActionStCnt(){
		return list("defectDAO.selectTaskByActionStCnt");
	}
	
	public List<?> selectDayByDefectCnt(){
		return list("defectDAO.selectDayByDefectCnt");
	}
	
	public List<?> selectMonthByDefectCnt(){
		return list("defectDAO.selectMonthByDefectCnt");
	}
	
	@SuppressWarnings("unchecked")
	public List<String> selectTaskByStats(String taskGbList) {
		return (List<String>) list("defectDAO.selectTaskByStats", taskGbList);
	}
	
	@SuppressWarnings("unchecked")
	public List<String> selectTaskGbByDefect() {
		return (List<String>) list("defectDAO.selectTaskGbByDefect");
	}
	
	@SuppressWarnings("unchecked")
	public List<String> selectPgIdByDefect() {
		return (List<String>) list("defectDAO.selectPgIdByDefect");
	}
	
	@SuppressWarnings("unchecked")
	public List<String> selectPgByStats(String pgIdList) {
		return (List<String>) list("defectDAO.selectPgByStats", pgIdList);
	}
	
	@SuppressWarnings("unchecked")
	public List<String> selectUserTestIdByDefect(){
		return (List<String>) list("defectDAO.selectUserTestIdByDefect");
	}
	
	@SuppressWarnings("unchecked")
	public List<String> selectUserTestByStats(String userTestList) {
		return (List<String>) list("defectDAO.selectUserTestByStats", userTestList);
	}
	
	@SuppressWarnings("unchecked")
	public List<String> selectUserDevIdByDefect(){
		return (List<String>) list("defectDAO.selectUserDevIdByDefect");
	}
	
	@SuppressWarnings("unchecked")
	public List<String> selectUserDevByStats(String userDevList) {
		return (List<String>) list("defectDAO.selectUserDevByStats", userDevList);
	}
}
