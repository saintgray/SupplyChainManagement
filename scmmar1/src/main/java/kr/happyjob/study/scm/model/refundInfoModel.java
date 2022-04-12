package kr.happyjob.study.scm.model;

public class refundInfoModel {
	
	private String sales_nm;
	private String wanted_date;
	private int return_cnt;
	private int avg;
	private int return_id;
	private int purinf_id;
	private String confirm_requestYN;
	
	public String getConfirm_requestYN() {
		return confirm_requestYN;
	}
	public void setConfirm_requestYN(String confirm_requestYN) {
		this.confirm_requestYN = confirm_requestYN;
	}
	public int getPurinf_id() {
		return purinf_id;
	}
	public void setPurinf_id(int purinf_id) {
		this.purinf_id = purinf_id;
	}
	public int getReturn_id() {
		return return_id;
	}
	public void setReturn_id(int return_id) {
		this.return_id = return_id;
	}
	public String getSales_nm() {
		return sales_nm;
	}
	public void setSales_nm(String sales_nm) {
		this.sales_nm = sales_nm;
	}
	public String getWanted_date() {
		return wanted_date;
	}
	public void setWanted_date(String wanted_date) {
		this.wanted_date = wanted_date;
	}
	public int getReturn_cnt() {
		return return_cnt;
	}
	public void setReturn_cnt(int return_cnt) {
		this.return_cnt = return_cnt;
	}
	public int getAvg() {
		return avg;
	}
	public void setAvg(int avg) {
		this.avg = avg;
	}
	
	
	
	
	
	
	
	
	
}
