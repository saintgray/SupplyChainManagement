package kr.happyjob.study.pcm.model;

import java.util.Date;

public class PcmReturnListModel {

	private int return_id; 		//반품번호
	private String comp_nm; 	//반품회사
	private String sales_nm;	//반품제품
	private int return_cnt;		//반품수량
	private Date regdate;		//날짜
	private String confirmYN; 	//임원입금확인(이거 사용안해서 뺐는데 있으면 오류가 난다.)
	
	public int getReturn_id() {
		return return_id;
	}
	public void setReturn_id(int return_id) {
		this.return_id = return_id;
	}
	public String getComp_nm() {
		return comp_nm;
	}
	public void setComp_nm(String comp_nm) {
		this.comp_nm = comp_nm;
	}
	public String getSales_nm() {
		return sales_nm;
	}
	public void setSales_nm(String sales_nm) {
		this.sales_nm = sales_nm;
	}
	public int getReturn_cnt() {
		return return_cnt;
	}
	public void setReturn_cnt(int return_cnt) {
		this.return_cnt = return_cnt;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getConfirmYN() {
		return confirmYN;
	}
	public void setConfirmYN(String confirmYN) {
		this.confirmYN = confirmYN;
	}
	
	@Override
	public String toString() {
		return "PcmReturnListModel [return_id=" + return_id + ", comp_nm=" + comp_nm + ", sales_nm=" + sales_nm
				+ ", return_cnt=" + return_cnt + ", regdate=" + regdate + ", confirmYN=" + confirmYN + "]";
	}
}
