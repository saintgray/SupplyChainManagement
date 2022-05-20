package kr.happyjob.study.ged.model;

public class OrderConfirmModel {
	
	public String getPurdate() {
		return purdate;
	}
	public void setPurdate(String purdate) {
		this.purdate = purdate;
	}
	public int getOrderCnt() {
		return orderCnt;
	}
	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}
	public String getConfirmYN() {
		return confirmYN;
	}
	public void setConfirmYN(String confirmYN) {
		this.confirmYN = confirmYN;
	}
	public String getSalesNm() {
		return salesNm;
	}
	public void setSalesNm(String salesNm) {
		this.salesNm = salesNm;
	}
	public int getUnitprice() {
		return unitprice;
	}
	public void setUnitprice(int unitprice) {
		this.unitprice = unitprice;
	}
	public String getCompNm() {
		return compNm;
	}
	public void setCompNm(String compNm) {
		this.compNm = compNm;
	}
	public String getFrom_date() {
		return from_date;
	}
	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}
	public String getTo_date() {
		return to_date;
	}
	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
	
	
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	
	private int orderid;
	private String purdate;
	private int orderCnt;
	private String confirmYN;
	private String salesNm;
	private int unitprice;
	private String compNm;
	private String from_date;
	private String to_date;
	
	
	
}
