package kr.happyjob.study.buyImportrtn.model;

import java.sql.Date;

public class BuyImportReturn {
	
	private int    rtnno   	   //반품번호
			  ,    brtncnt;    //반품건수;
	private Date   brtnregdate  //반품신청일
			   ,   brtncomdate; //반품완료일
	private String client	   //기업명
				 , pdno		   //제품번호
				 , pdnm		   //제품이름
				 , imppayyn; //입금여부
	
	public BuyImportReturn() {

	}

	public int getRtnno() {
		return rtnno;
	}

	public void setRtnno(int rtnno) {
		this.rtnno = rtnno;
	}

	public int getBrtncnt() {
		return brtncnt;
	}

	public void setBrtncnt(int brtncnt) {
		this.brtncnt = brtncnt;
	}

	public Date getBrtnregdate() {
		return brtnregdate;
	}

	public void setBrtnregdate(Date brtnregdate) {
		this.brtnregdate = brtnregdate;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getPdno() {
		return pdno;
	}

	public void setPdno(String pdno) {
		this.pdno = pdno;
	}

	public String getPdnm() {
		return pdnm;
	}

	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}

	public String getImppayyn() {
		return imppayyn;
	}

	public void setImppayyn(String imppayyn) {
		this.imppayyn = imppayyn;
	}

	public Date getBrtncomdate() {
		return brtncomdate;
	}

	public void setBrtncomdate(Date brtncomdate) {
		this.brtncomdate = brtncomdate;
	}
	
}
