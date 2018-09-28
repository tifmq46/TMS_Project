package egovframework.let.tms.test.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonArrayFormatVisitor;

import egovframework.let.tms.test.service.TestDefaultVO;
import egovframework.let.tms.test.service.TestScenarioVO;
import egovframework.let.tms.test.service.TestService;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.tms.test.service.TestCaseVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sf.json.JSONArray;

@Controller
public class TestController {

	/** TestService */
	@Resource (name = "testService")
	private TestService testService;
	
	/** EgovCmmUseService */
	@Resource (name = "EgovCmmUseService")
	private EgovCmmUseService egovCmmUseService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** EgovMessageSource */
	@Resource(name="egovMessageSource")
	EgovMessageSource egovMessageSource;
	
	
	
	/**
	 * 테스트시나리오를 가져온다
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestScenario.do")
	public String selectTestScenario(ModelMap model, HttpServletRequest request) throws Exception {
		
		String testscenarioId = request.getParameter("testscenarioId");
		TestScenarioVO testScenarioVO = testService.selectTestScenario(testscenarioId);
		
		model.addAttribute("testScenarioVO",testScenarioVO);
		
		return "tms/test/TestScenarioDetail";
	}
	
	/**
	 * 테스트시나리오의 결과를 가져온다
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestScenarioResult.do")
	public String selectTestScenarioResult(ModelMap model, HttpServletRequest request) throws Exception {
		
		String testscenarioId = request.getParameter("testscenarioId");
		TestScenarioVO testScenarioVO = testService.selectTestScenario(testscenarioId);
		
		model.addAttribute("testScenarioVO",testScenarioVO);
		
		return "tms/test/TestScenarioResult";
	}
	
	/**
	 * 테스트케이스 등록 페이지로 이동한다.
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/insertTestCase.do")
	public String insertTestCase( @ModelAttribute("testCaseVO") TestCaseVO testCaseVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		//'테스트케이스구분' 공통코드 가져오기
		ComDefaultCodeVO vo1 = new ComDefaultCodeVO();
		vo1.setCodeId("TCGB");
		List<CmmnDetailCode> tcGbCode =  egovCmmUseService.selectCmmCodeDetail(vo1);
		model.addAttribute("tcGbCode", tcGbCode);
		
		//'업무구분' 공통코드 가져오기
		ComDefaultCodeVO vo2 = new ComDefaultCodeVO();
		vo2.setCodeId("TASKGB");
		List<CmmnDetailCode> taskGbCode =  egovCmmUseService.selectCmmCodeDetail(vo2);
		model.addAttribute("taskGbCode", taskGbCode);
		
		System.out.println(testCaseVO.getPgId());
		
		return "tms/test/TestCaseInsert";
	}
	
	
	/**
	 * 테스트케이스를 등록한다.
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/insertTestCaseImpl.do")
	public String insertTestCaseImpl(RedirectAttributes redirectAttributes, @ModelAttribute("testCaseVO") TestCaseVO testCaseVO, 
			BindingResult errors, ModelMap model) throws Exception {
				
		
			String testcaseGb = testCaseVO.getTestcaseGb();
			
			beanValidator.validate(testCaseVO, errors);
			if(errors.hasErrors()) {
				return "redirect:/tms/test/insertTestCase.do";
			} else {
				testService.insertTestCase(testCaseVO);
				redirectAttributes.addFlashAttribute("message",  egovMessageSource.getMessage("success.common.insert"));
				return "redirect:/tms/test/selectTestCaseList.do?testcaseGb="+testcaseGb;
			}
	}
		
	
	
	
	/**
	 * 테스트시나리오 등록 페이지로 이동한다.
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/insertTestScenario.do")
	public String insertTestScenario( @ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		String userId = request.getParameter("userId");
		String testcaseId = request.getParameter("testcaseId");
		
		model.addAttribute("userTestId", userId);
		model.addAttribute("testcaseId", testcaseId);
		return "tms/test/TestScenarioInsert";
	}
	
		
	/**
	 * 테스트시나리오를 등록한다.
	 * @param vo - 등록할 정보가 담긴 testScenarioVO
	 * @return String
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/tms/test/insertTestScenarioImpl.do")
	public String insertTestScenarioImpl(RedirectAttributes redirectAttributes, @ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO, 
			BindingResult errors , ModelMap model) throws Exception {
		
		String testcaseId = testScenarioVO.getTestcaseId();

		beanValidator.validate(testScenarioVO, errors);
		if(errors.hasErrors()){
			return "redirect:/tms/test/selectTestCase.do?testcaseId=" + testcaseId;
		} else {
			testService.insertTestScenario(testScenarioVO);
			redirectAttributes.addFlashAttribute("message",  egovMessageSource.getMessage("success.common.insert"));
			return "redirect:/tms/test/selectTestCase.do?testcaseId=" + testcaseId;
		}
		
	}
	

	/**
	 * 테스트케이스를 수정한다.
	 * @param vo - 등록할 정보가 담긴 TestCaseVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/updateTestCaseImpl.do")
	public String updateTestCaseImpl(RedirectAttributes redirectAttributes, @ModelAttribute("testCaseVO") TestCaseVO testCaseVO, 
			BindingResult errors , ModelMap model) throws Exception {
		
			String testcaseId = testCaseVO.getTestcaseId();
			
			testService.updateTestCase(testCaseVO);
			redirectAttributes.addFlashAttribute("message",  egovMessageSource.getMessage("success.common.update"));
			return "redirect:/tms/test/selectTestCase.do?testcaseId=" + testcaseId;
			
	}
	
	/**
	 * 테스트시나리오를 수정한다.
	 * @param vo - 등록할 정보가 담긴 TestScenarioVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/updateTestScenarioImpl.do")
	public String updateTestScenarioImpl(RedirectAttributes redirectAttributes, @ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO, 
			BindingResult errors ,  ModelMap model) throws Exception {
		
		String testcaseId = testScenarioVO.getTestcaseId();
		
		beanValidator.validate(testScenarioVO, errors);
		if(errors.hasErrors()){
			return "redirect:/tms/test/selectTestCase.do?testcaseId=" + testcaseId;

		} else {
			testService.updateTestScenario(testScenarioVO);
			redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.update"));
			return "redirect:/tms/test/selectTestCase.do?testcaseId=" + testcaseId;
		}
	}
	
	
	/**
	 * 테스트케이스를 삭제한다
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/deleteTestCaseImpl.do")
	public String deleteTestCase(RedirectAttributes redirectAttributes, @ModelAttribute("testCaseVO") TestCaseVO testCaseVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		String testcaseId = testCaseVO.getTestcaseId();
		String testcaseGb = testCaseVO.getTestcaseGb();

		testService.deleteTestCase(testcaseId);
		redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "redirect:/tms/test/selectTestCaseList.do?testcaseGb="+testcaseGb;
	}
	
	
	/**
	 * 테스트시나리오를 삭제한다
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/deleteTestScenarioImpl.do")
	public String deleteTestScenario(RedirectAttributes redirectAttributes, @ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		String testscenarioId = testScenarioVO.getTestscenarioId();
		String testcaseId = testScenarioVO.getTestcaseId();

		testService.deleteTestScenario(testscenarioId);
		redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "redirect:/tms/test/selectTestCase.do?testcaseId=" + testcaseId;
	}
	
	
	/**
	 * 테스트케이스를 가져온다
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestCase.do")
	public String selectTestCase(ModelMap model, HttpServletRequest request) throws Exception {
		
		String testcaseId = request.getParameter("testcaseId");
		HashMap<String, Object> testVoMap = testService.selectTestCase(testcaseId);
		
		//테스트 시나리오 목록 가져오기
		List<?> testScenarioList = testService.selectTestScenarioList(testcaseId);
		model.addAttribute("testScenarioList",testScenarioList);
		model.addAttribute("testVoMap",testVoMap);
		
		return "tms/test/TestCaseDetail";
	}
	
	/**
	 * 테스트케이스와 케이스에 해당하는 시나리오 목록을 가져온다
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestCaseWithScenario.do")
	public String selectTestCaseWithScenario(ModelMap model, HttpServletRequest request) throws Exception {
		
		String testcaseId = request.getParameter("testcaseId");
		HashMap<String, Object> testVoMap = testService.selectTestCase(testcaseId);
		
		//테스트 시나리오 목록 가져오기
		List<?> testScenarioList = testService.selectTestScenarioList(testcaseId);
		model.addAttribute("testScenarioList",testScenarioList);
		model.addAttribute("testVoMap",testVoMap);
		
		return "tms/test/TestScenarioManage";
	}
	
	/**
	 * 테스트케이스와 시나리오의 결과를 관리한다.
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestResult.do")
	public String selectTestResult(ModelMap model, HttpServletRequest request) throws Exception {
		
		String testcaseId = request.getParameter("testcaseId");
		HashMap<String, Object> testVoMap = testService.selectTestCase(testcaseId);
		
		//테스트 시나리오 목록 가져오기
		List<?> testScenarioList = testService.selectTestScenarioList(testcaseId);
		model.addAttribute("testScenarioList",testScenarioList);
		model.addAttribute("testVoMap",testVoMap);
		
		return "tms/test/TestResultManage";
	}
	
	
	/**
	 * 테스트케이스 목록을 가져온다
	 * @param vo - 정보가 담긴 searchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/tms/test/selectTestCaseList.do")
	public String selectTestCaseList(HttpServletRequest request,  @ModelAttribute("searchVO") TestDefaultVO searchVO, ModelMap model) throws Exception {
		
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
		
		//'업무구분' 공통코드 가져오기
		ComDefaultCodeVO vo1 = new ComDefaultCodeVO();
		vo1.setCodeId("TASKGB");
		List<CmmnDetailCode> taskGbCode =  egovCmmUseService.selectCmmCodeDetail(vo1);
		model.addAttribute("taskGbCode", taskGbCode);
		
		//'시스템구분' 공통코드 가져오기
		ComDefaultCodeVO vo2 = new ComDefaultCodeVO();
		vo2.setCodeId("SYSGB");
		List<CmmnDetailCode> sysGbCode =  egovCmmUseService.selectCmmCodeDetail(vo2);
		model.addAttribute("sysGbCode", sysGbCode);
		
		//'완료여부' 공통코드 가져오기
		ComDefaultCodeVO vo3 = new ComDefaultCodeVO();
		vo3.setCodeId("RESULTYN");
		List<CmmnDetailCode> resultYnCode =  egovCmmUseService.selectCmmCodeDetail(vo3);
		model.addAttribute("resultYnCode", resultYnCode);

		
		//테스트케이스 구분에 따른 jsp페이지 설정(단위/통합)
		String testcaseGb = (String)request.getParameter("testcaseGb");
		searchVO.setSearchByTestcaseGb(testcaseGb);
		
		String link ="tms/test/TestCaseListUtc";
		
		if(testcaseGb.equals("TC2")){ //통합테스트일경우
			link = "tms/test/TestCaseListTtc";
		}
		
		//테스트 케이스 목록 가져오기
		List<?> testCaseList = testService.selectTestCaseList(searchVO);
		model.addAttribute("testCaseList", testCaseList);
		
		//테스트 케이스 목록 개수 가져오기
		int totCnt = testService.selectTestCaseListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return link;
	}
	
	

	/**
	 * 테스트시나리오 목록을 가져온다
	 * @param vo - 정보가 담긴 searchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/tms/test/selectTestScenarioList.do")
	public String selectTestScenarioList(HttpServletRequest request,  @ModelAttribute("searchVO") TestDefaultVO searchVO, ModelMap model) throws Exception {
		
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
		
		//'업무구분' 공통코드 가져오기
		ComDefaultCodeVO vo1 = new ComDefaultCodeVO();
		vo1.setCodeId("TASKGB");
		List<CmmnDetailCode> taskGbCode =  egovCmmUseService.selectCmmCodeDetail(vo1);
		model.addAttribute("taskGbCode", taskGbCode);
		
		//'시스템구분' 공통코드 가져오기
		ComDefaultCodeVO vo2 = new ComDefaultCodeVO();
		vo2.setCodeId("SYSGB");
		List<CmmnDetailCode> sysGbCode =  egovCmmUseService.selectCmmCodeDetail(vo2);
		model.addAttribute("sysGbCode", sysGbCode);
		
		//'완료여부' 공통코드 가져오기
		ComDefaultCodeVO vo3 = new ComDefaultCodeVO();
		vo3.setCodeId("RESULTYN");
		List<CmmnDetailCode> resultYnCode =  egovCmmUseService.selectCmmCodeDetail(vo3);
		model.addAttribute("resultYnCode", resultYnCode);

		
		//테스트케이스 구분에 따른 jsp페이지 설정(단위/통합)
		String testcaseGb = (String)request.getParameter("testcaseGb");
		searchVO.setSearchByTestcaseGb(testcaseGb);
		
		String link ="tms/test/TestScenarioListUtc";
		
		if(testcaseGb.equals("TC2")){ //통합테스트일경우
			link = "tms/test/TestScenarioListTtc";
		}
		
		//테스트 케이스 목록 가져오기
		List<?> testCaseList = testService.selectTestCaseList(searchVO);
		model.addAttribute("testCaseList", testCaseList);
		
		//테스트 케이스 목록 개수 가져오기
		int totCnt = testService.selectTestCaseListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return link;
	}
	
	/**
	 * 테스트시나리오 목록을 가져온다
	 * @param vo - 정보가 담긴 searchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/tms/test/selectTestResultList.do")
	public String selectTestResultList(HttpServletRequest request,  @ModelAttribute("searchVO") TestDefaultVO searchVO, ModelMap model) throws Exception {
		
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
		
		//'업무구분' 공통코드 가져오기
		ComDefaultCodeVO vo1 = new ComDefaultCodeVO();
		vo1.setCodeId("TASKGB");
		List<CmmnDetailCode> taskGbCode =  egovCmmUseService.selectCmmCodeDetail(vo1);
		model.addAttribute("taskGbCode", taskGbCode);
		
		//'시스템구분' 공통코드 가져오기
		ComDefaultCodeVO vo2 = new ComDefaultCodeVO();
		vo2.setCodeId("SYSGB");
		List<CmmnDetailCode> sysGbCode =  egovCmmUseService.selectCmmCodeDetail(vo2);
		model.addAttribute("sysGbCode", sysGbCode);
		
		//'완료여부' 공통코드 가져오기
		ComDefaultCodeVO vo3 = new ComDefaultCodeVO();
		vo3.setCodeId("RESULTYN");
		List<CmmnDetailCode> resultYnCode =  egovCmmUseService.selectCmmCodeDetail(vo3);
		model.addAttribute("resultYnCode", resultYnCode);

		
		//테스트케이스 구분에 따른 jsp페이지 설정(단위/통합)
		String testcaseGb = (String)request.getParameter("testcaseGb");
		searchVO.setSearchByTestcaseGb(testcaseGb);
		
		String link ="tms/test/TestResultListUtc";
		
		if(testcaseGb.equals("TC2")){ //통합테스트일경우
			link = "tms/test/TestResultListTtc";
		}
		
		//테스트 케이스 목록 가져오기
		List<?> testCaseList = testService.selectTestCaseList(searchVO);
		model.addAttribute("testCaseList", testCaseList);
		
		//테스트 케이스 목록 개수 가져오기
		int totCnt = testService.selectTestCaseListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return link;
	}
	
	/**
	 * 테스트 통계를 보여준다.
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestStats.do")
	public String selectTestStats(ModelMap model) throws Exception {
		
		//단위 테스트 통계
		HashMap<String, Integer> testCaseStatsMapTC1 = testService.selectTestCaseStats("TC1");
		model.addAttribute("testCaseStatsMapTC1", testCaseStatsMapTC1);
		
		//통합 테스트 통계
		HashMap<String, Integer> testCaseStatsMapTC2 = testService.selectTestCaseStats("TC2");
		model.addAttribute("testCaseStatsMapTC2", testCaseStatsMapTC2);
		
		List<?> tcStatsByTaskGb = testService.selectTestCaseStatsListByTaskGb();
		model.addAttribute("tcStatsByTaskGb", JSONArray.fromObject(tcStatsByTaskGb));
		
		
		return "tms/test/TestStats";
	}
	
	
	/**
	 * 테스트케이스 현황(단위,통합)을 가져온다
	 * @param vo - 정보가 담긴 searchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/tms/test/selectTestCurrent.do")
	public String selectTestCurrent(HttpServletRequest request,  @ModelAttribute("searchVO") TestDefaultVO searchVO, ModelMap model) throws Exception {
		
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
		
		//'업무구분' 공통코드 가져오기
		ComDefaultCodeVO vo1 = new ComDefaultCodeVO();
		vo1.setCodeId("TASKGB");
		List<CmmnDetailCode> taskGbCode =  egovCmmUseService.selectCmmCodeDetail(vo1);
		model.addAttribute("taskGbCode", taskGbCode);
		
		//'테스트케이스 구분' 공통코드 가져오기
		ComDefaultCodeVO vo2 = new ComDefaultCodeVO();
		vo2.setCodeId("TCGB");
		List<CmmnDetailCode> tcGbCode =  egovCmmUseService.selectCmmCodeDetail(vo2);
		model.addAttribute("tcGbCode", tcGbCode);
		
		//'완료여부' 공통코드 가져오기
		ComDefaultCodeVO vo3 = new ComDefaultCodeVO();
		vo3.setCodeId("RESULTYN");
		List<CmmnDetailCode> resultYnCode =  egovCmmUseService.selectCmmCodeDetail(vo3);
		model.addAttribute("resultYnCode", resultYnCode);

		
		//테스트 현황 목록 가져오기
		List<?> testCurrent = testService.selectTestCurrent(searchVO);
		model.addAttribute("testCurrent", testCurrent);
		
		//테스트 현황 목록 개수 가져오기
		int totCnt = testService.selectTestCurrentTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		//테스트 현황 총 개수, 완료 개수, 미완료 개수 가져오기
		HashMap<String, Object> selectTestCurrentCnt = testService.selectTestCurrentCnt(searchVO);
		model.addAttribute("selectTestCurrentCnt", selectTestCurrentCnt);
		
		//model.addAttribute("searchVO", searchVO);
		
		return "tms/test/TestCurrent";
	}
	
	
	/**
	 * 테스트케이스 현황(단위,통합)을 가져온다
	 * @param vo - 정보가 담긴 searchVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/tms/test/selectTestStatsTable.do")
	public String selectTestStatsTable(HttpServletRequest request, @ModelAttribute("searchVO") TestDefaultVO searchVO, ModelMap model) throws Exception {
		
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
		
		//'테스트케이스 구분' 공통코드 가져오기
		ComDefaultCodeVO vo2 = new ComDefaultCodeVO();
		vo2.setCodeId("TCGB");
		List<CmmnDetailCode> tcGbCode =  egovCmmUseService.selectCmmCodeDetail(vo2);
		model.addAttribute("tcGbCode", tcGbCode);
		
		//테스트 현황 목록 가져오기
		List<?> testStatsTable = testService.selectTestStatsTable(searchVO);
		model.addAttribute("testStatsTable", testStatsTable);
		
		
		return "tms/test/TestStatsTable";
	}
}
