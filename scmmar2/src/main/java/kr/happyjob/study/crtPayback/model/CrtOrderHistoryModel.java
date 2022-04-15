package kr.happyjob.study.crtPayback.model;

import java.sql.Date;

public class CrtOrderHistoryModel {

	private String orderno;
	private String userId;
	private Date orderdate;
	private int ordercnt;
	private String orderpayyn;
	private int orderamount;
	private int oddtno;
    private int oddtcnt;
    private String oddtreqyn;
    private String oddtrtnyn;
    private int pdcode;
    private String pdmdno;
    private int pdno;
    private Date oddthopedate;
	private String pdmdnm;
	private String pdmdcop;
	private int pdmdprice;
	private String pdcodenm;
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}
	public int getOrdercnt() {
		return ordercnt;
	}
	public void setOrdercnt(int ordercnt) {
		this.ordercnt = ordercnt;
	}
	public String getOrderpayyn() {
		return orderpayyn;
	}
	public void setOrderpayyn(String orderpayyn) {
		this.orderpayyn = orderpayyn;
	}
	public int getOrderamount() {
		return orderamount;
	}
	public void setOrderamount(int orderamount) {
		this.orderamount = orderamount;
	}
	public int getOddtno() {
		return oddtno;
	}
	public void setOddtno(int oddtno) {
		this.oddtno = oddtno;
	}
	public int getOddtcnt() {
		return oddtcnt;
	}
	public void setOddtcnt(int oddtcnt) {
		this.oddtcnt = oddtcnt;
	}
	public String getOddtreqyn() {
		return oddtreqyn;
	}
	public void setOddtreqyn(String oddtreqyn) {
		this.oddtreqyn = oddtreqyn;
	}
	public String getOddtrtnyn() {
		return oddtrtnyn;
	}
	public void setOddtrtnyn(String oddtrtnyn) {
		this.oddtrtnyn = oddtrtnyn;
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
	public Date getOddthopedate() {
		return oddthopedate;
	}
	public void setOddthopedate(Date oddthopedate) {
		this.oddthopedate = oddthopedate;
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
	public String getPdcodenm() {
		return pdcodenm;
	}
	public void setPdcodenm(String pdcodenm) {
		this.pdcodenm = pdcodenm;
	}
	public CrtOrderHistoryModel(String orderno, String userId, Date orderdate, int ordercnt, String orderpayyn,
			int orderamount, int oddtno, int oddtcnt, String oddtreqyn, String oddtrtnyn, int pdcode, String pdmdno,
			int pdno, Date oddthopedate, String pdmdnm, String pdmdcop, int pdmdprice, String pdcodenm) {
		super();
		this.orderno = orderno;
		this.userId = userId;
		this.orderdate = orderdate;
		this.ordercnt = ordercnt;
		this.orderpayyn = orderpayyn;
		this.orderamount = orderamount;
		this.oddtno = oddtno;
		this.oddtcnt = oddtcnt;
		this.oddtreqyn = oddtreqyn;
		this.oddtrtnyn = oddtrtnyn;
		this.pdcode = pdcode;
		this.pdmdno = pdmdno;
		this.pdno = pdno;
		this.oddthopedate = oddthopedate;
		this.pdmdnm = pdmdnm;
		this.pdmdcop = pdmdcop;
		this.pdmdprice = pdmdprice;
		this.pdcodenm = pdcodenm;
	}
	public CrtOrderHistoryModel() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "CrtOrderHistoryModel [orderno=" + orderno + ", userId=" + userId + ", orderdate=" + orderdate
				+ ", ordercnt=" + ordercnt + ", orderpayyn=" + orderpayyn + ", orderamount=" + orderamount + ", oddtno="
				+ oddtno + ", oddtcnt=" + oddtcnt + ", oddtreqyn=" + oddtreqyn + ", oddtrtnyn=" + oddtrtnyn
				+ ", pdcode=" + pdcode + ", pdmdno=" + pdmdno + ", pdno=" + pdno + ", oddthopedate=" + oddthopedate
				+ ", pdmdnm=" + pdmdnm + ", pdmdcop=" + pdmdcop + ", pdmdprice=" + pdmdprice + ", pdcodenm=" + pdcodenm
				+ "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + oddtcnt;
		result = prime * result + ((oddthopedate == null) ? 0 : oddthopedate.hashCode());
		result = prime * result + oddtno;
		result = prime * result + ((oddtreqyn == null) ? 0 : oddtreqyn.hashCode());
		result = prime * result + ((oddtrtnyn == null) ? 0 : oddtrtnyn.hashCode());
		result = prime * result + orderamount;
		result = prime * result + ordercnt;
		result = prime * result + ((orderdate == null) ? 0 : orderdate.hashCode());
		result = prime * result + ((orderno == null) ? 0 : orderno.hashCode());
		result = prime * result + ((orderpayyn == null) ? 0 : orderpayyn.hashCode());
		result = prime * result + pdcode;
		result = prime * result + ((pdcodenm == null) ? 0 : pdcodenm.hashCode());
		result = prime * result + ((pdmdcop == null) ? 0 : pdmdcop.hashCode());
		result = prime * result + ((pdmdnm == null) ? 0 : pdmdnm.hashCode());
		result = prime * result + ((pdmdno == null) ? 0 : pdmdno.hashCode());
		result = prime * result + pdmdprice;
		result = prime * result + pdno;
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CrtOrderHistoryModel other = (CrtOrderHistoryModel) obj;
		if (oddtcnt != other.oddtcnt)
			return false;
		if (oddthopedate == null) {
			if (other.oddthopedate != null)
				return false;
		} else if (!oddthopedate.equals(other.oddthopedate))
			return false;
		if (oddtno != other.oddtno)
			return false;
		if (oddtreqyn == null) {
			if (other.oddtreqyn != null)
				return false;
		} else if (!oddtreqyn.equals(other.oddtreqyn))
			return false;
		if (oddtrtnyn == null) {
			if (other.oddtrtnyn != null)
				return false;
		} else if (!oddtrtnyn.equals(other.oddtrtnyn))
			return false;
		if (orderamount != other.orderamount)
			return false;
		if (ordercnt != other.ordercnt)
			return false;
		if (orderdate == null) {
			if (other.orderdate != null)
				return false;
		} else if (!orderdate.equals(other.orderdate))
			return false;
		if (orderno == null) {
			if (other.orderno != null)
				return false;
		} else if (!orderno.equals(other.orderno))
			return false;
		if (orderpayyn == null) {
			if (other.orderpayyn != null)
				return false;
		} else if (!orderpayyn.equals(other.orderpayyn))
			return false;
		if (pdcode != other.pdcode)
			return false;
		if (pdcodenm == null) {
			if (other.pdcodenm != null)
				return false;
		} else if (!pdcodenm.equals(other.pdcodenm))
			return false;
		if (pdmdcop == null) {
			if (other.pdmdcop != null)
				return false;
		} else if (!pdmdcop.equals(other.pdmdcop))
			return false;
		if (pdmdnm == null) {
			if (other.pdmdnm != null)
				return false;
		} else if (!pdmdnm.equals(other.pdmdnm))
			return false;
		if (pdmdno == null) {
			if (other.pdmdno != null)
				return false;
		} else if (!pdmdno.equals(other.pdmdno))
			return false;
		if (pdmdprice != other.pdmdprice)
			return false;
		if (pdno != other.pdno)
			return false;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		return true;
	}
    
    
    
}
