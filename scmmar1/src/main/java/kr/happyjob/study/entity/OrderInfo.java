package kr.happyjob.study.entity;

import org.apache.ibatis.type.Alias;

@Alias("ordinf")
public class OrderInfo {
	
	
	protected String orderId;
	protected String wantedDate;
	protected String returnYN;
	
	protected Purchase purchase;
	protected Sale sales;
	protected Comp comp;
	
	protected RefundInfo refundInfo;
	
	public OrderInfo() {
		
	}

	

	public OrderInfo(String orderId, String wantedDate, String returnYN, Purchase purchase, Sale sales, Comp comp,
			RefundInfo refundInfo) {
	
		this.orderId = orderId;
		this.wantedDate = wantedDate;
		this.returnYN = returnYN;
		this.purchase = purchase;
		this.sales = sales;
		this.comp = comp;
		this.refundInfo = refundInfo;
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



	public RefundInfo getRefundInfo() {
		return refundInfo;
	}



	public void setRefundInfo(RefundInfo refundInfo) {
		this.refundInfo = refundInfo;
	}
	
	
	
	
	
	
	

}
