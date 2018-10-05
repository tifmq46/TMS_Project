package egovframework.let.main.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.LoginVO;
import egovframework.let.cop.bbs.service.EgovBBSManageService;
import egovframework.let.sym.mnu.mpm.service.EgovMenuManageService;
import egovframework.let.sym.mnu.mpm.service.MenuManageVO;
import egovframework.let.sym.prm.service.TmsProgrmManageService;
import egovframework.let.sym.prm.service.TmsProjectManageVO;
import egovframework.let.tms.defect.service.DefectService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import net.sf.json.JSONArray;

/**
 * 템플릿 메인 페이지 컨트롤러 클래스(Sample 소스)
 * @author 실행환경 개발팀 JJY
 * @since 2011.08.31
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2011.08.31  JJY            최초 생성
 *
 * </pre>
 */
@Controller@SessionAttributes(types = ComDefaultVO.class)
public class EgovMainController {

	/**
	 * EgovBBSManageService
	 */
	@Resource(name = "EgovBBSManageService")
    private EgovBBSManageService bbsMngService;

	/** EgovMenuManageService */
	@Resource(name = "meunManageService")
    private EgovMenuManageService menuManageService;
	
	/** EgovProgrmManageService */
	@Resource(name = "TmsProgrmManageService")
	private TmsProgrmManageService TmsProgrmManageService;

	/** DefectService */
	@Resource (name = "defectService")
	private DefectService defectService;
	
	/**
	 * 메인 페이지에서 각 업무 화면으로 연계하는 기능을 제공한다.
	 *
	 * @param request
	 * @param commandMap
	 * @exception Exception Exception
	 */
	@RequestMapping(value = "/cmm/forwardPage.do")
	public String forwardPageWithMenuNo(HttpServletRequest request, @RequestParam Map<String, Object> commandMap)
	  throws Exception{
		return "";
	}

	/**
	 * 템플릿 메인 페이지 조회
	 * @return 메인페이지 정보 Map [key : 항목명]
	 *
	 * @param request
	 * @param model
	 * @exception Exception Exception
	 */
	@RequestMapping(value = "/cmm/main/mainPage.do")
	public String getMgtMainPage(HttpServletRequest request, ModelMap model, @ModelAttribute("TmsProjectManageVO") TmsProjectManageVO TmsProjectManageVO)
	  throws Exception{
		System.out.println("프로젝트 인설트 후 옴");
		/*// 공지사항 메인 컨텐츠 조회 시작 ---------------------------------
		BoardVO boardVO = new BoardVO();
		boardVO.setPageUnit(10);
		boardVO.setPageSize(10);
		boardVO.setBbsId("BBSMSTR_AAAAAAAAAAAA");

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, "BBSA02");
		model.addAttribute("notiList", map.get("resultList"));


		// 공지사항 메인컨텐츠 조회 끝 -----------------------------------

		// 업무게시판 메인 컨텐츠 조회 시작 -------------------------------
		boardVO.setPageUnit(5);
		boardVO.setPageSize(10);
		boardVO.setBbsId("BBSMSTR_CCCCCCCCCCCC");

		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		model.addAttribute("bbsList", bbsMngService.selectBoardArticles(boardVO, "BBSA02").get("resultList"));*/

		// 업무게시판 메인컨텐츠 조회 끝 -----------------------------------
		// 프로젝트 정보 조회 시작 -------------------------------	
		TmsProjectManageVO tmsProjectManageVO = TmsProgrmManageService.selectProject();
		model.addAttribute("tmsProjectManageVO", tmsProjectManageVO);
		// 프로젝트 정보 조회 끝 -------------------------------
		
		// 공통코드 부분 시작 -------------------------------	
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		// 공통코드 끝 시작 -------------------------------	
		
		// 프로젝트 멤버 부분 시작 --------------------------
		List<?> pjtMemberList = defectService.selectPjtMember();
		model.addAttribute("pjtMemberList", pjtMemberList);
		// 프로젝트 멤버 부분 끝 ----------------------------
		
		// 결함 진행상태 부분 시작 --------------------------
		List<?> taskByMainStats = defectService.selectTaskByMainStats();
		model.addAttribute("taskByMainStats", JSONArray.fromObject(taskByMainStats));
		// 결함 진행상태 부분 끝 --------------------------
		
		/*List<?> testList = TmsProgrmManageService.selectTestList();
		
		List<HashMap<String,String>> r1 = new ArrayList <HashMap<String,String>>();
		List<HashMap<String,String>> r2 = new ArrayList <HashMap<String,String>>();
		
		//r1 = TmsProgrmManageService.selectProgrmList1(38);
		for(int i=38; i<44;i++){
			r1.addAll(TmsProgrmManageService.selectProgrmList1(i));
		}*/
		
		/*System.out.println("====tttt====="+r1);
		

		System.out.println(r1.size());
		int firstVal = r1.size()/6;
		String[] names = new String[firstVal];
		String[] names2 = new String[firstVal];
		
		for(int j=0; j<firstVal;j++){
			names[j] = r1.get(j).get("BN").toString();
			System.out.println("이름:"+names[j]); 
		}        
		
		//int k =38;
		int k1 =38;
		
		//String hm = hm+k;
		
		HashMap<String, String> hm1 = new HashMap<String,String>();
		HashMap<String, String> hm2 = new HashMap<String,String>();
		HashMap<String, String> hm3 = new HashMap<String,String>();
		HashMap<String, String> hm4 = new HashMap<String,String>();
		
		for(int i=0; i<firstVal; i++){
			HashMap<String, String> hmi = new HashMap<String,String>();			
		}
		
		int k[] = new int[4];
		ArrayList<HashMap<String, String>> al = new ArrayList <HashMap<String,String>>();
		
		for(int i=0; i<firstVal; i++){
			k[i]=38;
		}
		
		String t, t2;
		*/
		/*for(int i=0; i<r1.size();i++){
			
			//System.out.println("-----------------"+r1.get(i));
			String temp = r1.get(i).get("BN").toString();
			
			for(int j=0; j<firstVal; j++){
				if(names[j].equals(temp)){
					
					t = (String.format("%s",r1.get(i).get("B"+k[j])));
					
					hm1.put("BN", names[j]);
					hm1.put("B"+k[j], t);
					
					
					
					System.out.println("맵: "+ hm1);
					System.out.println("앞 리스트 :"+al);
					
					if(hm1.containsKey("B43")){
						System.out.println("><><><");
						//hm2.putAll(hm1);
						al.add(j, hm1);
						System.out.println("뒤 리스트 :"+al);
					}
					
					k[j] +=1;
					
				}
				
				//r2.addAll(al);
				
			}
		}*/
		//r2.addAll(al);
		
		//r2.add(rrr[0]);
		//r2.add(hm2);
		
		//System.out.println("====="+r2);
		
		//model.addAttribute("testList1", r1);
		
		//model.addAttribute("r2", r2);
		
		return "main/EgovMainView";
	}

