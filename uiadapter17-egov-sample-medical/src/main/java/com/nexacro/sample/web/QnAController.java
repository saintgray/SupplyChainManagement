package com.nexacro.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.nexacro.sample.service.QnAService;
import com.nexacro.uiadapter17.spring.core.NexacroException;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import com.nexacro17.xapi.data.DataSet;

@Controller
public class QnAController {
	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);

	@Autowired
	@Resource(name = "qnaService")
	private QnAService qnaService;

	@Resource
	private Validator validator;
	// 유효성 검사

	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		dataBinder.setValidator(this.validator);
	}

	/**Q&A 리스트 조회 **/

	@RequestMapping(value = "/QnAListSearch.do")
	public NexacroResult selectDataListMap(
			@ParamDataSet(name = "ds_search", required = false) Map<String, String> searchMap,
			HttpServletRequest request) throws NexacroException {

		List<Map<String, Object>> list = qnaService.QnAList(searchMap);
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_list", list);
		return result;
	};

	/**Q&A  등록 **/
	@RequestMapping(value = "/QnAInsertList.do")
	public NexacroResult QnAInsertListMap(@ParamDataSet(name = "ds_resultlist") Map<String, String> insertInfo
			                             ,@ParamVariable(name="LoginID",required=false) String LoginID) throws NexacroException {
		
		insertInfo.put("LoginID", LoginID);
		String wno = insertInfo.get("wno");
		
		if("".equals(wno) || wno == null) {
			// insert
			qnaService.QnAListInsert(insertInfo);
		} else {
			// update
			qnaService.QnAListUpdate(insertInfo);
		}		
 
		NexacroResult result = new NexacroResult();
		return result;
	}
	/**Q&A 삭제 **/
	@RequestMapping(value = "/QnADeleteList.do")
	public NexacroResult QnADeleteListMap(@ParamDataSet(name = "ds_resultlist") Map<String, String> deleteInfo
			                             ,@ParamVariable(name="LoginID",required=false) String LoginID) throws NexacroException {
		
		deleteInfo.put("LoginID", LoginID);
		String wno = deleteInfo.get("wno");
		
		if("".equals(wno) || wno == null) {
			// insert
			qnaService.QnAListInsert(deleteInfo);
		} else {
			// delete
			qnaService.QnAListDelete(deleteInfo);
		}		
 
		NexacroResult result = new NexacroResult();
		return result;
	}
	
	/**Q&A 팝업 창 **/
	@RequestMapping(value="/qnainfo.do")
	public NexacroResult QnApopupInfo(@ParamVariable(name="wno",required=false)String wno){
		
		Map<String,String> qnainfo = new HashMap<>();
		qnainfo.put("wno", wno);
			
		Map<String,Object> Qnapopinfo = qnaService.QnApopupInfo(qnainfo);
		NexacroResult result=new NexacroResult();
		result.addDataSet("ds_resultlist",Qnapopinfo);		
		
		return result;
	
	};
	

}
