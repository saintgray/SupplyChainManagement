package kr.happyjob.study.jmg.model;

import java.util.Date;

public class ResumeCareerInfoDto {
	
	private int career_No;
	private String loginID;
	private Date join_Date;
	private Date resign_Date;
	private String corp;
	public ResumeCareerInfoDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ResumeCareerInfoDto(int career_No, String loginID, Date join_Date, Date resign_Date, String corp) {
		super();
		this.career_No = career_No;
		this.loginID = loginID;
		this.join_Date = join_Date;
		this.resign_Date = resign_Date;
		this.corp = corp;
	}
	public int getCareer_No() {
		return career_No;
	}
	public void setCareer_No(int career_No) {
		this.career_No = career_No;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public Date getJoin_Date() {
		return join_Date;
	}
	public void setJoin_Date(Date join_Date) {
		this.join_Date = join_Date;
	}
	public Date getResign_Date() {
		return resign_Date;
	}
	public void setResign_Date(Date resign_Date) {
		this.resign_Date = resign_Date;
	}
	public String getCorp() {
		return corp;
	}
	public void setCorp(String corp) {
		this.corp = corp;
	}
	@Override
	public String toString() {
		return "ResumeCareerInfoDto [career_No=" + career_No + ", loginID=" + loginID + ", join_Date=" + join_Date
				+ ", resign_Date=" + resign_Date + ", corp=" + corp + "]";
	}
	
	
	
						
}
