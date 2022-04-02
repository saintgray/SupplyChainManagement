package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.sample.vo.PCListVO;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;
@Repository("PcAdminDAO")
public class PcAdminDAO extends NexacroIbatisAbstractDAO{

	@SuppressWarnings("unchecked")
	public List<PCListVO> getList() {
		return (List<PCListVO>) list("pcAdmin.pclist");
	}

	public List<PCListVO> getAvailble() {
		return (List<PCListVO>) list("pcAdmin.getAvailable");
	}

	public void setSeat(Map<String, Object> setMap) {
		insert("pcAdmin.setSeat", setMap);
		return;
	}

	public void setPcSeatUse(Map<String, Object> setMap) {
		 update("pcAdmin.setPcSeatUse", setMap);
		
	}
}
