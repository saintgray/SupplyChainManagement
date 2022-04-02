package kr.happyjob.study.scm.user.model;

public class UserRegData {
	
	private String loginID;
	private String password;
	private String user_Type;
	private String name;
	private String client;
	private String phone;
	private String zipCode;
	private String address;
	private String dtAddress;
	private String email;
	
	
	
	public UserRegData() {
		
	}

	public UserRegData(String loginID, String password, String user_Type, String name, String client, String phone,
			String zipCode, String address, String dtAddress, String email) {
		
		this.loginID = loginID;
		this.password = password;
		this.user_Type = user_Type;
		this.name = name;
		this.client = client;
		this.phone = phone;
		this.zipCode = zipCode;
		this.address = address;
		this.dtAddress = dtAddress;
		this.email = email;
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

	public String getUser_Type() {
		return user_Type;
	}

	public void setUser_Type(String user_Type) {
		this.user_Type = user_Type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	
	
	
	
	

}
