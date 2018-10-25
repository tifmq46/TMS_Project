package egovframework.let.tms.test.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.tms.test.service.TestDefaultVO;
import egovframework.let.tms.test.service.TestScenarioVO;
import egovframework.let.tms.test.service.TestService;
import egovframework.com.cmm.ComDefaultCodeVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.CmmnDetailCode;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.tms.defect.service.DefectService;
import egovframework.let.tms.test.service.TestCaseVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sf.json.JSONArray;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONObject;

@Controller
public class TestController {

	/** TestService */
	@Resource(name = "testService")
	private TestService testService;
	
	/** DefectService */
	@Resource (name = "defectService")
	private DefectService defectService;
	
	/** EgovCmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService egovCmmUseService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;
	/**
	 * 테스트시나리오를 가져온다
	 * 
	 * @param String
	 *            - testcaseGb, testscenarioId
	 * @return String - "tms/test/TestScenarioDetail"
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestScenario.do")
	public String selectTestScenario(@ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		TestScenarioVO vo = testService.selectTestScenario((String)testScenarioVO.getTestscenarioId());
		model.addAttribute("testScenarioVO", vo);
		}
		return "tms/test/TestScenarioDetail";
	}

	/**
	 * 테스트시나리오의 결과를 가져온다
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestScenarioResult.do")
	public String selectTestScenarioResult(@RequestParam("testscenarioId") String testscenarioId, ModelMap model)
			throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		TestScenarioVO testScenarioVO = testService.selectTestScenario(testscenarioId);
		model.addAttribute("testScenarioVO", testScenarioVO);
		}
		return "tms/test/TestScenarioResult";
	}

	/**
	 * 테스트케이스 등록 페이지로 이동한다.
	 * 
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/insertTestCase.do")
	public String insertTestCase(@ModelAttribute("testCaseVO") TestCaseVO testCaseVO, ModelMap model) throws Exception {

		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("TCGB"); // '테스트케이스구분' 공통코드
		List<CmmnDetailCode> codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("tcGbCode", codeResult);

		vo.setCodeId("TASKGB"); // '업무구분' 공통코드
		codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("taskGbCode", codeResult);

		return "tms/test/TestCaseInsert";
	}

	/**
	 * 테스트케이스를 등록한다.
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 testCaseVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/insertTestCaseImpl.do")
	public String insertTestCaseImpl(RedirectAttributes redirectAttributes,
			@ModelAttribute("testCaseVO") TestCaseVO testCaseVO, BindingResult errors, ModelMap model)
			throws Exception {

		String testcaseGb = testCaseVO.getTestcaseGb();

		beanValidator.validate(testCaseVO, errors);
		if (errors.hasErrors()) {
			return "redirect:/tms/test/insertTestCase.do";
		} else {
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			
			if (isAuthenticated) {
			testService.insertTestCase(testCaseVO);
			redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			}
			return "redirect:/tms/test/selectTestCaseList.do?testcaseGb=" + testcaseGb;
		}
	}

	/**
	 * 테스트시나리오 등록 페이지로 이동한다.
	 * 
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/insertTestScenario.do")
	public String insertTestScenario(@RequestParam("testcaseId") String testcaseId, ModelMap model) throws Exception {

		model.addAttribute("testcaseId", testcaseId);
		return "tms/test/TestScenarioInsert";
	}

	/**
	 * 테스트시나리오를 등록한다.
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 testScenarioVO
	 * @return String
	 * @exception Exception
	 */

	@RequestMapping(value = "/tms/test/insertTestScenarioImpl.do")
	public String insertTestScenarioImpl(
			RedirectAttributes redirectAttributes, @ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO,
			BindingResult errors, ModelMap model) throws Exception {

		String testcaseId = testScenarioVO.getTestcaseId();
		beanValidator.validate(testScenarioVO, errors);
		if (errors.hasErrors()) {
			return "redirect:/tms/test/insertTestScenario.do?testcaseId=" + testcaseId;
		} else {
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			if (isAuthenticated) {
			testService.insertTestScenario(testScenarioVO);
			redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.insert"));
			}
			return "redirect:/tms/test/selectTestCaseWithScenario.do?testcaseId=" + testcaseId;
		}

	}

