package kr.happyjob.study.entity;

public class Comp {
	
	protected String compId;
	protected String addr;
	
	protected User user;
	
	public Comp() {
		
	}

	
	
	public Comp(String compId, String addr, User user) {
		
		this.compId = compId;
		this.addr = addr;
		this.user = user;
	}



	public String getCompId() {
		return compId;
	}

	public void setCompId(String compId) {
		this.compId = compId;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	

}
