package egovframework.let.sym.prm.service;

/** 
 * 프로그램목록 처리를 위한 VO 클래스르를 정의한다
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성
 *
 * </pre>
 */

public class TmsProjectManageVO{

	String PJT_ID;

	public String getPJT_ID() {
		return PJT_ID;
	}

	public void setPJT_ID(String pJT_ID) {
		PJT_ID = pJT_ID;
	}

	@Override
	public String toString() {
		return "TmsProjectManageVO [PJT_ID=" + PJT_ID + "]";
	}

	
	
	

	
}