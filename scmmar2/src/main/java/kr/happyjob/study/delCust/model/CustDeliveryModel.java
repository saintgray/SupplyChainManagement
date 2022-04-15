package kr.happyjob.study.delCust.model;

public class CustDeliveryModel {
	
	// 배송번호
	private int delno;
	
	// 배송담당자
	private String clientnm;
	
	// 출발 창고지
	private String whplace;
	
	// 목적지
	private String address;
	
	// 배송결과
	private String delstate;
	
	// 모달
	// 제품명
	private String pdnm;
	
	// 제품수량
	private int oddtcnt;

	public int getDelno() {
		return delno;
	}

	public void setDelno(int delno) {
		this.delno = delno;
	}

	public String getClientnm() {
		return clientnm;
	}

	public void setClientnm(String clientnm) {
		this.clientnm = clientnm;
	}

	public String getWhplace() {
		return whplace;
	}

	public void setWhplace(String whplace) {
		this.whplace = whplace;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDelstate() {
		return delstate;
	}

	public void setDelstate(String delstate) {
		this.delstate = delstate;
	}

	public String getPdnm() {
		return pdnm;
	}

	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}

	public int getOddtcnt() {
		return oddtcnt;
	}

	public void setOddtcnt(int ordercnt) {
		this.oddtcnt = oddtcnt;
	}
	
}
