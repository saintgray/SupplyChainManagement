package kr.happyjob.study.mgrSell.model;

public class MgrSellModel {
	
	// 판매번호
	private int sellno;
	
	// 일련번호
	private String orderno;
	
	//총판매금액
	private int sellcnt;
	
	//총수익
	private int sellamount;
	
	//총반품
	private int totalsell;
	
	//총손익
	private int totalrtn;
	
	//반품번호
	private int totalamount;
	
	private int rtnno;

	public int getSellno() {
		return sellno;
	}

	public void setSellno(int sellno) {
		this.sellno = sellno;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public int getSellcnt() {
		return sellcnt;
	}

	public void setSellcnt(int sellcnt) {
		this.sellcnt = sellcnt;
	}

	public int getSellamount() {
		return sellamount;
	}

	public void setSellamount(int sellamount) {
		this.sellamount = sellamount;
	}

	public int getTotalsell() {
		return totalsell;
	}

	public void setTotalsell(int totalsell) {
		this.totalsell = totalsell;
	}

	public int getTotalrtn() {
		return totalrtn;
	}

	public void setTotalrtn(int totalrtn) {
		this.totalrtn = totalrtn;
	}

	public int getTotalamount() {
		return totalamount;
	}

	public void setTotalamount(int totalamount) {
		this.totalamount = totalamount;
	}

	public int getRtnno() {
		return rtnno;
	}

	public void setRtnno(int rtnno) {
		this.rtnno = rtnno;
	}
	
	
}
