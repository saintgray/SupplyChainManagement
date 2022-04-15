package kr.happyjob.study.crtCs.model;

import java.sql.Date;

public class CrtCsModel {

	private int qna_no;
	private String loginID;
	private String qna_title;
	private String qna_content;
	private Date qna_regdate;
	private int qna_ano;
	private String qna_atilte;
	private String qna_acontent;
	private Date qna_aregdate;
	private String qna_astate;
	private String qna_category;
	public int getQna_no() {
		return qna_no;
	}
	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getQna_title() {
		return qna_title;
	}
	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}
	public String getQna_content() {
		return qna_content;
	}
	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}
	public Date getQna_regdate() {
		return qna_regdate;
	}
	public void setQna_regdate(Date qna_regdate) {
		this.qna_regdate = qna_regdate;
	}
	public int getQna_ano() {
		return qna_ano;
	}
	public void setQna_ano(int qna_ano) {
		this.qna_ano = qna_ano;
	}
	public String getQna_atilte() {
		return qna_atilte;
	}
	public void setQna_atilte(String qna_atilte) {
		this.qna_atilte = qna_atilte;
	}
	public String getQna_acontent() {
		return qna_acontent;
	}
	public void setQna_acontent(String qna_acontent) {
		this.qna_acontent = qna_acontent;
	}
	public Date getQna_aregdate() {
		return qna_aregdate;
	}
	public void setQna_aregdate(Date qna_aregdate) {
		this.qna_aregdate = qna_aregdate;
	}
	public String getQna_astate() {
		return qna_astate;
	}
	public void setQna_astate(String qna_astate) {
		this.qna_astate = qna_astate;
	}
	public String getQna_category() {
		return qna_category;
	}
	public void setQna_category(String qna_category) {
		this.qna_category = qna_category;
	}
	public CrtCsModel() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CrtCsModel(int qna_no, String loginID, String qna_title, String qna_content, Date qna_regdate, int qna_ano,
			String qna_atilte, String qna_acontent, Date qna_aregdate, String qna_astate, String qna_category) {
		super();
		this.qna_no = qna_no;
		this.loginID = loginID;
		this.qna_title = qna_title;
		this.qna_content = qna_content;
		this.qna_regdate = qna_regdate;
		this.qna_ano = qna_ano;
		this.qna_atilte = qna_atilte;
		this.qna_acontent = qna_acontent;
		this.qna_aregdate = qna_aregdate;
		this.qna_astate = qna_astate;
		this.qna_category = qna_category;
	}
	@Override
	public String toString() {
		return "CrtCsModel [qna_no=" + qna_no + ", loginID=" + loginID + ", qna_title=" + qna_title + ", qna_content="
				+ qna_content + ", qna_regdate=" + qna_regdate + ", qna_ano=" + qna_ano + ", qna_atilte=" + qna_atilte
				+ ", qna_acontent=" + qna_acontent + ", qna_aregdate=" + qna_aregdate + ", qna_astate=" + qna_astate
				+ ", qna_category=" + qna_category + "]";
	}
	
	
	
	
}
