package egovframework.let.tms.pg.service;

import java.text.SimpleDateFormat;
import java.util.Date;

public class PgCurrentVO extends ProgramDefaultVO{
	
	private static final long serialVersionUID = 1L;
	

	   /** 프로그램 id */
	   private   String      pgId;
	   
	   /** 프로그램 명 */
	   private   String      pgNm;
	   
	   /** 개발자 ID */ 
	   private   String      userDevId;
	   
	   /**  개발완료일자 */
	   private String devEndDt;
		
	   /**  개발완료여부 */
	   private String devEndYn;
		
		/**  2차테스트결과 */
		private String secondTestResultYn;
		
		/**  3차테스트결과 */
		private String thirdTestResultYn;
	
		/**
		 * pgId attribute를 리턴한다.
		 * @return String
		 */
		public String getPgId() {
			return pgId;
		}
		/**
		 * pgId attribute 값을 설정한다.
		 * @param menuNo String
		 */
		public void setPgId(String pgId) {
			this.pgId = pgId;
		}
		
		/**
		 * pgNm attribute를 리턴한다.
		 * @return String
		 */
		public String getPgNm() {
			return pgNm;
		}
		/**
		 * pgNm attribute 값을 설정한다.
		 * @param menuNo String
		 */
		public void setPgNm(String pgNm) {
			this.pgNm = pgNm;
		}
		/**
		 * userDevId attribute를 리턴한다.
		 * @return String
		 */
		public String getUserDevId() {
			return userDevId;
		}	
		
		public String getDevEndDt() {
			return devEndDt;
		}

		public void setDevEndDt(Date DEV_END_DT) {
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			String to = transFormat.format(DEV_END_DT);

			this.devEndDt = to;
		}

		public String getDevEndYn() {
			return devEndYn;
		}

		public void setDevEndYn(String DEV_END_YN) {
			this.devEndYn = DEV_END_YN;
		}

		public String getSecondTestResultYn() {
			return secondTestResultYn;
		}

		public void setSecondTestResultYn(String SECOND_TEST_RESULT_YN) {
			this.secondTestResultYn = SECOND_TEST_RESULT_YN;
		}

		public String getThirdTestResultYn() {
			return thirdTestResultYn;
		}

		public void setThirdTestResultYn(String THIRD_TEST_RESULT_YN) {
			this.thirdTestResultYn = THIRD_TEST_RESULT_YN;
		}
		
}
