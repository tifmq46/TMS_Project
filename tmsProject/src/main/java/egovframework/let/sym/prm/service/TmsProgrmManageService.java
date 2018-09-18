package egovframework.let.sym.prm.service;

import java.util.List;

import egovframework.com.cmm.ComDefaultVO;

/**
 * 프로그램관리에 관한 서비스 인터페이스 클래스를 정의한다.
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

public interface TmsProgrmManageService {
	
	/**
	 * 프로그램 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	List<?> selectProgrmList(ComDefaultVO vo) throws Exception;
	/**
	 * 프로그램목록 총건수를 조회한다.
	 * @param vo ComDefaultVO
	 * @return int
	 * @exception Exception
	 */
	int selectProgrmListTotCnt(ComDefaultVO vo) throws Exception;
	/**
	 * 프로그램 정보를 등록
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	 
	TmsProjectManageVO selectProject() throws Exception;
	/**
	 * 프로젝트 정보를 조회
	 * @param vo TmsProjectManageVO
	 * @exception Exception
	 */
	List<?> selectSysGb() throws Exception;
	/**
	 * 
	 * @param vo TmsProjectManageVO
	 * @exception Exception
	 */
	List<?> selectTaskGb() throws Exception;
	/**
	 * 
	 * @param vo TmsProjectManageVO
	 * @exception Exception
	 */
	List<?> selectTaskGbSearch(String searchData) throws Exception;
	/**
	 * 
	 * @param vo TmsProjectManageVO
	 * @exception Exception
	 */
	List<?> selectUserList() throws Exception;
	List<?> TmsCommonCodeListSearch(ComDefaultVO searchVO);
	int TmsCommonCodeListSearchTotCnt(ComDefaultVO searchVO);
	Object insertProject(TmsProjectManageVO tmsProjectManageVO) throws Exception;
}