package egovframework.let.tms.defect.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class DefectVO{

	/** 결함 아이디 (시퀀스) */
	private int defectIdSq;
	
	/** 결함 제목*/
	private String defectTitle;
	
	/** 결함 내용 */
	private String defectContent;
	
	/** 프로그램 아이디 */
	private String pgId;
	
	/** 테스터 아이디 */
	private String userTestId;
	
	/** 결함 유형 구분 */
	private String defectGb;
	
	/** 등록일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date enrollDt;
	
	/** 조치내용 */
	private String actionContent;
	
	/** 조치상태 */
	private String actionSt;
	
	/** 조치일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date actionDt;

	/** 테스트시나리오 아이디 */
	private String testscenarioId;
	
	public int getDefectIdSq() {
		return defectIdSq;
	}
	
	/** 파일 테이블*/
	/** 결함 아이디는 결함테이블 사용*/
	
	/** 파일 번호(시퀀스) */
	private int fileIdSq;
	
	/** 파일명 */
	private String fileNm = "";
	
	/** 파일 사이즈 */
	private int fileSize = 0;
	
	/** 파일 이미지(blob)*/
	private MultipartFile fileImg;
	
//	private byte[] fileImg;
	
	private String fileImgByte;

	public String getFileImgByte() {
		return fileImgByte;
	}

	public void setFileImgByte(String fileImgByte) {
		this.fileImgByte = fileImgByte;
	}

	/** 파일 등록일자 == 결함등록일자? */
	
	public void setDefectIdSq(int defectIdSq) {
		this.defectIdSq = defectIdSq;
	}

	public String getDefectTitle() {
		return defectTitle;
	}

	public void setDefectTitle(String defectTitle) {
		this.defectTitle = defectTitle;
	}

	public String getDefectContent() {
		return defectContent;
	}

	public void setDefectContent(String defectContent) {
		this.defectContent = defectContent;
	}

	public String getPgId() {
		return pgId;
	}

	public void setPgId(String pgId) {
		this.pgId = pgId;
	}

	public String getUserTestId() {
		return userTestId;
	}

	public void setUserTestId(String userTestId) {
		this.userTestId = userTestId;
	}

	public String getDefectGb() {
		return defectGb;
	}

	public void setDefectGb(String defectGb) {
		this.defectGb = defectGb;
	}

	public Date getEnrollDt() {
		return enrollDt;
	}

	public void setEnrollDt(Date enrollDt) {
		this.enrollDt = enrollDt;
	}

	public String getActionContent() {
		return actionContent;
	}

	public void setActionContent(String actionContent) {
		this.actionContent = actionContent;
	}

	public String getActionSt() {
		return actionSt;
	}

	public void setActionSt(String actionSt) {
		this.actionSt = actionSt;
	}

	public Date getActionDt() {
		return actionDt;
	}

	public void setActionDt(Date actionDt) {
		this.actionDt = actionDt;
	}

	public String getTestscenarioId() {
		return testscenarioId;
	}

	public void setTestscenarioId(String testscenarioId) {
		this.testscenarioId = testscenarioId;
	}

	/** 파일 테이블 */

	public int getFileIdSq() {
		return fileIdSq;
	}

	public void setFileIdSq(int fileIdSq) {
		this.fileIdSq = fileIdSq;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public MultipartFile getFileImg() {
		return fileImg;
	}

	public void setFileImg(MultipartFile fileImg) {
		this.fileImg = fileImg;
	}

	@Override
	public String toString() {
		return "DefectVO [defectIdSq=" + defectIdSq + ", defectTitle=" + defectTitle + ", defectContent="
				+ defectContent + ", pgId=" + pgId + ", userTestId=" + userTestId + ", defectGb=" + defectGb
				+ ", enrollDt=" + enrollDt + ", actionContent=" + actionContent + ", actionSt=" + actionSt
				+ ", actionDt=" + actionDt + ", testscenarioId=" + testscenarioId + ", fileIdSq=" + fileIdSq
				+ ", fileNm=" + fileNm + ", fileSize=" + fileSize + ", fileImg=" + fileImg + "]";
	}

//	public byte[] getFileImg() {
//		return fileImg;
//	}
//
//	public void setFileImg(byte[] fileImg) {
//		this.fileImg = fileImg;
//	}

	
	
}
