package kr.happyjob.study.scm.supplier.model;

public class Supplier {
	
	
	private String comp_id;
	private String comp_nm;
	private String loginID;
	private String password;
	private String name;
	private String phone;
	
	public Supplier() {

	}

	public Supplier(String comp_id, String comp_nm, String loginID, String password, String name, String phone) {
		
		this.comp_id = comp_id;
		this.comp_nm = comp_nm;
		this.loginID = loginID;
		this.password = password;
		this.name = name;
		this.phone = phone;
	}

	public String getComp_id() {
		return comp_id;
	}

	public void setComp_id(String comp_id) {
		this.comp_id = comp_id;
	}

	public String getComp_nm() {
		return comp_nm;
	}

	public void setComp_nm(String comp_nm) {
		this.comp_nm = comp_nm;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
	
	
	
	
	
	
	

}
