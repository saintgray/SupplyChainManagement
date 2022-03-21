package kr.happyjob.study.jmg.model;

import java.util.Date;

public class ResumeAwardInfoDto {
	
	private int award_No;
	private String loginID;
	private String award_Nm;
	private Date award_Date;
	public ResumeAwardInfoDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ResumeAwardInfoDto(int award_No, String loginID, String award_Nm, Date award_Date) {
		super();
		this.award_No = award_No;
		this.loginID = loginID;
		this.award_Nm = award_Nm;
		this.award_Date = award_Date;
	}
	public int getAward_No() {
		return award_No;
	}
	public void setAward_No(int award_No) {
		this.award_No = award_No;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getAward_Nm() {
		return award_Nm;
	}
	public void setAward_Nm(String award_Nm) {
		this.award_Nm = award_Nm;
	}
	public Date getAward_Date() {
		return award_Date;
	}
	public void setAward_Date(Date award_Date) {
		this.award_Date = award_Date;
	}
	@Override
	public String toString() {
		return "ResumeAwardInfoDto [award_No=" + award_No + ", loginID=" + loginID + ", award_Nm=" + award_Nm
				+ ", award_Date=" + award_Date + "]";
	}
	
	

}
