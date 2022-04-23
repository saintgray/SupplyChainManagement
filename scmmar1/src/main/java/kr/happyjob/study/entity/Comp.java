package kr.happyjob.study.entity;

import org.apache.ibatis.type.Alias;

@Alias("comp")
public class Comp {
	
	protected String compId;
	protected String addr;
	
	protected Member user;
	
	public Comp() {
		
	}

	
	
	public Comp(String compId, String addr, Member user) {
		
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

	public Member getUser() {
		return user;
	}

	public void setUser(Member user) {
		this.user = user;
	}
	
	

}
