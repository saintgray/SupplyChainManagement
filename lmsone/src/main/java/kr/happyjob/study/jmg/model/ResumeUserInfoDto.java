package kr.happyjob.study.jmg.model;

import java.util.Date;

public class ResumeUserInfoDto {
	
	private String loginID;
	private String name;
	private String gender;
	private String tel;
	private String zipCd;
	private String addr;
	private String dtl_Addr;
	private Date birth;
	private String email;
	private String join_Yn;
	public ResumeUserInfoDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ResumeUserInfoDto(String loginID, String name, String gender, String tel, String zipCd, String addr,
			String dtl_Addr, Date birth, String email, String join_Yn) {
		super();
		this.loginID = loginID;
		this.name = name;
		this.gender = gender;
		this.tel = tel;
		this.zipCd = zipCd;
		this.addr = addr;
		this.dtl_Addr = dtl_Addr;
		this.birth = birth;
		this.email = email;
		this.join_Yn = join_Yn;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getZipCd() {
		return zipCd;
	}
	public void setZipCd(String zipCd) {
		this.zipCd = zipCd;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getDtl_Addr() {
		return dtl_Addr;
	}
	public void setDtl_Addr(String dtl_Addr) {
		this.dtl_Addr = dtl_Addr;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getJoin_Yn() {
		return join_Yn;
	}
	public void setJoin_Yn(String join_Yn) {
		this.join_Yn = join_Yn;
	}
	@Override
	public String toString() {
		return "ResumeUserInfoDto [loginID=" + loginID + ", name=" + name + ", gender=" + gender + ", tel=" + tel
				+ ", zipCd=" + zipCd + ", addr=" + addr + ", dtl_Addr=" + dtl_Addr + ", birth=" + birth + ", email="
				+ email + ", join_Yn=" + join_Yn + "]";
	}
	
	

}
