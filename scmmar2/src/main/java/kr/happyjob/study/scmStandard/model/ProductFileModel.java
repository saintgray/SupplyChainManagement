package kr.happyjob.study.scmStandard.model;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


public class ProductFileModel {
	
	// 장비코드
	private int pdcode;
	
	// 모델번호
	private String pdmdno;
	
	// 제품번호
	private int pdno;
	
	// 파일번호
	private int file_no;	
	
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
		return "ProductFileModel [pdcode=" + pdcode + ", pdmdno=" + pdmdno + ", pdno=" + pdno + ", file_no=" + file_no
				+ ", file_server_path=" + file_server_path + ", file_local_path=" + file_local_path
				+ ", file_relative_path=" + file_relative_path + ", file_new_name=" + file_new_name + ", file_ofname="
				+ file_ofname + ", file_size=" + file_size + ", file_exts=" + file_exts + "]";
	}

	public int getPdcode() {
		return pdcode;
	}

	public void setPdcode(int pdcode) {
		this.pdcode = pdcode;
	}

	public String getPdmdno() {
		return pdmdno;
	}

	public void setPdmdno(String pdmdno) {
		this.pdmdno = pdmdno;
	}

	public int getPdno() {
		return pdno;
	}

	public void setPdno(int pdno) {
		this.pdno = pdno;
	}

	public int getFile_no() {
		return file_no;
	}

	public void setFile_no(int file_no) {
		this.file_no = file_no;
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
