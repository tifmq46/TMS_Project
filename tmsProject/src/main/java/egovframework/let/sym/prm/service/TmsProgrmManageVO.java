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
	private String pgId="";
	/** 프로그램저장경로 */
	private String userDevId="";
	/** 프로그램한글명 */
	private String pgNm="";
	/** URL */
	private String sysGb="";
	/** 프로그램설명	 */	
	private String taskGb="";
	
	private String useYn="";
	
	private String pjtId="";
	
	private String userRealId="";
	
	

	public String getUserRealId() {
		return userRealId;
	}

	public void setUserRealId(String uSER_REAL_ID) {
		userRealId = uSER_REAL_ID;
	}

	public String getPgId() {
		return pgId;
	}

	public void setPgId(String pG_ID) {
		pgId = pG_ID;
	}

	public String getUserDevId() {
		return userDevId;
	}

	public void setUserDevId(String uSER_DEV_ID) {
		userDevId = uSER_DEV_ID;
	}

	public String getPgNm() {
		return pgNm;
	}

	public void setPgNm(String pG_NM) {
		pgNm = pG_NM;
	}

	public String getSysGb() {
		return sysGb;
	}

	public void setSysGb(String sYS_GB) {
		sysGb = sYS_GB;
	}

	public String getTaskGb() {
		return taskGb;
	}

	public void setTaskGb(String tASK_GB) {
		taskGb = tASK_GB;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String uSE_YN) {
		useYn = uSE_YN;
	}

	public String getPjtId() {
		return pjtId;
	}

	public void setPjtId(String pJT_ID) {
		pjtId = pJT_ID;
	}

	@Override
	public String toString() {
		return "TmsProgrmManageVO [pgId=" + pgId + ", userDevId=" + userDevId + ", pgNm=" + pgNm + ", sysGb="
				+ sysGb + ", taskGb=" + taskGb + ", useYn=" + useYn + ", pjtId=" + pjtId + ", USER_REAL_ID="
				+ userRealId + "]";
	}

	
	
}