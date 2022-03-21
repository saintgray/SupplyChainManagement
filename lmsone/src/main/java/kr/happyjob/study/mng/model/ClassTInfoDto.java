package kr.happyjob.study.mng.model;

import java.util.Date;

public class ClassTInfoDto {
	
	private String class_Type;
	private String class_Nm;
	private String name;
	private Date class_Startdate;
	private Date class_Enddate;
	private int class_Cnt;
	private int class_Totalcnt;
	private int class_No;
	public ClassTInfoDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ClassTInfoDto(String class_Type, String class_Nm, String name, Date class_Startdate, Date class_Enddate,
			int class_Cnt, int class_Totalcnt, int class_No) {
		super();
		this.class_Type = class_Type;
		this.class_Nm = class_Nm;
		this.name = name;
		this.class_Startdate = class_Startdate;
		this.class_Enddate = class_Enddate;
		this.class_Cnt = class_Cnt;
		this.class_Totalcnt = class_Totalcnt;
		this.class_No = class_No;
	}
	public String getClass_Type() {
		return class_Type;
	}
	public void setClass_Type(String class_Type) {
		this.class_Type = class_Type;
	}
	public String getClass_Nm() {
		return class_Nm;
	}
	public void setClass_Nm(String class_Nm) {
		this.class_Nm = class_Nm;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getClass_Startdate() {
		return class_Startdate;
	}
	public void setClass_Startdate(Date class_Startdate) {
		this.class_Startdate = class_Startdate;
	}
	public Date getClass_Enddate() {
		return class_Enddate;
	}
	public void setClass_Enddate(Date class_Enddate) {
		this.class_Enddate = class_Enddate;
	}
	public int getClass_Cnt() {
		return class_Cnt;
	}
	public void setClass_Cnt(int class_Cnt) {
		this.class_Cnt = class_Cnt;
	}
	public int getClass_Totalcnt() {
		return class_Totalcnt;
	}
	public void setClass_Totalcnt(int class_Totalcnt) {
		this.class_Totalcnt = class_Totalcnt;
	}
	public int getClass_No() {
		return class_No;
	}
	public void setClass_No(int class_No) {
		this.class_No = class_No;
	}
	@Override
	public String toString() {
		return "ClassTInfoDto [class_Type=" + class_Type + ", class_Nm=" + class_Nm + ", name=" + name
				+ ", class_Startdate=" + class_Startdate + ", class_Enddate=" + class_Enddate + ", class_Cnt="
				+ class_Cnt + ", class_Totalcnt=" + class_Totalcnt + ", class_No=" + class_No + "]";
	}
	
	

}
