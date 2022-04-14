package kr.happyjob.study.epc.model;

public class OrderListItemDTO {

	String loginID;
	String sales_type;
	String model_nm;
	String mfcomp;
	String purdate;
	String wanted_date;
	String deliverStatus;
	String returnYN;
	int price;
	int pur_cnt;
	int pur_id;
	int total;
	int purinf_id;
	int sales_id;
	int return_cnt;
	
	
	
	public String getLoginID() {
		return loginID;
	}
	public int getPur_id() {
		return pur_id;
	}
	public String getSales_type() {
		return sales_type;
	}
	public String getModel_nm() {
		return model_nm;
	}
	public String getMfcomp() {
		return mfcomp;
	}
	public int getPrice() {
		return price;
	}
	public int getPur_cnt() {
		return pur_cnt;
	}
	public String getPurdate() {
		return purdate;
	}
	public String getWanted_date() {
		return wanted_date;
	}
	public int getTotal() {
		return total;
	}
	public int getPurinf_id() {
		return purinf_id;
	}
	public int getSales_id() {
		return sales_id;
	}
	public String getReturnYN() {
		return returnYN;
	}
	
	public int getReturn_cnt() {
		return return_cnt;
	}
	public void setReturn_cnt(int return_cnt) {
		this.return_cnt = return_cnt;
	}
	public void setReturnYN(String returnYN) {
		this.returnYN = returnYN;
	}
	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
	}
	public String getDeliverStatus() {
		return deliverStatus;
	}
	public void setDeliverStatus(String deliverStatus) {
		this.deliverStatus = deliverStatus;
	}
	public void setPurinf_id(int purinf_id) {
		this.purinf_id = purinf_id;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public void setWanted_date(String wanted_date) {
		this.wanted_date = wanted_date;
	}
	public void setPurdate(String purdate) {
		this.purdate = purdate;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public void setPur_id(int pur_id) {
		this.pur_id = pur_id;
	}
	public void setSales_type(String sales_type) {
		this.sales_type = sales_type;
	}
	public void setModel_nm(String model_nm) {
		this.model_nm = model_nm;
	}
	public void setMfcomp(String mfcomp) {
		this.mfcomp = mfcomp;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public void setPur_cnt(int pur_cnt) {
		this.pur_cnt = pur_cnt;
	}
	
	
	
}
