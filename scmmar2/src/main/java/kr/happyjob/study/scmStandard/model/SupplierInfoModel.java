package kr.happyjob.study.scmStandard.model;

public class SupplierInfoModel {
	
	//사용자 아이디
	private String loginID;
	
	//사용자 비밀번호
	private String password;
	
	//사용자 구분
	private String user_Type;
	
	//회사명
	private String client;

	//담당자명
	private String mgrnm;
		
	//담당자연락처
	private String phone;
	
	//납품업체고유번호
	private int comp_id;
	
	//제품명
	private String pdnm;

	//제품번호
	private int pdno;
	
	//납품단가
	private int pdmdprice;
	
	
	
	
	
	
	
	
	/////////////getter.setter//////////////
	
	public int getComp_id() {
		return comp_id;
	}

	public void setComp_id(int comp_id) {
		this.comp_id = comp_id;
	}

	public int getPdno() {
		return pdno;
	}

	public void setPdno(int pdno) {
		this.pdno = pdno;
	}

	public int getPdmdprice() {
		return pdmdprice;
	}

	public void setPdmdprice(int pdmdprice) {
		this.pdmdprice = pdmdprice;
	}

	public String getPdnm() {
		return pdnm;
	}
	
	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}
	
	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUser_Type() {
		return user_Type;
	}

	public void setUser_Type(String user_Type) {
		this.user_Type = user_Type;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getMgrnm() {
		return mgrnm;
	}

	public void setMgrnm(String mgrnm) {
		this.mgrnm = mgrnm;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Override
	public String toString() {
		return "SupplierInfoModel [loginID=" + loginID + ", password=" + password + ", user_Type=" + user_Type
				+ ", client=" + client + ", mgrnm=" + mgrnm + ", phone=" + phone + ", comp_id=" + comp_id + ", pdnm="
				+ pdnm + ", pdno=" + pdno + ", pdmdprice=" + pdmdprice + "]";
	}

	public SupplierInfoModel(String loginID, String password, String user_Type, String client, String mgrnm,
			String phone, int comp_id, String pdnm, int pdno, int pdmdprice) {
		super();
		this.loginID = loginID;
		this.password = password;
		this.user_Type = user_Type;
		this.client = client;
		this.mgrnm = mgrnm;
		this.phone = phone;
		this.comp_id = comp_id;
		this.pdnm = pdnm;
		this.pdno = pdno;
		this.pdmdprice = pdmdprice;
	}

	public SupplierInfoModel() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((client == null) ? 0 : client.hashCode());
		result = prime * result + comp_id;
		result = prime * result + ((loginID == null) ? 0 : loginID.hashCode());
		result = prime * result + ((mgrnm == null) ? 0 : mgrnm.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		result = prime * result + pdmdprice;
		result = prime * result + ((pdnm == null) ? 0 : pdnm.hashCode());
		result = prime * result + pdno;
		result = prime * result + ((phone == null) ? 0 : phone.hashCode());
		result = prime * result + ((user_Type == null) ? 0 : user_Type.hashCode());
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
		SupplierInfoModel other = (SupplierInfoModel) obj;
		if (client == null) {
			if (other.client != null)
				return false;
		} else if (!client.equals(other.client))
			return false;
		if (comp_id != other.comp_id)
			return false;
		if (loginID == null) {
			if (other.loginID != null)
				return false;
		} else if (!loginID.equals(other.loginID))
			return false;
		if (mgrnm == null) {
			if (other.mgrnm != null)
				return false;
		} else if (!mgrnm.equals(other.mgrnm))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (pdmdprice != other.pdmdprice)
			return false;
		if (pdnm == null) {
			if (other.pdnm != null)
				return false;
		} else if (!pdnm.equals(other.pdnm))
			return false;
		if (pdno != other.pdno)
			return false;
		if (phone == null) {
			if (other.phone != null)
				return false;
		} else if (!phone.equals(other.phone))
			return false;
		if (user_Type == null) {
			if (other.user_Type != null)
				return false;
		} else if (!user_Type.equals(other.user_Type))
			return false;
		return true;
	}

	

}
