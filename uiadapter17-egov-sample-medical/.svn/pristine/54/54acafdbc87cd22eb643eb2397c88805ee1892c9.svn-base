package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nexacro.sample.service.CopJoinService;
import com.nexacro.sample.service.impl.ibatis.CopJoinDAO;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro17.xapi.data.DataSet;
import com.nexacro17.xapi.data.datatype.DataType;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("copjoinService")
public class CopJoinServiceImpl extends EgovAbstractServiceImpl implements CopJoinService{
  
	@Resource(name = "copJoinDAO")
    // Name 정의
    private CopJoinDAO copJoinDAO;
    
    
	@Override
	public int iddupchk(Map<String, String> copinfo) {
		// TODO Auto-generated method stub
		return copJoinDAO.iddupchk(copinfo);
	}


	@Override
	public void copReg(Map<String, String> copinfo) {
		// TODO Auto-generated method stub
		copJoinDAO.copReg(copinfo);
	}


	@Override
	public void copupdate(Map<String, String> copinfo) {
		// TODO Auto-generated method stub
		copJoinDAO.copupdate(copinfo);
	}


	

	/*******************************************기업회원 정보 조회***************************************/
	@Override
	public List<Map<String, String>> copINFO(Map<String, String> info) {
		return copJoinDAO.copINFOSelect(info);
	}




 
}
