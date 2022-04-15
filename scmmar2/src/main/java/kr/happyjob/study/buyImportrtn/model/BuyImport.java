package kr.happyjob.study.buyImportrtn.model;

import java.sql.Date;

public class BuyImport {
	
	private int impordno  //주문번호
		      , impdtcnt //주문개수
			  , pdno //제품번호
			  , pdcode
			  , comp_id
			  , pdmdprice;
	
	private Date impdtdate; //주문일자
	
	private String impno    //일련번호
				 , imppayyn //입금여부
				 , client   //업체이름
				 , impmgryn //임원승인여부
				 , pdmdno   //제품번호
				 , pdnm;  //제품이름
	
	public BuyImport() {
		
	}

	public int getImpordno() {
		return impordno;
	}

	public void setImpordno(int impordno) {
		this.impordno = impordno;
	}

	public int getImpdtcnt() {
		return impdtcnt;
	}

	public void setImpdtcnt(int impdtcnt) {
		this.impdtcnt = impdtcnt;
	}

	public Date getImpdtdate() {
		return impdtdate;
	}

	public void setImpdtdate(Date impdtdate) {
		this.impdtdate = impdtdate;
	}

	public String getImpno() {
		return impno;
	}

	public void setImpno(String impno) {
		this.impno = impno;
	}

	public String getImppayyn() {
		return imppayyn;
	}

	public void setImppayyn(String imppayyn) {
		this.imppayyn = imppayyn;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getImpmgryn() {
		return impmgryn;
	}

	public void setImpmgryn(String impmgryn) {
		this.impmgryn = impmgryn;
	}

	public String getPdmdno() {
		return pdmdno;
	}

	public void setPdmdno(String pdmdno) {
		this.pdmdno = pdmdno;
	}

	public String getPdnm() {
		return pdnm;
	}

	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}

	public int getPdno() {
		return pdno;
	}

	public void setPdno(int pdno) {
		this.pdno = pdno;
	}

	public int getPdcode() {
		return pdcode;
	}

	public void setPdcode(int pdcode) {
		this.pdcode = pdcode;
	}

	public int getComp_id() {
		return comp_id;
	}

	public void setComp_id(int comp_id) {
		this.comp_id = comp_id;
	}

	public int getPdmdprice() {
		return pdmdprice;
	}

	public void setPdmdprice(int pdmdprice) {
		this.pdmdprice = pdmdprice;
	}	

	
	
}
