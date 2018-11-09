package egovframework.let.uat.uia.service;

import java.util.List;

import egovframework.com.cmm.TmsLoginVO;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
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
public interface TmsLoginService {
	
	String searchId(TmsLoginVO tmsloginVO) throws Exception;
	
	String searchName(TmsLoginVO tmsloginVO) throws Exception;

	Object addUsr(TmsLoginVO tmsloginVO);
	
}
