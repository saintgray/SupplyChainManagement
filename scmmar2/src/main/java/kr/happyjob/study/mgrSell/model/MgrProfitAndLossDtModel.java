package kr.happyjob.study.mgrSell.model;

import java.util.Date;

public class MgrProfitAndLossDtModel {
	
	// 사용자(고객) 아이디
	private String userID;
	
	// 사용자(고객) 이름
	private String name;
	
	// 주문번호
	private String oddtno;
	
	// 반품주문번호
	private String crtrtio;
	
	// 주문일자
	private Date oddtdate;
	
	// 주문 개수
	private int oddtcnt;
	
	// 제품단가
	private int pdmdprice;
	
	// 제품별 주문금액
	private int oddtsell;
	
	// 제품명
	private String pdnm;
	
	// 제품별 반품금액
	private int crtndtsell;

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOddtno() {
		return oddtno;
	}

	public void setOddtno(String oddtno) {
		this.oddtno = oddtno;
	}

	public String getCrtrtio() {
		return crtrtio;
	}

	public void setCrtrtio(String crtrtio) {
		this.crtrtio = crtrtio;
	}

	public Date getOddtdate() {
		return oddtdate;
	}

	public void setOddtdate(Date oddtdate) {
		this.oddtdate = oddtdate;
	}

	public int getOddtcnt() {
		return oddtcnt;
	}

	public void setOddtcnt(int oddtcnt) {
		this.oddtcnt = oddtcnt;
	}

	public int getPdmdprice() {
		return pdmdprice;
	}

	public void setPdmdprice(int pdmdprice) {
		this.pdmdprice = pdmdprice;
	}

	public int getOddtsell() {
		return oddtsell;
	}

	public void setOddtsell(int oddtsell) {
		this.oddtsell = oddtsell;
	}

	public String getPdnm() {
		return pdnm;
	}

	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}

	public int getCrtndtsell() {
		return crtndtsell;
	}

	public void setCrtndtsell(int crtndtsell) {
		this.crtndtsell = crtndtsell;
	}

	
	
}
