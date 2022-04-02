package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nexacro.sample.service.PcAdminService;
import com.nexacro.sample.service.impl.ibatis.PcAdminDAO;
import com.nexacro.sample.vo.PCListVO;
@Service
public class PcAdminServiceImpl implements PcAdminService {
	
	@Autowired
	PcAdminDAO pcAdminDAO;
	
	@Override
	public List<PCListVO> getPclist() {
		return pcAdminDAO.getList();
	}

	@Override
	public List<PCListVO> getAvailble() {
		return pcAdminDAO.getAvailble();
	}

	@Override
	public void setSeat(Map<String, Object> setMap) {
		pcAdminDAO.setSeat(setMap);
	}

	@Override
	public void setPcSeatUse(Map<String, Object> setMap) {
		pcAdminDAO.setPcSeatUse(setMap);
	}

}
