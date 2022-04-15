package kr.happyjob.study.scmTask.model;

public class ImpOrderModel {

	/*일련번호*/
	private String impno;
	/*사용자id*/
	private String userid;
	/*주문일자*/
	private String impregdate;
	/*주문개수*/
	private int impcnt;
	/*입금여부*/
	private String imppayyn;
	/*총금액*/
	private int  impamount;
	/*발주단가*/
	private int impprice;
	/*입고일자*/
	private String impdate;
	/*임원승인여부*/
	private String impmgryn;
	/*납품회사고유번호*/
	private int comp_id;
	/*제품번호*/
	private int pdno;
	/*제품이름*/
	private String pdnm;
	/*회사명(납품회사/기업)*/
	private String client;
	
	private String impdtdate;
	
	private int impdtcnt;
	
	
	
	
	public int getImpdtcnt() {
		return impdtcnt;
	}
	public void setImpdtcnt(int impdtcnt) {
		this.impdtcnt = impdtcnt;
	}
	public String getImpdtdate() {
		return impdtdate;
	}
	public void setImpdtdate(String impdtdate) {
		this.impdtdate = impdtdate;
	}
	public int getPdno() {
		return pdno;
	}
	public void setPdno(int pdno) {
		this.pdno = pdno;
	}
	public String getPdnm() {
		return pdnm;
	}
	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getImpno() {
		return impno;
	}
	public void setImpno(String impno) {
		this.impno = impno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getImpregdate() {
		return impregdate;
	}
	public void setImpregdate(String impregdate) {
		this.impregdate = impregdate;
	}
	public int getImpcnt() {
		return impcnt;
	}
	public void setImpcnt(int impcnt) {
		this.impcnt = impcnt;
	}
	public String getImppayyn() {
		return imppayyn;
	}
	public void setImppayyn(String imppayyn) {
		this.imppayyn = imppayyn;
	}
	public int getImpamount() {
		return impamount;
	}
	public void setImpamount(int impamount) {
		this.impamount = impamount;
	}
	public int getImpprice() {
		return impprice;
	}
	public void setImpprice(int impprice) {
		this.impprice = impprice;
	}
	public String getImpdate() {
		return impdate;
	}
	public void setImpdate(String impdate) {
		this.impdate = impdate;
	}
	public String getImpmgryn() {
		return impmgryn;
	}
	public void setImpmgryn(String impmgryn) {
		this.impmgryn = impmgryn;
	}
	public int getComp_id() {
		return comp_id;
	}
	public void setComp_id(int comp_id) {
		this.comp_id = comp_id;
	}
	
	
	
	
}
