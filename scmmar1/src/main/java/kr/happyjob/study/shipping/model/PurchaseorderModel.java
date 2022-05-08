package kr.happyjob.study.shipping.model;

import java.util.Date;

public class PurchaseorderModel {

	private String orderid;
	private Date regdate;
	private Date editdate;
	private String sales_nm;
	private String name;
	private int price;
	private int order_cnt;
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getEditdate() {
		return editdate;
	}
	public void setEditdate(Date editdate) {
		this.editdate = editdate;
	}
	public String getSales_nm() {
		return sales_nm;
	}
	public void setSales_nm(String sales_nm) {
		this.sales_nm = sales_nm;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(int order_cnt) {
		this.order_cnt = order_cnt;
	}
	
	
}
