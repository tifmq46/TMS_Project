package egovframework.let.tms.dev.web;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.sym.prm.service.TmsProgrmManageService;
import egovframework.let.sym.prm.service.TmsProjectManageVO;
import egovframework.let.tms.dev.service.DevPlanDefaultVO;
import egovframework.let.tms.dev.service.DevPlanService;
import egovframework.let.tms.dev.service.DevPlanVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class DevPlanController {

	/** DevPlanService */
	@Resource (name = "devPlanService")
	private DevPlanService devPlanService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	/** EgovProgrmManageService */
	@Resource(name = "TmsProgrmManageService")
	private TmsProgrmManageService TmsProgrmManageService;
	
	
	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 DevPlanDefaultVO
	 * @param model
	 * @return "DevPlanList"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/tms/dev/devPlans.do")
	public String selectDevPlans(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model) throws Exception {
		System.out.println("여기는 옴ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
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
		
		//공통코드(시스템, 업무구분)
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<?> devList = devPlanService.selectDevPlans(searchVO);
		model.addAttribute("resultList", devList);
		
		int totCnt = devPlanService.selectDevPlanListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		

		return "tms/dev/devPlanList";
	}
	
	
	
	/**
	 * 계획을 상세 조회한다.
	 * 
	 */
	@RequestMapping(value = "/tms/dev/selectDevPlan.do")
	public String selectDevPlan(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model) throws Exception {
		
		//searchVO.setPgId(pgId);
		
		//O vo = new DevPlanDefaultVO();
				
		List<?> vo = devPlanService.selectDevPlan(searchVO);

		model.addAttribute("result", vo);

		return "/tms/dev/devPlanUpdt";
	}

	
	/*
	 *계발계획 정보를 등록한다. 
	 * */
	@RequestMapping("/tms/dev/insertDevPlan.do")
	public String insertDevPlan(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, @ModelAttribute("devPlan") DevPlanVO dvo, BindingResult bindingResult,
			SessionStatus status, ModelMap model) throws Exception {

		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		beanValidator.validate(dvo, bindingResult);

		/*if (bindingResult.hasErrors()) {
			//ComDefaultCodeVO vo = new ComDefaultCodeVO();
			DevPlanDefaultVO vo = new DevPlanDefaultVO();
			
			devPlanService.insertDevPlan(dvo); 

			return "tms/dev/devPlanRegist";
		}*/

		/*dvo.setFrstRegisterId(user.getUniqId());*/

		if (isAuthenticated) {
			devPlanService.insertDevPlan(dvo);
		}

		return "redirect:/tms/dev/devPlans.do";
	}
	
	@RequestMapping("/tms/dev/addDevPlan.do")
	public String addDevPlan(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model) throws Exception {
		ComDefaultCodeVO vo = new ComDefaultCodeVO();

		//vo.setCodeId("COM005");

		List<?> result = cmmUseService.selectCmmCodeDetail(vo);
		
		ComDefaultCodeVO codeVO = new ComDefaultCodeVO();
		codeVO.setCodeId("SYSGB");
		List<?> resultS = cmmUseService.selectCmmCodeDetail(codeVO);
		
		codeVO.setCodeId("TASKGB");
		List<?> resultT = cmmUseService.selectCmmCodeDetail(codeVO);
		
		//List<?> devList = devPlanService.selectDevPlans(searchVO);
		//model.addAttribute("resultList", devList);
		model.addAttribute("resultS", resultS);
		model.addAttribute("resultT", resultT);

		model.addAttribute("resultList", result);

		return "tms/dev/devPlanRegist";
		/*return "cop/com/EgovTemplateRegist";*/
	}
	
	@RequestMapping(value = "/tms/dev/updateDevPlan.do")
	public String updateDevPlan(@ModelAttribute("searchVO") DevPlanVO dvo, BindingResult bindingResult, SessionStatus status, Model model) throws Exception {

		//beanValidator.validate(dvo, bindingResult); //validation 수행

		//if (bindingResult.hasErrors()) {
			//return "/tms/dev/updateDevPlan";
		//} else {
			devPlanService.updateDevPlan(dvo);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
			return "forward:/tms/dev/selectDevPlan.do";
		//}
	}

	@RequestMapping(value = "/tms/dev/deleteDevPlan.do")
	public String deleteDevPlan(@ModelAttribute("searchVO") DevPlanVO dvo, SessionStatus status, Model model) throws Exception {

		devPlanService.deleteDevPlan(dvo);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/tms/dev/devPlans.do";
	}
	
	/**
	 * 개발결과
	 */
	

	@RequestMapping(value = "/tms/dev/devResultList.do")
	public String selectDevResultList(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model) throws Exception {
		
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
		
		//공통코드(시스템, 업무구분)
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		System.out.println("----------------------업무구분값");
		System.out.println(searchVO.getSearchBySysGb());
		System.out.println(searchVO.getSearchByTaskGb());
				
		List<?> devList = devPlanService.selectDevPlans(searchVO);
		model.addAttribute("resultList", devList);
		
		List<?> devResultList = devPlanService.selectDevResultList(searchVO);
		model.addAttribute("resultList", devResultList);
		
		int totCnt = devPlanService.selectDevPlanListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "tms/dev/devResultList";
	}
	
	@RequestMapping(value = "/tms/dev/selectDevResult.do")
	public String selectDevResult(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model) throws Exception {
		
		List<?> vo = devPlanService.selectDevResult(searchVO);

		model.addAttribute("result", vo);

		return "/tms/dev/devResultUpdt";
	}
	
	@RequestMapping(value = "/tms/dev/updateDevResult.do")
	public String updateDevResult(@RequestParam("h") String h, BindingResult bindingResult, SessionStatus status, Model model) throws Exception {

		System.out.println("---------------dd-"+h);
		//beanValidator.validate(dvo, bindingResult); //validation 수행

		//if (bindingResult.hasErrors()) {
			//return "/tms/dev/updateDevPlan";
		//} else {
			/*devPlanService.updateDevResult(dvo);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));*/
			return "forward:/tms/dev/selectDevResult.do";
		//}
	}
	
	@RequestMapping(value = "/tms/dev/deleteDevResult.do")
	public String deleteDevResult(@ModelAttribute("searchVO") DevPlanVO dvo, SessionStatus status, Model model) throws Exception {

		devPlanService.deleteDevResult(dvo);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/tms/dev/selectDevResult.do";
	}
	
	@RequestMapping(value = "/tms/dev/devStats.do")
	public String devStats(@ModelAttribute("searchVO") DevPlanVO dvo, SessionStatus status, Model model) throws Exception {
		
		/*개발기간*/
		String start = "2018-09-17";
		String end = "2018-10-28";
		/*프로젝트의 개발기간을 가져와서 주차의 값이랑 주차의 차이를 가져온다.*/
		TmsProjectManageVO tt = TmsProgrmManageService.selectProject();
		model.addAttribute("tt", tt);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date startDate = tt.getDEV_START_DT();
		String ab = sdf.format(startDate);
		
		Date endDate = tt.getDEV_END_DT();
		
		//date -> calendar
		Calendar cal = Calendar.getInstance();
		cal.setTime(startDate);
		
		int startWeek = cal.get(cal.WEEK_OF_YEAR);
		
		cal.setTime(endDate);
		int endWeek = cal.get(cal.WEEK_OF_YEAR);
		
		devPlanService.deleteWeek();
		for(int i=startWeek; i<=endWeek; i++){
			devPlanService.insertWeek(i);
		}
		/*월에서 주차 구하기
		 * System.out.println(String.valueOf(cal.get(Calendar.WEEK_OF_MONTH)));
		 * */
		
		
		System.out.println("========================");
		System.out.println(sdf.format(startDate));
		System.out.println("시작 주차"+startWeek);
		System.out.println("종료 주차"+endWeek);
		
		
		List<?> devPeriod = devPlanService.selectDevPeriod();
		model.addAttribute("resultP", devPeriod);
		
		return "/tms/dev/devStats";
	}
		
}
