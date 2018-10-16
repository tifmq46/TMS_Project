package egovframework.let.tms.pg.service;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;
import org.springmodules.validation.bean.conf.loader.annotation.handler.NotEmpty;
import org.springmodules.validation.bean.conf.loader.annotation.handler.NotNull;

public class ProgramVO extends ProgramDefaultVO{
	
	private static final long serialVersionUID = 1L;

	   /** 프로그램 id */
	   @NotEmpty
	   @NotNull
	   private   String      pgId;
	   
	   /** 프로그램 명 */
	   @NotEmpty
	   @NotNull
	   private   String      pgNm;
	   
	   /** 개발자 ID */ 
	   @NotEmpty
	   @NotNull
	   private   String      userDevId;
	   
	   /** 시스템구분 */
	   @NotEmpty
	   @NotNull
	   private   String      sysGb;
	   /** 업무구분 */
	   @NotEmpty
	   @NotNull
	   private   String      taskGb;
	   /** 사용여부 */
	   @NotEmpty
	   @NotNull
	   private   String      useYn;
	   /** 프로젝트 id */
	   private   String      pjtId;
	
		/**
		 * PG_ID attribute를 리턴한다.
		 * @return String
		 */
		public String getPgId() {
			return pgId;
		}
		/**
		 * PG_ID attribute 값을 설정한다.
		 * @param menuNo String
		 */
		public void setPgId(String pgId) {
			this.pgId = pgId;
		}
		
		/**
		 * PG_NM attribute를 리턴한다.
		 * @return String
		 */
		public String getPgNm() {
			return pgNm;
		}
		/**
		 * PG_NM attribute 값을 설정한다.
		 * @param menuNo String
		 */
		public void setPgNm(String pgNm) {
			this.pgNm = pgNm;
		}
		
		public void setUserDevId(String userDevId) {
			this.userDevId = userDevId;
		}
		/**
		 * USER_DEV_ID attribute를 리턴한다.
		 * @return String
		 */
		public String getUserDevId() {
			return userDevId;
		}	
		
		/**
		 * upperMenuId attribute를 리턴한다.
		 * @return int
		 */
		public String getSysGb() {
			return sysGb;
		}
		/**
		 * upperMenuId attribute 값을 설정한다.
		 * @param upperMenuId int
		 */
		public void setSysGb(String sysGb) {
			this.sysGb = sysGb;
		}
		
		public String getTaskGb() {
			return taskGb;
		}
		/**
		 * upperMenuId attribute 값을 설정한다.
		 * @param upperMenuId int
		 */
		public void setTaskGb(String taskGb) {
			this.taskGb = taskGb;
		}
		/**
		 * menuDc attribute를 리턴한다.
		 * @return String
		 */
		public String getUseYn() {
			return useYn;
		}
		/**
		 * menuDc attribute 값을 설정한다.
		 * @param menuDc String
		 */
		public void setUseYn(String useYn) {
			this.useYn = useYn;
		}
		public String getPjtId() {
			return pjtId;
		}
		/**
		 * PG_ID attribute 값을 설정한다.
		 * @param menuNo String
		 */
		public void setPjtId(String pjtId) {
			this.pjtId = pjtId;
		}

}
