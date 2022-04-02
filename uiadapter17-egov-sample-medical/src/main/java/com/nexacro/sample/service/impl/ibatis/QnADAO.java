package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("qnaDAO")
public class QnADAO extends NexacroIbatisAbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> QnAList(Map<String, String> searchMap) {

		return (List<Map<String, Object>>) list("qna.QnAList", searchMap);
	}

	@SuppressWarnings("unchecked")
	public void QnAListInsert(Map<String, String> insertInfo) {
		insert("qna.QnAListInsert", insertInfo);
		return;
	}

	@SuppressWarnings("unchecked")
	public void QnAListUpdate(Map<String, String> updateInfo) {
		insert("qna.QnAListUpdate", updateInfo);
		return;
	}

	@SuppressWarnings("unchecked")
	public void QnAListDelete(Map<String, String> deleteInfo) {
		delete("qna.QnAListDelete", deleteInfo);
		return;
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> QnApopupInfo(Map<String, String> qnainfo) {
		return (Map<String, Object>) select("qna.QnApopupInfo", qnainfo);
	}

}