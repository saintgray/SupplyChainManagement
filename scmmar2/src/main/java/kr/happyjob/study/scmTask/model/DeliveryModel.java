package kr.happyjob.study.scmTask.model;

import java.sql.Date;

public class DeliveryModel {
	
	// 주문번호
	private int orderSeq;
	
	// 주문일자
	private Date orderDate;
	
	// 고객기업명
	private String client;
	
	// 주문개수
	private int orderCnt;
	
	// 상세
	// 제품명
	private String product;
	
	// 배송담당자
	private String name;
	
	// 입금여부
	private String payyn;
	
	public int getOrderSeq() {
		return orderSeq;
	}

	public void setOrderSeq(int orderSeq) {
		this.orderSeq = orderSeq;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public int getOrderCnt() {
		return orderCnt;
	}

	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPayyn() {
		return payyn;
	}

	public void setPayyn(String payyn) {
		this.payyn = payyn;
	}
}
