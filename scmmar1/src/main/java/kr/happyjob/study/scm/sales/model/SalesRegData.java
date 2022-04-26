package kr.happyjob.study.scm.sales.model;

public class SalesRegData {
	
	private String model_code;
	private String model_nm;
	private String sales_type;
	private String sales_id;
	private String sales_nm;
	private String mfcomp;
	private String price;
	private String info;
	
	public SalesRegData() {
		
	}

	public SalesRegData(String model_code, String model_nm, String sales_type, String sales_id, String sales_nm,
			String mfcomp, String price, String info) {
		
		this.model_code = model_code;
		this.model_nm = model_nm;
		this.sales_type = sales_type;
		this.sales_id = sales_id;
		this.sales_nm = sales_nm;
		this.mfcomp = mfcomp;
		this.price = price;
		this.info = info;
	}

	public String getModel_code() {
		return model_code;
	}

	public void setModel_code(String model_code) {
		this.model_code = model_code;
	}

	public String getModel_nm() {
		return model_nm;
	}

	public void setModel_nm(String model_nm) {
		this.model_nm = model_nm;
	}

	public String getSales_type() {
		return sales_type;
	}

	public void setSales_type(String sales_type) {
		this.sales_type = sales_type;
	}

	public String getSales_id() {
		return sales_id;
	}

	public void setSales_id(String sales_id) {
		this.sales_id = sales_id;
	}

	public String getSales_nm() {
		return sales_nm;
	}

	public void setSales_nm(String sales_nm) {
		this.sales_nm = sales_nm;
	}

	public String getMfcomp() {
		return mfcomp;
	}

	public void setMfcomp(String mfcomp) {
		this.mfcomp = mfcomp;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	
	
	
	
	
	
	


	

}
