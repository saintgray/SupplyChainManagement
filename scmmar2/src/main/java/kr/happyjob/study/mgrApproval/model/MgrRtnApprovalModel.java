package kr.happyjob.study.mgrApproval.model;

import java.util.Date;

public class MgrRtnApprovalModel {

	// 반품상세 주문번호
	private int crtrtio;
	
	// 사용자ID
	private String loginID;
	
	// 반품고객명
	private String name;
	
	// 제품명
	private String pdnm;
	
	// 수량=반품건수
	private int crtncnt;
	
	// 금액
	private int crtnprice;
	
	// 구매일자
	private Date oddtdate;
	
	// 반품신청날짜
	private Date rtnregdate;
	
	// 관리자승인여부
	private String scryn;
	
	// 임원승인 여부
	private String mgryn;

	
	public int getCrtrtio() {
		return crtrtio;
	}

	public void setCrtrtio(int crtrtio) {
		this.crtrtio = crtrtio;
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

	public String getPdnm() {
		return pdnm;
	}

	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}

	public int getCrtncnt() {
		return crtncnt;
	}

	public void setCrtncnt(int crtncnt) {
		this.crtncnt = crtncnt;
	}

	public int getCrtnprice() {
		return crtnprice;
	}

	public void setCrtnprice(int crtnprice) {
		this.crtnprice = crtnprice;
	}

	public Date getOddtdate() {
		return oddtdate;
	}

	public void setOddtdate(Date oddtdate) {
		this.oddtdate = oddtdate;
	}

	public Date getRtnregdate() {
		return rtnregdate;
	}

	public void setRtnregdate(Date rtnregdate) {
		this.rtnregdate = rtnregdate;
	}

	public String getScryn() {
		return scryn;
	}

	public void setScryn(String scryn) {
		this.scryn = scryn;
	}

	public String getMgryn() {
		return mgryn;
	}

	public void setMgryn(String mgryn) {
		this.mgryn = mgryn;
	}

	

}
