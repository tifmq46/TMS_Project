package egovframework.let.uat.uia.service.impl;


import egovframework.com.cmm.TmsLoginVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

import java.util.List;

import org.springframework.stereotype.Repository;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
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
@Repository("tmsLoginDAO")
public class TmsLoginDAO extends EgovAbstractDAO {
	
	public String searchId(TmsLoginVO tmsLoginVO) throws Exception{
		String a = (String) select("TmsLoginDAO.searchId", tmsLoginVO);
		return a;
	}
	
	public String searchName(TmsLoginVO tmsLoginVO) throws Exception{
		String a = (String) select("TmsLoginDAO.searchName", tmsLoginVO);
		return a;
	}

	public Object addUsr(TmsLoginVO tmsloginVO) {
		// TODO Auto-generated method stub
		insert("TmsLoginDAO.addUsr", tmsloginVO);
		return null;
	}
	
}
