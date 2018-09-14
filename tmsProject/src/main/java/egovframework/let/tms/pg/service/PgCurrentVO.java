package egovframework.let.tms.pg.service;

import java.text.SimpleDateFormat;
import java.util.Date;

public class PgCurrentVO extends ProgramDefaultVO{
	
	private static final long serialVersionUID = 1L;
	

	   /** 프로그램 id */
	   private   String      PG_ID;
	   
	   /** 프로그램 명 */
	   private   String      PG_NM;
	   
	   /** 개발자 ID */ 
	   private   String      USER_DEV_ID;
	   
	   /**  개발완료일자 */
	   private String DEV_END_DT;
		
	   /**  개발완료여부 */
	   private String DEV_END_YN;
		
		/**  2차테스트결과 */
		private String SECOND_TEST_RESULT_YN;
		
		/**  3차테스트결과 */
		private String THIRD_TEST_RESULT_YN;
	
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
		/**
		 * USER_DEV_ID attribute를 리턴한다.
		 * @return String
		 */
		public String getUSER_DEV_ID() {
			return USER_DEV_ID;
		}	
		
		public String getDEV_END_DT() {
			return DEV_END_DT;
		}

		public void setDevEndDt(Date DEV_END_DT) {
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			String to = transFormat.format(DEV_END_DT);

			this.DEV_END_DT = to;
		}

		public String getDEV_END_YN() {
			return DEV_END_YN;
		}

		public void setDevEndYn(String DEV_END_YN) {
			this.DEV_END_YN = DEV_END_YN;
		}

		public String getSECOND_TEST_RESULT_YN() {
			return SECOND_TEST_RESULT_YN;
		}

		public void setSECOND_TEST_RESULT_YN(String SECOND_TEST_RESULT_YN) {
			this.SECOND_TEST_RESULT_YN = SECOND_TEST_RESULT_YN;
		}

		public String getTHIRD_TEST_RESULT_YN() {
			return THIRD_TEST_RESULT_YN;
		}

		public void setTHIRD_TEST_RESULT_YN(String THIRD_TEST_RESULT_YN) {
			this.THIRD_TEST_RESULT_YN = THIRD_TEST_RESULT_YN;
		}
		
}
