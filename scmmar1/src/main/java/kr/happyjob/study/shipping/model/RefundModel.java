package kr.happyjob.study.shipping.model;

import java.util.Date;

public class RefundModel {

	private String return_id;
	private String client;
	private String sales_nm;
	private String sales_id;
	private int return_cnt;
	private Date regdate;
	private Date editdate;
	private String wh_nm;
	private int wh_id;
	private String rfinfo_id;
	private String dtAddress;
	private String address;
	private String deliverStatus;
	private String deliv_id;
	
	
	public String getDeliv_id() {
		return deliv_id;
	}
	public void setDeliv_id(String deliv_id) {
		this.deliv_id = deliv_id;
	}
	public String getSales_id() {
		return sales_id;
	}
	public void setSales_id(String sales_id) {
		this.sales_id = sales_id;
	}
	public String getDeliverStatus() {
		return deliverStatus;
	}
	public void setDeliverStatus(String deliverStatus) {
		this.deliverStatus = deliverStatus;
	}
	public String getDtAddress() {
		return dtAddress;
	}
	public void setDtAddress(String dtAddress) {
		this.dtAddress = dtAddress;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRfinfo_id() {
		return rfinfo_id;
	}
	public void setRfinfo_id(String rfinfo_id) {
		this.rfinfo_id = rfinfo_id;
	}
	public String getReturn_id() {
		return return_id;
	}
	public void setReturn_id(String return_id) {
		this.return_id = return_id;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getSales_nm() {
		return sales_nm;
	}
	public void setSales_nm(String sales_nm) {
		this.sales_nm = sales_nm;
	}
	public int getReturn_cnt() {
		return return_cnt;
	}
	public void setReturn_cnt(int return_cnt) {
		this.return_cnt = return_cnt;
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
	public String getWh_nm() {
		return wh_nm;
	}
	public void setWh_nm(String wh_nm) {
		this.wh_nm = wh_nm;
	}
	public int getWh_id() {
		return wh_id;
	}
	public void setWh_id(int wh_id) {
		this.wh_id = wh_id;
	}
	
	
	
	
}
