package kr.happyjob.study.qna.model;

public class Reply {
	
	private String reply_id;
	private String reply_title;
	private String reply_content;
	private String reply_regdate;
	private String reply_editdate;
	
	
	public Reply() {
	
	}
	
	public Reply(String reply_id, String reply_title, String reply_content) {
		
		this.reply_id = reply_id;
		this.reply_title = reply_title;
		this.reply_content = reply_content;
	}


	public String getReply_id() {
		return reply_id;
	}


	public void setReply_id(String reply_id) {
		this.reply_id = reply_id;
	}


	public String getReply_title() {
		return reply_title;
	}


	public void setReply_title(String reply_title) {
		this.reply_title = reply_title;
	}


	public String getReply_content() {
		return reply_content;
	}


	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}


	public String getReply_regdate() {
		return reply_regdate;
	}


	public void setReply_regdate(String reply_regdate) {
		this.reply_regdate = reply_regdate;
	}


	public String getReply_editdate() {
		return reply_editdate;
	}


	public void setReply_editdate(String reply_editdate) {
		this.reply_editdate = reply_editdate;
	}
	
	
	
	
	

}
