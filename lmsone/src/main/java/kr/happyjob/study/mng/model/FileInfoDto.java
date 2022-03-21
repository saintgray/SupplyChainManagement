package kr.happyjob.study.mng.model;

public class FileInfoDto {
	
	private int file_No;
	private String file_Name;
	private String file_Title;
	private String file_Root;
	private String 	file_Addr;
	private int file_Size;
	private String file_Writer;
	public FileInfoDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public FileInfoDto(int file_No, String file_Name, String file_Title, String file_Root, String file_Addr,
			int file_Size, String file_Writer) {
		super();
		this.file_No = file_No;
		this.file_Name = file_Name;
		this.file_Title = file_Title;
		this.file_Root = file_Root;
		this.file_Addr = file_Addr;
		this.file_Size = file_Size;
		this.file_Writer = file_Writer;
	}
	
	
	
	public FileInfoDto(String file_Name, String file_Root) {
		super();
		this.file_Name = file_Name;
		this.file_Root = file_Root;
	}
	
	
	public FileInfoDto(String file_Name, String file_Title, String file_Root) {
		super();
		this.file_Name = file_Name;
		this.file_Title = file_Title;
		this.file_Root = file_Root;
	}
	public int getFile_No() {
		return file_No;
	}
	public void setFile_No(int file_No) {
		this.file_No = file_No;
	}
	public String getFile_Name() {
		return file_Name;
	}
	public void setFile_Name(String file_Name) {
		this.file_Name = file_Name;
	}
	public String getFile_Title() {
		return file_Title;
	}
	public void setFile_Title(String file_Title) {
		this.file_Title = file_Title;
	}
	public String getFile_Root() {
		return file_Root;
	}
	public void setFile_Root(String file_Root) {
		this.file_Root = file_Root;
	}
	public String getFile_Addr() {
		return file_Addr;
	}
	public void setFile_Addr(String file_Addr) {
		this.file_Addr = file_Addr;
	}
	public int getFile_Size() {
		return file_Size;
	}
	public void setFile_Size(int file_Size) {
		this.file_Size = file_Size;
	}
	public String getFile_Writer() {
		return file_Writer;
	}
	public void setFile_Writer(String file_Writer) {
		this.file_Writer = file_Writer;
	}
	@Override
	public String toString() {
		return "FileInfoDto [file_No=" + file_No + ", file_Name=" + file_Name + ", file_Title=" + file_Title
				+ ", file_Root=" + file_Root + ", file_Addr=" + file_Addr + ", file_Size=" + file_Size
				+ ", file_Writer=" + file_Writer + "]";
	}
	
	
	
}
