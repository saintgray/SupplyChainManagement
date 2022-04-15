package kr.happyjob.study.scmDeal.model;

import java.sql.Date;

public class WarehouseInfo {
	
	/** 창고 목록 */	
	private int    whcode   	//창고코드
				 , stockcnt 	//재고수량
				 , pdno;    	//제품번호
	private String whnm     	//창고명
				 , whzip    	//우편번호
				 , whplace  	//창고위치
				 , whaddr   	//상세주소
				 , mgrnm    	//담당자
				 , pdnm	    	//제품명
				 , oi;			//입고출고여부
	
	/** 창고별 입·출고 내역 */
	private int    oddtcnt   	//출고수량
			     , impdtcnt; 	//입고수량
	private Date   oddtdate  	//출고일자
			     , impdtdate;	//입고일자
	
	public WarehouseInfo() {
	
	}

	public int getWhcode() {
		return whcode;
	}

	public void setWhcode(int whcode) {
		this.whcode = whcode;
	}

	public int getStockcnt() {
		return stockcnt;
	}

	public void setStockcnt(int stockcnt) {
		this.stockcnt = stockcnt;
	}

	public int getPdno() {
		return pdno;
	}

	public void setPdno(int pdno) {
		this.pdno = pdno;
	}

	public String getWhnm() {
		return whnm;
	}

	public void setWhnm(String whnm) {
		this.whnm = whnm;
	}

	public String getWhzip() {
		return whzip;
	}

	public void setWhzip(String whzip) {
		this.whzip = whzip;
	}

	public String getWhplace() {
		return whplace;
	}

	public void setWhplace(String whplace) {
		this.whplace = whplace;
	}

	public String getWhaddr() {
		return whaddr;
	}

	public void setWhaddr(String whaddr) {
		this.whaddr = whaddr;
	}

	public String getMgrnm() {
		return mgrnm;
	}

	public void setMgrnm(String mgrnm) {
		this.mgrnm = mgrnm;
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

	public void setOddtcnt(int oddtcnt) {
		this.oddtcnt = oddtcnt;
	}

	public int getImpdtcnt() {
		return impdtcnt;
	}

	public void setImpdtcnt(int impdtcnt) {
		this.impdtcnt = impdtcnt;
	}

	public Date getOddtdate() {
		return oddtdate;
	}

	public void setOddtdate(Date oddtdate) {
		this.oddtdate = oddtdate;
	}

	public Date getImpdtdate() {
		return impdtdate;
	}

	public void setImpdtdate(Date impdtdate) {
		this.impdtdate = impdtdate;
	}

	public String getOi() {
		return oi;
	}

	public void setOi(String oi) {
		this.oi = oi;
	}
	
	
}
