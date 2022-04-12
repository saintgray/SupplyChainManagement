package kr.happyjob.study.qna.model;

public class QnaListRow {
	
	private String qna_id;
	private String qna_title;
	private String qna_regdate;
	private String name;
	
	public QnaListRow() {

	}

	public QnaListRow(String qna_id, String qna_title, String qna_regdate, String name) {

		this.qna_id = qna_id;
		this.qna_title = qna_title;
		this.qna_regdate = qna_regdate;
		this.name = name;
	}

	public String getQna_id() {
		return qna_id;
	}

	public void setQna_id(String qna_id) {
		this.qna_id = qna_id;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_regdate() {
		return qna_regdate;
	}

	public void setQna_regdate(String qna_regdate) {
		this.qna_regdate = qna_regdate;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	

}
