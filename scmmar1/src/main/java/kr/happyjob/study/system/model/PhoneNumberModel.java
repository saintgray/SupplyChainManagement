package kr.happyjob.study.system.model;

public class PhoneNumberModel {
	
	private String p_head;
	private String p_mid;
	private String p_end;
	
	public PhoneNumberModel() {
		
	}

	public String getP_head() {
		return p_head;
	}

	public void setP_head(String p_head) {
		this.p_head = p_head;
	}

	public String getP_mid() {
		return p_mid;
	}

	public void setP_mid(String p_mid) {
		this.p_mid = p_mid;
	}

	public String getP_end() {
		return p_end;
	}

	public void setP_end(String p_end) {
		this.p_end = p_end;
	}


	public String getPhoneNumber(){
		return this.p_head.concat(this.p_mid).concat(this.p_end);
	}

	

}
