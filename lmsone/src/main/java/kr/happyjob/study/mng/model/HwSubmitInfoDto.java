package kr.happyjob.study.mng.model;

import java.util.Date;

public class HwSubmitInfoDto {
	
	private String hw_Subject;
	private String name;
	private Date hw_Date;
	private String file_Name;
	private int hw_Submit_No;
	private int file_No;
	public HwSubmitInfoDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public HwSubmitInfoDto(String hw_Subject, String name, Date hw_Date, String file_Name, int hw_Submit_No,
			int file_No) {
		super();
		this.hw_Subject = hw_Subject;
		this.name = name;
		this.hw_Date = hw_Date;
		this.file_Name = file_Name;
		this.hw_Submit_No = hw_Submit_No;
		this.file_No = file_No;
	}
	public String getHw_Subject() {
		return hw_Subject;
	}
	public void setHw_Subject(String hw_Subject) {
		this.hw_Subject = hw_Subject;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getHw_Date() {
		return hw_Date;
	}
	public void setHw_Date(Date hw_Date) {
		this.hw_Date = hw_Date;
	}
	public String getFile_Name() {
		return file_Name;
	}
	public void setFile_Name(String file_Name) {
		this.file_Name = file_Name;
	}
	public int getHw_Submit_No() {
		return hw_Submit_No;
	}
	public void setHw_Submit_No(int hw_Submit_No) {
		this.hw_Submit_No = hw_Submit_No;
	}
	public int getFile_No() {
		return file_No;
	}
	public void setFile_No(int file_No) {
		this.file_No = file_No;
	}
	@Override
	public String toString() {
		return "HwSubmitInfoDto [hw_Subject=" + hw_Subject + ", name=" + name + ", hw_Date=" + hw_Date + ", file_Name="
				+ file_Name + ", hw_Submit_No=" + hw_Submit_No + ", file_No=" + file_No + "]";
	}
	
	

}
