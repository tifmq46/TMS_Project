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
	   private   String      PG_ID;
	   
	   /** 프로그램 명 */
	   @NotEmpty
	   @NotNull
	   private   String      PG_NM;
	   
	   /** 개발자 ID */ 
	   private   String      USER_DEV_ID;
	   
	   /** 시스템구분 */
	   private   String      SYS_GB;
	   /** 업무구분 */
	   private   String      TASK_GB;
	   /** 사용여부 */
	   private   String      USE_YN;
	   /** 프로젝트 id */
	   private   String      PJT_ID;
	
		/**
		 * PG_ID attribute를 리턴한다.
		 * @return String
		 */
		public String getPG_ID() {
			return PG_ID;
		}
		/**
		 * PG_ID attribute 값을 설정한다.
		 * @param menuNo String
		 */
		public void setPG_ID(String PG_ID) {
			this.PG_ID = PG_ID;
		}
		
		/**
		 * PG_NM attribute를 리턴한다.
		 * @return String
		 */
		public String getPG_NM() {
			return PG_NM;
		}
		/**
		 * PG_NM attribute 값을 설정한다.
		 * @param menuNo String
		 */
		public void setPG_NM(String PG_NM) {
			this.PG_NM = PG_NM;
		}
		
		public void setUSER_DEV_ID(String USER_DEV_ID) {
			this.USER_DEV_ID = USER_DEV_ID;
		}
		/**
		 * USER_DEV_ID attribute를 리턴한다.
		 * @return String
		 */
		public String getUSER_DEV_ID() {
			return USER_DEV_ID;
		}	
		
		/**
		 * upperMenuId attribute를 리턴한다.
		 * @return int
		 */
		public String getSYS_GB() {
			return SYS_GB;
		}
		/**
		 * upperMenuId attribute 값을 설정한다.
		 * @param upperMenuId int
		 */
		public void setSYS_GB(String SYS_GB) {
			this.SYS_GB = SYS_GB;
		}
		
		public String getTASK_GB() {
			return TASK_GB;
		}
		/**
		 * upperMenuId attribute 값을 설정한다.
		 * @param upperMenuId int
		 */
		public void setTASK_GB(String TASK_GB) {
			this.TASK_GB = TASK_GB;
		}
		/**
		 * menuDc attribute를 리턴한다.
		 * @return String
		 */
		public String getUSE_YN() {
			return USE_YN;
		}
		/**
		 * menuDc attribute 값을 설정한다.
		 * @param menuDc String
		 */
		public void setUSE_YN(String USE_YN) {
			this.USE_YN = USE_YN;
		}
		public String getPJT_ID() {
			return PJT_ID;
		}
		/**
		 * PG_ID attribute 값을 설정한다.
		 * @param menuNo String
		 */
		public void setPJT_ID(String PJT_ID) {
			this.PJT_ID = PJT_ID;
		}

}
