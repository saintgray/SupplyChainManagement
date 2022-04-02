package com.nexacro.sample.web;


import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import com.nexacro.sample.service.AdminService;
import com.nexacro.sample.vo.DetailCDVO;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;


/**
 * <pre>
 * 
 * @title
 * @desc 관리자 공통코드 처리. - Controller Login Class
 * @package com.nexacro.sample.web
 * 
 *          <pre>
 * @author 이미혜
 * @since 2019. 9. 16.
 * @version 1.0
 * 
 * 
 */

@Controller
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	@Resource(name = "adminService")
	private AdminService adminService;

	@Resource
	private Validator validator;
	// 유효성 검사?

	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		dataBinder.setValidator(this.validator);
	};
	/*********************************************그룹코드**************************************************************/
	@RequestMapping(value = "/comcodelist.do")
	public NexacroResult selectMap(@ParamDataSet(name = "ds_Search", required = false) Map<String, Object> searchMap) {
		List<Map<String, Object>> list = adminService.selectCDListMap(searchMap);
		NexacroResult result = new NexacroResult();
		//System.out.println(list.size());
		result.addDataSet("ds_GroupCD", list);
		return result;
	};

	@RequestMapping(value = "/GruopCDupdateMap.do")
	public NexacroResult GruopInsert(@ParamDataSet(name = "ds_ResultGroupCD", required = false) List<Map<String, Object>> groupUpdate) {
		adminService.GcodeUpdateMap(groupUpdate);
		NexacroResult result = new NexacroResult();
		return result;
	};
	
	/********************************************상세코드**************************************************************/
	@RequestMapping(value="/detailCDlist.do")
	public NexacroResult DetailCDListVO(@ParamVariable(name="group_code",required=false)String group_code){
		System.out.println("controller send=========================="+group_code);
		List<DetailCDVO> selectDListVO=adminService.DetailCDVO(group_code);
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_ResultDetailCD",selectDListVO);
		return result;
	};
	
	@RequestMapping(value = "/DetailCDupdateMap.do")
	public NexacroResult DetailInsert(@ParamDataSet(name = "ds_ResultDetailCD", required = false)List<Map<String, Object>> DetailUpdate) {
	
		adminService.DetailUpdate(DetailUpdate);
		NexacroResult result = new NexacroResult();	
	
		return result;
	};




}
