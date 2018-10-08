package egovframework.let.tms.dev.web;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.set.SynchronizedSortedSet;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
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
import egovframework.let.tms.dev.service.TempVO;
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
		
		List<?> devResultList = devPlanService.selectDevResultList(searchVO);
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
	public String updateDevResult(@ModelAttribute("searchVO") DevPlanVO dvo, BindingResult bindingResult, SessionStatus status, Model model) throws Exception {

		
		//if (bindingResult.hasErrors()) {
			//return "/tms/dev/updateDevPlan";
		//} else {
			devPlanService.updateDevResult(dvo);
			status.setComplete();
			model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
			return "redirect:/tms/dev/devResultList.do";
		//}
	}
	
	@RequestMapping(value = "/tms/dev/deleteDevResult.do")
	public String deleteDevResult(@ModelAttribute("searchVO") DevPlanVO dvo, SessionStatus status, Model model) throws Exception {

		devPlanService.deleteDevResult(dvo);
		status.setComplete();
		model.addAttribute("message", egovMessageSource.getMessage("success.common.delete"));
		return "forward:/tms/dev/selectDevResult.do";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/tms/dev/devStats.do")
	public String devStats(@ModelAttribute("searchVO") DevPlanVO dvo, SessionStatus status, Model model) throws Exception {
		
		
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
				
		List<HashMap<String,String>> temp = new ArrayList<HashMap<String,String>>();
		TempVO t = new TempVO();
		
		for(int i=0; i<userList.size(); i++) {
			temp.addAll(devPlanService.selectTempList(userList.get(i).toString()));
		}
		
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		devPlanService.deleteTemp();
		String planEndDate;
		String[] splitDate;
		
		for(int i=0; i<temp.size(); i++){
			t.setPgId(String.valueOf(temp.get(i).get("PG_ID")));
			t.setUserDevId(String.valueOf(temp.get(i).get("USER_DEV_ID")));
			t.setUserDevNm(String.valueOf(temp.get(i).get("USER_DEV_NM")));
			
			planEndDate = String.valueOf(temp.get(i).get("PLAN_END_DT"));
			splitDate = planEndDate.split("-");
			t.setPlanEndDt(splitDate[0]+splitDate[1]+splitDate[2]);
			
			devPlanService.insertTemp(t);
		}
		
		List<String> periodList = devPlanService.selectPeriod();
		
		List<HashMap<String,String>> userDevStats = new ArrayList<HashMap<String,String>>();
		
		HashMap<String,String> test = new HashMap<String,String>();
		
		
		
		for(int i=0; i<userList.size(); i++){
			
			for(int j=0; j<periodList.size(); j++){
				test.put("userList",String.valueOf(userList.get(i)));
				test.put("dates",String.valueOf(periodList.get(j)));
				userDevStats.addAll(devPlanService.selectUserDevStats(test));			
			}
		}
		
		JSONObject jsonObject = new JSONObject();
		JSONArray resultArray = new JSONArray();
		JSONObject resultInfo = new JSONObject();
		/*이름 중복 저장 여부 플래그*/
		boolean flag = true;
		
		/*for(int i=0; i<userDevStats.size(); i++){
			같은 사람 찾기
			for(int j=0; j<userList.size(); j++){
				System.out.println("userList값 ;;"+userList.get(j));
				System.out.println("userDevStats값 ;;"+userDevStats.get(i).get("userDevId"));
				
				if(userDevStats.get(i).get("userDevId").equals(userList.get(j))){
					while(resultArray.iterator().hasNext() ){
						
					}
					
					if(flag){
					System.out.println("값 확인"+ userDevStats.get(i).get("userDevNm"));
					 resultInfo.put("DevNm", userDevStats.get(i).get("userDevNm"));
					 flag = false;
					 resultArray.add(resultInfo);
					}
					
				}
			}
		}
		System.out.println("resultArray++++"+resultArray);*/
		
		resultInfo.put("DevNm", userDevStats.get(0).get("userDevNm"));
		
		for(int i=0; i< periodList.size(); i++){
			resultInfo.put( "a"+periodList.get(i), userDevStats.get(i).get(periodList.get(i)));
		}
		resultArray.add(resultInfo);
		
		
		resultInfo = new JSONObject();
		resultInfo.put("DevNm", userDevStats.get(periodList.size()+1).get("userDevNm"));

		for(int i=0; i< periodList.size(); i++){
			resultInfo.put( "a"+periodList.get(i), userDevStats.get(i+periodList.size()).get(periodList.get(i)));
		}
		resultArray.add(resultInfo);
		
		
		resultInfo = new JSONObject();
		resultInfo.put("DevNm", userDevStats.get((periodList.size()*2)+1).get("userDevNm"));

		for(int i=0; i< periodList.size(); i++){
			resultInfo.put( "a"+periodList.get(i), userDevStats.get(i+(periodList.size()*2)).get(periodList.get(i)));
		}
		resultArray.add(resultInfo);
		
		JsonUtil jsU = new JsonUtil();
		List<Map<String,Object>> a = jsU.getListMapFromJsonArray(resultArray);
		
		System.out.println("한줄로"+a);
		
		jsonObject.put("test",resultArray);
		 
		System.out.println("++++++++++"+jsonObject.toJSONString());
		
		//List<Map<String,Object>> a = new ArrayList<Map<String,Object>>();
		
		
		
		//userDevStats.addAll(devPlanService.selectUserDevStats("20181004"));
		//for(int i=0; i<periodList.size(); i++){
			//userDevStats.addAll(devPlanService.selectUserDevStats(periodList.get(i).toString()));
		//}
		
		model.addAttribute("stats", userDevStats);
		model.addAttribute("a",a);
		
		return "/tms/dev/devStats";
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
		//model.addAttribute("resultList", devCurrentList);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date start[] = new Date[devCurrentList.size()];
		Date end[] = new Date[devCurrentList.size()];
		Date cur = new Date();
		DecimalFormat format = new DecimalFormat(".#");
		
		/*달성률 계산*/
		for(int i=0; i<devCurrentList.size(); i++){
			String start_temp = String.valueOf(devCurrentList.get(i).get("PLAN_START_DT"));
			start[i] = sdf.parse(start_temp);
			
			String end_temp = String.valueOf(devCurrentList.get(i).get("PLAN_END_DT"));
			end[i] = sdf.parse(end_temp);
			
			int compare = cur.compareTo(start[i]); 	/*현재날짜, 계획시작날짜 비교*/
			int compare2 = cur.compareTo(end[i]);	/*현재날짜, 계획종료날짜 비교*/
			
			/*계획시작일 ~ 현재날짜 작업일수*/
			long calDate = start[i].getTime() - cur.getTime();
			long calDateDays = Math.abs(calDate / (24*60*60*1000));
			float aa = (float)(long)calDateDays;
			
			/*계획시작일 ~ 계획종료일 작업일수*/
			long calDate2 = start[i].getTime() - end[i].getTime();
			long calDateDays2 = Math.abs(calDate2 / (24*60*60*1000));
			float bb = (float)(long)calDateDays2;
			
			searchVO.setPgId(devCurrentList.get(i).get("PG_ID"));
			float achRate = (float) 0.0;
			
			if(compare > 0){
				System.out.println("현재날짜 > 계획시작일");
				if(compare2 > 0){
					achRate = (float) 100.0;
				}else if(compare2 < 0){
					achRate = Float.parseFloat(String.format("%.1f",((aa/bb)*100)));
				}
			}else if(compare < 0){
				System.out.println("현재날짜 < 계획시작일");
					achRate = (float) 0.0;

			}
			
			searchVO.setAchievementRate(achRate);
			devPlanService.updateRate(searchVO);
		}
		List<HashMap<String,String>> devResult = devPlanService.selectDevCurrent(searchVO);
		model.addAttribute("resultList", devResult);
		
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
