package kr.happyjob.study.shipping.model;

import java.util.Date;

public class ShippingModel {
	
	private int deliv_id;		//배송지시서일련번호 PK
	private String sales_nm;	//상품명
	private int pur_cnt;		//수량(구매갯수) 
	private String name;		//담당자명
	private String deliverStatus;	//지시서결과 ( U:배송준비, O:배송시작, E:배송완료)
	private Date regdate;		//등록일
	private Date deldate;		//삭제일
	private Date editdate;		//수정일
	
	private String deliv_type;	//배송타입 (?)
	
	private int purinf_id;		//구매상세고유번호 FK
	private int orderid;		//발주지시서고유번호 FK
	private int return_id;		//반품지시서일련번호 FK

	private String address;		//주소1
	private String dtAddress;	//주소2
	private String wh_nm;		//창고명
	private String loginID;		//로그인아이디
	private int deliv_wh_id;	//창고코드
	private int sales_id;		//상품번호
	private String wh_id_ship;	//shipping 전용 창고 코드
	
	
	
	
	public int getDeliv_id() {
		return deliv_id;
	}

	public String getWh_id_ship() {
		return wh_id_ship;
	}

	public void setWh_id_ship(String wh_id_ship) {
		this.wh_id_ship = wh_id_ship;
	}

	public void setDeliv_id(int deliv_id) {
		this.deliv_id = deliv_id;
	}

	public String getSales_nm() {
		return sales_nm;
	}

	public void setSales_nm(String sales_nm) {
		this.sales_nm = sales_nm;
	}

	public int getPur_cnt() {
		return pur_cnt;
	}

	public void setPur_cnt(int pur_cnt) {
		this.pur_cnt = pur_cnt;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	

	public String getDeliverStatus() {
		return deliverStatus;
	}

	public void setDeliverStatus(String deliverStatus) {
		this.deliverStatus = deliverStatus;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getDeldate() {
		return deldate;
	}

	public void setDeldate(Date deldate) {
		this.deldate = deldate;
	}

	public Date getEditdate() {
		return editdate;
	}

	public void setEditdate(Date editdate) {
		this.editdate = editdate;
	}

	public String getDeliv_type() {
		return deliv_type;
	}

	public void setDeliv_type(String deliv_type) {
		this.deliv_type = deliv_type;
	}

	public int getPurinf_id() {
		return purinf_id;
	}

	public void setPurinf_id(int purinf_id) {
		this.purinf_id = purinf_id;
	}

	public int getOrderid() {
		return orderid;
	}

	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}

	public int getReturn_id() {
		return return_id;
	}

	public void setReturn_id(int return_id) {
		this.return_id = return_id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDtAddress() {
		return dtAddress;
	}

	public void setDtAddress(String dtAddress) {
		this.dtAddress = dtAddress;
	}

	public String getWh_nm() {
		return wh_nm;
	}

	public void setWh_nm(String wh_nm) {
		this.wh_nm = wh_nm;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public int getDeliv_wh_id() {
		return deliv_wh_id;
	}

	public void setDeliv_wh_id(int deliv_wh_id) {
		this.deliv_wh_id = deliv_wh_id;
	}

	public int getSales_id() {
		return sales_id;
	}

	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
	}
	
	
	
	
}
