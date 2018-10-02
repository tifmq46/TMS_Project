package egovframework.let.sym.prm.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.sym.prm.service.TmsProjectManageVO;
import egovframework.let.tms.dev.service.DevPlanDefaultVO;
import egovframework.let.tms.pg.service.ProgramDefaultVO;
import egovframework.let.tms.pg.service.ProgramVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
/**
 * 프로그램 목록관리및 프로그램변경관리에 대한 DAO 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */

@Repository("TmsProgrmManageDAO")
public class TmsProgrmManageDAO extends EgovAbstractDAO {

	/**
	 * 프로그램 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */

	public List<?> selectProgrmList(ComDefaultVO vo) throws Exception{
		return list("TmsProgrmManageDAO.selectProgrmList_D", vo);
	}

    /**
	 * 프로그램목록 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
    public int selectProgrmListTotCnt(ComDefaultVO vo) {
        return (Integer)select("TmsProgrmManageDAO.selectProgrmListTotCnt_S", vo);
    }

	public TmsProjectManageVO selectProject() {
		// TODO Auto-generated method stub
		return (TmsProjectManageVO)select("TmsProgrmManageDAO.selectProject");
	}

	public List<?> selectSysGb() {
		// TODO Auto-generated method stub
		return list("TmsProgrmManageDAO.selectSysGb");
	}
	
	public List<?> selectTaskGb() {
		// TODO Auto-generated method stub
		return list("TmsProgrmManageDAO.selectTaskGb");
	}
	
	public List<?> selectTaskGb2(ProgramDefaultVO searchVO) {
		// TODO Auto-generated method stub
		return list("TmsProgrmManageDAO.selectTaskGb2", searchVO);
	}
	
	public List<?> selectTaskGb3(DevPlanDefaultVO searchVO) {
		// TODO Auto-generated method stub
		return list("TmsProgrmManageDAO.selectTaskGb3", searchVO);
	}

	public List<?> selectTaskGbSearch(String searchData) {
		// TODO Auto-generated method stub
		return list("TmsProgrmManageDAO.selectTaskGbSearch",searchData);
	}
	
	public List<?> selectUserList() {
		// TODO Auto-generated method stub
		return list("TmsProgrmManageDAO.selectUserList");
	}
	
	public List<?> TmsCommonCodeListSearch(ComDefaultVO searchVO) {
		// TODO Auto-generated method stub
		return list("TmsProgrmManageDAO.TmsCommonCodeListSearch",searchVO);
	}
	
	public int TmsCommonCodeListSearchTotCnt(ComDefaultVO vo) {
        return (Integer)select("TmsProgrmManageDAO.TmsCommonCodeListSearchTotCnt", vo);
    }

	public Object insertProject(TmsProjectManageVO tmsProjectManageVO) {
		insert("TmsProgrmManageDAO.insertProject",tmsProjectManageVO);
		return null;
	}

	public List<?> selectTestList() {
		// TODO Auto-generated method stub
		return list("TmsProgrmManageDAO.selectTestList");
	}

	public List<HashMap<String,String>> selectProgrmList1(int a) {
	      return (List<HashMap<String,String>>)list("TmsProgrmManageDAO.selectTestList1",a);
	   }

	
	
}