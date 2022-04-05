package kr.happyjob.study.scm.warehouse.model;

public class WarehouseDetail {
	
	private String wh_id;
	private String loginID;
	private String wh_nm;
	private String name;
	private String email;
	private String phone;
	private String zipCode;
	private String wh_loc;
	private String addr;
	private String dtAddress;
	
	public WarehouseDetail() {
		
	}

	public WarehouseDetail(String wh_id, String loginID, String wh_nm, String name, String email, String phone,
			String zipCode, String wh_loc, String addr, String dtAddress) {
		
		this.wh_id = wh_id;
		this.loginID = loginID;
		this.wh_nm = wh_nm;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.zipCode = zipCode;
		this.wh_loc = wh_loc;
		this.addr = addr;
		this.dtAddress = dtAddress;
	}

	public String getWh_id() {
		return wh_id;
	}

	public void setWh_id(String wh_id) {
		this.wh_id = wh_id;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getWh_nm() {
		return wh_nm;
	}

	public void setWh_nm(String wh_nm) {
		this.wh_nm = wh_nm;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getDtAddress() {
		return dtAddress;
	}

	public void setDtAddress(String dtAddress) {
		this.dtAddress = dtAddress;
	}
	
	
	
	

	



}
