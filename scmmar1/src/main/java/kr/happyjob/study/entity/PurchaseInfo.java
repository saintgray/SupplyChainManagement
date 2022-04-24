package kr.happyjob.study.entity;

import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.type.Alias;

@Alias("purinfAlias")
public class PurchaseInfo {
	
	protected String purinfId;
	protected String purCnt;
	protected String wantedDate;
	protected String returnYN;
	
	// 구매 개수 * 상품가격
	protected String avg; 
	
	protected Purchase purchase;
	protected Sale sales;
	
	protected RefundInfo refundInfo;
	
	public PurchaseInfo() {
	
	}

	
	
	



	public PurchaseInfo(String purinfId, String purCnt, String wantedDate, String returnYN, Purchase purchase,
			Sale sales, RefundInfo refundInfo) {
	
		this.purinfId = purinfId;
		this.purCnt = purCnt;
		this.wantedDate = wantedDate;
		this.returnYN = returnYN;
		this.purchase = purchase;
		this.sales = sales;
		this.refundInfo = refundInfo;
	}







	public String getPurinfId() {
		return purinfId;
	}

	public void setPurinfId(String purinfId) {
		this.purinfId = purinfId;
	}

	public String getPurCnt() {
		return purCnt;
	}

	public void setPurCnt(String purCnt) {
		this.purCnt = purCnt;
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
	
	

	public String getAvg() {
		return avg;
	}
	
	public void setAvg(String avg) {
		this.avg = avg;
	}







	public Sale getSales() {
		return sales;
	}

	public void setSales(Sale sales) {
		this.sales = sales;
	}







	public RefundInfo getRefundInfo() {
		return refundInfo;
	}







	public void setRefundInfo(RefundInfo refundInfo) {
		this.refundInfo = refundInfo;
	}
	
	
	
	
	
	
	

}
