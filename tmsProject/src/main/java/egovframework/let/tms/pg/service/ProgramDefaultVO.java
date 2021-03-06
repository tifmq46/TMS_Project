package egovframework.let.tms.pg.service;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class ProgramDefaultVO implements Serializable{
	/**
	 *  serialVersion UID
	 */
	private static final long serialVersionUID = -858838578081269359L;

	
	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";

	/** 시스템구분으로 검색 */
	private String searchBySysGb = "";
	
	/** 업무구분으로 검색 */
	private String searchByTaskGb = "";
	
	/** 개발자명으로 검색  */
	private String searchByUserDevId = "";
	
	/** 화면ID로 검색 */
	private String searchByPgId = "";
	
	/** 계획일자로 검색*/
	private Date searchByPlanStartDt;
	
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
	
	private String del;
	
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	
	public String getSearchBySysGb() {
		return searchBySysGb;
	}

	public void setSearchBySysGb(String searchBySysGb) {
		this.searchBySysGb = searchBySysGb;
	}

	public String getSearchByTaskGb() {
		return searchByTaskGb;
	}

	public void setSearchByTaskGb(String searchByTaskGb) {
		this.searchByTaskGb = searchByTaskGb;
	}

	public String getSearchByUserDevId() {
		return searchByUserDevId;
	}

	public void setSearchByUserDevId(String searchByUserDevId) {
		this.searchByUserDevId = searchByUserDevId;
	}

	public String getSearchByPgId() {
		return searchByPgId;
	}

	public void setSearchByPgId(String searchByPgId) {
		this.searchByPgId = searchByPgId;
	}

	public Date getSearchByPlanStartDt() {
		return searchByPlanStartDt;
	}

	public void setSearchByPlanStartDt(Date searchByPlanStartDt) {
		this.searchByPlanStartDt = searchByPlanStartDt;
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

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}