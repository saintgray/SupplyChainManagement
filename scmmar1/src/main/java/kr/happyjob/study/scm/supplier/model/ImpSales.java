package kr.happyjob.study.scm.supplier.model;

public class ImpSales {
	
	private int unitprice;
	private String sales_nm;
	private String sales_id;
	
	
	public ImpSales() {
	
	}


	public ImpSales(int unitprice, String sales_nm, String sales_id) {
	
		this.unitprice = unitprice;
		this.sales_nm = sales_nm;
		this.sales_id = sales_id;
	}


	public int getUnitprice() {
		return unitprice;
	}


	public void setUnitprice(int unitprice) {
		this.unitprice = unitprice;
	}


	public String getSales_nm() {
		return sales_nm;
	}


	public void setSales_nm(String sales_nm) {
		this.sales_nm = sales_nm;
	}


	public String getSales_id() {
		return sales_id;
	}


	public void setSales_id(String sales_id) {
		this.sales_id = sales_id;
	}
	
	
	
	
	

}
