package kr.happyjob.study.scmStandard.model;

public class QnaModel {

	//게시글 번호
	private int qna_no;
    //답변번호(게시글번호)
	private int qna_ano;
	//사용자ID
	private String loginid;
	//제목
	private String qna_title;
	//내용
	private String qna_content;
	//작성일
	private String qna_regdate;
	//답변제목
	private String qna_atitle;
	//답변내용
	private String qna_acontent;
	//답변날짜
	private String qna_aregdate;
	//답변상태
	private String qna_astate;
	//카테고리
	private String qna_category;
	
	
	public int getQna_no() {
		return qna_no;
	}
	public void setQna_no(int qna_no) {
		this.qna_no = qna_no;
	}
	public int getQna_ano() {
		return qna_ano;
	}
	public void setQna_ano(int qna_ano) {
		this.qna_ano = qna_ano;
	}
	public String getLoginid() {
		return loginid;
	}
	public void setLoginid(String loginid) {
		this.loginid = loginid;
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
	public String getQna_atitle() {
		return qna_atitle;
	}
	public void setQna_atitle(String qna_atitle) {
		this.qna_atitle = qna_atitle;
	}
	public String getQna_acontent() {
		return qna_acontent;
	}
	public void setQna_acontent(String qna_acontent) {
		this.qna_acontent = qna_acontent;
	}
	public String getQna_aregdate() {
		return qna_aregdate;
	}
	public void setQna_aregdate(String qna_aregdate) {
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
	
	
}
