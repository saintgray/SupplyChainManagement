package kr.happyjob.study.cmg.model;

import java.util.Date;

public class EquipmentModel {

	private int row_num;
	private int room_No;		// 강의실 번호
	private int equi_No;		// 장비 번호
	private String equi_Nm;		// 장비명
	private int equi_Cnt;		// 갯수
	private String equi_Etc;	// 비고
	
	public int getRow_num() {
		return row_num;
	}
	public void setRow_num(int row_num) {
		this.row_num = row_num;
	}
	public int getRoom_No() {
		return room_No;
	}
	public void setRoom_No(int room_No) {
		this.room_No = room_No;
	}
	public int getEqui_No() {
		return equi_No;
	}
	public void setEqui_No(int equi_No) {
		this.equi_No = equi_No;
	}
	public String getEqui_Nm() {
		return equi_Nm;
	}
	public void setEqui_Nm(String equi_Nm) {
		this.equi_Nm = equi_Nm;
	}
	public int getEqui_Cnt() {
		return equi_Cnt;
	}
	public void setEqui_Cnt(int equi_Cnt) {
		this.equi_Cnt = equi_Cnt;
	}
	public String getEqui_Etc() {
		return equi_Etc;
	}
	public void setEqui_Etc(String equi_Etc) {
		this.equi_Etc = equi_Etc;
	}
	
	@Override
	public String toString() {
		return "EquipmentModel [room_No=" + room_No + ", equi_No=" + equi_No + ", equi_Nm=" + equi_Nm + ", equi_Cnt="
				+ equi_Cnt + ", equi_Etc=" + equi_Etc + "]";
	}
	
	

}