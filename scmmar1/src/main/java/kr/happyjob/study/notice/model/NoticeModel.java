package kr.happyjob.study.notice.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.scm.model.FileModel;

public class NoticeModel {
	
	private int ntc_no;
	private String loginID;
	private String ntc_content;
	private String ntc_moddate;
	private String ntc_regdate;
	private String ntc_editdate;
	private String ntc_title;
	private List<FileModel> filesInfo;
	
	
	
	public NoticeModel() {
	
	}

	

	public String getLoginID() {
		return loginID;
	}


	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}


	public String getNtc_content() {
		return ntc_content;
	}


	public void setNtc_content(String ntc_content) {
		this.ntc_content = ntc_content;
	}


	public String getNtc_moddate() {
		return ntc_moddate;
	}


	public void setNtc_moddate(String ntc_moddate) {
		this.ntc_moddate = ntc_moddate;
	}


	public int getNtc_no() {
		return ntc_no;
	}


	public void setNtc_no(int ntc_no) {
		this.ntc_no = ntc_no;
	}


	public String getNtc_regdate() {
		return ntc_regdate;
	}


	public void setNtc_regdate(String ntc_regdate) {
		this.ntc_regdate = ntc_regdate;
	}


	public String getNtc_title() {
		return ntc_title;
	}


	public void setNtc_title(String ntc_title) {
		this.ntc_title = ntc_title;
	}




	public String getNtc_editdate() {
		return ntc_editdate;
	}




	public void setNtc_editdate(String ntc_editdate) {
		this.ntc_editdate = ntc_editdate;
	}



	public List<FileModel> getFilesInfo() {
		return filesInfo;
	}



	public void setFilesInfo(List<FileModel> filesInfo) {
		this.filesInfo = filesInfo;
	}



	
	
	
	
	
	

	
	

}
