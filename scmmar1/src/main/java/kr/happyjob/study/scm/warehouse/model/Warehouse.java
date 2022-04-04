package kr.happyjob.study.scm.warehouse.model;

public class Warehouse {
	
	private String wh_id;
	private String wh_nm;
	private String loginID;
	private String email;
	private String phone;
	private String zipCode;
	private String wh_loc;
	
	public Warehouse() {
		
	}

	public Warehouse(String wh_id, String wh_nm, String loginID, String email, String phone, String zipCode,
			String wh_loc) {
		
		this.wh_id = wh_id;
		this.wh_nm = wh_nm;
		this.loginID = loginID;
		this.email = email;
		this.phone = phone;
		this.zipCode = zipCode;
		this.wh_loc = wh_loc;
	}

	public String getWh_id() {
		return wh_id;
	}

	public void setWh_id(String wh_id) {
		this.wh_id = wh_id;
	}

	public String getWh_nm() {
		return wh_nm;
	}

	public void setWh_nm(String wh_nm) {
		this.wh_nm = wh_nm;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getWh_loc() {
		return wh_loc;
	}

	public void setWh_loc(String wh_loc) {
		this.wh_loc = wh_loc;
	}
	
	
	
	
	

}
