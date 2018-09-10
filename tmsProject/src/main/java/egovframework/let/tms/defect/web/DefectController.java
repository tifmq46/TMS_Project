package egovframework.let.tms.defect.web;

import java.util.List;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.tms.defect.service.DefectDefaultVO;
import egovframework.let.tms.defect.service.DefectService;
import egovframework.let.tms.defect.service.DefectVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class DefectController {

	/** DefectService */
	@Resource (name = "defectService")
	private DefectService defectService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	/**
	 * 전체 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 DefectDefaultVO
	 * @param model
	 * @return "DefectList"
	 * @exception Exception
	 */
	@RequestMapping("/tms/defect/selectDefect.do")
	public String selectDefect(@ModelAttribute("searchVO") DefectDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> list = defectService.selectDefect(searchVO);
		
		model.addAttribute("defectList", list);
		int totCnt = defectService.selectDefectTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<?> taskGbList = defectService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<?> defectGbList = defectService.selectDefectGb();
		model.addAttribute("defectGb", defectGbList);
		
		List<?> actionStList = defectService.selectActionSt();
		model.addAttribute("actionSt", actionStList);
		
		return "tms/defect/defectList";
	}
	
	/** 결함 등록 페이지로 이동 */
	@RequestMapping("/tms/defect/insertDefect.do")
	public String insertDefect(ModelMap model){
		int defectIdSq = defectService.selectDefectIdSq();
		defectIdSq = defectIdSq + 1;
		model.addAttribute("defectIdSq", defectIdSq);
		return "tms/defect/defectRegist";
	}
	/** 결함 등록 */
	@RequestMapping("/tms/defect/insertDefectImpl.do")
	public String insertDefectImpl(@ModelAttribute("defectVO") DefectVO defectVO) {
		defectService.insertDefect(defectVO);
		return "redirect:/tms/defect/selectDefect.do";
	}
	
	/** 결함 상세 조회*/
	@RequestMapping("/tms/defect/selectDefectInfo.do")
	public String selectDefectInfo(@ModelAttribute("defectVO") DefectVO defectVO, ModelMap model) throws Exception {
		System.out.println("@@@@@@@@@@@@@@@@@@@"+defectVO.toString());
		List<?> list = defectService.selectOneDefect(defectVO);
		model.addAttribute("defectOne", list);
		return "tms/defect/defectListOne";
	}
	
	/** 결함조치 수정
	 * @throws Exception */
	@RequestMapping("/tms/defect/updateDefect.do")
	public String updateDefect(@ModelAttribute("defectVO") DefectVO defectVO, ModelMap model) throws Exception{
		int result = defectService.updateDefect(defectVO);
		List<?> list = defectService.selectOneDefect(defectVO);
		model.addAttribute("defectOne", list);
		return "tms/defect/defectListOne";
	}
	
	/** 결함조치 삭제 */
	@RequestMapping("/tms/defect/deleteDefect.do")
	public String deleteDefect(@ModelAttribute("defectVO") DefectVO defectVO, ModelMap model) {
		int result = defectService.deleteDefect(defectVO);
		return "redirect:/tms/defect/selectDefect.do";
	}
	
	/**  결함처리 현황 */
	@RequestMapping("/tms/defect/selectDefectCurrent.do")
	public String selectDefectCurrent(@ModelAttribute("searchVO") DefectDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<?> list = defectService.selectDefect(searchVO);
		
		model.addAttribute("defectList", list);
		int totCnt = defectService.selectDefectTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "tms/defect/defectListCurrent";
	}
}
