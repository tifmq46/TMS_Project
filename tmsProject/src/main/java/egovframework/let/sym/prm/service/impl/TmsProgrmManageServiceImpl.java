package egovframework.let.sym.prm.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.let.sym.prm.service.TmsProgrmManageService;
import egovframework.let.sym.prm.service.TmsProjectManageVO;
import egovframework.let.tms.dev.service.DevPlanDefaultVO;
import egovframework.let.tms.pg.service.ProgramDefaultVO;
import egovframework.let.tms.pg.service.ProgramVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 프로그램목록관리 및 프로그램변경관리에 관한 비즈니스 구현 클래스를 정의한다.
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
@Service("TmsProgrmManageService")
public class TmsProgrmManageServiceImpl extends EgovAbstractServiceImpl implements TmsProgrmManageService {

	@Resource(name="TmsProgrmManageDAO")
    private TmsProgrmManageDAO TmsProgrmManageDAO;


	/**
	 * 프로그램 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	@Override
	public List<?> selectProgrmList(ComDefaultVO vo) throws Exception {
   		return TmsProgrmManageDAO.selectProgrmList(vo);
	}
	/**
	 * 프로그램목록 총건수를 조회한다.
	 * @param vo  ComDefaultVO
	 * @return Integer
	 * @exception Exception
	 */
    @Override
	public int selectProgrmListTotCnt(ComDefaultVO vo) throws Exception {
        return TmsProgrmManageDAO.selectProgrmListTotCnt(vo);
	}
	/**
	 * 프로그램 정보를 등록
	 * @param vo ProgrmManageVO
	 * @exception Exception
	 */
	@Override
	public TmsProjectManageVO selectProject() throws Exception {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.selectProject();
	}
	@Override
	public List<String> selectSysGb() throws Exception {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.selectSysGb();
	}
	@Override
	public List<String> selectTaskGb() throws Exception {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.selectTaskGb();
	}
	@Override
	public List<String> selectTaskGb2(ProgramDefaultVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.selectTaskGb2(searchVO);
	}
	@Override
	public List<String> selectTaskGb3(ProgramVO searchVO) throws Exception {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.selectTaskGb3(searchVO);
	}
	@Override
	public List<String> selectTaskGbSearch(String searchData) throws Exception {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.selectTaskGbSearch(searchData);
	}
	@Override
	public List<?> selectUserList() throws Exception {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.selectUserList();
	}
	@Override
	public List<?> TmsCommonCodeListSearch(ComDefaultVO searchVO) {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.TmsCommonCodeListSearch(searchVO);
	}
	@Override
	public int TmsCommonCodeListSearchTotCnt(ComDefaultVO searchVO) {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.TmsCommonCodeListSearchTotCnt(searchVO);
	}

	@Override
	public Object insertProject(TmsProjectManageVO tmsProjectManageVO) throws Exception {
		// TODO Auto-generated method stub
		TmsProgrmManageDAO.insertProject(tmsProjectManageVO);
		return null;
	}
	@Override
	public List<?> selectTestList() {
		
		return TmsProgrmManageDAO.selectTestList();
	}
	@Override
	public List<HashMap<String, String>> selectProgrmList1(int a) {
		// TODO Auto-generated method stub
		return TmsProgrmManageDAO.selectProgrmList1(a);
	}
	@Override
	public List<?> selectTaskGb4(DevPlanDefaultVO dvo) {
		return TmsProgrmManageDAO.selectTaskGb4(dvo);
	}
}