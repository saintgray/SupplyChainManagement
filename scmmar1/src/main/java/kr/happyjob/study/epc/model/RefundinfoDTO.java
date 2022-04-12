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

	
	Integer account_number;
	String account_holder;
	String bank_name;
	Integer purinf_id;
	ArrayList<Integer> purinf_id_list;
	
	
	public int getAccount_number() {
		return account_number;
	}
	public String getAccount_holder() {
		return account_holder;
	}
	public String getBank_name() {
		return bank_name;
	}
	public int getPurinf_id() {
		return purinf_id;
	}
	public List<Integer> getPurinf_id_list() {
		return purinf_id_list;
	}
	public void setAccount_number(int account_number) {
		this.account_number = account_number;
	}
	public void setAccount_holder(String account_holder) {
		this.account_holder = account_holder;
	}
	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}
	public void setPurinf_id(int purinf_id) {
		this.purinf_id = purinf_id;
	}
	/*
	public void setPurinf_id_list(String purinf_id_list) throws ParseException {	//ajax에서 stringify 해서 보낼 경우
		ArrayList<Integer> result = new ArrayList<>();
		JSONParser parser = new JSONParser();
		JSONArray arr =  (JSONArray) parser.parse(purinf_id_list);
		result = arr;
		this.purinf_id_list = result;
	}
	*/

	public void setPurinf_id_list(ArrayList<Integer> purinf_id_list) {
		this.purinf_id_list = purinf_id_list;
	}
		
	
	@Override
	public String toString() {
		return "RefundinfoDTO [account_number=" + account_number + ", account_holder=" + account_holder + ", bank_name="
				+ bank_name + ", purinf_id=" + purinf_id + ", purinf_id_list=" + purinf_id_list + "]";
	}

	
}
