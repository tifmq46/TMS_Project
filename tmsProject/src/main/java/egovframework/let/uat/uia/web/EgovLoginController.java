package egovframework.let.uat.uia.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.WebApplicationContextUtils;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.TmsLoginVO;
import egovframework.let.uat.uia.service.EgovLoginService;
import egovframework.let.uat.uia.service.TmsLoginService;
import egovframework.let.utl.sim.service.EgovClntInfo;
import egovframework.rte.fdl.cmmn.trace.LeaveaTrace;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 컨트롤러 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성
 *  2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 *  </pre>
 */
@Controller
public class EgovLoginController {

	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;
	
	/** EgovLoginService */
	@Resource(name = "tmsLoginService")
	private TmsLoginService tmsLoginService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;



	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** TRACE */
	@Resource(name = "leaveaTrace")
	LeaveaTrace leaveaTrace;

	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/egovLoginUsr.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "uat/uia/EgovLoginUsr";
	}

	/**
	 * 일반(스프링 시큐리티) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionSecurityLogin.do")
	public String actionSecurityLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletResponse response, HttpServletRequest request, ModelMap model) throws Exception {

		// 접속IP
		String userIp = EgovClntInfo.getClntIP(request);

		// 1. 일반 로그인 처리
		LoginVO resultVO = loginService.actionLogin(loginVO);

		boolean loginPolicyYn = true;

		

		
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") && loginPolicyYn) {

			// 2. spring security 연동
			request.getSession().setAttribute("LoginVO", resultVO);

			UsernamePasswordAuthenticationFilter springSecurity = null;

			ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getSession().getServletContext());
			@SuppressWarnings("rawtypes")
			Map beans = act.getBeansOfType(UsernamePasswordAuthenticationFilter.class);
			if (beans.size() > 0) {
				springSecurity = (UsernamePasswordAuthenticationFilter) beans.values().toArray()[0];
			} else {
				throw new IllegalStateException("No AuthenticationProcessingFilter");
			}

			springSecurity.setContinueChainBeforeSuccessfulAuthentication(false); // false 이면 chain 처리 되지 않음.. (filter가 아닌 경우 false로...)

			springSecurity.doFilter(new RequestWrapperForSecurity(request, resultVO.getUserSe() + resultVO.getId(), resultVO.getUniqId()), response, null);

			return "forward:/uat/uia/actionMain.do"; // 성공 시 페이지.. (redirect 불가)

		} else {

			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}
	}

	/**
	 * 로그인 후 메인화면으로 들어간다
	 * @param
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionMain.do")
	public String actionMain(ModelMap model) throws Exception {
		// 1. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "uat/uia/EgovLoginUsr";
		}

		// 2. 메인 페이지 이동
		return "forward:/cmm/main/mainPage.do";
	}
	
	/**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "/uat/uia/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("LoginVO", null);

		return "redirect:/j_spring_security_logout";
	}
	
	
	@RequestMapping(value="/uat/uia/viewAddUsr.do")
	public String ViewAddUsr(ModelMap model) throws Exception {
		if(EgovUserDetailsHelper.isAuthenticated()){
	   		//인증된 경우 처리할 사항 추가 ...
	   		model.addAttribute("lastLogoutDateTime", "로그아웃 타임: 2011-11-10 11:30");
	   		//최근 로그아웃 시간 등에 대한 확보 후 메인 컨텐츠로 활용
	   	}
	    	return "uat/uia/ViewTmsAddUsr";
	    }
	 
	@RequestMapping(value="/uat/uia/addUsr.do")
	public String addUsr(@ModelAttribute("TmsLoginVO") TmsLoginVO TmsloginVO, ModelMap model) throws Exception {
		tmsLoginService.addUsr(TmsloginVO);
       	return "uat/uia/EgovLoginUsr";
	    }
	 
	@RequestMapping(value="/uat/uia/checkId.do")
	@ResponseBody
	public String checkId(@ModelAttribute("TmsLoginVO") TmsLoginVO TmsloginVO, String EMPLYR_ID, ModelMap model) throws Exception {
	 
		 TmsloginVO.setEMPLYR_ID(EMPLYR_ID);
		 String Id = tmsLoginService.searchId(TmsloginVO);
		 if(Id==null)
		 {
			 return "notHave";
		 }else{
			 return "have";
		 }
	    }
	
	@RequestMapping(value="/uat/uia/checkName.do")
	@ResponseBody
	public String checkName(@ModelAttribute("TmsLoginVO") TmsLoginVO TmsloginVO, String EMPLYR_ID, ModelMap model) throws Exception {
	 
		 TmsloginVO.setEMPLYR_ID(EMPLYR_ID);
		 String Id = tmsLoginService.searchName(TmsloginVO);
		 System.out.println("확인 : "+Id);
		 if(Id==null)
		 {
			 return "notHave";
		 }else{
			 return "have";
		 }
	    }
	 
}

class RequestWrapperForSecurity extends HttpServletRequestWrapper {
	private String username = null;
	private String password = null;

	public RequestWrapperForSecurity(HttpServletRequest request, String username, String password) {
		super(request);

		this.username = username;
		this.password = password;
	}

	@Override
	public String getRequestURI() {
		return ((HttpServletRequest) super.getRequest()).getContextPath() + "/j_spring_security_check";
	}

	@Override
	public String getParameter(String name) {
		if (name.equals("j_username")) {
			return username;
		}

		if (name.equals("j_password")) {
			return password;
		}

		return super.getParameter(name);
	}
}