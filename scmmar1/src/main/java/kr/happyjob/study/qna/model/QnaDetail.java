package kr.happyjob.study.qna.model;

public class QnaDetail {
	
	private String qna_id;
	private String loginID;
	private String client;
	private String qna_title;
	private String qna_content;
	private String qna_regdate;
	private String qna_editdate;
	
	private Reply reply;
	
	
	public QnaDetail() {
		
	}

	public String getQna_id() {
		return qna_id;
	}


	public void setQna_id(String qna_id) {
		this.qna_id = qna_id;
	}


	public String getLoginID() {
		return loginID;
	}


	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getClient() {
		return client;
	}


	public void setClient(String client) {
		this.client = client;
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


	public String getQna_regdate() {
		return qna_regdate;
	}


	public void setQna_regdate(String qna_regdate) {
		this.qna_regdate = qna_regdate;
	}


	public String getQna_editdate() {
		return qna_editdate;
	}


	public void setQna_editdate(String qna_editdate) {
		this.qna_editdate = qna_editdate;
	}


	public Reply getReply() {
		return reply;
	}


	public void setReply(Reply reply) {
		this.reply = reply;
	}
	
	
	
	
	
	

}