	/**
	 * 테스트케이스를 수정한다.
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 TestCaseVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/updateTestCaseImpl.do")
	public String updateTestCaseImpl(RedirectAttributes redirectAttributes,
			@ModelAttribute("testCaseVO") TestCaseVO testCaseVO, BindingResult errors) throws Exception {

		String testcaseGb = testCaseVO.getTestcaseGb();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		testService.updateTestCase(testCaseVO);
		redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.update"));
		}
		return "redirect:/tms/test/selectTestCaseList.do?testcaseGb=" + testcaseGb;
	}

	/**
	 * 테스트시나리오를 수정한다.
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 TestScenarioVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/updateTestScenarioImpl.do")
	public String updateTestScenarioImpl(@RequestParam("testcaseGb") String testcaseGb,
			RedirectAttributes redirectAttributes, @ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO,
			BindingResult errors) throws Exception {

		beanValidator.validate(testScenarioVO, errors);
		if (errors.hasErrors()) {
			redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("fail.common.update"));
			return "redirect:/tms/test/selectTestScenarioList.do?testcaseGb=" + testcaseGb;

		} else {
			Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
			
			if (isAuthenticated) {
			testService.updateTestScenario(testScenarioVO);
			redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.update"));
			}
			return "redirect:/tms/test/selectTestCaseWithScenario.do?testcaseId=" + (String)testScenarioVO.getTestcaseId();
		}
	}

	/**
	 * 테스트시나리오 결과만 수정한다.
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 TestScenarioVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/updateTestScenarioResultImpl.do")
	public String updateTestScenarioResultImpl(RedirectAttributes redirectAttributes,
			@ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO) throws Exception {

		String testcaseId = testScenarioVO.getTestcaseId();
		testService.updateTestScenarioResult(testScenarioVO);
		redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.update"));

		return "redirect:/tms/test/selectTestResult.do?testcaseId=" + testcaseId;
	}

	/**
	 * 테스트케이스를 삭제한다
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/deleteTestCaseImpl.do")
	public String deleteTestCase(RedirectAttributes redirectAttributes,
			@ModelAttribute("testCaseVO") TestCaseVO testCaseVO) throws Exception {

		String testcaseId = testCaseVO.getTestcaseId();
		String testcaseGb = testCaseVO.getTestcaseGb();

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		testService.deleteTestCase(testcaseId);
		redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		}
		return "redirect:/tms/test/selectTestCaseList.do?testcaseGb=" + testcaseGb;
	}

	/**
	 * 메뉴목록 멀티 삭제한다.
	 * 
	 * @param checkedMenuNoForDel
	 *            String
	 * @return
	 * @exception Exception
	 */

