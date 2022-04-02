package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.nexacro.sample.service.QnAService;
import com.nexacro.sample.service.impl.ibatis.QnADAO;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro17.xapi.data.DataSet;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("qnaService")
public class QnAlistServiceImpl extends EgovAbstractServiceImpl implements QnAService {

	private Logger logger = LoggerFactory.getLogger(UiAdapterSampleServiceImpl.class);

	@Resource(name = "qnaDAO")
	// Name 정의
	private QnADAO qnaDAO;

	/**조회**/
	@Override
	public List<Map<String, Object>> QnAList(Map<String, String> searchMap) {

		return qnaDAO.QnAList(searchMap);
	}
	
	/**등록**/
	@Override
	public void QnAListInsert(Map<String, String> insertInfo) {
		qnaDAO.QnAListInsert(insertInfo);
		return;
	}
	
	/**수정**/
	@Override
	public void QnAListUpdate(Map<String, String> updateInfo) {
		qnaDAO.QnAListUpdate(updateInfo);
		return;
	}
	/**삭제**/
	@Override
	public void QnAListDelete(Map<String, String> deleteInfo) {
		qnaDAO.QnAListDelete(deleteInfo);
		return;
	}	
	
	/**팝업창**/
	@Override
	public Map<String, Object> QnApopupInfo(Map<String, String> qnainfo) {
		return qnaDAO.QnApopupInfo(qnainfo);
	}

	

}
