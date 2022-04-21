package kr.happyjob.study.entity;

public class Purchase {
	
	protected String purId;
	protected String purDate;
	protected String depositYN;
	protected String depositDate;
	protected String type;
	
	private User user;
	
	public Purchase() {

	}

	public Purchase(String purId, String purDate, String depositYN, String depositDate, String type, User user) {
		
		this.purId = purId;
		this.purDate = purDate;
		this.depositYN = depositYN;
		this.depositDate = depositDate;
		this.type = type;
		this.user = user;
	}

	public String getPurId() {
		return purId;
	}

	public void setPurId(String purId) {
		this.purId = purId;
	}

	public String getPurDate() {
		return purDate;
	}

	public void setPurDate(String purDate) {
		this.purDate = purDate;
	}

	public String getDepositYN() {
		return depositYN;
	}

	public void setDepositYN(String depositYN) {
		this.depositYN = depositYN;
	}

	public String getDepositDate() {
		return depositDate;
	}

	public void setDepositDate(String depositDate) {
		this.depositDate = depositDate;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	
	
	
	
	
	
	

}
