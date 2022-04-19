package kr.happyjob.study.epc.model;

public class ShoppingCartItemDTO {

	int pur_id;
	int purinf_id;
	int sales_id;
	String photo;
	String model_nm;
	int price;
	int pur_cnt;
	String wanted_date;
	String loginID;
	
	String purcYN;
	String type;
	
	
	public int getPur_id() {
		return pur_id;
	}


	public void setPur_id(int pur_id) {
		this.pur_id = pur_id;
	}

	

	
	public int getPurinf_id() {
		return purinf_id;
	}


	public void setPurinf_id(int purinf_id) {
		this.purinf_id = purinf_id;
	}


	public int getSales_id() {
		return sales_id;
	}


	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
	}


	public String getPhoto() {
		return photo;
	}


	public void setPhoto(String photo) {
		this.photo = photo;
	}


	public String getModel_nm() {
		return model_nm;
	}


	public void setModel_nm(String model_nm) {
		this.model_nm = model_nm;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public int getPur_cnt() {
		return pur_cnt;
	}


	public void setPur_cnt(int pur_cnt) {
		this.pur_cnt = pur_cnt;
	}


	public String getWanted_date() {
		return wanted_date;
	}


	public void setWanted_date(String wanted_date) {
		this.wanted_date = wanted_date;
	}


	public String getLoginID() {
		return loginID;
	}


	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}



	public String getPurcYN() {
		return purcYN;
	}


	public void setPurcYN(String purcYN) {
		this.purcYN = purcYN;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	@Override
	public String toString() {
		return "ShoppingCartItemDTO [pur_id=" + pur_id + ", sales_id=" + sales_id + ", photo=" + photo + ", model_nm="
				+ model_nm + ", price=" + price + ", pur_cnt=" + pur_cnt + ", wanted_date=" + wanted_date + ", loginID="
				+ loginID + ", purcYN=" + purcYN + ", type=" + type + "]";
	}

	
	
	
}
