package egovframework.let.tms.test.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonArrayFormatVisitor;

import egovframework.let.tms.test.service.TestDefaultVO;
import egovframework.let.tms.test.service.TestScenarioVO;
import egovframework.let.tms.test.service.TestService;
import egovframework.com.cmm.ComDefaultCodeVO;
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
	public String insertTestCaseImpl( @ModelAttribute("testCaseVO") TestCaseVO testCaseVO, ModelMap model) throws Exception {
				testService.insertTestCase(testCaseVO);
		return "forward:/tms/test/selectTestCaseList.do";
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
	public String insertTestScenarioImpl( @ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO, ModelMap model) throws Exception {
		
		String testcaseId = testScenarioVO.getTestcaseId();
		testService.insertTestScenario(testScenarioVO);
		return "redirect:/tms/test/selectTestCase.do?testcaseId=" + testcaseId;
		
	}
	

	/**
	 * 테스트케이스를 수정한다.
	 * @param vo - 등록할 정보가 담긴 TestCaseVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/updateTestCaseImpl.do")
	public String updateTestCaseImpl( @ModelAttribute("testCaseVO") TestCaseVO testCaseVO, ModelMap model) throws Exception {
		
		String testcaseId = testCaseVO.getTestcaseId();
		testService.updateTestCase(testCaseVO);
		
		return "redirect:/tms/test/selectTestCase.do?testcaseId=" + testcaseId;
	}
	
	/**
	 * 테스트시나리오를 수정한다.
	 * @param vo - 등록할 정보가 담긴 TestScenarioVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/updateTestScenarioImpl.do")
	public String updateTestScenarioImpl( @ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO, ModelMap model) throws Exception {
		
		String testcaseId = testScenarioVO.getTestcaseId();
		testService.updateTestScenario(testScenarioVO);
		
		return "redirect:/tms/test/selectTestCase.do?testcaseId=" + testcaseId;
	}
	
	
	
	/**
	 * 테스트케이스를 삭제한다
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/deleteTestCaseImpl.do")
	public String deleteTestCase(ModelMap model, HttpServletRequest request) throws Exception {
		
		String testcaseId = request.getParameter("testcaseId");
		String testcaseGb = request.getParameter("testcaseGbCode");


		testService.deleteTestCase(testcaseId);
		
		return "redirect:/tms/test/selectTestCaseList.do?testcaseGb="+testcaseGb;
	}
	
	
	/**
	 * 테스트시나리오를 삭제한다
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/deleteTestScenarioImpl.do")
	public String deleteTestScenario(ModelMap model, HttpServletRequest request) throws Exception {
		
		String testscenarioId = request.getParameter("testscenarioId");
		String testcaseId = request.getParameter("testcaseId");

		testService.deleteTestScenario(testscenarioId);
		
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
		
		System.out.println("테스트케이스 컨텐트 :" + testVoMap.get("testcaseContent"));
		
		//테스트 시나리오 목록 가져오기
		List<?> testScenarioList = testService.selectTestScenarioList(testcaseId);
		model.addAttribute("testScenarioList",testScenarioList);
		
		model.addAttribute("testVoMap",testVoMap);
		
		return "tms/test/TestCaseDetail";
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
	 * 테스트 통계를 보여준다.
	 * @param vo - 등록할 정보가 담긴 testCaseVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestStats.do")
	public String selectTestStats(ModelMap model) throws Exception {
		
		//단위 테스트 통계
		HashMap<String, Object> testCaseStatsMapTC1 = testService.selectTestCaseStats("TC1");
		model.addAttribute("testCaseStatsMapTC1", testCaseStatsMapTC1);
		
		//통합 테스트 통계
		HashMap<String, Object> testCaseStatsMapTC2 = testService.selectTestCaseStats("TC2");
		model.addAttribute("testCaseStatsMapTC2", testCaseStatsMapTC2);
		
		List<?> tcStatsByTaskGb = testService.selectTestCaseStatsListByTaskGb();
		model.addAttribute("tcStatsByTaskGb", JSONArray.fromObject(tcStatsByTaskGb));
		
		return "tms/test/TestStats";
	}
	
	
	/**
	 * 테스트케이스 목록을 가져온다
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
		
		//테스트 현황 총 개수, 완료 개수, 미완료 개수 가져오기
		HashMap<String, Object> selectTestCurrentCnt = testService.selectTestCurrentCnt(searchVO);
		model.addAttribute("selectTestCurrentCnt", selectTestCurrentCnt);
		
		
		return "tms/test/TestCurrent";
	}
}
