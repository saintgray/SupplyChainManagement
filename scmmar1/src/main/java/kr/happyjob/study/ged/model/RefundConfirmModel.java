package kr.happyjob.study.ged.model;

public class RefundConfirmModel {
	
	private int returnId;
	private int purCnt;
	private String salesNm;
	private String purdate;
	private String regdate;
	private int returnCnt;
	private String client;
	private int price;
	private String confirmYN;
	private String from_date;
	private String to_date;
	
	
	public int getPurCnt() {
		return purCnt;
	}
	public void setPurCnt(int purCnt) {
		this.purCnt = purCnt;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getConfirmYN() {
		return confirmYN;
	}
	public void setConfirmYN(String confirmYN) {
		this.confirmYN = confirmYN;
	}

	public int getReturnId() {
		return returnId;
	}
	public String getSalesNm() {
		return salesNm;
	}
	public void setSalesNm(String salesNm) {
		this.salesNm = salesNm;
	}
	public void setReturnId(int returnId) {
		this.returnId = returnId;
	}
	public String getPurdate() {
		return purdate;
	}
	public void setPurdate(String purdate) {
		this.purdate = purdate;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getReturnCnt() {
		return returnCnt;
	}
	public void setReturnCnt(int returnCnt) {
		this.returnCnt = returnCnt;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getFrom_date() {
		return from_date;
	}
	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}
	public String getTo_date() {
		return to_date;
	}
	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
	
	
	
}
