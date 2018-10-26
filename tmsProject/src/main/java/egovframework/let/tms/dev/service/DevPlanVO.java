package egovframework.let.tms.dev.service;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

@SuppressWarnings("serial")
public class DevPlanVO implements Serializable{
	
	
	/** 프로그램 아이디 */
	private String pgId;
	
	/**  계획시작일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date planStartDt;
	
	/**  계획완료일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date planEndDt;
	
	/**  개발시작일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date devStartDt;
	
	/**  개발완료일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date devEndDt;
	
	/**  등록일자 */
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date enrollDt;
	
	/**  개발완료여부 */
	private String devEndYn;
	
	/**  1차테스트결과 */
	private String firstTestResultYn;
	
	/**  2차테스트결과 */
	private String secondTestResultYn;
	
	/**  3차테스트결과 */
	private String thirdTestResultYn;
	
	/**  달성률 */
	private Integer achievementRate;
	
	/**  소요일수 */
	private Integer dayDiff;
	
	public int  getAchievementRate() {
		return achievementRate;
	}

	public void setAchievementRate(int achievementRate) {
		this.achievementRate = achievementRate;
	}

	public String getPgId() {
		return pgId;
	}

	public void setPgId(String pgId) {
		this.pgId = pgId;
	}

	public Date getPlanStartDt() {
		return planStartDt;
	}

	public void setPlanStartDt(Date planStartDt) {
		this.planStartDt = planStartDt;
	}

	public Date getPlanEndDt() {
		return planEndDt;
	}

	public void setPlanEndDt(Date planEndDt) {
		this.planEndDt = planEndDt;
	}

	public Date getDevStartDt() {
		return devStartDt;
	}

	public void setDevStartDt(Date devStartDt) {
		this.devStartDt = devStartDt;
	}

	public Date getDevEndDt() {
		return devEndDt;
	}

	public void setDevEndDt(Date devEndDt) {
		this.devEndDt = devEndDt;
	}

	public Date getEnrollDt() {
		return enrollDt;
	}

	public void setEnrollDt(Date enrollDt) {
		this.enrollDt = enrollDt;
	}

	public String getDevEndYn() {
		return devEndYn;
	}

	public void setDevEndYn(String devEndYn) {
		this.devEndYn = devEndYn;
	}

	public String getFirstTestResultYn() {
		return firstTestResultYn;
	}

	public void setFirstTestResultYn(String firstTestResultYn) {
		this.firstTestResultYn = firstTestResultYn;
	}

	public String getSecondTestResultYn() {
		return secondTestResultYn;
	}

	public void setSecondTestResultYn(String secondTestResultYn) {
		this.secondTestResultYn = secondTestResultYn;
	}

	public String getThirdTestResultYn() {
		return thirdTestResultYn;
	}

	public void setThirdTestResultYn(String thirdTestResultYn) {
		this.thirdTestResultYn = thirdTestResultYn;
	}

	public Integer getDayDiff() {
		return dayDiff;
	}

	public void setDayDiff(Integer dayDiff) {
		this.dayDiff = dayDiff;
	}
}
