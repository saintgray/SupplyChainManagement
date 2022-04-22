package kr.happyjob.study.entity;

public class OrderInfo {
	
	
	protected String orderId;
	protected String wantedDate;
	protected String returnYN;
	
	protected Purchase purchase;
	protected Sale sales;
	protected Comp comp;
	
	public OrderInfo() {
		
	}

	public OrderInfo(String orderId, String wantedDate, String returnYN, Purchase purchase, Sale sales, Comp comp) {
		
		this.orderId = orderId;
		this.wantedDate = wantedDate;
		this.returnYN = returnYN;
		this.purchase = purchase;
		this.sales = sales;
		this.comp = comp;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getWantedDate() {
		return wantedDate;
	}

	public void setWantedDate(String wantedDate) {
		this.wantedDate = wantedDate;
	}

	public String getReturnYN() {
		return returnYN;
	}

	public void setReturnYN(String returnYN) {
		this.returnYN = returnYN;
	}

	public Purchase getPurchase() {
		return purchase;
	}

	public void setPurchase(Purchase purchase) {
		this.purchase = purchase;
	}

	public Sale getSales() {
		return sales;
	}

	public void setSales(Sale sales) {
		this.sales = sales;
	}

	public Comp getComp() {
		return comp;
	}

	public void setComp(Comp comp) {
		this.comp = comp;
	}
	
	
	
	
	

}
