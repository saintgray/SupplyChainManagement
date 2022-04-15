package kr.happyjob.study.crtPayback.model;

import java.sql.Date;

public class OrderDetailModel {

	
	private String orderno;
	private String userId;
	private int oddtno;
    private int oddtcnt;
    private int oddtrecnt;
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
	private int delstate;
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
	public int getOddtrecnt() {
		return oddtrecnt;
	}
	public void setOddtrecnt(int oddtrecnt) {
		this.oddtrecnt = oddtrecnt;
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
	public int getDelstate() {
		return delstate;
	}
	public void setDelstate(int delstate) {
		this.delstate = delstate;
	}
	public OrderDetailModel(String orderno, String userId, int oddtno, int oddtcnt, int oddtrecnt, String oddtreqyn,
			String oddtrtnyn, int pdcode, String pdmdno, int pdno, Date oddthopedate, String pdmdnm, String pdmdcop,
			int pdmdprice, String pdcodenm, int delstate) {
		super();
		this.orderno = orderno;
		this.userId = userId;
		this.oddtno = oddtno;
		this.oddtcnt = oddtcnt;
		this.oddtrecnt = oddtrecnt;
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
		this.delstate = delstate;
	}
	public OrderDetailModel() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + delstate;
		result = prime * result + oddtcnt;
		result = prime * result + ((oddthopedate == null) ? 0 : oddthopedate.hashCode());
		result = prime * result + oddtno;
		result = prime * result + oddtrecnt;
		result = prime * result + ((oddtreqyn == null) ? 0 : oddtreqyn.hashCode());
		result = prime * result + ((oddtrtnyn == null) ? 0 : oddtrtnyn.hashCode());
		result = prime * result + ((orderno == null) ? 0 : orderno.hashCode());
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
		OrderDetailModel other = (OrderDetailModel) obj;
		if (delstate != other.delstate)
			return false;
		if (oddtcnt != other.oddtcnt)
			return false;
		if (oddthopedate == null) {
			if (other.oddthopedate != null)
				return false;
		} else if (!oddthopedate.equals(other.oddthopedate))
			return false;
		if (oddtno != other.oddtno)
			return false;
		if (oddtrecnt != other.oddtrecnt)
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
		if (orderno == null) {
			if (other.orderno != null)
				return false;
		} else if (!orderno.equals(other.orderno))
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
	@Override
	public String toString() {
		return "OrderDetailModel [orderno=" + orderno + ", userId=" + userId + ", oddtno=" + oddtno + ", oddtcnt="
				+ oddtcnt + ", oddtrecnt=" + oddtrecnt + ", oddtreqyn=" + oddtreqyn + ", oddtrtnyn=" + oddtrtnyn
				+ ", pdcode=" + pdcode + ", pdmdno=" + pdmdno + ", pdno=" + pdno + ", oddthopedate=" + oddthopedate
				+ ", pdmdnm=" + pdmdnm + ", pdmdcop=" + pdmdcop + ", pdmdprice=" + pdmdprice + ", pdcodenm=" + pdcodenm
				+ ", delstate=" + delstate + "]";
	}
	
	
	
	
	
}
