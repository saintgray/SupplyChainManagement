package kr.happyjob.study.epc.model;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import net.sf.json.JSONObject;

public class RefundinfoDTO {

	
	String account_number;
	String account_holder;
	String bank_name;
	Integer purinf_id;
	Integer return_cnt;
	Integer rfinfo_id;
	ArrayList<Integer> checkedPurinfIdList;
	ArrayList<Integer> checkedReturnCntList;
	
	public String getAccount_holder() {
		return account_holder;
	}
	public String getBank_name() {
		return bank_name;
	}
	public Integer getPurinf_id() {
		return purinf_id;
	}
	public Integer getReturn_cnt() {
		return return_cnt;
	}
	public ArrayList<Integer> getCheckedPurinfIdList() {
		return checkedPurinfIdList;
	}
	public ArrayList<Integer> getCheckedReturnCntList() {
		return checkedReturnCntList;
	}
	
	public String getAccount_number() {
		return account_number;
	}
	public void setAccount_number(String account_number) {
		this.account_number = account_number;
	}
	public Integer getRfinfo_id() {
		return rfinfo_id;
	}
	public void setRfinfo_id(Integer rfinfo_id) {
		this.rfinfo_id = rfinfo_id;
	}
	public void setAccount_holder(String account_holder) {
		this.account_holder = account_holder;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public void setPurinf_id(Integer purinf_id) {
		this.purinf_id = purinf_id;
	}
	public void setReturn_cnt(Integer return_cnt) {
		this.return_cnt = return_cnt;
	}
	public void setCheckedPurinfIdList(ArrayList<Integer> checkedPurinfIdList) {
		this.checkedPurinfIdList = checkedPurinfIdList;
	}
	public void setCheckedReturnCntList(ArrayList<Integer> checkedReturnCntList) {
		this.checkedReturnCntList = checkedReturnCntList;
	}
	
	

	
}
