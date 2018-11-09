package egovframework.let.uat.uia.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
//import egovframework.let.ems.service.EgovSndngMailRegistService;
//import egovframework.let.ems.service.SndngMailVO;

import egovframework.com.cmm.TmsLoginVO;
import egovframework.let.uat.uia.service.TmsLoginService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
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
@Service("tmsLoginService")
public class TmsLoginServiceImpl extends EgovAbstractServiceImpl implements TmsLoginService {

    @Resource(name="tmsLoginDAO")
    private TmsLoginDAO tmsLoginDAO;

	@Override
	public String searchId(TmsLoginVO tmsLoginVO) throws Exception {
		// TODO Auto-generated method stub
		return tmsLoginDAO.searchId(tmsLoginVO);
	}

	@Override
	public String searchName(TmsLoginVO tmsLoginVO) throws Exception {
		// TODO Auto-generated method stub
		return tmsLoginDAO.searchName(tmsLoginVO);
	}
	
	@Override
	public Object addUsr(TmsLoginVO tmsloginVO) {
		// TODO Auto-generated method stub
		tmsLoginDAO.addUsr(tmsloginVO);
		return null;
		
	}

}
