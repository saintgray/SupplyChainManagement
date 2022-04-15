package kr.happyjob.study.scmStandard.model;

import java.sql.Date;

import kr.happyjob.study.login.model.UserInfo;


public class NoticeBoardModel {

	// 글 번호
	private int ntc_no;
	
	// 사용자
	private String loginID;
	
	// 담당자
	private String name;
	
	// 제목
	private String ntc_title;
	
	// 내용
	private String ntc_content;
	
	// 등록일
	private Date ntc_regdate;
	
	// 조회수
	private int ntc_readcnt;
	
	// 서버 경로
	private String file_server_path;	
	
	// 로컬 경로
	private String file_local_path;	
	
	// 상대 경로
	private String file_relative_path;

	// 파일 신규 이름
	private String file_new_name;
	
	// 파일명
	private String file_ofname;
	
	// 용량
	private int file_size;
	
	//파일 확장자(DB에는 없음)
	private String file_exts;
	
	@Override
	public String toString() {
		return "NoticeBoardModel [ntc_no=" + ntc_no + ", loginID=" + loginID + ", name=" + name + ", ntc_title="
				+ ntc_title + ", ntc_content=" + ntc_content + ", ntc_regdate=" + ntc_regdate + ", ntc_readcnt="
				+ ntc_readcnt + ", file_server_path=" + file_server_path + ", file_local_path=" + file_local_path
				+ ", file_relative_path=" + file_relative_path + ", file_new_name=" + file_new_name + ", file_ofname="
				+ file_ofname + ", file_size=" + file_size + ", file_exts=" + file_exts + "]";
	}

	public int getNtc_no() {
		return ntc_no;
	}

	public void setNtc_no(int ntc_no) {
		this.ntc_no = ntc_no;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNtc_title() {
		return ntc_title;
	}

	public void setNtc_title(String ntc_title) {
		this.ntc_title = ntc_title;
	}

	public String getNtc_content() {
		return ntc_content;
	}

	public void setNtc_content(String ntc_content) {
		this.ntc_content = ntc_content;
	}

	public Date getNtc_regdate() {
		return ntc_regdate;
	}

	public void setNtc_regdate(Date ntc_regdate) {
		this.ntc_regdate = ntc_regdate;
	}

	public int getNtc_readcnt() {
		return ntc_readcnt;
	}

	public void setNtc_readcnt(int ntc_readcnt) {
		this.ntc_readcnt = ntc_readcnt;
	}

	public String getFile_server_path() {
		return file_server_path;
	}

	public void setFile_server_path(String file_server_path) {
		this.file_server_path = file_server_path;
	}

	public String getFile_local_path() {
		return file_local_path;
	}

	public void setFile_local_path(String file_local_path) {
		this.file_local_path = file_local_path;
	}

	public String getFile_relative_path() {
		return file_relative_path;
	}

	public void setFile_relative_path(String file_relative_path) {
		this.file_relative_path = file_relative_path;
	}

	public String getFile_new_name() {
		return file_new_name;
	}

	public void setFile_new_name(String file_new_name) {
		this.file_new_name = file_new_name;
	}

	public String getFile_ofname() {
		return file_ofname;
	}

	public void setFile_ofname(String file_ofname) {
		this.file_ofname = file_ofname;
	}

	public int getFile_size() {
		return file_size;
	}

	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}

	public String getFile_exts() {
		return file_exts;
	}

	public void setFile_exts(String file_exts) {
		this.file_exts = file_exts;
	} 

}