	/**
     * Head메뉴를 조회한다.
     * @param menuManageVO MenuManageVO
     * @return 출력페이지정보 "main_headG", "main_head"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mms/EgovMainMenuHead.do")
    public String selectMainMenuHead(
    		@ModelAttribute("menuManageVO") MenuManageVO menuManageVO,
    		ModelMap model)
            throws Exception {

    	LoginVO user =
    		EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;

    	if(EgovUserDetailsHelper.isAuthenticated() && user!=null){
    		menuManageVO.setTmp_Id(user.getId());
        	menuManageVO.setTmp_Password(user.getPassword());
        	menuManageVO.setTmp_UserSe(user.getUserSe());
        	menuManageVO.setTmp_Name(user.getName());
        	menuManageVO.setTmp_Email(user.getEmail());
        	menuManageVO.setTmp_OrgnztId(user.getOrgnztId());
        	menuManageVO.setTmp_UniqId(user.getUniqId());
    		model.addAttribute("list_headmenu", menuManageService.selectMainMenuHead(menuManageVO));
    		model.addAttribute("list_menulist", menuManageService.selectMainMenuLeft(menuManageVO));
    	}else{
    		//model.addAttribute("list_headmenu", menuManageService.selectMainMenuHeadAnonymous(menuManageVO));
    		//model.addAttribute("list_menulist", menuManageService.selectMainMenuLeftAnonymous(menuManageVO));
    	}
        return "main/inc/EgovIncTopnav"; // 내부업무의 상단메뉴 화면
    }


    /**
     * 좌측메뉴를 조회한다.
     * @param menuManageVO MenuManageVO
     * @param vStartP      String
     * @return 출력페이지정보 "main_left"
     * @exception Exception
     */
    @RequestMapping(value="/sym/mms/EgovMainMenuLeft.do")
    public String selectMainMenuLeft(
    		ModelMap model)
            throws Exception {

    	//LoginVO user = EgovUserDetailsHelper.isAuthenticated()? (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser():null;
    	//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    	if(EgovUserDetailsHelper.isAuthenticated()){
    		//인증된 경우 처리할 사항 추가 ...
    		model.addAttribute("lastLogoutDateTime", "로그아웃 타임: 2011-11-10 11:30");
    		//최근 로그아웃 시간 등에 대한 확보 후 메인 컨텐츠로 활용
    	}

      	return "main/inc/EgovIncLeftmenu";
    }
    
   
    
   

}