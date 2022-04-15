package kr.happyjob.study.scmStandard.model;

import java.util.Date;

public class UserInfoModel {
	
	//사용자 아이디
	private String loginID;
	
	//사용자 비밀번호
	private String password;
	
	//사용자 구분
	private String user_Type;
	
	//회사명
	private String client;

	//직원명
	private String clientnm;
	
	//담당자명
	private String mgrnm;
		
	//연락처
	private String phone;
	
	//이메일
	private String email;
	
	//우편번호
	private String zipCode;
	
	//주소
	private String address;
	
	//상세주소
	private String dtAddress;
	
	//등록일
	private Date regDate;
	
	//수정일
	private Date upDate;
		
	//수정한 아이디
	private String upID;
	
	
	private String fnl_mdfr_sst_id;
	
	
	
	
	
	
	
	
	/////////////getter.setter//////////////

	public String getFnl_mdfr_sst_id() {
		return fnl_mdfr_sst_id;
	}

	public void setFnl_mdfr_sst_id(String fnl_mdfr_sst_id) {
		this.fnl_mdfr_sst_id = fnl_mdfr_sst_id;
	}

	public Date getUpDate() {
		return upDate;
	}

	public void setUpDate(Date upDate) {
		this.upDate = upDate;
	}

	public String getUpID() {
		return upID;
	}

	public void setUpID(String upID) {
		this.upID = upID;
	}

	public Date getRegDate() {
		return regDate;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDtAddress() {
		return dtAddress;
	}

	public void setDtAddress(String dtAddress) {
		this.dtAddress = dtAddress;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getUser_Type() {
		return user_Type;
	}

	public void setUser_Type(String user_Type) {
		this.user_Type = user_Type;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getClientnm() {
		return clientnm;
	}

	public void setClientnm(String clientnm) {
		this.clientnm = clientnm;
	}

	public String getMgrnm() {
		return mgrnm;
	}

	public void setMgrnm(String mgrnm) {
		this.mgrnm = mgrnm;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	

}
