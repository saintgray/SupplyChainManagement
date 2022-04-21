package kr.happyjob.study.scm.orders.model;

public class DirModel {
	
	private String purinf_id;
	private String orderid;
	private String return_id;
	private String deliv_wh_id;
	
	
	public DirModel() {
	
	}


	public DirModel(String purinf_id, String orderid, String return_id, String deliv_wh_id) {
	
		this.purinf_id = purinf_id;
		this.orderid = orderid;
		this.return_id = return_id;
		this.deliv_wh_id = deliv_wh_id;
	}
	
	
	public static DirModel standard(){
		return new DirModel();
	}
	
	public DirModel withPurInf_id(String purinf_id){
		this.purinf_id=purinf_id;
		return this;
	}
	
	public DirModel withOrderid(String orderid){
		this.orderid=orderid;
		return this;
	}
	
	public DirModel withReturn_id(String return_id){
		this.return_id=return_id;
		return this;
	}
	
	public DirModel withDeliv_wh_id(String deliv_wh_id){
		this.deliv_wh_id=deliv_wh_id;
		return this;
	}
	
	public DirModel build(){
		return this;
	}


	public String getPurinf_id() {
		return purinf_id;
	}


	public void setPurinf_id(String purinf_id) {
		this.purinf_id = purinf_id;
	}


	public String getOrderid() {
		return orderid;
	}


	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}


	public String getReturn_id() {
		return return_id;
	}


	public void setReturn_id(String return_id) {
		this.return_id = return_id;
	}


	public String getDeliv_wh_id() {
		return deliv_wh_id;
	}


	public void setDeliv_wh_id(String deliv_wh_id) {
		this.deliv_wh_id = deliv_wh_id;
	}
	
	
	
	
	
	
	
	

}
