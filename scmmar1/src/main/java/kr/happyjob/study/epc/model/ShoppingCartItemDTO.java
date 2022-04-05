package kr.happyjob.study.epc.model;

public class ShoppingCartItemDTO {

	int sales_id;
	String photo;
	String model_nm;
	int price;
	int pur_cnt;
	String wanteddate;
	String loginID;
	String purcYN;
	public int getSales_id() {
		return sales_id;
	}
	public String getPhoto() {
		return photo;
	}
	public String getModel_nm() {
		return model_nm;
	}
	public int getPrice() {
		return price;
	}
	public int getPur_cnt() {
		return pur_cnt;
	}
	public String getWanteddate() {
		return wanteddate;
	}
	public String getLoginID() {
		return loginID;
	}
	public String getPurcYN() {
		return purcYN;
	}
	
	
	
	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public void setModel_nm(String model_nm) {
		this.model_nm = model_nm;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public void setPur_cnt(int pur_cnt) {
		this.pur_cnt = pur_cnt;
	}
	public void setWanteddate(String wanteddate) {
		this.wanteddate = wanteddate;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public void setPurcYN(String purcYN) {
		this.purcYN = purcYN;
	}

	
}
