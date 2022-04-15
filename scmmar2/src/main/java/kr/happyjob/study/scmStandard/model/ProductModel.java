package kr.happyjob.study.scmStandard.model;

import java.sql.Date;

public class ProductModel {
	
	// 장비코드
	private int pdcode;
	
	// 장비구분
	private String pdcodenm;

	// 모델번호
	private String pdmdno;
	
	// 모델명
	private String pdmdnm;
	
	// 납품회사번호
	private int	comp_id;
	
	// 제조사
	private String pdmdcop;
	
	// 판매단가
	private int pdmdprice;
	
	// 등록일
	private Date pdmdregdate;
	
	// 제품번호
	private int pdno;
	
	// 제품명
	private String pdnm;
	
	// 상세정보
	private String pdinfo;
	
	@Override
	public String toString() {
		return "ProductModel [pdcode=" + pdcode + ", pdcodenm=" + pdcodenm + ", pdmdno=" + pdmdno + ", pdmdnm=" + pdmdnm
				+ ", comp_id=" + comp_id + ", pdmdcop=" + pdmdcop + ", pdmdprice=" + pdmdprice + ", pdmdregdate="
				+ pdmdregdate + ", pdno=" + pdno + ", pdnm=" + pdnm + ", pdinfo=" + pdinfo + "]";
	}

	public int getPdcode() {
		return pdcode;
	}

	public void setPdcode(int pdcode) {
		this.pdcode = pdcode;
	}

	public String getPdcodenm() {
		return pdcodenm;
	}

	public void setPdcodenm(String pdcodenm) {
		this.pdcodenm = pdcodenm;
	}

	public String getPdmdno() {
		return pdmdno;
	}

	public void setPdmdno(String pdmdno) {
		this.pdmdno = pdmdno;
	}

	public String getPdmdnm() {
		return pdmdnm;
	}

	public void setPdmdnm(String pdmdnm) {
		this.pdmdnm = pdmdnm;
	}

	public String getPdmdcop() {
		return pdmdcop;
	}

	public void setPdmdcop(String pdmdcop) {
		this.pdmdcop = pdmdcop;
	}

	public int getPdmdprice() {
		return pdmdprice;
	}

	public void setPdmdprice(int pdmdprice) {
		this.pdmdprice = pdmdprice;
	}

	public Date getPdmdregdate() {
		return pdmdregdate;
	}

	public void setPdmdregdate(Date pdmdregdate) {
		this.pdmdregdate = pdmdregdate;
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

	public String getPdinfo() {
		return pdinfo;
	}

	public void setPdinfo(String pdinfo) {
		this.pdinfo = pdinfo;
	}

	public int getComp_id() {
		return comp_id;
	}

	public void setComp_id(int comp_id) {
		this.comp_id = comp_id;
	}
	
	

}