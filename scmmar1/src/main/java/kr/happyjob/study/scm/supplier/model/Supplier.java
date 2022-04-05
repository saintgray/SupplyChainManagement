package kr.happyjob.study.scm.supplier.model;

public class Supplier {
	
	private String comp_nm;
	private String userid;
	private String password;
	private String name;
	private String phone;
	
	public Supplier() {

	}

	public Supplier(String comp_nm, String userid, String password, String name, String phone) {

		this.comp_nm = comp_nm;
		this.userid = userid;
		this.password = password;
		this.name = name;
		this.phone = phone;
	}

	public String getComp_nm() {
		return comp_nm;
	}

	public void setComp_nm(String comp_nm) {
		this.comp_nm = comp_nm;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
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
