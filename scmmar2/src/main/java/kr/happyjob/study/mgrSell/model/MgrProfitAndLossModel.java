package kr.happyjob.study.mgrSell.model;

public class MgrProfitAndLossModel {
	
	// 수주 일련번호
	private String orderno;
	
	// 사용자ID
	private String userID;
	
	// 사용자 이름
	private String name;
	
	// 주문별 총 주문금액
	private int orderamount;
	
	// 고객별 총 주문금액
	private int totalorder;
	
	// 반품주문별 총 반품금액
	private int crtnprice;
	
	// 고객별 총 반품금액
	private int totalreturn;
	
	// 고객별 총 손익
	private int totalprofit;
	
	// 주문 입금 완료 여부
	private String orderpayyn;
	
	// 반품 승인 완료 여부
	private String mgryn;
	

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

	public int getTotalorder() {
		return totalorder;
	}

	public void setTotalorder(int totalorder) {
		this.totalorder = totalorder;
	}

	public int getCrtnprice() {
		return crtnprice;
	}

	public void setCrtnprice(int crtnprice) {
		this.crtnprice = crtnprice;
	}

	public int getTotalreturn() {
		return totalreturn;
	}

	public void setTotalreturn(int totalreturn) {
		this.totalreturn = totalreturn;
	}

	public int getTotalprofit() {
		return totalprofit;
	}

	public void setTotalprofit(int totalprofit) {
		this.totalprofit = totalprofit;
	}

	public String getOrderpayyn() {
		return orderpayyn;
	}

	public void setOrderpayyn(String orderpayyn) {
		this.orderpayyn = orderpayyn;
	}

	public String getMgryn() {
		return mgryn;
	}

	public void setMgryn(String mgryn) {
		this.mgryn = mgryn;
	}
	
	
}
