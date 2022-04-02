package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.sample.vo.DetailCDVO;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("adminDAO")
public class AdminDAO extends NexacroIbatisAbstractDAO {

	/**********************************
	 * 그룹코드 처리
	 ************************************************/

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectCDListMap(Map<String, Object> gcdMap) {
		return (List<Map<String, Object>>) list("nexacroAdmin.selectMapList", gcdMap);
	}

	/* GRUPList insert,update,delete처리 START */
	public void GcodeinsertMap(Map<String, Object> groupUpdate) {
		insert("nexacroAdmin.GcdInsertMap", groupUpdate);
		return;
	}

	public void GcodeUpdateMap(Map<String, Object> groupUpdate) {
		update("nexacroAdmin.GcdUpdateMap", groupUpdate);
		return;
	}

	public void GcodeDeletetMap(Map<String, Object> groupUpdate) {
		delete("nexacroAdmin.GcdDeleteMap", groupUpdate);
		return;
	}
	/* GRUPList insert,update,delete처리 END */

	/**********************************
	 * 상세코드 처리
	 ************************************************/

	@SuppressWarnings("unchecked")
	public List<DetailCDVO> selectDCDListVO(String group_code) {
		return (List<DetailCDVO>) list("nexacroAdmin.DcdListVO", group_code);
	}

	/* DetailList insert,update,delete처리 START */

	public void DetailInsertMap(Map<String, Object> DetailUpdate) {
		insert("nexacroAdmin.DcdInsertMap", DetailUpdate);
		return;
	}

	public void DetailUpdateMap(Map<String, Object> DetailUpdate) {
		update("nexacroAdmin.DcdUpdateMap", DetailUpdate);
		return;
	}

	public void DetailDeleteMap(Map<String, Object> DetailUpdate) {
		delete("nexacroAdmin.DcdDeleteMap", DetailUpdate);
		return;
	}



}
