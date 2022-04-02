package com.nexacro.sample.vo;

public class StatisticsVO {
	private int sales_code;
	private String goods_category;
	private String goods_name;
	private int sales_totp;
	private int last_month_sale;
	private int search_month_sale;
	private int inc_dec;
	private int orderCnt;
	private int userCnt;

	public int getStno() {
		return sales_code;
	}

	public void setStno(int stno) {
		this.sales_code = stno;
	}

	public String getGoods_category() {
		return goods_category;
	}

	public void setGoods_category(String goods_category) {
		this.goods_category = goods_category;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public int getSales_totp() {
		return sales_totp;
	}

	public void setSales_totp(int sales_totp) {
		this.sales_totp = sales_totp;
	}

	public int getLast_month_sale() {
		return last_month_sale;
	}

	public void setLast_month_sale(int last_month_sale) {
		this.last_month_sale = last_month_sale;
	}

	public int getSearch_month_sale() {
		return search_month_sale;
	}

	public void setSearch_month_sale(int search_month_sale) {
		this.search_month_sale = search_month_sale;
	}

	public int getInc_dec() {
		return inc_dec;
	}

	public void setInc_dec(int inc_dec) {
		this.inc_dec = inc_dec;
	}

	public int getOrderCnt() {
		return orderCnt;
	}

	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}

	public int getUserCnt() {
		return userCnt;
	}

	public void setUserCnt(int userCnt) {
		this.userCnt = userCnt;
	}
}
