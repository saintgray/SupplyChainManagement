package kr.happyjob.study.entity;

import org.apache.ibatis.type.Alias;

@Alias("purinfAlias")
public class PurchaseInfo {
	
	protected String purinfId;
	protected String purCnt;
	protected String wantedDate;
	protected String returnYN;
	
	protected Purchase purchase;
	protected Sale sales;
	
	public PurchaseInfo() {
	
	}

	
	
	public PurchaseInfo(String purinfId, String purCnt, String wantedDate, String returnYN, Purchase purchase,
			Sale sales) {
		
		this.purinfId = purinfId;
		this.purCnt = purCnt;
		this.wantedDate = wantedDate;
		this.returnYN = returnYN;
		this.purchase = purchase;
		this.sales = sales;
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

	public Sale getSales() {
		return sales;
	}

	public void setSales(Sale sales) {
		this.sales = sales;
	}
	
	
	
	
	

}
