package kr.happyjob.study.scm.model;

public class WorkOrderModel {
	
	private int pur_id;
	private String purdate;
	private String name;
	private String sales_nm;
	private int price_sum;
	private int price;
	private int pur_cnt;
	private int price_cnt;
	private String returnYN;
	private String wanted_date;
	private String depositYN;
	private int sales_id;
	private String loginID;
	
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getPur_id() {
		return pur_id;
	}
	public void setPur_id(int pur_id) {
		this.pur_id = pur_id;
	}
	public String getPurdate() {
		return purdate;
	}
	public void setPurdate(String purdate) {
		this.purdate = purdate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSales_nm() {
		return sales_nm;
	}
	public void setSales_nm(String sales_nm) {
		this.sales_nm = sales_nm;
	}
	public int getPrice_sum() {
		return price_sum;
	}
	public void setPrice_sum(int price_sum) {
		this.price_sum = price_sum;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getPur_cnt() {
		return pur_cnt;
	}
	public void setPur_cnt(int pur_cnt) {
		this.pur_cnt = pur_cnt;
	}
	public int getPrice_cnt() {
		return price_cnt;
	}
	public void setPrice_cnt(int price_cnt) {
		this.price_cnt = price_cnt;
	}
	public String getReturnYN() {
		return returnYN;
	}
	public void setReturnYN(String returnYN) {
		this.returnYN = returnYN;
	}
	public String getWanted_date() {
		return wanted_date;
	}
	public void setWanted_date(String wanted_date) {
		this.wanted_date = wanted_date;
	}
	public String getDepositYN() {
		return depositYN;
	}
	public void setDepositYN(String depositYN) {
		this.depositYN = depositYN;
	}
	public int getSales_id() {
		return sales_id;
	}
	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
	}
	
	
	
	
	
}
