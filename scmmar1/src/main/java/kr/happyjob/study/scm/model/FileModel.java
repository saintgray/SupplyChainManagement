package kr.happyjob.study.scm.model;


/**
 * 
 * @author OJH
 *
 */
public class FileModel {
	

	private int file_no;	
	private String file_server_path; // 이미지 출력시 해당 경로로 보여줄 가상 파일 경로	
	private String file_local_path;	// 실제 디렉토리 경로(SVN 서버 Y:// ...)
	private String file_new_name; // UUID 로 만든 고유 파일명
	private String file_ofname; // 원본 파일명
	private int file_size;	
	private String foreignKey; // 어떤 테이블의 데이터에 대한 파일인지 구분하기위한 참조하고 있는 테이블의 PK값
	private String file_exts;	// 확장자
	
	
	public FileModel() {
		
	}


	public FileModel(String file_server_path, String file_local_path, String file_new_name,
			String file_ofname, int file_size, String foreignKey, String file_exts) {
		
		this.file_server_path = file_server_path;
		this.file_local_path = file_local_path;
		this.file_new_name = file_new_name;
		this.file_ofname = file_ofname;
		this.file_size = file_size;
		this.foreignKey = foreignKey;
		this.file_exts = file_exts;
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


	public String getForeignKey() {
		return foreignKey;
	}


	public void setForeignKey(String foreignKey) {
		this.foreignKey = foreignKey;
	}


	public String getFile_exts() {
		return file_exts;
	}


	public void setFile_exts(String file_exts) {
		this.file_exts = file_exts;
	}
	
	
	@Override
	public boolean equals(Object obj){
		
		boolean chk=false;
		
		if(obj instanceof FileModel){
			FileModel fm= (FileModel)obj;
			if(this.file_no==fm.getFile_no()){
				chk=true;
			}
		}
		
		return chk;
	}
	
	
	
	
}
