package kr.happyjob.study.pcm.model;

import java.util.Date;

public class PcmOrderListModel {
	private int orderid;
	private String comp_nm;			//발주회사
	private String sales_nm;		//상품이름
	private int order_cnt;			//발주갯수
	private Date regdate;			//등록일
	private String confirmYN;		//승인여부
	private String depositYN;		//승인여부
	
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public String getComp_nm() {
		return comp_nm;
	}
	public void setComp_nm(String comp_nm) {
		this.comp_nm = comp_nm;
	}
	public String getSales_nm() {
		return sales_nm;
	}
	public void setSales_nm(String sales_nm) {
		this.sales_nm = sales_nm;
	}
	public int getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(int order_cnt) {
		this.order_cnt = order_cnt;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getConfirmYN() {
		return confirmYN;
	}
	public void setConfirmYN(String confirmYN) {
		this.confirmYN = confirmYN;
	}
	public String getDepositYN() {
		return depositYN;
	}
	public void setDepositYN(String depositYN) {
		this.depositYN = depositYN;
	}
	@Override
	public String toString() {
		return "PcmOrderListModel [orderid=" + orderid + ", comp_nm=" + comp_nm + ", sales_nm=" + sales_nm
				+ ", order_cnt=" + order_cnt + ", regdate=" + regdate + ", confirmYN=" + confirmYN + ", depositYN="
				+ depositYN + "]";
	}
}
