package kr.happyjob.study.mgrSell.model;

public class MgrSellStatusModel {
	
	// 수주일련번호
	private String orderno;

	// 고객ID
	private String userID;
	
	// 고객명
	private String name;
	
	// 일련번호 별 총 주문금액
	private int orderamount;
	
	// 제품명
	private String pdnm;
	
	// 입금 완료 여부
	private String orderpayyn;
	
	// 사용자별 매출 금액
	private int usersell;

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
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

	public int getOrderamount() {
		return orderamount;
	}

	public void setOrderamount(int orderamount) {
		this.orderamount = orderamount;
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

	public int getUsersell() {
		return usersell;
	}

	public void setUsersell(int usersell) {
		this.usersell = usersell;
	}
	
	
}
