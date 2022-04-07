package kr.happyjob.study.notice.model;

public class FileModel {
	
	private String file_no;
	private String file_server_path;
	private String file_local_path;
	private String file_relative_path;
	private String file_new_name;
	private String file_ofname;
	private String file_size;
	private String sales_id;
	private String loginID;
	
	
	public FileModel() {

	}


	public FileModel(String file_no, String file_server_path, String file_local_path, String file_relative_path,
			String file_new_name, String file_ofname, String file_size, String sales_id, String loginID) {
		
		this.file_no = file_no;
		this.file_server_path = file_server_path;
		this.file_local_path = file_local_path;
		this.file_relative_path = file_relative_path;
		this.file_new_name = file_new_name;
		this.file_ofname = file_ofname;
		this.file_size = file_size;
		this.sales_id = sales_id;
		this.loginID = loginID;
	}


	public String getFile_no() {
		return file_no;
	}


	public void setFile_no(String file_no) {
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


	public String getFile_size() {
		return file_size;
	}


	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}


	public String getSales_id() {
		return sales_id;
	}


	public void setSales_id(String sales_id) {
		this.sales_id = sales_id;
	}


	public String getLoginID() {
		return loginID;
	}


	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	
	
	
	

}