	@RequestMapping("/tms/test/deleteMultiTestCase.do")
	public String deleteMultiTestCase(RedirectAttributes redirectAttributes,
			@RequestParam("checkedMenuNoForDel") String checkedMenuNoForDel,
			@ModelAttribute("testCaseVO") TestCaseVO testCaseVO) throws Exception {

		String testcaseGb = testCaseVO.getTestcaseGb();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		testService.deleteMultiTestCase(checkedMenuNoForDel);
		redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		}
		return "redirect:/tms/test/selectTestCaseList.do?testcaseGb=" + testcaseGb;
	}

	/**
	 * 삭제하려는 케이스를 참조하고 있는 시나리오가 있는지 개수를 확인한다.
	 * 
	 * @param checkedMenuNoForDel
	 *            String
	 * @return totalCount 시나리오가 있는 케이스의 개수
	 * @exception Exception
	 */

	@RequestMapping("/tms/test/selectScenarioCntReferringToCase.do")
	@ResponseBody
	public int selectScenarioCntReferringToCase(@RequestParam("checkedMenuNoForDel") String checkedMenuNoForDel)
			throws Exception {

		int totalCount = testService.selectScenarioCntReferringToCase(checkedMenuNoForDel);
		return totalCount;
	}

	/**
	 * 테스트시나리오를 삭제한다
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/deleteTestScenarioImpl.do")
	public String deleteTestScenario(RedirectAttributes redirectAttributes,
			@ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO) throws Exception {

		String testscenarioId = testScenarioVO.getTestscenarioId();
		String testcaseId = testScenarioVO.getTestcaseId();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		testService.deleteTestScenario(testscenarioId);
		redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		}
		return "redirect:/tms/test/selectTestCaseWithScenario.do?testcaseId=" + testcaseId;
	}

	/**
	 * 메뉴목록 멀티 삭제한다.
	 * 
	 * @param checkedMenuNoForDel
	 *            String
	 * @return
	 * @exception Exception
	 */
	@RequestMapping("/tms/test/deleteMultiTestScenario.do")
	public String deleteMultiTestScenario(RedirectAttributes redirectAttributes,
			@RequestParam("checkedMenuNoForDel") String checkedMenuNoForDel,
			@ModelAttribute("testScenarioVO") TestScenarioVO testScenarioVO, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		testService.deleteMultiTestScenario(checkedMenuNoForDel);
		redirectAttributes.addFlashAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		}
		return "redirect:/tms/test/selectTestCaseWithScenario.do?testcaseId=" + (String)testScenarioVO.getTestcaseId();
	}

	/**
	 * 테스트케이스를 가져온다
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestCase.do")
	public String selectTestCase(@RequestParam("testcaseId") String testcaseId,
			@RequestParam("returnPg") String returnPg, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		HashMap<String, Object> testVoMap = testService.selectTestCase(testcaseId);
		List<?> testScenarioList = testService.selectTestScenarioList(testcaseId);
		model.addAttribute("testScenarioList", testScenarioList);
		model.addAttribute("testVoMap", testVoMap);
		}
		return "tms/test/" + returnPg;
	}
	
	/**
	 * 테스트케이스Id 중복체크
	 * 
	 * @param testcaseId
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/checkTestCaseIdDuplication.do")
	@ResponseBody
	public boolean checkTestCaseIdDuplication(@RequestParam("testcaseId") String testcaseId, ModelMap model) throws Exception {

		HashMap<String, Object> testVoMap = testService.selectTestCase(testcaseId);
		//테스크케이스Id 중복시 false
		if(testVoMap != null) {return false;}
		else {return true;}
	}
	
	/**
	 * 테스트시나리오Id 중복체크
	 * 
	 * @param testscenarioId
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/checkTestScenarioIdDuplication.do")
	@ResponseBody
	public boolean checkTestScenarioIdDuplication(@RequestParam("testscenarioId") String testscenarioId, ModelMap model) throws Exception {

		TestScenarioVO vo = testService.selectTestScenario(testscenarioId);
		//테스크케이스Id 중복시 false
		if(vo != null){return false;}
		else {return true;}
	}

	/**
	 * 테스트케이스와 케이스에 해당하는 시나리오 목록을 가져온다
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestCaseWithScenario.do")
	public String selectTestCaseWithScenario(@RequestParam("testcaseId") String testcaseId, ModelMap model)
			throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		HashMap<String, Object> testVoMap = testService.selectTestCase(testcaseId);
		List<?> testScenarioList = testService.selectTestScenarioList(testcaseId);
		model.addAttribute("testScenarioList", testScenarioList);
		model.addAttribute("testVoMap", testVoMap);
		}
		return "tms/test/TestScenarioManage";
	}

	/**
	 * 테스트케이스와 케이스에 해당하는 시나리오 목록을 가져온다 ( 시나리오리스트 페이지에서 비동기처리 )
	 * 
	 * @param
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestScenarioOnScenarioListPg.do")
	@ResponseBody
	public HashMap<String, Object> selectTestScenarioOnScenarioListPg(@RequestParam("testcaseId") String testcaseId,
			@RequestParam("testcaseGb") String testcaseGb, ModelMap model, HttpServletRequest request)
			throws Exception {

		HashMap<String, Object> resultData = new HashMap<String, Object>();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		HashMap<String, Object> testVoMap = testService.selectTestCase(testcaseId);
		List<?> testScenarioList = testService.selectTestScenarioList(testcaseId);
		resultData.put("testVoMap", testVoMap);
		resultData.put("testcaseGb", testcaseGb);
		resultData.put("testScenarioList", testScenarioList);
		}
		return resultData;
	}

	/**
	 * 테스트케이스와 시나리오의 결과를 관리한다.
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 testCaseVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestResult.do")
	public String selectTestResult(@RequestParam("testcaseId") String testcaseId, ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		HashMap<String, Object> testVoMap = testService.selectTestCase(testcaseId);
		List<?> testScenarioList = testService.selectTestScenarioList(testcaseId);
		model.addAttribute("testScenarioList", testScenarioList);
		model.addAttribute("testVoMap", testVoMap);
		}
		return "tms/test/TestResultManage";
	}

	/**
	 * 테스트케이스 목록을 가져온다
	 * 
	 * @param vo
	 *            - 정보가 담긴 searchVO
	 * @return 등록 결과
	 * @exception Exception
	 */

	@RequestMapping(value = "/tms/test/selectTestCaseList.do")
	public String selectTestCaseList(HttpServletRequest request, @ModelAttribute("searchVO") TestDefaultVO searchVO,
			ModelMap model) throws Exception {

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

		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("TASKGB"); //업무구분
		List<CmmnDetailCode> codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("taskGbCode", codeResult);

		vo.setCodeId("SYSGB"); //시스템구분
		codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("sysGbCode", codeResult);

		vo.setCodeId("RESULTYN"); //완료여부
		codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("resultYnCode", codeResult);

		// 테스트케이스 구분에 따른 jsp페이지 설정(단위/통합)
		String testcaseGb = (String) request.getParameter("testcaseGb");
		searchVO.setSearchByTestcaseGb(testcaseGb);

		String link = "tms/test/TestCaseListUtc";
		link = (testcaseGb.equals("TC2")) ? "tms/test/TestCaseListTtc" : link;

		// 테스트 케이스 목록 가져오기
		List<?> testCaseList = testService.selectTestCaseList(searchVO);
		model.addAttribute("testCaseList", testCaseList);

		// 테스트 케이스 목록 개수 가져오기
		int totCnt = testService.selectTestCaseListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		return link;
	}

	/**
	 * 테스트케이스 목록을 가져온다
	 * 
	 * @param vo
	 *            - 정보가 담긴 searchVO
	 * @returnPg TestScenarioListUtc / TestScenarioListTtc
	 * @exception Exception
	 */

	@RequestMapping(value = "/tms/test/selectTestScenarioList.do")
	public String selectTestScenarioList(HttpServletRequest request, @ModelAttribute("searchVO") TestDefaultVO searchVO,
			ModelMap model) throws Exception {

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

		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("TASKGB"); //업무구분
		List<CmmnDetailCode> codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("taskGbCode", codeResult);

		vo.setCodeId("SYSGB"); //시스템구분
		codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("sysGbCode", codeResult);

		vo.setCodeId("RESULTYN"); //완료여부
		codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("resultYnCode", codeResult);

		// 테스트케이스 구분에 따른 jsp페이지 설정(단위/통합)
		String testcaseGb = (String) request.getParameter("testcaseGb");
		searchVO.setSearchByTestcaseGb(testcaseGb);

		String link = "tms/test/TestScenarioListUtc";
		link = (testcaseGb.equals("TC2")) ? "tms/test/TestScenarioListTtc" : link;
		
		// 테스트 케이스 목록 가져오기
		List<?> testCaseList = testService.selectTestCaseList(searchVO);
		model.addAttribute("testCaseList", testCaseList);

		// 테스트 케이스 목록 개수 가져오기
		int totCnt = testService.selectTestCaseListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		return link;
	}

	/**
	 * 테스트케이스 목록을 가져온다
	 * 
	 * @param vo
	 *            - 정보가 담긴 searchVO
	 * @returnPg TestResultListUtc / TestResultListTtc
	 * @exception Exception
	 */

	@RequestMapping(value = "/tms/test/selectTestResultList.do")
	public String selectTestResultList(HttpServletRequest request, @ModelAttribute("searchVO") TestDefaultVO searchVO,
			ModelMap model) throws Exception {

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

		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("TASKGB"); //업무구분
		List<CmmnDetailCode> codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("taskGbCode", codeResult);

		vo.setCodeId("SYSGB"); //시스템구분
		codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("sysGbCode", codeResult);

		vo.setCodeId("RESULTYN"); //완료여부
		codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("resultYnCode", codeResult);

		// 테스트케이스 구분에 따른 jsp페이지 설정(단위/통합)
		String testcaseGb = (String) request.getParameter("testcaseGb");
		searchVO.setSearchByTestcaseGb(testcaseGb);

		String link = "tms/test/TestResultListUtc";
		link = (testcaseGb.equals("TC2")) ? "tms/test/TestResultListTtc" : link;
		
		// 테스트 케이스 목록 가져오기
		List<?> testCaseList = testService.selectTestCaseList(searchVO);
		model.addAttribute("testCaseList", testCaseList);

		// 테스트 케이스 목록 개수 가져오기
		int totCnt = testService.selectTestCaseListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		return link;
	}

	/**
	 * 테스트 통계를 보여준다.(대시보드)
	 * 
	 * @param vo
	 *            - 등록할 정보가 담긴 testCaseVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/test/selectTestStats.do")
	public String selectTestStatsDashboard(ModelMap model) throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		// 단위 테스트 통계
		HashMap<String, Integer> testCaseStatsMapTC1 = testService.selectTestCaseStats("TC1");
		model.addAttribute("testCaseStatsMapTC1", testCaseStatsMapTC1);

		// 통합 테스트 통계
		HashMap<String, Integer> testCaseStatsMapTC2 = testService.selectTestCaseStats("TC2");
		model.addAttribute("testCaseStatsMapTC2", testCaseStatsMapTC2);

		// 통합 테스트 진행 상태
		HashMap<String, Object> ProgressStatusTtc = testService.selectTestCaseProgressStatus("TC2");
		model.addAttribute("ProgressStatusTtc", JSONObject.toJSONString(ProgressStatusTtc));
		
		//특정 시스템에 대한 '업무별' 단위테스트 케이스 
		String sysNm = null;
		List<?> taskByTestcaseCnt = testService.selectTestCaseStatsListByTaskGb(sysNm);
		model.addAttribute("taskByTestcaseCnt", JSONArray.fromObject(taskByTestcaseCnt));
		
		//시스템별 단위테스트케이스
		List<?> tcStatsBySysGb = testService.selectTestCaseStatsListBySysGb();
		model.addAttribute("tcStatsBySysGb", JSONArray.fromObject(tcStatsBySysGb));
		
		}
		return "tms/test/TestStatsDashboard";
	}

	
	/**
	 * 특정 시스템구분에 관한 업무별 테스트케이스 통계를 가져온다
	 * 
	 * @param String- 정보가 담긴 sysNm
	 * @return 등록 결과
	 * @exception Exception
	 */
	   @RequestMapping("/tms/test/selectTestCaseStatsListByTaskGb.do")
	   @ResponseBody
	   public List<?> selectTestCaseStatsListByTaskGb(String sysNm) throws Exception {
		   
	      List<?> taskByTestcaseCnt = testService.selectTestCaseStatsListByTaskGb(sysNm.equals("전체") ? null : sysNm);
	      return taskByTestcaseCnt;
	   }
	
	/**
	 * 테스트케이스 현황(단위,통합)을 가져온다
	 * 
	 * @param vo
	 *            - 정보가 담긴 searchVO
	 * @return 등록 결과
	 * @exception Exception
	 */

	@RequestMapping(value = "/tms/test/selectTestCurrent.do")
	public String selectTestCurrent(HttpServletRequest request, @ModelAttribute("searchVO") TestDefaultVO searchVO,
			ModelMap model) throws Exception {

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

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("TASKGB"); // '업무구분'
		List<CmmnDetailCode> codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("taskGbCode", codeResult);

		vo.setCodeId("TCGB"); // '테스트케이스 구분'
		codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("tcGbCode", codeResult);

		vo.setCodeId("RESULTYN"); // '완료여부'
		codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("resultYnCode", codeResult);

		// 테스트 현황 목록 가져오기
		List<?> testCurrent = testService.selectTestCurrent(searchVO);
		model.addAttribute("testCurrent", testCurrent);

		// 테스트 현황 목록 개수 가져오기
		int totCnt = testService.selectTestCurrentTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		// 테스트 현황 총 개수, 완료 개수, 미완료 개수 가져오기
		HashMap<String, Object> selectTestCurrentCnt = testService.selectTestCurrentCnt(searchVO);
		model.addAttribute("selectTestCurrentCnt", selectTestCurrentCnt);
		}
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		return "tms/test/TestCurrent";
	}

	/**
	 * 테스트케이스 현황(단위,통합)을 가져온다
	 * 
	 * @param vo
	 *            - 정보가 담긴 searchVO
	 * @return 등록 결과
	 * @exception Exception
	 */

	@RequestMapping(value = "/tms/test/selectTestStatsTable.do")
	public String selectTestStatsTable(HttpServletRequest request, @ModelAttribute("searchVO") TestDefaultVO searchVO,
			ModelMap model) throws Exception {

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

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		// '테스트케이스 구분' 공통코드 가져오기
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("TCGB");
		List<CmmnDetailCode> codeResult = egovCmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("tcGbCode", codeResult);

		// 테스트 현황 목록 가져오기
		List<?> testStatsTable = testService.selectTestStatsTable(searchVO);
		model.addAttribute("testStatsTable", testStatsTable);
		}
		return "tms/test/TestStatsTable";
	}

	/**
	 * 통계 엑셀 다운로드 기능
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/tms/test/statsToExcel.do")
	public String statsToExcel(RedirectAttributes redirectAttributes, @RequestParam("testcaseGb") String testcaseGb,
			ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
		TestDefaultVO vo = new TestDefaultVO();
		vo.setSearchByTestcaseGb(testcaseGb);
		List<?> testStatsTable = testService.selectTestStatsTable(vo);
		testStatsXlsxWriter(testStatsTable, testcaseGb, response);
		}
		return "redirect:/tms/test/selectTestStatsTable.do";

	}

	
	/**
	 * 현황 엑셀 다운로드 기능
	 * 
	 * @throws Exception
	 */
	@RequestMapping(value = "/tms/test/currentToExcel.do")
	public String currentToExcel(RedirectAttributes redirectAttributes,
			ModelMap model, @ModelAttribute("searchVO") TestDefaultVO searchVO, HttpServletResponse response) throws Exception {
		
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		if (isAuthenticated) {
			searchVO.setExcel(true);
			List<?> testCurrent = testService.selectTestCurrent(searchVO);
			testCurrentXlsxWriter(testCurrent, searchVO.getAsOf() ,response);
		}
		return "redirect:/tms/test/selectTestCurrent.do";

	}
	
	public void testCurrentXlsxWriter(List<?> list, String asOf, HttpServletResponse response) throws Exception {

		// 워크북 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		// 워크시트 생성
		XSSFSheet sheet = workbook.createSheet();
		// 행 생성
		XSSFRow row = sheet.createRow(0);
		// 쎌 생성
		XSSFCell cell;

		Font defaultFont = workbook.createFont();
		defaultFont.setFontHeightInPoints((short) 11);
		defaultFont.setFontName("맑은 고딕");

		// 제목 스타일
		CellStyle HeadStyle = workbook.createCellStyle();
		HeadStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HeadStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HeadStyle.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
		HeadStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		HeadStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		HeadStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		HeadStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		HeadStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		HeadStyle.setFont(defaultFont);

		// 본문 스타일
		CellStyle BodyStyle = workbook.createCellStyle();
		BodyStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		BodyStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		BodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		BodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		BodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		BodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		BodyStyle.setFont(defaultFont);

		// 헤더 정보 구성
		if(asOf.equals("pgId")){
			cell = row.createCell(0);
			cell.setCellValue("화면ID");
			cell.setCellStyle(HeadStyle); // 제목스타일

			cell = row.createCell(1);
			cell.setCellValue("업무구분");
			cell.setCellStyle(HeadStyle); // 제목스타일

			cell = row.createCell(2);
			cell.setCellValue("테스트케이스 ID");
			cell.setCellStyle(HeadStyle); // 제목스타일

			cell = row.createCell(3);
			cell.setCellValue("테스트케이스명");
			cell.setCellStyle(HeadStyle); // 제목스타일
			
		} else if(asOf.equals("testcaseId")) {
			
			cell = row.createCell(0);
			cell.setCellValue("테스트케이스 ID");
			cell.setCellStyle(HeadStyle); // 제목스타일

			cell = row.createCell(1);
			cell.setCellValue("테스트케이스명");
			cell.setCellStyle(HeadStyle); // 제목스타일

			cell = row.createCell(2);
			cell.setCellValue("화면ID");
			cell.setCellStyle(HeadStyle); // 제목스타일

			cell = row.createCell(3);
			cell.setCellValue("업무구분");
			cell.setCellStyle(HeadStyle); // 제목스타일
		}
		
		cell = row.createCell(4);
		cell.setCellValue("작성자");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(5);
		cell.setCellValue("등록일자");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(6);
		cell.setCellValue("완료일자");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(7);
		cell.setCellValue("1차");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(8);
		cell.setCellValue("2차");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(9);
		cell.setCellValue("완료여부");
		cell.setCellStyle(HeadStyle); // 제목스타일

		String tempSt;
		SimpleDateFormat sdft = new SimpleDateFormat("yyyy-MM-dd");
		
		// 리스트의 size 만큼 row를 생성
		for (int i = 0; i < list.size(); i++) {
			// 행 생성
			EgovMap recode = (EgovMap) list.get(i);
			row = sheet.createRow(i + 1);

			if(asOf.equals("pgId")){
				cell = row.createCell(0);
				cell.setCellValue((String) recode.get("pgId"));
				cell.setCellStyle(BodyStyle); // 본문스타일
				
				cell = row.createCell(1);
				cell.setCellValue((String) recode.get("taskGbNm"));
				cell.setCellStyle(BodyStyle); // 본문스타일
				
				cell = row.createCell(2);
				cell.setCellValue((String)recode.get("testcaseId"));
				cell.setCellStyle(BodyStyle); // 본문스타일
				
				cell = row.createCell(3);
				cell.setCellValue((String)recode.get("testcaseContent"));
				cell.setCellStyle(BodyStyle); // 본문스타일
				
			} else if(asOf.equals("testcaseId")) {
				cell = row.createCell(0);
				cell.setCellValue((String) recode.get("testcaseId"));
				cell.setCellStyle(BodyStyle); // 본문스타일
				
				cell = row.createCell(1);
				cell.setCellValue((String) recode.get("testcaseContent"));
				cell.setCellStyle(BodyStyle); // 본문스타일
				
				cell = row.createCell(2);
				cell.setCellValue((String)recode.get("pgId"));
				cell.setCellStyle(BodyStyle); // 본문스타일
				
				cell = row.createCell(3);
				cell.setCellValue((String)recode.get("taskGbNm"));
				cell.setCellStyle(BodyStyle); // 본문스타일
			}
			
			cell = row.createCell(4);
			cell.setCellValue((String)recode.get("userNm"));
			cell.setCellStyle(BodyStyle); // 본문스타일
			
			tempSt = (Date)recode.get("enrollDt") != null ? sdft.format((Date)recode.get("enrollDt")) : "";
			cell = row.createCell(5);
			cell.setCellValue(tempSt);
			cell.setCellStyle(BodyStyle); // 본문스타일
			
			tempSt = (Date)recode.get("completeDt") != null ? sdft.format((Date)recode.get("completeDt")) : "";
			cell = row.createCell(6);
			cell.setCellValue(tempSt);
			cell.setCellStyle(BodyStyle); // 본문스타일
			
			cell = row.createCell(7);
			cell.setCellValue((String)recode.get("firstTestResultYn"));
			cell.setCellStyle(BodyStyle); // 본문스타일
			
			cell = row.createCell(8);
			cell.setCellValue((String)recode.get("secondTestResultYn"));
			cell.setCellStyle(BodyStyle); // 본문스타일
			
			cell = row.createCell(9);
			cell.setCellValue((String)recode.get("completeYn"));
			cell.setCellStyle(BodyStyle); // 본문스타일
		}

		/** 3. 컬럼 Width */
		for (int i = 0; i < list.size(); i++) {
			sheet.autoSizeColumn(i);
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000);
		}

		// 입력된 내용 파일로 쓰기
		File folder = new File("C:\\TMS\\TMS_통계자료");
		File file = new File("C:\\TMS\\TMS_통계자료\\프로그램현황.xlsx");

		// 디렉토리 생성 메서드
		if (!folder.exists()) {
			folder.mkdirs();
		}

		FileOutputStream fos = null;

		try {
			fos = new FileOutputStream(file);
			workbook.write(fos);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (workbook != null) // workbook.close();
					if (fos != null)
						fos.close();

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		/** 경로 다운로드 */
		String path = "C:/TMS/TMS_통계자료/"; // Link의 자바파일에서 excel 파일이 생성된 경로
		String realFileNm = "프로그램현황.xlsx";

		File uFile = new File(path, realFileNm);
		int fSize = (int) uFile.length();
		if (fSize > 0) { // 파일 사이즈가 0보다 클 경우 다운로드
			String mimetype = "application/x-msdownload"; // minetype은 파일확장자에 맞게
															// 설정
			response.setHeader("Content-Disposition", "attachment; filename=\"TMS.xlsx\"");
			response.setContentType(mimetype);
			response.setContentLength(fSize);
			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {

				in = new BufferedInputStream(new FileInputStream(uFile));
				out = new BufferedOutputStream(response.getOutputStream());
				FileCopyUtils.copy(in, out);
				out.flush();
			} catch (Exception ex) {
			} finally {
				String path1 = "C:/TMS/TMS_통계자료/프로그램현황.xlsx";
				File deleteFolder = new File(path1);
				deleteFolder.delete();
				String path2 = "C:/TMS/TMS_통계자료";
				File deleteFolder2 = new File(path2);
				deleteFolder2.delete();
				String path3 = "C:/TMS";
				File deleteFolder3 = new File(path3);
				deleteFolder3.delete();
				if (in != null)
					in.close();
				if (out != null)
					out.close();
			}
		} else {
			response.setContentType("application/x-msdownload");

			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + realFileNm + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}

	}

	public void testStatsXlsxWriter(List<?> list, String testcaseGb, HttpServletResponse response) throws Exception {

		// 워크북 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		// 워크시트 생성
		XSSFSheet sheet = workbook.createSheet();
		// 행 생성
		XSSFRow row = sheet.createRow(0);
		// 쎌 생성
		XSSFCell cell;

		Font defaultFont = workbook.createFont();
		defaultFont.setFontHeightInPoints((short) 11);
		defaultFont.setFontName("맑은 고딕");

		// 제목 스타일
		CellStyle HeadStyle = workbook.createCellStyle();
		HeadStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HeadStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HeadStyle.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index);
		HeadStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		HeadStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		HeadStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		HeadStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		HeadStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
		HeadStyle.setFont(defaultFont);

		// 본문 스타일
		CellStyle BodyStyle = workbook.createCellStyle();
		BodyStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		BodyStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		BodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		BodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		BodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		BodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		BodyStyle.setFont(defaultFont);

		// 헤더 정보 구성
		cell = row.createCell(0);
		cell.setCellValue("시스템구분");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(1);
		cell.setCellValue("업무구분");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(2);
		cell.setCellValue("프로그램 본수");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(3);
		cell.setCellValue("테스트케이스 개수");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(4);
		cell.setCellValue("미진행");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(5);
		cell.setCellValue("1차");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(6);
		cell.setCellValue("2차");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(7);
		cell.setCellValue("진행률(%)");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(8);
		cell.setCellValue("완료");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(9);
		cell.setCellValue("미완료");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(10);
		cell.setCellValue("합계");
		cell.setCellStyle(HeadStyle); // 제목스타일

		cell = row.createCell(11);
		cell.setCellValue("완료율(%)");
		cell.setCellStyle(HeadStyle); // 제목스타일

		System.out.println(list.size());
		// 리스트의 size 만큼 row를 생성
		for (int i = 0; i < list.size(); i++) {
			// 행 생성
			EgovMap recode = (EgovMap) list.get(i);
			row = sheet.createRow(i + 1);

			cell = row.createCell(0);
			cell.setCellValue((String) recode.get("sysGb"));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(1);
			cell.setCellValue((String) recode.get("taskGb"));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(2);
			cell.setCellValue(String.valueOf(recode.get("pgCnt")));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(3);
			cell.setCellValue(String.valueOf(recode.get("tcWriteYCnt")));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(4);
			cell.setCellValue(String.valueOf(recode.get("notTestCnt")));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(5);
			cell.setCellValue(String.valueOf(recode.get("firstTestCnt")));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(6);
			cell.setCellValue(String.valueOf(recode.get("secondTestCnt")));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(7);
			cell.setCellValue(String.valueOf(recode.get("tcProgressPct")));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(8);
			cell.setCellValue(String.valueOf(recode.get("tcResultYCnt")));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(9);
			cell.setCellValue(String.valueOf(recode.get("tcResultNCnt")));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(10);
			cell.setCellValue(String.valueOf(recode.get("tcWriteYCnt")));
			cell.setCellStyle(BodyStyle); // 본문스타일

			cell = row.createCell(11);
			cell.setCellValue(String.valueOf(recode.get("tcResultPct")));
			cell.setCellStyle(BodyStyle); // 본문스타일

		}

		/** 3. 컬럼 Width */
		for (int i = 0; i < list.size(); i++) {
			sheet.autoSizeColumn(i);
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000);
		}

		// 입력된 내용 파일로 쓰기
		File folder = new File("C:\\TMS\\TMS_통계자료");
		File file = new File("C:\\TMS\\TMS_통계자료\\프로그램현황.xlsx");

		// 디렉토리 생성 메서드
		if (!folder.exists()) {
			folder.mkdirs();
		}

		FileOutputStream fos = null;

		try {
			fos = new FileOutputStream(file);
			workbook.write(fos);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (workbook != null) // workbook.close();
					if (fos != null)
						fos.close();

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		/** 경로 다운로드 */
		String path = "C:/TMS/TMS_통계자료/"; // Link의 자바파일에서 excel 파일이 생성된 경로
		String realFileNm = "프로그램현황.xlsx";

		File uFile = new File(path, realFileNm);
		int fSize = (int) uFile.length();
		if (fSize > 0) { // 파일 사이즈가 0보다 클 경우 다운로드
			String mimetype = "application/x-msdownload"; // minetype은 파일확장자에 맞게
															// 설정
			response.setHeader("Content-Disposition", "attachment; filename=\"TMS.xlsx\"");
			response.setContentType(mimetype);
			response.setContentLength(fSize);
			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {

				in = new BufferedInputStream(new FileInputStream(uFile));
				out = new BufferedOutputStream(response.getOutputStream());
				FileCopyUtils.copy(in, out);
				out.flush();
			} catch (Exception ex) {
			} finally {
				String path1 = "C:/TMS/TMS_통계자료/프로그램현황.xlsx";
				File deleteFolder = new File(path1);
				deleteFolder.delete();
				String path2 = "C:/TMS/TMS_통계자료";
				File deleteFolder2 = new File(path2);
				deleteFolder2.delete();
				String path3 = "C:/TMS";
				File deleteFolder3 = new File(path3);
				deleteFolder3.delete();
				if (in != null)
					in.close();
				if (out != null)
					out.close();
			}
		} else {
			response.setContentType("application/x-msdownload");

			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + realFileNm + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}

	}

}
