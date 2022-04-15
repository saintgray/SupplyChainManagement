package kr.happyjob.study.mgrSell.model;

import java.util.Date;

public class MgrSellStatusDtModel {
	
	// 수주일련번호
	private String orderno;
	
	// 수주상세 주문번호
	private int oddtno;
	
	// 고객ID
	private String userID;
	
	// 고객명
	private String name;
	
	// 주문일자
	private Date oddtdate;
	
	// 주문개수
	private int oddtcnt;
	
	// 제품별 판매단가
	private int pdmdprice;
	
	// 주문번호 별 주문 금액
	private int oddtsell;
	
	// 제품명
	private String pdnm;
	
	// 입금 완료 여부
	private String orderpayyn;

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public int getOddtno() {
		return oddtno;
	}

	public void setOddtno(int oddtno) {
		this.oddtno = oddtno;
	}

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

	public int getOddtsell() {
		return oddtsell;
	}

	public void setOddtsell(int oddtsell) {
		this.oddtsell = oddtsell;
	}

	public int getPdmdprice() {
		return pdmdprice;
	}

	public void setPdmdprice(int pdmdprice) {
		this.pdmdprice = pdmdprice;
	}

	public String getPdnm() {
		return pdnm;
	}

	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}

	public String getOrderpayyn() {
		return orderpayyn;
	}

	public void setOrderpayyn(String orderpayyn) {
		this.orderpayyn = orderpayyn;
	}
	
	
	
}
