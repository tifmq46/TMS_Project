package egovframework.let.tms.defect.service;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;

@SuppressWarnings("serial")
public class DefectDefaultVO extends DefectVO implements Serializable{

	/** 검색조건 */
	private String searchCondition = "";

	/** 검색Keyword */
	private String searchKeyword = "";
	
	/** 프로그램(화면) 아이디로 검색*/
	private String searchByPgId = "";
	
	/** 업무구분으로 검색*/
	private int searchByTaskGb = 0;
	
	/** 결함구분으로 검색*/
	private int searchByDefectGb = 0;
	
	/** 조치상태로 검색*/
	private int searchByActionSt = 0;
	
	/** 테스터아이디로 검색 */
	private String searchByUserTestId = "";
	
	/** 개발자아이디로 검색*/
	private String searchByUserDevId = "";
	
	/** 등록일자로 검색*/
	private Date searchByEnrollDt;
	
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

	public int getSearchByTaskGb() {
		return searchByTaskGb;
	}

	public void setSearchByTaskGb(int searchByTaskGb) {
		this.searchByTaskGb = searchByTaskGb;
	}

	public int getSearchByDefectGb() {
		return searchByDefectGb;
	}

	public void setSearchByDefectGb(int searchByDefectGb) {
		this.searchByDefectGb = searchByDefectGb;
	}

	public int getSearchByActionSt() {
		return searchByActionSt;
	}

	public void setSearchByActionSt(int searchByActionSt) {
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

	public Date getSearchByEnrollDt() {
		return searchByEnrollDt;
	}

	public void setSearchByEnrollDt(Date searchByEnrollDt) {
		this.searchByEnrollDt = searchByEnrollDt;
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
	
	
	
}
