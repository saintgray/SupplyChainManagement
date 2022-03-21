package kr.happyjob.study.system.model;

import java.util.Date;

import lombok.Data;


public class NoticeDTO {
	
	private int board_No;
	private String loginID;
	private String board_Nm;
	private String board_Content;
	private Date board_Date;
	private String board_Type;
	private int view_Cnt;
	
	
	
	public NoticeDTO(int board_No, String loginID, String board_Nm, String board_Content, Date board_Date,
			String board_Type, int view_Cnt) {
		super();
		this.board_No = board_No;
		this.loginID = loginID;
		this.board_Nm = board_Nm;
		this.board_Content = board_Content;
		this.board_Date = board_Date;
		this.board_Type = board_Type;
		this.view_Cnt = view_Cnt;
	}
	public NoticeDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getBoard_No() {
		return board_No;
	}
	public void setBoard_No(int board_No) {
		this.board_No = board_No;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getBoard_Nm() {
		return board_Nm;
	}
	public void setBoard_Nm(String board_Nm) {
		this.board_Nm = board_Nm;
	}
	public String getBoard_Content() {
		return board_Content;
	}
	public void setBoard_Content(String board_Content) {
		this.board_Content = board_Content;
	}
	public Date getBoard_Date() {
		return board_Date;
	}
	public void setBoard_Date(Date board_Date) {
		this.board_Date = board_Date;
	}
	public String getBoard_Type() {
		return board_Type;
	}
	public void setBoard_Type(String board_Type) {
		this.board_Type = board_Type;
	}
	public int getView_Cnt() {
		return view_Cnt;
	}
	public void setView_Cnt(int view_Cnt) {
		this.view_Cnt = view_Cnt;
	}
	@Override
	public String toString() {
		return "NoticeDTO [board_No=" + board_No + ", loginID=" + loginID + ", board_Nm=" + board_Nm
				+ ", board_Content=" + board_Content + ", board_Date=" + board_Date + ", board_Type=" + board_Type
				+ ", view_Cnt=" + view_Cnt + "]";
	}
	
	
	
}
