package kr.happyjob.study.crtOrder.model;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class CrtCartModel {

	private int cartno;
	private String loginID;
	private int cartcnt;
	private int cartamount;
	private Date carthopedate;
	private int pdcode;
	private String pdcodenm;
	private String pdmdnm;
	private String pdmdno;
	private int pdmdprice;
	private String pdmdcop;
	private Date pdmdregDate;
	private int pdno;
	private String pdnm;
	private String pdinfo;
	private String file_server_path;
	public int getCartno() {
		return cartno;
	}
	public void setCartno(int cartno) {
		this.cartno = cartno;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getCartcnt() {
		return cartcnt;
	}
	public void setCartcnt(int cartcnt) {
		this.cartcnt = cartcnt;
	}
	public int getCartamount() {
		return cartamount;
	}
	public void setCartamount(int cartamount) {
		this.cartamount = cartamount;
	}
	public Date getCarthopedate() {
		return carthopedate;
	}
	public void setCarthopedate(Date carthopedate) {
		this.carthopedate = carthopedate;
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
	public String getPdmdnm() {
		return pdmdnm;
	}
	public void setPdmdnm(String pdmdnm) {
		this.pdmdnm = pdmdnm;
	}
	public String getPdmdno() {
		return pdmdno;
	}
	public void setPdmdno(String pdmdno) {
		this.pdmdno = pdmdno;
	}
	public int getPdmdprice() {
		return pdmdprice;
	}
	public void setPdmdprice(int pdmdprice) {
		this.pdmdprice = pdmdprice;
	}
	public String getPdmdcop() {
		return pdmdcop;
	}
	public void setPdmdcop(String pdmdcop) {
		this.pdmdcop = pdmdcop;
	}
	public Date getPdmdregDate() {
		return pdmdregDate;
	}
	public void setPdmdregDate(Date pdmdregDate) {
		this.pdmdregDate = pdmdregDate;
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
	public String getFile_server_path() {
		return file_server_path;
	}
	public void setFile_server_path(String file_server_path) {
		this.file_server_path = file_server_path;
	}
	public CrtCartModel(int cartno, String loginID, int cartcnt, int cartamount, Date carthopedate, int pdcode,
			String pdcodenm, String pdmdnm, String pdmdno, int pdmdprice, String pdmdcop, Date pdmdregDate, int pdno,
			String pdnm, String pdinfo, String file_server_path) {
		super();
		this.cartno = cartno;
		this.loginID = loginID;
		this.cartcnt = cartcnt;
		this.cartamount = cartamount;
		this.carthopedate = carthopedate;
		this.pdcode = pdcode;
		this.pdcodenm = pdcodenm;
		this.pdmdnm = pdmdnm;
		this.pdmdno = pdmdno;
		this.pdmdprice = pdmdprice;
		this.pdmdcop = pdmdcop;
		this.pdmdregDate = pdmdregDate;
		this.pdno = pdno;
		this.pdnm = pdnm;
		this.pdinfo = pdinfo;
		this.file_server_path = file_server_path;
	}
	public CrtCartModel() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "CrtCartModel [cartno=" + cartno + ", loginID=" + loginID + ", cartcnt=" + cartcnt + ", cartamount="
				+ cartamount + ", carthopedate=" + carthopedate + ", pdcode=" + pdcode + ", pdcodenm=" + pdcodenm
				+ ", pdmdnm=" + pdmdnm + ", pdmdno=" + pdmdno + ", pdmdprice=" + pdmdprice + ", pdmdcop=" + pdmdcop
				+ ", pdmdregDate=" + pdmdregDate + ", pdno=" + pdno + ", pdnm=" + pdnm + ", pdinfo=" + pdinfo
				+ ", file_server_path=" + file_server_path + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + cartamount;
		result = prime * result + cartcnt;
		result = prime * result + ((carthopedate == null) ? 0 : carthopedate.hashCode());
		result = prime * result + cartno;
		result = prime * result + ((file_server_path == null) ? 0 : file_server_path.hashCode());
		result = prime * result + ((loginID == null) ? 0 : loginID.hashCode());
		result = prime * result + pdcode;
		result = prime * result + ((pdcodenm == null) ? 0 : pdcodenm.hashCode());
		result = prime * result + ((pdinfo == null) ? 0 : pdinfo.hashCode());
		result = prime * result + ((pdmdcop == null) ? 0 : pdmdcop.hashCode());
		result = prime * result + ((pdmdnm == null) ? 0 : pdmdnm.hashCode());
		result = prime * result + ((pdmdno == null) ? 0 : pdmdno.hashCode());
		result = prime * result + pdmdprice;
		result = prime * result + ((pdmdregDate == null) ? 0 : pdmdregDate.hashCode());
		result = prime * result + ((pdnm == null) ? 0 : pdnm.hashCode());
		result = prime * result + pdno;
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
		CrtCartModel other = (CrtCartModel) obj;
		if (cartamount != other.cartamount)
			return false;
		if (cartcnt != other.cartcnt)
			return false;
		if (carthopedate == null) {
			if (other.carthopedate != null)
				return false;
		} else if (!carthopedate.equals(other.carthopedate))
			return false;
		if (cartno != other.cartno)
			return false;
		if (file_server_path == null) {
			if (other.file_server_path != null)
				return false;
		} else if (!file_server_path.equals(other.file_server_path))
			return false;
		if (loginID == null) {
			if (other.loginID != null)
				return false;
		} else if (!loginID.equals(other.loginID))
			return false;
		if (pdcode != other.pdcode)
			return false;
		if (pdcodenm == null) {
			if (other.pdcodenm != null)
				return false;
		} else if (!pdcodenm.equals(other.pdcodenm))
			return false;
		if (pdinfo == null) {
			if (other.pdinfo != null)
				return false;
		} else if (!pdinfo.equals(other.pdinfo))
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
		if (pdmdregDate == null) {
			if (other.pdmdregDate != null)
				return false;
		} else if (!pdmdregDate.equals(other.pdmdregDate))
			return false;
		if (pdnm == null) {
			if (other.pdnm != null)
				return false;
		} else if (!pdnm.equals(other.pdnm))
			return false;
		if (pdno != other.pdno)
			return false;
		return true;
	}
	
	
		
	
}
