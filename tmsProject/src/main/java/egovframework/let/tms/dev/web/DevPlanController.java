package egovframework.let.tms.dev.web;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Locale;

import javax.annotation.Resource;
import javax.sound.midi.Synthesizer;

import org.apache.commons.collections.set.SynchronizedSortedSet;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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
			List<?> taskGbList2 = TmsProgrmManageService.selectTaskGb4(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
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
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		String a = String.valueOf(searchVO.getSearchBySysGb());
		if(searchVO.getSearchBySysGb() != null && searchVO.getSearchBySysGb() != "") {
			//System.out.println("ddddd");
			List<?> taskGbList2 = TmsProgrmManageService.selectTaskGb4(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
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
		Date startDate = tt.getDEV_START_DT();
		Date endDate = tt.getDEV_END_DT();
		
		devPlanService.deleteDates();
		
		ArrayList<String> dates = betweenDate(startDate, endDate);
		for(String date : dates){
			devPlanService.insertDates(date);
		}
		
		List<?> devPeriod = devPlanService.selectDevPeriod();
		model.addAttribute("resultP", devPeriod);
		
		List<String> userList = devPlanService.selectUserList();
		
		List<String> periodList = devPlanService.selectPeriodWeek();
		
		List<String> periodMonthWeek = devPlanService.selectPeriodMonthWeek();
		model.addAttribute("monthWeek",periodMonthWeek);
		
		/*개발자별(계획) */
		List<HashMap<String,String>> userPlanStats = new ArrayList<HashMap<String,String>>();
		HashMap<String,String> userPlan = new HashMap<String,String>();
		
		for(int i=0; i<userList.size(); i++){
			for(int j=0; j<periodList.size(); j++){
				userPlan.put("userList",String.valueOf(userList.get(i)));
				userPlan.put("dt",String.valueOf(periodList.get(j)));
				userPlanStats.addAll(devPlanService.selectUserPlanWeekStats(userPlan));
			}
		}
		
		JSONArray userPlanArray = new JSONArray();
		JSONObject userPlanObj = new JSONObject();
		
		int sumUserPlan=0;
		
		for(int i=0; i<userList.size(); i++){

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
		
		model.addAttribute("userplanList",userplanList);
		model.addAttribute("begin", periodList.get(0));
		model.addAttribute("end", periodList.get(periodList.size()-1));

		
		/*개발자별(실적) */
		List<HashMap<String,String>> userDevStats = new ArrayList<HashMap<String,String>>();
		HashMap<String,String> userDev = new HashMap<String,String>();
		
		for(int i=0; i<userList.size(); i++){
			for(int j=0; j<periodList.size(); j++){
				userDev.put("userList",String.valueOf(userList.get(i)));
				userDev.put("dt",String.valueOf(periodList.get(j)));
				userDevStats.addAll(devPlanService.selectUserDevWeekStats(userDev));
			}
		}
		
		JSONArray userDevArray = new JSONArray();
		JSONObject userDevObj = new JSONObject();
		
		int sumUserDev=0;
		
		for(int i=0; i<userList.size(); i++){

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
		
		JsonUtil jsU2 = new JsonUtil();
		List<Map<String,Object>> userDevList = jsU2.getListMapFromJsonArray(userDevArray);
		
		model.addAttribute("userDevList",userDevList);
		
		/*업무별(계획) */
		List<String> taskGbList = devPlanService.selectTaskGbList();
		
		List<HashMap<String,String>> taskPlanStats = new ArrayList<HashMap<String,String>>();
		HashMap<String,String> taskPlan = new HashMap<String,String>();
		
		for(int i=0; i<taskGbList.size(); i++){
			
			for(int j=0; j<periodList.size(); j++){
				taskPlan.put("taskGbList",String.valueOf(taskGbList.get(i)));
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
		
		JsonUtil jsU3 = new JsonUtil();
		List<Map<String,Object>> taskPlanList = jsU2.getListMapFromJsonArray(taskPlanArray);
		
		model.addAttribute("sumTaskPlan", taskPlanStats);
		model.addAttribute("taskPlanList",taskPlanList);
		
		/*업무별(실적) */
		
		List<HashMap<String,String>> taskDevStats = new ArrayList<HashMap<String,String>>();
		HashMap<String,String> taskDev = new HashMap<String,String>();
		
		for(int i=0; i<taskGbList.size(); i++){
			
			for(int j=0; j<periodList.size(); j++){
				taskDev.put("taskGbList",String.valueOf(taskGbList.get(i)));
				taskDev.put("dt",String.valueOf(periodList.get(j)));
				taskDevStats.addAll(devPlanService.selectTaskDevWeekStats(taskDev));

			}
		}
		
		JSONArray taskDevArray = new JSONArray();
		JSONObject taskDevObj = new JSONObject();
		
		int sumTaskDev=0;
		int div2 = taskPlanStats.size() / periodList.size();
		
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
		
		JsonUtil jsU4 = new JsonUtil();
		List<Map<String,Object>> taskDevList = jsU4.getListMapFromJsonArray(taskDevArray);
		
		model.addAttribute("stats4", taskDevStats);
		model.addAttribute("taskDevList",taskDevList);
		
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
		
		return "/tms/dev/devStatsTable";
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
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		String a = String.valueOf(searchVO.getSearchBySysGb());
		if(searchVO.getSearchBySysGb() != null && searchVO.getSearchBySysGb() != "") {
			//System.out.println("ddddd");
			List<?> taskGbList2 = TmsProgrmManageService.selectTaskGb4(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
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
		
		// 시스템별 진척률 시작 -------------------------------------
		// 시스템별 전체
		List<?> sysAllByStats = devPlanService.selectSysAllByStats();
		model.addAttribute("sysAllByStats", net.sf.json.JSONArray.fromObject(sysAllByStats));
		
		// 시스템별 그룹바이
		List<?> sysByStats = devPlanService.selectSysByStats();
		model.addAttribute("sysByStats", net.sf.json.JSONArray.fromObject(sysByStats));
		// 시스템별 진척률 끝 -------------------------------------

		// 업무별 진척률 시작 ---------------------------------------
		List<String> taskList = devPlanService.selectTaskGbList();
		
		// 업무별 금주 계획대비 실적, 금주 진척률
		List<HashMap<String,String>> taskThisWeek = new ArrayList<HashMap<String,String>>();
		for(int i=0; i<taskList.size(); i++){
			taskThisWeek.addAll(devPlanService.selectThisWeekStats(taskList.get(i)));
		}
		model.addAttribute("taskThisWeekByStats", net.sf.json.JSONArray.fromObject(taskThisWeek));
		
		// 업무별 금주 누적 계획대비 실적, 누적 진척률
		List<HashMap<String,String>> taskAccumulate = new ArrayList<HashMap<String,String>>();
		for(int i=0; i<taskList.size(); i++){
			taskAccumulate.addAll(devPlanService.selectAccumulateStats(taskList.get(i)));
		}
		model.addAttribute("taskAccumulateByStats", net.sf.json.JSONArray.fromObject(taskAccumulate));
		
		// 업무별 총 본수대비 실적, 총 진척률
		List<HashMap<String,String>> taskTotal = new ArrayList<HashMap<String,String>>();
		for(int i=0; i<taskList.size(); i++){
			taskTotal.addAll(devPlanService.selectTotalStats(taskList.get(i)));
		}
		model.addAttribute("taskTotalByStats", net.sf.json.JSONArray.fromObject(taskTotal));
		// 업무별 진척률 시작 ---------------------------------------	
		
		return "tms/dev/devStats";
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
