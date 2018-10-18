package egovframework.let.tms.defect.service;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.format.annotation.DateTimeFormat;

@SuppressWarnings("serial")
public class DefectDefaultVO extends DefectVO implements Serializable{

	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";
	
	/** 프로그램(화면) 아이디로 검색*/
	private String searchByPgId;
	
	/** 업무구분으로 검색*/
	private String searchByTaskGb;
	
	/** 결함구분으로 검색*/
	private String searchByDefectGb;
	
	/** 조치상태로 검색*/
	private String searchByActionSt;
	
	/** 테스터아이디로 검색 */
	private String searchByUserTestId;
	
	/** 개발자아이디로 검색*/
	private String searchByUserDevId;
	
	/** 등록일자로 검색*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date searchByStartDt;
	
	/** 끝 일자로 검색*/
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date searchByEndDt;
	
	/** 검색사용여부 */
	private String searchUseYn = "";

	/** 현재페이지 */
	private int pageIndex = 1;

	/** 페이지갯수 */
	private int pageUnit = 10;

	/** 페이지사이즈 */
	private int pageSize = 10;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 10;
	
	/** 로그인ID(세션)-사용자명*/
	private String sessionId;
	
	/** 로그인 권한ID(ESNTL_ID)*/
	private String uniqId;
	
	public String getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getSearchByPgId() {
		return searchByPgId;
	}

	public void setSearchByPgId(String searchByPgId) {
		this.searchByPgId = searchByPgId;
	}

	public String getSearchByTaskGb() {
		return searchByTaskGb;
	}

	public void setSearchByTaskGb(String searchByTaskGb) {
		this.searchByTaskGb = searchByTaskGb;
	}

	public String getSearchByDefectGb() {
		return searchByDefectGb;
	}

	public void setSearchByDefectGb(String searchByDefectGb) {
		this.searchByDefectGb = searchByDefectGb;
	}

	public String getSearchByActionSt() {
		return searchByActionSt;
	}

	public void setSearchByActionSt(String searchByActionSt) {
		this.searchByActionSt = searchByActionSt;
	}

	public String getSearchByUserTestId() {
		return searchByUserTestId;
	}

	public void setSearchByUserTestId(String searchByUserTestId) {
		this.searchByUserTestId = searchByUserTestId;
	}

	public String getSearchByUserDevId() {
		return searchByUserDevId;
	}

	public void setSearchByUserDevId(String searchByUserDevId) {
		this.searchByUserDevId = searchByUserDevId;
	}

	public Date getSearchByStartDt() {
		return searchByStartDt;
	}

	public void setSearchByStartDt(Date searchByStartDt) {
		this.searchByStartDt = searchByStartDt;
	}

	public Date getSearchByEndDt() {
		return searchByEndDt;
	}

	public void setSearchByEndDt(Date searchByEndDt) {
		this.searchByEndDt = searchByEndDt;
	}

	public String getSearchUseYn() {
		return searchUseYn;
	}

	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getPageUnit() {
		return pageUnit;
	}

	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public String getUniqId() {
		return uniqId;
	}

	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}
	
	
	
}
