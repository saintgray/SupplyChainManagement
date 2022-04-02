package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.sample.vo.LoginVO;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("copJoinDAO")
public class CopJoinDAO extends NexacroIbatisAbstractDAO {


	public int iddupchk(Map<String, String> copinfo) {
		// TODO Auto-generated method stub
		return (int) select("cop.iddupchk", copinfo);
	}
	
	public void copReg(Map<String, String> copinfo) {
		// TODO Auto-generated method stub
		insert("copjoin.copReg", copinfo);
        
    	
       		
	}
	public void copupdate(Map<String, String> copinfo) {
		// TODO Auto-generated method stub
		update("cop.copupdate", copinfo);
		
		return;
	}
	


	
	/*******************************************기업회원 정보 조회***************************************/
	@SuppressWarnings("unchecked")
	public List<Map<String, String>> copINFOSelect(Map<String, String> info) {
		//System.out.println("DAO!!!!!!!!!!!!userid"+info.get("userID"));
		return (List<Map<String, String>>) list("cop.readINFO",info);
	}





}
