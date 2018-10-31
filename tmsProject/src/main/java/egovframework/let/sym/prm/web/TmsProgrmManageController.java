package egovframework.let.sym.prm.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.let.sym.prm.service.TmsProgrmManageService;
import egovframework.let.sym.prm.service.TmsProjectManageVO;
import egovframework.let.tms.defect.service.DefectService;
import egovframework.let.tms.pg.service.ProgramService;
import egovframework.let.tms.pg.service.ProgramVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 프로그램목록 관리및 변경을 처리하는 비즈니스 구현 클래스
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

@Controller
public class TmsProgrmManageController {
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** EgovProgrmManageService */
	@Resource(name = "TmsProgrmManageService")
	private TmsProgrmManageService TmsProgrmManageService;
	
	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	// 방금 전화했는데 서류 제출하고 9월말부터 확실하진 않지만 3년형 예싼이 들어올수는 있다고 
	// 혹시 들어오면 3년형 대기자로 올려도 되는데 어떻게 하겠냐고 하대
//	
	/**
	 * 프로그램파일명을 조회한다.
	 * @param searchVO ComDefaultVO
	 * @return 출력페이지정보 "sym/prm/EgovFileNmSearch"
	 * @exception Exception
	 */
	@RequestMapping(value = "/sym/prm/TmsProgramListSearch.do")
	public String selectProgrmListSearch(@ModelAttribute("searchVO") ComDefaultVO searchVO, ModelMap model) throws Exception {
		// 0. Spring Security 사용자권한 처리
		System.out.println("searchVO = " + searchVO);
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
		System.out.println("searchVO ================== "+searchVO);
		// 내역 조회
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> list_progrmmanage = TmsProgrmManageService.selectProgrmList(searchVO);
		model.addAttribute("list_progrmmanage", list_progrmmanage);

		int totCnt = TmsProgrmManageService.selectProgrmListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "sym/prm/TmsFileNmSearch";

	}
	
	@RequestMapping(value = "/sym/prm/TaskGbSearch.do")
	@ResponseBody
	public List<?> selectTaskGbSearch(String searchData,ModelMap model) throws Exception {
		// 0. Spring Security 사용자권한 처리
		
		List<String> selectTaskGbSearch = TmsProgrmManageService.selectTaskGbSearch(searchData);
		model.addAttribute("selectTaskGbSearch", selectTaskGbSearch);
		System.out.println("================"+selectTaskGbSearch);
		return selectTaskGbSearch;

	}
	

	
	@RequestMapping(value = "/sym/prm/TmsCommonCodeListSearch.do")
	public String TmsCommonCodeListSearch(@ModelAttribute("searchVO") ComDefaultVO searchVO, ModelMap model) throws Exception {
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
		// 내역 조회
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> TmsCommonCodeListSearch = TmsProgrmManageService.TmsCommonCodeListSearch(searchVO);
		model.addAttribute("TmsCommonCodeListSearch", TmsCommonCodeListSearch);
		
		System.out.println("TmsCommonCodeListSearch ======================= " + TmsCommonCodeListSearch);

		int totCnt = TmsProgrmManageService.TmsCommonCodeListSearchTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		return "sym/prm/TmsCommonCodeListSearch";

	}
	
	 @RequestMapping(value="/sym/prm/insertProjectView.do")
	    public String insertProjectView(ModelMap model)throws Exception {

	      	return "tms/pjt/PjtInsert";
	    }
	    
	    @RequestMapping(value="/sym/prm/insertProject.do")
	    public String insertProject(@ModelAttribute("TmsProjectManageVO") TmsProjectManageVO TmsProjectManageVO)throws Exception {
	    	System.out.println("###"+TmsProjectManageVO);
	    	TmsProgrmManageService.insertProject(TmsProjectManageVO);

	      	return "redirect:/cmm/main/mainPage.do";
	    }

}