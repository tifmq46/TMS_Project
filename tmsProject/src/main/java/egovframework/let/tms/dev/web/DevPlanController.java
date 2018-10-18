package egovframework.let.tms.dev.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.sound.midi.Synthesizer;

import org.apache.commons.collections.set.SynchronizedSortedSet;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
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
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ibm.icu.text.SimpleDateFormat;
import com.ibm.icu.util.Calendar;

import egovframework.com.cmm.ComDefaultCodeVO;
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
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		searchVO.setSessionId(user.getName());
		System.out.println("--유저"+ searchVO.getSessionId());
		
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
		
		List<?> userList = defectService.selectUser();
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
		System.out.println("sdate"+currentDate);
		
		String start = devPlanService.selectSTART();
		Date sDate = sdf.parse(start);
		String end =devPlanService.selectEND();
		Date eDate = sdf.parse(end);
		
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
		
		//기준일자
		TmsProjectManageVO tmsPrj = TmsProgrmManageService.selectProject();
		Date ps = tmsPrj.getDevStartDt();
		String formatPs = sdf.format(ps);

		Date pe = tmsPrj.getDevEndDt();
		String formatPe = sdf.format(pe);
		
		model.addAttribute("ps", formatPs);
		model.addAttribute("pe", formatPe);
		
		model.addAttribute("tms", tmsPrj);
		
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
	
	@RequestMapping("/tms/dev/inputDevPlan.do")
	public String inputDevPlan(@RequestParam String s1, @RequestParam String s2, @ModelAttribute("searchVO") DevPlanDefaultVO searchVO, @ModelAttribute("devPlan") DevPlanVO dvo, ModelMap model, BindingResult bindingResult,
			SessionStatus status) throws Exception {

		String[] strs1 = s1.split(",");
		String[] strs2 = s2.split(",");
		
		System.out.println(strs1[0]);
		System.out.println(strs2[0]);
		
		devPlanService.updateinput1(strs1[0]);
		devPlanService.updateinput2(strs2[0]);
		
		
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
		System.out.println("00000"+dvo.getPgId());
		String result = devPlanService.ifNullDevPlan(dvo.getPgId());
		String r = String.valueOf(result);
		//System.out.println("result값 = "+result);
		if(r.equals("1")){
			devPlanService.updateDevPlan(dvo);
			status.setComplete(); 
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
		}else{
			devPlanService.insertDevPlan(dvo);
		}
			
			return "redirect:/tms/dev/devPlans.do";
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
		
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		
		searchVO.setSessionId(user.getName());
		
		System.out.println("");
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
			//System.out.println("ddddd");
			List<String> taskGbList2 = TmsProgrmManageService.selectTaskGb4(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		
		List<String> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		List<HashMap<String,String>> devResultList = devPlanService.selectDevResultList(searchVO);
		model.addAttribute("resultList", devResultList);
		
		int totCnt = devPlanService.selectDevResultListTotCnt(searchVO);
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
	public String updateDevResult(@ModelAttribute("searchVO") DevPlanDefaultVO dvo,@RequestParam String flag, BindingResult bindingResult, SessionStatus status, Model model) throws Exception {

		
		//if (bindingResult.hasErrors()) {
			//return "/tms/dev/updateDevPlan";
		//} else {
			//Float.valueOf(dvo.getAchievementRate());
			//System.out.println(dvo.getAchievementRate());
		
		String devStartDt, devEndDt,devAchRate;
		float achRate=0.0f;

		devStartDt = String.valueOf(dvo.getDevStartDt());
		devEndDt = String.valueOf(dvo.getDevEndDt());
		devAchRate = String.valueOf(dvo.getAchievementRate());
			
			System.out.println("날짜값"+devStartDt);
			if(flag.equals("auto")){
				if(!devStartDt.equals("null")){
					if(!devEndDt.equals("null")){
						achRate=100;
					}else{
						if(devAchRate.equals("0.0")){
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
			return "redirect:/tms/dev/devResultList.do";
	}
	
	@RequestMapping(value = "/tms/dev/deleteDevResult.do")
	public String deleteDevResult(@ModelAttribute("searchVO") DevPlanVO dvo, SessionStatus status, Model model) throws Exception {

		devPlanService.deleteDevResult(dvo);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/tms/dev/selectDevResult.do";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/tms/dev/devStatsTable.do")
	public String devStatsTable(@ModelAttribute("searchVO") DevPlanVO dvo, SessionStatus status, Model model) throws Exception {
		
		
		/*프로젝트의 개발기간의 주차 값과 차이를 가져온다.*/
		TmsProjectManageVO tt = TmsProgrmManageService.selectProject();
		model.addAttribute("tt", tt);
		
		/*프로젝트 개발계획 기간(주말 제외)*/
		Date startDate = tt.getDevStartDt();
		Date endDate = tt.getDevEndDt();
		
		devPlanService.deleteDates();
		
		ArrayList<String> dates = betweenDate(startDate, endDate);
		for(String date : dates){
			devPlanService.insertDates(date);
		}
		
		List<?> devPeriod = devPlanService.selectDevPeriod();
		model.addAttribute("resultP", devPeriod);
		
		List<String> userList = devPlanService.selectUserList();
		List<String> taskGbList = devPlanService.selectTaskGbList();
		
		List<String> periodList = devPlanService.selectPeriodWeek();
		
		List<String> periodMonthWeek = devPlanService.selectPeriodMonthWeek();
		model.addAttribute("monthWeek",periodMonthWeek);
		
		//개발자별 통계 시작---------------------------------
		/*개발자별(계획) */
		List<Map<String,Object>> userplanList = stats("userPlan", userList, periodList);
		model.addAttribute("userplanList",userplanList);
		model.addAttribute("begin", periodList.get(0));
		model.addAttribute("end", periodList.get(periodList.size()-1));
		
		/*개발자별(실적) */
		List<Map<String,Object>> userDevList = stats("userDev", userList, periodList);
		model.addAttribute("userDevList",userDevList);
		//개발자별 통계 끝----------------------------------
		
		//업무별 통계 시작---------------------------------
		/*업무별(계획) */
		List<Map<String,Object>> taskPlanList = stats("taskPlan", taskGbList, periodList);
		model.addAttribute("taskPlanList",taskPlanList);
		
		/*업무별(실적) */
		List<Map<String,Object>> taskDevList = stats("taskDev", taskGbList, periodList);
		model.addAttribute("taskDevList",taskDevList);
		//업무별 통계 끝----------------------------------
		
		//주별 합계(계획)
		List<String> sumPlanWeek = new ArrayList<String>();
				
		for(int i=0; i<periodList.size();i++){
			sumPlanWeek.add(i,devPlanService.selectPlanSum(periodList.get(i)));
		}
		model.addAttribute("sumPlanWeek",sumPlanWeek);
		

		//주별 합계(실적)
		List<String> sumDevWeek = new ArrayList<String>();
				
		for(int i=0; i<periodList.size();i++){
			sumDevWeek.add(i,devPlanService.selectDevSum(periodList.get(i)));
		}
		model.addAttribute("sumDevWeek",sumDevWeek);
		
		List<EgovMap> totalTable = devPlanService.selectStatsTable();
		model.addAttribute("totalTable", totalTable);
		
		
		return "/tms/dev/devStatsTable";
	}
	
	@SuppressWarnings("unchecked")
	private List<Map<String, Object>> stats(String statsGb, List<String> list, List<String> periodList) {
		
		if(statsGb.equals("userPlan")){
			List<HashMap<String,String>> userPlanStats = new ArrayList<HashMap<String,String>>();
			HashMap<String,String> userPlan = new HashMap<String,String>();
			
			for(int i=0; i<list.size(); i++){
				for(int j=0; j<periodList.size(); j++){
					userPlan.put("userList",String.valueOf(list.get(i)));
					userPlan.put("dt",String.valueOf(periodList.get(j)));
					userPlanStats.addAll(devPlanService.selectUserPlanWeekStats(userPlan));
				}
			}
			
			JSONArray userPlanArray = new JSONArray();
			JSONObject userPlanObj = new JSONObject();
			
			int sumUserPlan=0;
			
			for(int i=0; i<list.size(); i++){

				userPlanObj = new JSONObject();
				sumUserPlan = 0;
				if(i==0){
					userPlanObj.put("DevNm", userPlanStats.get(0).get("userDevNm"));
					for(int j=0; j< periodList.size(); j++){
						userPlanObj.put( "a"+periodList.get(j), userPlanStats.get(j).get(periodList.get(j)));
						sumUserPlan += Integer.parseInt(String.valueOf(userPlanStats.get(j).get(periodList.get(j))));
					}
				}else{
					userPlanObj.put("DevNm", userPlanStats.get(((periodList.size())*i)+1).get("userDevNm"));
					for(int j=0; j< periodList.size(); j++){
						userPlanObj.put( "a"+periodList.get(j), userPlanStats.get(j+(periodList.size()*i)).get(periodList.get(j)));
						sumUserPlan += Integer.parseInt(String.valueOf(userPlanStats.get(j+(periodList.size()*i)).get(periodList.get(j))));
					}
				}
				userPlanObj.put("sumUserPlan", sumUserPlan);
				userPlanArray.add(userPlanObj);
			}
			
			JsonUtil jsU = new JsonUtil();
			List<Map<String,Object>> userplanList = jsU.getListMapFromJsonArray(userPlanArray);
			
			return userplanList;
			
		}else if(statsGb.equals("userDev")){
			List<HashMap<String,String>> userDevStats = new ArrayList<HashMap<String,String>>();
			HashMap<String,String> userDev = new HashMap<String,String>();
			
			for(int i=0; i<list.size(); i++){
				for(int j=0; j<periodList.size(); j++){
					userDev.put("userList",String.valueOf(list.get(i)));
					userDev.put("dt",String.valueOf(periodList.get(j)));
					userDevStats.addAll(devPlanService.selectUserDevWeekStats(userDev));
				}
			}
			
			JSONArray userDevArray = new JSONArray();
			JSONObject userDevObj = new JSONObject();
			
			int sumUserDev=0;
			
			for(int i=0; i<list.size(); i++){

				userDevObj = new JSONObject();
				sumUserDev = 0;
				if(i==0){
					userDevObj.put("DevNm", userDevStats.get(0).get("userDevNm"));
					for(int j=0; j< periodList.size(); j++){
						userDevObj.put( "a"+periodList.get(j), userDevStats.get(j).get(periodList.get(j)));
						sumUserDev += Integer.parseInt(String.valueOf(userDevStats.get(j).get(periodList.get(j))));
					}
				}else{
					userDevObj.put("DevNm", userDevStats.get(((periodList.size())*i)+1).get("userDevNm"));
					for(int j=0; j< periodList.size(); j++){
						userDevObj.put( "a"+periodList.get(j), userDevStats.get(j+(periodList.size()*i)).get(periodList.get(j)));
						sumUserDev += Integer.parseInt(String.valueOf(userDevStats.get(j+(periodList.size()*i)).get(periodList.get(j))));
					}
				}
				userDevObj.put("sumUserDev", sumUserDev);
				userDevArray.add(userDevObj);
			}
			
			JsonUtil jsU = new JsonUtil();
			List<Map<String,Object>> userDevList = jsU.getListMapFromJsonArray(userDevArray);
			
			return userDevList;
			
		}else if(statsGb.equals("taskPlan")){
			
			
			
			List<HashMap<String,String>> taskPlanStats = new ArrayList<HashMap<String,String>>();
			HashMap<String,String> taskPlan = new HashMap<String,String>();
			
			for(int i=0; i<list.size(); i++){
				
				for(int j=0; j<periodList.size(); j++){
					taskPlan.put("taskGbList",String.valueOf(list.get(i)));
					taskPlan.put("dt",String.valueOf(periodList.get(j)));
					taskPlanStats.addAll(devPlanService.selectTaskPlanWeekStats(taskPlan));

				}
			}
			
			JSONArray taskPlanArray = new JSONArray();
			JSONObject taskPlanObj = new JSONObject();
			
			int sumTaskPlan=0;
			int div = taskPlanStats.size() / periodList.size();
			
			for(int i=0; i<div; i++){

				taskPlanObj = new JSONObject();
				sumTaskPlan = 0;
				if(i==0){
					taskPlanObj.put("taskGbNm", taskPlanStats.get(0).get("taskGbNm"));
					for(int j=0; j< periodList.size(); j++){
						taskPlanObj.put( "a"+periodList.get(j), taskPlanStats.get(j).get(periodList.get(j)));
						sumTaskPlan += Integer.parseInt(String.valueOf(taskPlanStats.get(j).get(periodList.get(j))));
					}
				}else{
					taskPlanObj.put("taskGbNm", taskPlanStats.get(((periodList.size())*i)+1).get("taskGbNm"));
					for(int j=0; j< periodList.size(); j++){
						taskPlanObj.put( "a"+periodList.get(j), taskPlanStats.get(j+(periodList.size()*i)).get(periodList.get(j)));
						sumTaskPlan += Integer.parseInt(String.valueOf(taskPlanStats.get(j+(periodList.size()*i)).get(periodList.get(j))));
					}
				}
				taskPlanObj.put("sumTaskPlan", sumTaskPlan);
				taskPlanArray.add(taskPlanObj);
			}
			
			JsonUtil jsU = new JsonUtil();
			List<Map<String,Object>> taskPlanList = jsU.getListMapFromJsonArray(taskPlanArray);
			
			return taskPlanList;
			
		}else if(statsGb.equals("taskDev")){
			
			List<HashMap<String,String>> taskDevStats = new ArrayList<HashMap<String,String>>();
			HashMap<String,String> taskDev = new HashMap<String,String>();
			
			for(int i=0; i<list.size(); i++){
				
				for(int j=0; j<periodList.size(); j++){
					taskDev.put("taskGbList",String.valueOf(list.get(i)));
					taskDev.put("dt",String.valueOf(periodList.get(j)));
					taskDevStats.addAll(devPlanService.selectTaskDevWeekStats(taskDev));

				}
			}
			
			JSONArray taskDevArray = new JSONArray();
			JSONObject taskDevObj = new JSONObject();
			
			int sumTaskDev=0;
			int div2 = taskDevStats.size() / periodList.size();
			
			for(int i=0; i<div2; i++){

				taskDevObj = new JSONObject();
				sumTaskDev = 0;
				if(i==0){
					taskDevObj.put("taskGbNm", taskDevStats.get(0).get("taskGbNm"));
					for(int j=0; j< periodList.size(); j++){
						taskDevObj.put( "a"+periodList.get(j), taskDevStats.get(j).get(periodList.get(j)));
						sumTaskDev += Integer.parseInt(String.valueOf(taskDevStats.get(j).get(periodList.get(j))));
					}
				}else{
					taskDevObj.put("taskGbNm", taskDevStats.get(((periodList.size())*i)+1).get("taskGbNm"));
					for(int j=0; j< periodList.size(); j++){
						taskDevObj.put( "a"+periodList.get(j), taskDevStats.get(j+(periodList.size()*i)).get(periodList.get(j)));
						sumTaskDev += Integer.parseInt(String.valueOf(taskDevStats.get(j+(periodList.size()*i)).get(periodList.get(j))));
					}
				}
				taskDevObj.put("sumTaskDev", sumTaskDev);
				taskDevArray.add(taskDevObj);
			}
			
			JsonUtil jsU = new JsonUtil();
			List<Map<String,Object>> taskDevList = jsU.getListMapFromJsonArray(taskDevArray);
			
			return taskDevList;
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
			//System.out.println("ddddd");
			List<String> taskGbList2 = TmsProgrmManageService.selectTaskGb4(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		
		List<String> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<HashMap<String,String>> devCurrentList = devPlanService.selectDevCurrent(searchVO);
		model.addAttribute("resultList", devCurrentList);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		int totCnt = devPlanService.selectDevCurrentTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		HashMap<String,String> devPlanAvg = devPlanService.DevPlanAvg(searchVO);
		model.addAttribute("r", devPlanAvg);
		System.out.println(devPlanAvg);
		
		return "tms/dev/devCurrent";
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
		
		List<String> sysList = devPlanService.selectSysGbList();
		List<String> taskList = devPlanService.selectTaskGbList();
		
		// 금주 진척률 시작 ---------------------------------------
		
		HashMap<String, String> type = new HashMap<>();
		
		//업무별 금주 계획대비 실적, 금주 진척률
		List<HashMap<String,String>> taskThisWeek = new ArrayList<HashMap<String,String>>();
		
		for(int i=0; i<taskList.size(); i++){
			type.put("codeType", "task");
			type.put("taskList", taskList.get(i));
			taskThisWeek.addAll(devPlanService.selectThisWeekStats(type));
		}
		
		// 시스템별 금주 계획대비 실적, 금주 진척률
		List<HashMap<String,String>> sysThisWeek = new ArrayList<HashMap<String,String>>();

		type = new HashMap<>();
		for(int i=0; i<sysList.size(); i++){
			type.put("codeType", "sys");
			type.put("sysList", sysList.get(i));
			sysThisWeek.addAll(devPlanService.selectThisWeekStats(type));
		}
		
		//금주 계획대비 실적, 합계
		int totPlanThisWeek = 0;
		int totDevThisWeek = 0;
		HashMap<String, String> hashThisWeek = new HashMap<>();
		
		for(int j=0; j<sysThisWeek.size(); j++){
			totPlanThisWeek += Integer.parseInt(String.valueOf(sysThisWeek.get(j).get("CNTA")));
			totDevThisWeek += Integer.parseInt(String.valueOf(sysThisWeek.get(j).get("CNTB")));
		}
		
		double totThisWeek = ((double)totDevThisWeek / (double)totPlanThisWeek) * 100;
		totThisWeek = Math.round(totThisWeek * 10)/10.0;
		
		hashThisWeek.put("CNTA",String.valueOf(totPlanThisWeek));
		hashThisWeek.put("CNTB",String.valueOf(totDevThisWeek));
		hashThisWeek.put("R",String.valueOf(totThisWeek));
		
		System.out.println("금주 총 진척률 " + hashThisWeek);
		
		model.addAttribute("hashThisWeekByStats", net.sf.json.JSONArray.fromObject(hashThisWeek));
		model.addAttribute("sysThisWeekByStats", net.sf.json.JSONArray.fromObject(sysThisWeek));
		model.addAttribute("taskThisWeekByStats", net.sf.json.JSONArray.fromObject(taskThisWeek));
		// 금주 진척률 끝 ---------------------------------------
		
		// 누적 진척률 시작 ---------------------------------------
		
		// 업무별 금주 누적 계획대비 실적, 누적 진척률
		List<HashMap<String,String>> taskAccumulate = new ArrayList<HashMap<String,String>>();
		
		type = new HashMap<>();
		
		for(int i=0; i<taskList.size(); i++){
			type.put("codeType", "task");
			type.put("taskList", taskList.get(i));
			taskAccumulate.addAll(devPlanService.selectAccumulateStats(type));
		}
		model.addAttribute("taskAccumulateByStats", net.sf.json.JSONArray.fromObject(taskAccumulate));
		System.out.println("업무별 누적진척률"+taskAccumulate);
		
		List<HashMap<String,String>> sysAccumulate = new ArrayList<HashMap<String,String>>();

		type = new HashMap<>();
		for(int i=0; i<sysList.size(); i++){
			type.put("codeType", "sys");
			type.put("sysList", sysList.get(i));
			sysAccumulate.addAll(devPlanService.selectAccumulateStats(type));
		}
		System.out.println("시스템별 누적진척률"+sysAccumulate);
		
		//누적 계획대비 실적, 합계
		int totPlanAccumulate = 0;
		int totDevAccumulate = 0;
		HashMap<String, String> hashAccumulate = new HashMap<>();
		
		for(int j=0; j<sysAccumulate.size(); j++){
			totPlanAccumulate += Integer.parseInt(String.valueOf(sysAccumulate.get(j).get("CNTA")));
			totDevAccumulate += Integer.parseInt(String.valueOf(sysAccumulate.get(j).get("CNTB")));
		}
				
		double totAccumulate = ((double)totDevAccumulate / (double)totPlanAccumulate) * 100;
		totAccumulate = Math.round(totAccumulate * 10)/10.0;
		
		hashAccumulate.put("CNTA",String.valueOf(totPlanAccumulate));
		hashAccumulate.put("CNTB",String.valueOf(totDevAccumulate));
		hashAccumulate.put("R",String.valueOf(totAccumulate));
		
		System.out.println("누적 총 진척률 " + hashAccumulate);
		
		model.addAttribute("hashAccumulateByStats", net.sf.json.JSONArray.fromObject(hashAccumulate));
		model.addAttribute("sysAccumulateByStats", net.sf.json.JSONArray.fromObject(sysAccumulate));
		model.addAttribute("taskAccumulateByStats", net.sf.json.JSONArray.fromObject(taskAccumulate));
		// 누적 진척률 끝 ---------------------------------------
		
		// 전체 진척률 시작 ---------------------------------------
		
		// 업무별 총 본수대비 실적, 총 진척률
		List<HashMap<String,String>> taskTotal = new ArrayList<HashMap<String,String>>();
		
		type = new HashMap<>();
		for(int i=0; i<taskList.size(); i++){
			type.put("codeType", "task");
			type.put("taskList", taskList.get(i));
			taskTotal.addAll(devPlanService.selectTotalStats(type));
		}
		model.addAttribute("taskTotalByStats", net.sf.json.JSONArray.fromObject(taskTotal));
		// 업무별 진척률 시작 ---------------------------------------	
		System.out.println("업무별 전체 진척률"+taskTotal);
		
		List<HashMap<String,String>> sysTotal = new ArrayList<HashMap<String,String>>();

		type = new HashMap<>();
		for(int i=0; i<sysList.size(); i++){
			type.put("codeType", "sys");
			type.put("sysList", sysList.get(i));
			sysTotal.addAll(devPlanService.selectTotalStats(type));
		}
		System.out.println("시스템별 전체 진척률"+sysTotal);
		
		//누적 계획대비 실적, 합계
		int totPlan = 0;
		int totDev = 0;
		HashMap<String, String> hashTot = new HashMap<>();
		
		for(int j=0; j<sysTotal.size(); j++){
			totPlan += Integer.parseInt(String.valueOf(sysTotal.get(j).get("CNTA")));
			totDev += Integer.parseInt(String.valueOf(sysTotal.get(j).get("CNTB")));
		}
						
		double tot = ((double)totDev / (double)totPlan) * 100;
		tot = Math.round(tot * 10)/10.0;
		
		hashTot.put("CNTA",String.valueOf(totPlan));
		hashTot.put("CNTB",String.valueOf(totDev));
		hashTot.put("R",String.valueOf(tot));
		
		System.out.println("전체 진척률 " + hashTot);

		model.addAttribute("hashTotalByStats", net.sf.json.JSONArray.fromObject(hashTot));
		model.addAttribute("sysTotalByStats", net.sf.json.JSONArray.fromObject(sysTotal));
		model.addAttribute("taskTotalByStats", net.sf.json.JSONArray.fromObject(taskTotal));
		// 전체 진척률 끝 ---------------------------------------
		
		return "tms/dev/devStats";
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
		
		if(statsGb.equals("taskTotal")){
			List<EgovMap> totalTable = devPlanService.selectStatsTable();
			xlsxWiter(totalTable, statsGb, response, null, null);
			model.addAttribute("taskTotalStats",totalTable);
		}else if(statsGb.equals("user")){
			List<Map<String,Object>> userplanList = stats("userPlan", userList, periodList);
			
			List<String> sumPlanWeek = new ArrayList<String>();
			
			for(int i=0; i<periodList.size();i++){
				sumPlanWeek.add(i,devPlanService.selectPlanSum(periodList.get(i)));
			}
			xlsxWiter(null, statsGb, response, userplanList, sumPlanWeek);
			model.addAttribute("userStats",userplanList);
			
		}else if(statsGb.equals("task")){
			System.out.println("업무엑셀");
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
		defaultFont.setFontHeightInPoints((short) 11); 
		defaultFont.setFontName("맑은 고딕");
		
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

		//본문 스타일 
		CellStyle BodyStyle = workbook.createCellStyle(); 
		BodyStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		BodyStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		BodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setFont(defaultFont);   
		
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
			System.out.println("?ssssss");
			// 헤더 정보 구성
			cell = row.createCell(0);
			cell.setCellValue("개발자");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(1);
			cell.setCellValue("1주차");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(2);
			cell.setCellValue("2주차");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(3);
			cell.setCellValue("3주차");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(4);
			cell.setCellValue("4주차");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(5);
			cell.setCellValue("5주차");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			// 리스트의 size 만큼 row를 생성
			for(int i=0; i < otherList.size(); i++) {
				// 행 생성
		
				row = sheet.createRow(i+1);
				
				cell = row.createCell(0);
				cell.setCellValue(String.valueOf(otherList.get(i).get("DevNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(1);
				cell.setCellValue(String.valueOf(otherList.get(i).get("a39")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(2);
				cell.setCellValue(String.valueOf(otherList.get(i).get("a40")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(3);
				cell.setCellValue(String.valueOf(otherList.get(i).get("a41")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(4);
				cell.setCellValue(String.valueOf(otherList.get(i).get("a42")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(5);
				cell.setCellValue(String.valueOf(otherList.get(i).get("a43")));
				cell.setCellStyle(BodyStyle); // 본문스타일
			}
			
			/** 3. 컬럼 Width */ 
			for (int i = 0; i <  otherList.size(); i++){ 
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
				// TODO Auto-generated catch block
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
         response.setHeader("Content-Disposition", "attachment; filename=\"devStats.xlsx\"");
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
