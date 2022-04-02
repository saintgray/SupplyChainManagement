package com.nexacro.sample.vo;

public class AdminPayInfoVO {
	private String goods_name;
	private String goods_price;
	private int total_product;
	private int total_Fee;
	private String loginID;

	private String sales_code;
	
	public String getGoods_name() {
		return goods_name;
	}
	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}
	public String getGoods_price() {
		return goods_price;
	}
	public void setGoods_price(String goods_price) {
		this.goods_price = goods_price;
	}
	public int getTotal_Fee() {
		return total_Fee;
	}
	public void setTotal_Fee(int total_Fee) {
		this.total_Fee = total_Fee;
	}
	public int getTotal_product() {
		return total_product;
	}
	public void setTotal_product(int total_product) {
		this.total_product = total_product;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getSales_code() {
		return sales_code;
	}
	public void setSales_code(String sales_code) {
		this.sales_code = sales_code;
	}
}
