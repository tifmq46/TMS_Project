package egovframework.let.tms.dev.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.annotation.Resource;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.let.sym.prm.service.TmsProgrmManageService;
import egovframework.let.sym.prm.service.TmsProjectManageVO;
import egovframework.let.tms.defect.service.DefectService;
import egovframework.let.tms.dev.service.DevPlanDefaultVO;
import egovframework.let.tms.dev.service.DevPlanService;
import egovframework.let.tms.dev.service.DevPlanVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
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
	
	/** DefectService */
	@Resource (name = "defectService")
	private DefectService defectService;
	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 DevPlanDefaultVO
	 * @param model
	 * @return "DevPlanList"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/tms/dev/devPlans.do")
	public String selectDevPlans(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model) throws Exception {
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		searchVO.setSessionId(user.getName());
		searchVO.setUniqId(user.getUniqId());
		searchVO.setId(user.getId());
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		searchVO.setSessionId(user.getName());
		
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
		
		String a = String.valueOf(searchVO.getSearchBySysGb());
		if(searchVO.getSearchBySysGb() != null && searchVO.getSearchBySysGb() != "") {
			List<String> taskGbList2 = TmsProgrmManageService.selectTaskGb4(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		
		List<String> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<?> userList = defectService.selectUser(0);
		model.addAttribute("userList", userList);
		
		List<HashMap<String,String>> devList = devPlanService.selectDevPlans(searchVO);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String inputStartDate, inputEndDate;
		Date startDate, endDate;
		int dayDiff; 
		
		for(int i=0; i<devList.size(); i++){
			if(((devList.get(i).get("PLAN_START_DT")) == null || "".equals(devList.get(i).get("PLAN_START_DT")))
					&&((devList.get(i).get("PLAN_END_DT")) == null || "".equals(devList.get(i).get("PLAN_END_DT")))
					){
				
			}else{
				inputStartDate =  String.valueOf(devList.get(i).get("PLAN_START_DT"));
				inputEndDate = String.valueOf(devList.get(i).get("PLAN_END_DT"));
				startDate = sdf.parse(inputStartDate);
				endDate = sdf.parse(inputEndDate);
				dayDiff = betweenDate(startDate,endDate).size();
				searchVO.setDayDiff(dayDiff);
				searchVO.setPgId(devList.get(i).get("PG_ID"));
				devPlanService.insertDayDiff(searchVO);
			}
		}
		
		devList = devPlanService.selectDevPlans(searchVO);
		model.addAttribute("resultList", devList);
		
		int totCnt = devPlanService.selectDevPlanListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);

		//계획 입력 가능일자
		Date currentTime = new Date ();
		String mTime = sdf.format (currentTime);
		Date currentDate = sdf.parse(mTime);

		TmsProjectManageVO tmsPrj = TmsProgrmManageService.selectProject();
		
		model.addAttribute("tms", tmsPrj);	
		
		//********************
		if(!Objects.equals(tmsPrj, null)){
			if(!Objects.equals(tmsPrj.getPlanStartDt(), null) && !Objects.equals(tmsPrj.getPlanEndDt(), null)){
				Date ps = tmsPrj.getPlanStartDt();
				String formatPs = sdf.format(ps);
	
				Date pe = tmsPrj.getPlanEndDt();
				String formatPe = sdf.format(pe);
				
				model.addAttribute("ps", formatPs);
				model.addAttribute("pe", formatPe);
			}
		
			if(!Objects.equals(tmsPrj.getInputStartDt(), null) && !Objects.equals(tmsPrj.getInputEndDt(), null)){
				Date sDate = tmsPrj.getInputStartDt();
				Date eDate = tmsPrj.getInputEndDt();

				int compare = currentDate.compareTo(sDate);
				int compare2 = currentDate.compareTo(eDate);
				
				boolean d_result = true;
				
				if((compare >= 0) && (compare2 <=0) ){
					d_result = false;
				}else{
					d_result = true;
				}
				model.addAttribute("start", sDate);
				model.addAttribute("end", eDate);
				model.addAttribute("d_test", d_result);
			}
		}
		model.addAttribute("page", searchVO.getPageIndex());
		
		return "tms/dev/devPlanList";
	}
	
	/**소요일수 비동기 처리 */
	@RequestMapping("/tms/dev/selectBetweenDate.do")
	@ResponseBody
	public String selectBetweenDate(String start, String end) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		if(start.equals("") || end.equals("")){
			return null;
		}else{
			Date startDate = sdf.parse(start);
			Date endDate = sdf.parse(end);
			ArrayList<String> a= betweenDate(startDate, endDate);
			return String.valueOf(a.size());
		}
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
		if (isAuthenticated) {
			devPlanService.insertDevPlan(dvo);
		}

		return "redirect:/tms/dev/devPlans.do";
	}
	
	@RequestMapping(value = "/tms/dev/updateDevPlan.do")
	public String updateDevPlan(final RedirectAttributes redirectAttributes, @ModelAttribute("search") DevPlanVO dvo, @ModelAttribute("searchVO") DevPlanDefaultVO vo, BindingResult bindingResult, SessionStatus status, Model model) throws Exception {

		String result = devPlanService.ifNullDevPlan(dvo.getPgId());
		String r = String.valueOf(result);
		if(r.equals("1")){
			devPlanService.updateDevPlan(dvo);
			status.setComplete(); 
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
		}else{
			devPlanService.insertDevPlan(dvo);
		}
			
			model.addAttribute("pageIndex", vo.getPageIndex());
			redirectAttributes.addFlashAttribute("searchVO", vo);
			
			return "redirect:/tms/dev/devPlans.do";
		
	}

	@RequestMapping(value = "/tms/dev/deleteDevPlan.do")
	public String deleteDevPlan(final RedirectAttributes redirectAttributes, @ModelAttribute("searchVO") DevPlanDefaultVO dvo, SessionStatus status, Model model) throws Exception {

		devPlanService.deleteDevPlan(dvo);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		
		redirectAttributes.addFlashAttribute("searchVO", dvo);
		
		return "redirect:/tms/dev/devPlans.do";
	}
	
	/**
	 * 개발결과
	 */
	@RequestMapping(value = "/tms/dev/devResultList.do")
	public String selectDevResultList(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model) throws Exception {
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		searchVO.setSessionId(user.getName());
		searchVO.setUniqId(user.getUniqId());
		searchVO.setId(user.getId());
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		searchVO.setSessionId(user.getName());
		
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
		List<String> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		String a = String.valueOf(searchVO.getSearchBySysGb());
		if(searchVO.getSearchBySysGb() != null && searchVO.getSearchBySysGb() != "") {
			List<String> taskGbList2 = TmsProgrmManageService.selectTaskGb4(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		
		List<String> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<?> userList = defectService.selectUser(0);
		model.addAttribute("userList", userList);
		
		List<HashMap<String,String>> devResultList = devPlanService.selectDevResultList(searchVO);
		model.addAttribute("resultList", devResultList);
		
		int totCnt = devPlanService.selectDevResultListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("page", searchVO.getPageIndex());
		
		return "tms/dev/devResultList";
	}
	
	@RequestMapping(value = "/tms/dev/updateDevResult.do")
	public String updateDevResult(final RedirectAttributes redirectAttributes, @ModelAttribute("searchVO") DevPlanDefaultVO dvo,@RequestParam String flag, BindingResult bindingResult, SessionStatus status, Model model) throws Exception {

		String devStartDt, devEndDt,devAchRate;
		int achRate=0;

		devStartDt = String.valueOf(dvo.getDevStartDt());
		devEndDt = String.valueOf(dvo.getDevEndDt());
		devAchRate = String.valueOf(dvo.getAchievementRate());
			
			if(flag.equals("auto")){
				if(!devStartDt.equals("null")){
					if(!devEndDt.equals("null")){
						achRate=100;
					}else{
						if(devAchRate.equals("0")){
							achRate = 50;
						}else{
							achRate = dvo.getAchievementRate();
						}
					}
				}else{
					achRate=0;
				}
			}else if(flag.equals("change")){
				if(!devEndDt.equals("null")){
					achRate = 100;
				}else{
					achRate = dvo.getAchievementRate();
				}
			}
			
			dvo.setAchievementRate(achRate);
			devPlanService.updateDevResult(dvo);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
			
			redirectAttributes.addFlashAttribute("searchVO", dvo);
			
			return "redirect:/tms/dev/devResultList.do";
	}
	
	@SuppressWarnings({ "unchecked", "static-access" })
	@RequestMapping(value = "/tms/dev/devStatsTable.do")
	public String devStatsTable(@ModelAttribute("searchVO") DevPlanVO dvo, SessionStatus status, Model model) throws Exception {
		
		
		/*프로젝트의 개발기간의 주차 값과 차이를 가져온다.*/
		TmsProjectManageVO tt = TmsProgrmManageService.selectProject();
		model.addAttribute("tt", tt);
		
		/*프로젝트 개발계획 기간(주말 제외)*/
		if(!Objects.equals(tt, null)){
		
			Date startDate = tt.getDevStartDt();
			Date endDate = tt.getDevEndDt();
			
			devPlanService.deleteDates();
			
			ArrayList<String> dates = betweenDate(startDate, endDate);
			for(String date : dates){
				devPlanService.insertDates(date);
			}
		
		
			List<String> userList = devPlanService.selectUserList();
			List<String> taskGbList = devPlanService.selectTaskGbList();
			
			List<String> periodList = devPlanService.selectPeriodWeek();
			
			List<String> periodMonthWeek = devPlanService.selectPeriodMonthWeek();
			model.addAttribute("monthWeek",periodMonthWeek);
			
			int s = Integer.parseInt(String.valueOf(periodList.get(0)));
			int e = Integer.parseInt(String.valueOf(periodList.get(periodList.size()-1)));
			
			
			//개발자별 통계 
			List<Map<String,Object>> userStats = stats("user", userList, periodList);
			int sumUserPlan =0;
			int sumUserDev =0;
			int sumUserDiff = 0;
			JSONArray userSumArray = new JSONArray();
			JSONObject userSumObj = new JSONObject();
			
			for(int j=s; j<=e; j++){
				userSumObj = new JSONObject();
				sumUserPlan =0;
				sumUserDev =0;
				sumUserDiff = 0;
				
				for(int i =0; i<userStats.size(); i++){
					sumUserPlan += Integer.parseInt(String.valueOf(userStats.get(i).get("a"+j)));
					sumUserDev += Integer.parseInt(String.valueOf(userStats.get(i).get("b"+j)));
					sumUserDiff += Integer.parseInt(String.valueOf(userStats.get(i).get("sub"+j)));
					}
				userSumObj.put("sumUserPlan"+j, sumUserPlan);
				userSumObj.put("sumUserDev"+j, sumUserDev);
				userSumObj.put("sumUserDiff"+j, sumUserDiff);
				userSumArray.add(userSumObj);
			}
			
			JsonUtil jsU = new JsonUtil();
			List<Map<String,Object>> userSum = jsU.getListMapFromJsonArray(userSumArray);
			
			model.addAttribute("userSum",userSum);
			model.addAttribute("userStats",userStats);
			
			model.addAttribute("begin", periodList.get(0));
			model.addAttribute("end", periodList.get(periodList.size()-1));
			
			//업무별 통계 
			List<Map<String,Object>> taskStats = stats("task", taskGbList, periodList);
			model.addAttribute("taskStats",taskStats);
			
			//전체 통계
			List<EgovMap> totalTable = devPlanService.selectStatsTable();
			model.addAttribute("totalTable", totalTable);
		}
		return "/tms/dev/devStatsTable";
	}
	
	@SuppressWarnings("unchecked")
	private List<Map<String, Object>> stats(String statsGb, List<String> list, List<String> periodList) {
		
		if(statsGb.equals("user")){
			List<HashMap<String,String>> userStatsList = new ArrayList<HashMap<String,String>>();
			HashMap<String,String> userMap = new HashMap<String,String>();
			
			for(int j=0; j<periodList.size(); j++){
				userMap.put("dt",String.valueOf(periodList.get(j)));
				userStatsList.addAll(devPlanService.selectUserWeekStats(userMap));
			}
			
			JSONArray userArray = new JSONArray();
			JSONObject userObj = new JSONObject();
			
			int sumUserPlan=0;
			int sumUserDev=0;
			int sumDiff=0;
			
			for(int i=0; i<list.size(); i++){

				userObj = new JSONObject();
				int temp = i;
				sumUserPlan = 0;
				sumUserDev = 0;
				sumDiff = 0;
				
				
				for(int j=0; j<periodList.size();j++){
					userObj.put("userDevId", userStatsList.get(temp).get("userDevId"));
					userObj.put("userDevNm", userStatsList.get(temp).get("userDevNm"));
					userObj.put("totCnt",userStatsList.get(temp).get("totCnt"));
					userObj.put("a"+periodList.get(j), userStatsList.get(temp).get(periodList.get(j)));
					userObj.put("b"+periodList.get(j), userStatsList.get(temp).get("b"+periodList.get(j)));
					userObj.put("sub"+periodList.get(j), userStatsList.get(temp).get("sub"+periodList.get(j)));
					
					sumUserPlan += Integer.parseInt(String.valueOf(userStatsList.get(temp).get(periodList.get(j))));
					sumUserDev += Integer.parseInt(String.valueOf(userStatsList.get(temp).get("b"+periodList.get(j))));
					sumDiff += Integer.parseInt(String.valueOf(userStatsList.get(temp).get("sub"+periodList.get(j))));
					
					temp += list.size();
				}
				userObj.put("sumUserPlan", sumUserPlan);
				userObj.put("sumUserDev", sumUserDev);
				userObj.put("sumDiff", sumDiff);
				userArray.add(userObj);
			}
			
			JsonUtil jsU = new JsonUtil();
			List<Map<String,Object>> userStats = jsU.getListMapFromJsonArray(userArray);
			
			return userStats;
			
		}else if(statsGb.equals("task")){
			
			List<HashMap<String,String>> taskStatsList = new ArrayList<HashMap<String,String>>();
			HashMap<String,String> taskMap = new HashMap<String,String>();

			for(int j=0; j<periodList.size(); j++){
				taskMap.put("dt",String.valueOf(periodList.get(j)));
				taskStatsList.addAll(devPlanService.selectTaskWeekStats(taskMap));
			}
			
			JSONArray taskArray = new JSONArray();
			JSONObject taskObj = new JSONObject();
			
			int sumTaskPlan=0;
			int sumTaskDev=0;
			int sumDiff = 0;
			
			int sysCnt = devPlanService.selectSysGbCnt();

			for(int i=0; i<list.size()+sysCnt+1; i++){
				taskObj = new JSONObject();
				int temp=i;
				sumTaskPlan=0;
				sumTaskDev=0;
				sumDiff = 0;
				for(int j=0; j<periodList.size();j++){
					taskObj.put("sysGbNm", taskStatsList.get(temp).get("sysGbNm"));
					taskObj.put("taskGbNm", taskStatsList.get(temp).get("taskGbNm"));
					taskObj.put("totCnt", String.valueOf(taskStatsList.get(temp).get("totCnt")));
					taskObj.put("a"+periodList.get(j), taskStatsList.get(temp).get(periodList.get(j)));
					taskObj.put("b"+periodList.get(j), taskStatsList.get(temp).get("b"+periodList.get(j)));
					taskObj.put("sub"+periodList.get(j), taskStatsList.get(temp).get("sub"+periodList.get(j)));
					
					sumTaskPlan += Integer.parseInt(String.valueOf(taskStatsList.get(temp).get(periodList.get(j))));
					sumTaskDev += Integer.parseInt(String.valueOf(taskStatsList.get(temp).get("b"+periodList.get(j))));
					sumDiff += Integer.parseInt(String.valueOf(taskStatsList.get(temp).get("sub"+periodList.get(j))));
					temp+=list.size()+sysCnt+1;
					System.out.println("temp"+temp);
				}
				taskObj.put("sumTaskPlan", sumTaskPlan);
				taskObj.put("sumTaskDev", sumTaskDev);
				taskObj.put("sumDiff", sumDiff);
				taskArray.add(taskObj);
			}
			JsonUtil jsU = new JsonUtil();
			List<Map<String,Object>> taskStats = jsU.getListMapFromJsonArray(taskArray);
			
			return taskStats;
			
		}else{
			return null;
		}
	}
	
	@RequestMapping(value = "/tms/dev/devCurrent.do")
	public String selectDevCurrent(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model) throws Exception {
		
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
		List<String> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		String a = String.valueOf(searchVO.getSearchBySysGb());
		if(searchVO.getSearchBySysGb() != null && searchVO.getSearchBySysGb() != "") {
			List<String> taskGbList2 = TmsProgrmManageService.selectTaskGb4(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		
		List<String> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<EgovMap> devCurrentList = devPlanService.selectDevCurrent(searchVO);
		model.addAttribute("resultList", devCurrentList);
		
		List<?> userList = defectService.selectUser(0);
		model.addAttribute("userList", userList);
		
		int totCnt = devPlanService.selectDevCurrentTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		HashMap<String,String> devPlanAvg = devPlanService.DevPlanAvg(searchVO);
		model.addAttribute("r", devPlanAvg);
		
		return "tms/dev/devCurrent";
	}
	
	@RequestMapping(value = "/tms/dev/devCurrentExcel.do")
	public String selectDevCurrentExcel(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model, HttpServletResponse response) throws Exception {
		
		searchVO.setExcelOpt("excel");
		List<EgovMap> devCurrentList = devPlanService.selectDevCurrent(searchVO);
		xlsxWiter(devCurrentList, "current", response, null, null);
		
		return "redirect:/tms/dev/devCurrent.do";
	}
	
	@RequestMapping(value = "/tms/dev/devCurListPrint.do")
	public String selectDevCurListPrint(@ModelAttribute("searchVO") DevPlanDefaultVO searchVO, ModelMap model) throws Exception {
		System.out.println("hererererere"+searchVO.getSearchByPgId());
		searchVO.setPrintOpt("printPage");
		
		List<EgovMap> devCurrentList = devPlanService.selectDevCurrent(searchVO);
		model.addAttribute("resultList", devCurrentList);
		
		return "tms/dev/devCurListPrint";
	}
	/*주말 제외한 두 날짜 사이의 기간 가져오기*/
	public ArrayList<String> betweenDate(Date startDate, Date endDate){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		ArrayList<String> dates = new ArrayList<String>();
		Date currentDate = startDate;
		int dayOfWeek;	//요일
		String sdfDate;
		String[] splitDate;
		
		while(currentDate.compareTo(endDate) <= 0){
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(currentDate);
			
			/*주말 제외*/
			dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			if(dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY){
				
			}else{
				sdfDate = sdf.format(currentDate);
				splitDate = sdfDate.split("-");
				sdfDate = splitDate[0]+splitDate[1]+splitDate[2];
				dates.add(sdfDate);
				
			}
			cal.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = cal.getTime();
			
		}
		
		return dates;
	}
	
	@RequestMapping("/tms/dev/devStats.do")
	public String selectDevPlanStats(ModelMap model){
		//1. 전체
		//1-1.전체 진척률
		HashMap<String, Object> progressRateTotal = devPlanService.selectTotalByProgressRate();
		model.addAttribute("progressRateTotal", progressRateTotal);
		
		//1-2. 시스템별 진척률
		List<?> sysByProgressRate = devPlanService.selectSysByProgressRate();
		model.addAttribute("sysByProgressRate", net.sf.json.JSONArray.fromObject(sysByProgressRate));
		
		//1-3. 업무별 진척률
		List<?> taskByProgressRate = devPlanService.selectTaskTotalProgressRate();
		model.addAttribute("taskByProgressRate", net.sf.json.JSONArray.fromObject(taskByProgressRate));
		
		return "tms/dev/devStats";
	}
	
	/** 대시보드(비동기처리) */
	@RequestMapping("/tms/dev/selectDevStatsAsyn.do")
	@ResponseBody
	public List<?> selectDevStatsAsyn(String sysGb) throws Exception {
		List<?> taskByProgressRate;
		if(sysGb.equals("sysGb")){
			taskByProgressRate = devPlanService.selectTaskTotalProgressRate();
		} else {
			taskByProgressRate = devPlanService.selectTaskByProgressRate(sysGb);
		}
		
		return taskByProgressRate;
	}
	
	/** 통계 엑셀 다운로드 기능 
	 * @throws Exception */
	@RequestMapping(value = "/tms/dev/StatsToExcel.do")
	public String StatsToExcel(@RequestParam("statsGb") String statsGb, ModelMap model, HttpServletResponse response) throws Exception {
		
		List<String> taskGbList = defectService.selectTaskGbByDefect();
		List<HashMap<String,String>> taskGbByStats = new ArrayList<HashMap<String,String>>();
		for(int i=0; i<taskGbList.size(); i++) {
			taskGbByStats.addAll(defectService.selectTaskByStats(taskGbList.get(i).toString()));
		}
		
		List<String> userList = devPlanService.selectUserList();
		List<String> taskList = devPlanService.selectTaskGbList();
		List<String> periodList = devPlanService.selectPeriodWeek();
		
		//String returnValue = "/tms/dev/devStatsTable";
		
		if(statsGb.equals("taskTotal")){
			List<EgovMap> totalTable = devPlanService.selectStatsTable();
			xlsxWiter(totalTable, statsGb, response, null, null);
			
		}else if(statsGb.equals("user")){
			List<Map<String,Object>> userStats = stats("user", userList, periodList);
			xlsxWiter(null, statsGb, response, userStats, null);
			
		}else if(statsGb.equals("task")){
			List<Map<String,Object>> taskStats = stats("task", taskList, periodList);
			xlsxWiter(null, statsGb, response, taskStats, null);
		}
		
		return "/tms/dev/devStatsTable";
	}
	
	public void xlsxWiter(List<EgovMap> list, String statsGb, HttpServletResponse response, List<Map<String,Object>> otherList, List<String> sum) throws Exception {
		// 워크북 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		// 워크시트 생성
		XSSFSheet sheet = workbook.createSheet();
		// 행 생성
		XSSFRow row = sheet.createRow(0);
		// 쎌 생성
		XSSFCell cell;
			
		Font defaultFont = workbook.createFont();        
		defaultFont.setColor(HSSFColor.WHITE.index);
		defaultFont.setBoldweight(Font.BOLDWEIGHT_BOLD); 
		defaultFont.setFontHeightInPoints((short) 11); 
		defaultFont.setFontName("맑은 고딕");

		Font contentFont = workbook.createFont();      
		contentFont.setFontHeightInPoints((short) 11); 
		contentFont.setFontName("맑은 고딕");
		
		//제목 스타일 
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
		 
		CellStyle TitleStyle = workbook.createCellStyle(); 
		TitleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		TitleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 
		TitleStyle.setFillForegroundColor(HSSFColor.AQUA.index); 
		TitleStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 
		TitleStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 
		TitleStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 
		TitleStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 
		TitleStyle.setFillPattern(CellStyle.SOLID_FOREGROUND); 
		TitleStyle.setFont(defaultFont);

		//본문 스타일 
		CellStyle BodyStyle = workbook.createCellStyle(); 
		BodyStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		BodyStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		BodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setFont(contentFont);   
		
		if(statsGb.equals("taskTotal")){
			// 헤더 정보 구성
			cell = row.createCell(0);
			cell.setCellValue("시스템구분");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(1);
			cell.setCellValue("업무구분");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(2);
			cell.setCellValue("총 본수");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(3);
			cell.setCellValue("금주 계획");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(4);
			cell.setCellValue("금주 실적");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(5);
			cell.setCellValue("금주 진척률");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(6);
			cell.setCellValue("누적 계획");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(7);
			cell.setCellValue("누적 실적");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(8);
			cell.setCellValue("누적 진척률");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(9);
			cell.setCellValue("전체 실적");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(10);
			cell.setCellValue("전체 진척률");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			// 리스트의 size 만큼 row를 생성
			for(int i=0; i < list.size(); i++) {
				// 행 생성
		
				row = sheet.createRow(i+1);
				
				cell = row.createCell(0);
				cell.setCellValue(String.valueOf(list.get(i).get("sysNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(1);
				cell.setCellValue(String.valueOf(list.get(i).get("taskNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(2);
				cell.setCellValue(String.valueOf(list.get(i).get("totCnt")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(3);
				cell.setCellValue(String.valueOf(list.get(i).get("tp")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(4);
				cell.setCellValue(String.valueOf(list.get(i).get("td")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(5);
				cell.setCellValue(String.valueOf(list.get(i).get("tr")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(6);
				cell.setCellValue(String.valueOf(list.get(i).get("ap")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(7);
				cell.setCellValue(String.valueOf(list.get(i).get("ad")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(8);
				cell.setCellValue(String.valueOf(list.get(i).get("ar")));
				cell.setCellStyle(BodyStyle); // 본문스타일
				
				cell = row.createCell(9);
				cell.setCellValue(String.valueOf(list.get(i).get("totD")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(10);
				cell.setCellValue(String.valueOf(list.get(i).get("tot")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
			}
			
			/** 3. 컬럼 Width */ 
			for (int i = 0; i <  list.size(); i++){ 
				sheet.autoSizeColumn(i); 
				sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000); 
			}
			
		}else if(statsGb.equals("user")){
			// 헤더 정보 구성
			cell = row.createCell(0);
			cell.setCellValue("개발자");
			sheet.addMergedRegion(new CellRangeAddress(0,1, 0,0));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			List<String> periodList = devPlanService.selectPeriodWeek();
			
			int temp = 1;
			for(int i =0; i<periodList.size(); i++){
				if(i == 0){
					cell = row.createCell(i+1);
					cell.setCellValue("1주");
					sheet.addMergedRegion(new CellRangeAddress(0,0, 1,3));
					cell.setCellStyle(HeadStyle);
					
				}else{
					cell = row.createCell(temp+3);
					cell.setCellValue((i+1)+"주");
					sheet.addMergedRegion(new CellRangeAddress(0,0, temp+3,temp+5));
					cell.setCellStyle(HeadStyle);
					temp +=3;
				}
			}
			cell = row.createCell(periodList.size()*3+1);
			cell.setCellValue("합계");
			sheet.addMergedRegion(new CellRangeAddress(0,0, periodList.size()*3+1,periodList.size()*3+3));
			cell.setCellStyle(HeadStyle);
			
			
			row = sheet.createRow(1);
			for(int i =0; i<periodList.size()+1; i++){
				cell = row.createCell(1+(3*i));
				cell.setCellValue("계획");
				cell.setCellStyle(TitleStyle);
				cell = row.createCell(2+(3*i));
				cell.setCellValue("실적");
				cell.setCellStyle(TitleStyle);
				cell = row.createCell(3+(3*i));
				cell.setCellValue("차이");
				cell.setCellStyle(TitleStyle);
			}
			
			 //리스트의 size 만큼 row를 생성
			for(int i=0; i < otherList.size(); i++) {
				// 행 생성
				row = sheet.createRow(i+2);
				
				cell = row.createCell(0);
				cell.setCellValue(String.valueOf(otherList.get(i).get("userDevNm"))+"("+String.valueOf(otherList.get(i).get("userDevId"))+")");
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				int temp2 = 1;
				for(int j=0; j<periodList.size(); j++){
					cell = row.createCell(temp2);
					cell.setCellValue(String.valueOf(otherList.get(i).get("a"+String.valueOf(periodList.get(j)))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(temp2+1);
					cell.setCellValue(String.valueOf(otherList.get(i).get("b"+String.valueOf(periodList.get(j)))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(temp2+2);
					cell.setCellValue(String.valueOf(otherList.get(i).get("sub"+String.valueOf(periodList.get(j)))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(periodList.size()*3+1);
					cell.setCellValue(String.valueOf(otherList.get(i).get(String.valueOf("sumUserPlan"))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(periodList.size()*3+2);
					cell.setCellValue(String.valueOf(otherList.get(i).get(String.valueOf("sumUserDev"))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(periodList.size()*3+3);
					cell.setCellValue(String.valueOf(otherList.get(i).get(String.valueOf("sumDiff"))));
					cell.setCellStyle(BodyStyle);
					
					
					temp2 +=3;
				}
				
			}
		}else if(statsGb.equals("task")){
			// 헤더 정보 구성
			cell = row.createCell(0);
			cell.setCellValue("시스템구분");
			sheet.addMergedRegion(new CellRangeAddress(0,1, 0,0));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(1);
			cell.setCellValue("업무구분");
			sheet.addMergedRegion(new CellRangeAddress(0,1, 1,1));
			cell.setCellStyle(HeadStyle); // 제목스타일 

			List<String> periodList = devPlanService.selectPeriodWeek();
			
			int temp = 2;
			for(int i =1; i<=periodList.size(); i++){
				if(i == 1){
					cell = row.createCell(i+1);
					cell.setCellValue(i+"주");
					sheet.addMergedRegion(new CellRangeAddress(0,0, 2,4));
					cell.setCellStyle(HeadStyle);
					
				}else{
					cell = row.createCell(temp+3);
					cell.setCellValue(i+"주");
					sheet.addMergedRegion(new CellRangeAddress(0,0, temp+3,temp+5));
					cell.setCellStyle(HeadStyle);
					temp +=3;
				}
			}
			cell = row.createCell(periodList.size()*3+2);
			cell.setCellValue("합계");
			sheet.addMergedRegion(new CellRangeAddress(0,0, periodList.size()*3+2,periodList.size()*3+4));
			cell.setCellStyle(HeadStyle);
			
			row = sheet.createRow(1);
			
			cell = row.createCell(0);
			cell.setCellStyle(TitleStyle);
			cell = row.createCell(1);
			cell.setCellStyle(TitleStyle);
			
			for(int i =0; i<periodList.size()+1; i++){
				cell = row.createCell(2+(3*i));
				cell.setCellValue("계획");
				cell.setCellStyle(TitleStyle);
				cell = row.createCell(3+(3*i));
				cell.setCellValue("실적");
				cell.setCellStyle(TitleStyle);
				cell = row.createCell(4+(3*i));
				cell.setCellValue("차이");
				cell.setCellStyle(TitleStyle);
			}
			
			 //리스트의 size 만큼 row를 생성
			for(int i=0; i < otherList.size(); i++) {
				// 행 생성
				row = sheet.createRow(i+2);
				
				cell = row.createCell(0);
				cell.setCellValue(String.valueOf(otherList.get(i).get("sysGbNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(1);
				cell.setCellValue(String.valueOf(otherList.get(i).get("taskGbNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				
				
				int temp2 = 2;
				for(int j=0; j<periodList.size(); j++){
					cell = row.createCell(temp2);
					cell.setCellValue(String.valueOf(otherList.get(i).get("a"+String.valueOf(periodList.get(j)))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(temp2+1);
					cell.setCellValue(String.valueOf(otherList.get(i).get("b"+String.valueOf(periodList.get(j)))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(temp2+2);
					cell.setCellValue(String.valueOf(otherList.get(i).get("sub"+String.valueOf(periodList.get(j)))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(periodList.size()*3+2);
					cell.setCellValue(String.valueOf(otherList.get(i).get(String.valueOf("sumTaskPlan"))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(periodList.size()*3+3);
					cell.setCellValue(String.valueOf(otherList.get(i).get(String.valueOf("sumTaskDev"))));
					cell.setCellStyle(BodyStyle);
					
					cell = row.createCell(periodList.size()*3+4);
					cell.setCellValue(String.valueOf(otherList.get(i).get(String.valueOf("sumDiff"))));
					cell.setCellStyle(BodyStyle);
					
					temp2 +=3;
				}
			}
			
		}else if(statsGb.equals("current")){
			// 헤더 정보 구성
			cell = row.createCell(0);
			cell.setCellValue("시스템구분");
			cell.setCellStyle(HeadStyle); // 제목스타일 

			cell = row.createCell(1);
			cell.setCellValue("업무구분");
			cell.setCellStyle(HeadStyle); // 제목스타일 
								
			cell = row.createCell(2);
			cell.setCellValue("화면ID");
			cell.setCellStyle(HeadStyle); // 제목스타일 
								
			cell = row.createCell(3);
			cell.setCellValue("화면명");
			cell.setCellStyle(HeadStyle); // 제목스타일 
								
			cell = row.createCell(4);
			cell.setCellValue("개발자");
			cell.setCellStyle(HeadStyle); // 제목스타일 
								
			cell = row.createCell(5);
			cell.setCellValue("계획시작일자");
			cell.setCellStyle(HeadStyle); // 제목스타일 
								
			cell = row.createCell(6);
			cell.setCellValue("계획종료일자");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(7);
			cell.setCellValue("개발시작일자");
			cell.setCellStyle(HeadStyle); // 제목스타일 
								
			cell = row.createCell(8);
			cell.setCellValue("개발종료일자");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(9);
			cell.setCellValue("완료율(%)");
			cell.setCellStyle(HeadStyle); // 제목스타일 
								
			cell = row.createCell(10);
			cell.setCellValue("진행상태");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			// 리스트의 size 만큼 row를 생성
			for(int i=0; i < list.size(); i++) {
				// 행 생성
		
				row = sheet.createRow(i+1);
				
				cell = row.createCell(0);
				cell.setCellValue(String.valueOf(list.get(i).get("sysGb")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(1);
				cell.setCellValue(String.valueOf(list.get(i).get("taskGb")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(2);
				cell.setCellValue(String.valueOf(list.get(i).get("pgId")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(3);
				cell.setCellValue(String.valueOf(list.get(i).get("pgNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(4);
				cell.setCellValue(String.valueOf(list.get(i).get("userDevNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(5);
				cell.setCellValue(String.valueOf(list.get(i).get("planStartDt")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(6);
				cell.setCellValue(String.valueOf(list.get(i).get("planEndDt")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(7);
				if(String.valueOf(list.get(i).get("devStartDt")).equals("null")){
					cell.setCellValue("");
				}else{
					cell.setCellValue(String.valueOf(list.get(i).get("devStartDt")));
				}
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(8);
				if(String.valueOf(list.get(i).get("devEndDt")).equals("null")){
					cell.setCellValue("");
				}else{
					cell.setCellValue(String.valueOf(list.get(i).get("devEndDt")));
				}
				cell.setCellStyle(BodyStyle); // 본문스타일
				
				cell = row.createCell(9);
				cell.setCellValue(String.valueOf(list.get(i).get("achievementRate")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(10);
				cell.setCellValue(String.valueOf(list.get(i).get("st")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
			}
			
			/** 3. 컬럼 Width */ 
			for (int i = 0; i <  list.size(); i++){ 
				sheet.autoSizeColumn(i); 
				sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000); 
			}
			
		}

		// 입력된 내용 파일로 쓰기
		File folder = new File("C:\\TMS\\TMS_통계자료");
		
		File file = new File("C:\\TMS\\TMS_통계자료\\프로그램현황.xlsx");
		
		
		//디렉토리 생성 메서드
		if(!folder.exists()){
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
				if(workbook!=null) //workbook.close();
				if(fos!=null) fos.close();
				
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		/** 경로 다운로드 */
		 String path = "C:/TMS/TMS_통계자료/";  // Link의 자바파일에서 excel 파일이 생성된 경로
        String realFileNm = "프로그램현황.xlsx";
        
        File uFile = new File(path,realFileNm);
        int fSize = (int) uFile.length();
        if (fSize > 0) {  //파일 사이즈가 0보다 클 경우 다운로드
         String mimetype = "application/x-msdownload";  //minetype은 파일확장자에 맞게 설정
         String fileName = "개발진척통계.xlsx"; //리퀘스트로 넘어온 파일명
		 String docName = URLEncoder.encode(fileName,"UTF-8"); // UTF-8로 인코딩			
		 response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";"); 
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
          if (in != null) in.close();
          if (out != null) out.close();
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
/** JsonArray를 List<Map<String, String>> 로 변환*/
class JsonUtil {
	
	@SuppressWarnings("unchecked")
    public static Map<String, Object> getMapFromJsonObject( JSONObject jsonObj )
    {
        Map<String, Object> map = null;
        
        try {
            
            map = new ObjectMapper().readValue(jsonObj.toJSONString(), Map.class) ;
            
        } catch (JsonParseException e) {
            e.printStackTrace();
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
 
        return map;
    }
	
	public static List<Map<String, Object>> getListMapFromJsonArray( JSONArray jsonArray )
    {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        
        if( jsonArray != null )
        {
            int jsonSize = jsonArray.size();
            for( int i = 0; i < jsonSize; i++ )
            {
                Map<String, Object> map = JsonUtil.getMapFromJsonObject( ( JSONObject ) jsonArray.get(i) );
                list.add( map );
            }
        }
        
        return list;
    }
	
}
