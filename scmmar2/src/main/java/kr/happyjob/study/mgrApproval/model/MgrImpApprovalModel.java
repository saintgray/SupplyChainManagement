package kr.happyjob.study.mgrApproval.model;

import java.util.Date;

public class MgrImpApprovalModel {

	// 발주업체코드
	private int comp_id;

	// 발주업체명
	private String comp_nm;
	
	// 제품명
	private String pdnm;
	
	// 발주일련번호
	private String impno;
	
	// 주문일자
	private Date impregdate;
	
	// 주문 개수
	private int impdtcnt;
	
	// 주문 총 개수
	private int impcnt;
	
	// 발주 단가
	private int impprice;
	
	// 주문개수*발주단가
	private int impdtprice;
	
	// 발주 총 금액
	private int impamount;
	
	// 임원승인여부
	private String impmgryn;

	// 입금여부
	private String imppayyn;
	
	// 입고일자
	private Date impdate;
	
	//발주주문번호
	private int impordno;
	
	//장비코드
	private int pdcode;
	
	//모델번호
	private String pdmdno;
	
	//제품번호
	private int pdno;
	
	public int getImpordno() {
		return impordno;
	}

	public void setImpordno(int impordno) {
		this.impordno = impordno;
	}

	public int getPdcode() {
		return pdcode;
	}

	public void setPdcode(int pdcode) {
		this.pdcode = pdcode;
	}

	public String getPdmdno() {
		return pdmdno;
	}

	public void setPdmdno(String pdmdno) {
		this.pdmdno = pdmdno;
	}

	public int getPdno() {
		return pdno;
	}

	public void setPdno(int pdno) {
		this.pdno = pdno;
	}

	public int getComp_id() {
		return comp_id;
	}

	public void setComp_id(int comp_id) {
		this.comp_id = comp_id;
	}

	public String getComp_nm() {
		return comp_nm;
	}

	public void setComp_nm(String comp_nm) {
		this.comp_nm = comp_nm;
	}

	public String getPdnm() {
		return pdnm;
	}

	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}

	public String getImpno() {
		return impno;
	}

	public void setImpno(String impno) {
		this.impno = impno;
	}

	public Date getImpregdate() {
		return impregdate;
	}

	public void setImpregdate(Date impregdate) {
		this.impregdate = impregdate;
	}

	public int getImpdtcnt() {
		return impdtcnt;
	}

	public void setImpdtcnt(int impdtcnt) {
		this.impdtcnt = impdtcnt;
	}

	public int getImpcnt() {
		return impcnt;
	}

	public void setImpcnt(int impcnt) {
		this.impcnt = impcnt;
	}

	public int getImpprice() {
		return impprice;
	}

	public void setImpprice(int impprice) {
		this.impprice = impprice;
	}

	
	public int getImpdtprice() {
		return impdtprice;
	}

	public void setImpdtprice(int impdtprice) {
		this.impdtprice = impdtprice;
	}

	public int getImpamount() {
		return impamount;
	}

	public void setImpamount(int impamount) {
		this.impamount = impamount;
	}

	public String getImpmgryn() {
		return impmgryn;
	}

	public void setImpmgryn(String impmgryn) {
		this.impmgryn = impmgryn;
	}

	public String getImppayyn() {
		return imppayyn;
	}

	public void setImppayyn(String imppayyn) {
		this.imppayyn = imppayyn;
	}

	public Date getImpdate() {
		return impdate;
	}

	public void setImpdate(Date impdate) {
		this.impdate = impdate;
	}

 
	
}
