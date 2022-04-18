package kr.happyjob.study.scm.orders.model;

public class DailyOrderHistoryModel {
       
	private int pur_id;
	private String purdate;
	private String name;
	// private String sales_nm;
	// private int stock_sum;
	// private int price;
	
	// private int pur_cnt;
	private int pur_cnt_total;
	
	
	
	// private int price_cnt;
	private int total_price;
	private String returnYN;
	// private String wanted_date;
	private String depositYN;
	// private int sales_id;
	// private String loginID;
	// private int deliv_id;
	// private String client;
	
	public DailyOrderHistoryModel() {
		
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

	public int getPur_cnt_total() {
		return pur_cnt_total;
	}

	public void setPur_cnt_total(int pur_cnt_total) {
		this.pur_cnt_total = pur_cnt_total;
	}

	public int getTotal_price() {
		return total_price;
	}

	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}

	public String getDepositYN() {
		return depositYN;
	}

	public void setDepositYN(String depositYN) {
		this.depositYN = depositYN;
	}

	public String getReturnYN() {
		return returnYN;
	}

	public void setReturnYN(String returnYN) {
		this.returnYN = returnYN;
	}
	
	
	
	
	
	
	
	
	
	
	
}
