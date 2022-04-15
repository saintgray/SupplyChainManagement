package kr.happyjob.study.scmTask.model;

import java.util.Date;
import java.util.Objects;

public class PaybackOrderModel {
	
	//주문일자
	private Date oddtdate;
	
	//주문고객명
	private String client;
	
	//제품명
	private String pdnm;
	
	//반품개수
	private int crtncnt;
	
	//금액
	private int crtnprice;
	
	//반품배송여부
	private int delstate;
	
	//반품번호
	private int rtnno;
	
	//주문번호
	private int crtrtio;
	
	//최종반품여부(입금완료)
	private String crtrtyn;

	
	
/////////////getter.setter//////////////
	

	public int getRtnno() {
		return rtnno;
	}

	public void setRtnno(int rtnno) {
		this.rtnno = rtnno;
	}

	public int getCrtrtio() {
		return crtrtio;
	}

	public void setCrtrtio(int crtrtio) {
		this.crtrtio = crtrtio;
	}

	public Date getOddtdate() {
		return oddtdate;
	}
	
	public void setOddtdate(Date oddtdate) {
		this.oddtdate = oddtdate;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getPdnm() {
		return pdnm;
	}

	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}

	public int getCrtncnt() {
		return crtncnt;
	}

	public void setCrtncnt(int crtncnt) {
		this.crtncnt = crtncnt;
	}

	public int getCrtnprice() {
		return crtnprice;
	}

	public void setCrtnprice(int crtnprice) {
		this.crtnprice = crtnprice;
	}

	public int getDelstate() {
		return delstate;
	}

	public void setDelstate(int delstate) {
		this.delstate = delstate;
	}
	
	public String getCrtrtyn() {
		return crtrtyn;
	}

	public void setCrtrtyn(String crtrtyn) {
		this.crtrtyn = crtrtyn;
	}

	@Override
	public int hashCode() {
		return Objects.hash(client, crtncnt, crtnprice, delstate, oddtdate, pdnm, crtrtyn);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PaybackOrderModel other = (PaybackOrderModel) obj;
		return Objects.equals(client, other.client) && crtncnt == other.crtncnt && crtnprice == other.crtnprice
				&& Objects.equals(delstate, other.delstate) && Objects.equals(oddtdate, other.oddtdate)
				&& Objects.equals(pdnm, other.pdnm) && Objects.equals(crtrtyn, other.crtrtyn);
	}

	@Override
	public String toString() {
		return "PaybackOrderModel [oddtdate=" + oddtdate + ", client=" + client + ", pdnm=" + pdnm + ", crtncnt="
				+ crtncnt + ", crtnprice=" + crtnprice + ", delstate=" + delstate + ", crtrtyn=" + crtrtyn + "]";
	}
	

}






