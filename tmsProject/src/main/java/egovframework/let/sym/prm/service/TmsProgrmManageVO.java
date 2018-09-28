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

public class TmsProgrmManageVO{

	/** 프로그램파일명 */
	private String PG_ID="";
	/** 프로그램저장경로 */
	private String USER_DEV_ID="";
	/** 프로그램한글명 */
	private String PG_NM="";
	/** URL */
	private String SYS_GB="";
	/** 프로그램설명	 */	
	private String TASK_GB="";
	
	private String USE_YN="";
	
	private String PJT_ID="";
	
	private String USER_REAL_ID="";
	
	

	public String getUSER_REAL_ID() {
		return USER_REAL_ID;
	}

	public void setUSER_REAL_ID(String uSER_REAL_ID) {
		USER_REAL_ID = uSER_REAL_ID;
	}

	public String getPG_ID() {
		return PG_ID;
	}

	public void setPG_ID(String pG_ID) {
		PG_ID = pG_ID;
	}

	public String getUSER_DEV_ID() {
		return USER_DEV_ID;
	}

	public void setUSER_DEV_ID(String uSER_DEV_ID) {
		USER_DEV_ID = uSER_DEV_ID;
	}

	public String getPG_NM() {
		return PG_NM;
	}

	public void setPG_NM(String pG_NM) {
		PG_NM = pG_NM;
	}

	public String getSYS_GB() {
		return SYS_GB;
	}

	public void setSYS_GB(String sYS_GB) {
		SYS_GB = sYS_GB;
	}

	public String getTASK_GB() {
		return TASK_GB;
	}

	public void setTASK_GB(String tASK_GB) {
		TASK_GB = tASK_GB;
	}

	public String getUSE_YN() {
		return USE_YN;
	}

	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}

	public String getPJT_ID() {
		return PJT_ID;
	}

	public void setPJT_ID(String pJT_ID) {
		PJT_ID = pJT_ID;
	}

	@Override
	public String toString() {
		return "TmsProgrmManageVO [PG_ID=" + PG_ID + ", USER_DEV_ID=" + USER_DEV_ID + ", PG_NM=" + PG_NM + ", SYS_GB="
				+ SYS_GB + ", TASK_GB=" + TASK_GB + ", USE_YN=" + USE_YN + ", PJT_ID=" + PJT_ID + ", USER_REAL_ID="
				+ USER_REAL_ID + "]";
	}

	
	
}