package kr.happyjob.study.entity;

import java.util.List;

import org.apache.ibatis.type.Alias;
@Alias("userAlias")
public class Member {
	
	protected String loginID;
	protected String userType;
	protected String password;
	protected String name;
	protected String client;
	protected String zipCode;
	protected String address;
	protected String dtAddress;
	protected String phone;
	protected String email;
	protected String businessNo;
	protected String regID;
	protected String regDate;
	protected String upID;
	protected String upDate;
	protected String photo;
	protected String deletedYN;
	
	protected List<Purchase> purchases;
	
	public Member() {
		
	}

	
	


	public Member(String loginID, String userType, String password, String name, String client, String zipCode,
			String address, String dtAddress, String phone, String email, String businessNo, String regID,
			String regDate, String upID, String upDate, String photo, String deletedYN, List<Purchase> purchases) {
		
		this.loginID = loginID;
		this.userType = userType;
		this.password = password;
		this.name = name;
		this.client = client;
		this.zipCode = zipCode;
		this.address = address;
		this.dtAddress = dtAddress;
		this.phone = phone;
		this.email = email;
		this.businessNo = businessNo;
		this.regID = regID;
		this.regDate = regDate;
		this.upID = upID;
		this.upDate = upDate;
		this.photo = photo;
		this.deletedYN = deletedYN;
		this.purchases = purchases;
	}





	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
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

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBusinessNo() {
		return businessNo;
	}

	public void setBusinessNo(String businessNo) {
		this.businessNo = businessNo;
	}

	public String getRegID() {
		return regID;
	}

	public void setRegID(String regID) {
		this.regID = regID;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUpID() {
		return upID;
	}

	public void setUpID(String upID) {
		this.upID = upID;
	}

	public String getUpDate() {
		return upDate;
	}

	public void setUpDate(String upDate) {
		this.upDate = upDate;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getDeletedYN() {
		return deletedYN;
	}

	public void setDeletedYN(String deletedYN) {
		this.deletedYN = deletedYN;
	}



	public List<Purchase> getPurchases() {
		return purchases;
	}



	public void setPurchases(List<Purchase> purchases) {
		this.purchases = purchases;
	}
	
	
	
	

}
