package kr.happyjob.study.scmStandard.model;


public class WhInfoModel {
	
	//창고코드
	private int whcode;
	
	//창고명
	private String whnm;
	
	//담당자명
	private String mgrnm;
	
	//창고 우편번호
	private String whzip;

	//창고주소
	private String whplace;
	
	//창고상세주소
	private String whaddr;
		
	//연락처
	private String phone;
	
	//이메일
	private String email;
	
	//담당자리스트
	private String mgrlist;
	
	
	/////////////getter.setter//////////////

	

	public String getMgrlist() {
		return mgrlist;
	}

	public void setMgrlist(String mgrlist) {
		this.mgrlist = mgrlist;
	}

	public int getWhcode() {
		return whcode;
	}

	public void setWhcode(int whcode) {
		this.whcode = whcode;
	}

	public String getWhnm() {
		return whnm;
	}

	public void setWhnm(String whnm) {
		this.whnm = whnm;
	}

	public String getMgrnm() {
		return mgrnm;
	}

	public void setMgrnm(String mgrnm) {
		this.mgrnm = mgrnm;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((mgrnm == null) ? 0 : mgrnm.hashCode());
		result = prime * result + ((phone == null) ? 0 : phone.hashCode());
		result = prime * result + ((whaddr == null) ? 0 : whaddr.hashCode());
		result = prime * result + whcode;
		result = prime * result + ((whnm == null) ? 0 : whnm.hashCode());
		result = prime * result + ((whplace == null) ? 0 : whplace.hashCode());
		result = prime * result + ((whzip == null) ? 0 : whzip.hashCode());
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
		WhInfoModel other = (WhInfoModel) obj;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (mgrnm == null) {
			if (other.mgrnm != null)
				return false;
		} else if (!mgrnm.equals(other.mgrnm))
			return false;
		if (phone == null) {
			if (other.phone != null)
				return false;
		} else if (!phone.equals(other.phone))
			return false;
		if (whaddr == null) {
			if (other.whaddr != null)
				return false;
		} else if (!whaddr.equals(other.whaddr))
			return false;
		if (whcode != other.whcode)
			return false;
		if (whnm == null) {
			if (other.whnm != null)
				return false;
		} else if (!whnm.equals(other.whnm))
			return false;
		if (whplace == null) {
			if (other.whplace != null)
				return false;
		} else if (!whplace.equals(other.whplace))
			return false;
		if (whzip == null) {
			if (other.whzip != null)
				return false;
		} else if (!whzip.equals(other.whzip))
			return false;
		return true;
	}

	
	
	
}