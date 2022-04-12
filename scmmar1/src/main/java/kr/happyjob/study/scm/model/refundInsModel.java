package kr.happyjob.study.scm.model;

public class refundInsModel {
		
	private String regdate;
	private String sales_nm;
	private int return_cnt;
	private int avg;
	private String confirmYN;
	private String client;
	private String confirm_requestYN;
	
	public String getConfirm_requestYN() {
		return confirm_requestYN;
	}
	public void setConfirm_requestYN(String confirm_requestYN) {
		this.confirm_requestYN = confirm_requestYN;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
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
	public int getAvg() {
		return avg;
	}
	public void setAvg(int avg) {
		this.avg = avg;
	}
	public String getConfirmYN() {
		return confirmYN;
	}
	public void setConfirmYN(String confirmYN) {
		this.confirmYN = confirmYN;
	}
	
	
	
	
	
	
	
}
