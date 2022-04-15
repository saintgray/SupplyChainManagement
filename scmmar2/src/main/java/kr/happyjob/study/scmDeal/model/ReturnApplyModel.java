package kr.happyjob.study.scmDeal.model;

public class ReturnApplyModel {

	//반품 제품명
	private String pdnm;
	//반품 신청날짜
	private String rtnregdate;
	//반품수량
	private int rtncnt;
	//반품금액
	private int rtnamount;
	//관리자승인여부
	private String scryn;
	//창고명
	private String whnm;
	//반품 번호
	private int rtnno;
	
	private int crtncnt;
	
	private int crtnprice;

	private int pdcode;
	
	private String pdmdno;
	
	private String pdno;
	
	//일련번호
	private String rtnio;
	
	//주문번호
	private int crtrtio;
	
	
	
	
	
	public int getPdcode() {
		return pdcode;
	}
	public void setPdcode(int pdcode) {
		this.pdcode = pdcode;
	}
	public String getPdmdno() {
		return pdmdno;
	}
	public void setPdmdno(String pdmdno) {
		this.pdmdno = pdmdno;
	}
	public String getRtnio() {
		return rtnio;
	}
	public void setRtnio(String rtnio) {
		this.rtnio = rtnio;
	}
	public int getCrtrtio() {
		return crtrtio;
	}
	public void setCrtrtio(int crtrtio) {
		this.crtrtio = crtrtio;
	}
	public String getPdno() {
		return pdno;
	}
	public void setPdno(String pdno) {
		this.pdno = pdno;
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
	public int getRtnno() {
		return rtnno;
	}
	public void setRtnno(int rtnno) {
		this.rtnno = rtnno;
	}
	public String getPdnm() {
		return pdnm;
	}
	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}
	public String getRtnregdate() {
		return rtnregdate;
	}
	public void setRtnregdate(String rtnregdate) {
		this.rtnregdate = rtnregdate;
	}
	public int getRtncnt() {
		return rtncnt;
	}
	public void setRtncnt(int rtncnt) {
		this.rtncnt = rtncnt;
	}
	public int getRtnamount() {
		return rtnamount;
	}
	public void setRtnamount(int rtnamount) {
		this.rtnamount = rtnamount;
	}
	public String getScryn() {
		return scryn;
	}
	public void setScryn(String scryn) {
		this.scryn = scryn;
	}
	public String getWhnm() {
		return whnm;
	}
	public void setWhnm(String whnm) {
		this.whnm = whnm;
	}
	
	
	
	
}
