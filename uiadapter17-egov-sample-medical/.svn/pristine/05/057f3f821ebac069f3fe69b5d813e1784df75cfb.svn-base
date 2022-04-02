package com.nexacro.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.Validator;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.nexacro.sample.service.ProjectService;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;
import com.nexacro17.xapi.data.DataSet;

@Controller
public class ProjectInfoController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Autowired
	@Resource(name = "projectService")
	private ProjectService projectService;

	@Resource
	private Validator validator;
	// 유효성 검사?

	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		dataBinder.setValidator(this.validator);
	}

	/**********************************************
	 * 프로젝트 목록
	 **********************************************************/


	@RequestMapping(value = "/ProList.do")
	public NexacroResult ProjectList(@ParamDataSet(name = "ds_ProSearch", required = false) Map<String, String> Proinfo) {
		System.out.println("!!!!!!!!!!!!" + Proinfo.get("user_type"));
	
		List<Map<String, String>> ProList = projectService.ProjectList(Proinfo);		
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_ProList", ProList);
		return result;

	}

	/******************************************프로젝트 등록 ********************************************************/

	@RequestMapping(value = "/ProjectInfoInsert.do")
	public NexacroResult ProjectInfoInsert(
			@ParamDataSet(name = "ds_ProjcetInfo", required = false) Map<String, String> insertInfo,
			@ParamDataSet(name = "ds_project_skill", required = false) List<Map<String, String>> skillInfo,
			@ParamVariable(name = "loginID") String loginID) {

		NexacroResult result = new NexacroResult();
		String projectID = insertInfo.get("projectId");
		insertInfo.put("loginID", loginID);
		if ("".equals(projectID) || projectID == null) {
			System.out.println("insert Project!!!!!!!!!!!!!!");
			try {
				projectService.ProcjetINFO_Insert(insertInfo);
				System.out.println("skillInfo!!!!!!!!!!!!!!" + skillInfo.size());
				for (int i = 0; i < skillInfo.size(); i++) {

					Map<String, String> item = skillInfo.get(i);
					item.put("loginID", loginID);
					projectService.ProcjetSkill_Insert(item);
				}
				result.setErrorCode(0);
				result.setErrorMsg("등록성공");
			} catch (Exception e) {
				System.out.println(e.getMessage());
				result.setErrorCode(-1);
				result.setErrorMsg("등록오류");
			}
		} else {

			try {
				System.out.println(" ProcjetSkill_Update START!!!!!!!!!!!!!!");
				projectService.ProcjetINFO_Update(insertInfo);
				projectService.ProcjetSkill_Delete(insertInfo);

				// System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+
				// skillInfo.get(0));
				for (int i = 0; i < skillInfo.size(); i++) {
					Map<String, String> item = skillInfo.get(i);
					int dataRowType = Integer.parseInt(String.valueOf(item.get(DataSetRowTypeAccessor.NAME)));
					logger.debug("..... dataRowType >>" + dataRowType);

					if (dataRowType == DataSet.ROW_TYPE_INSERTED) {
						item.put("projectId", insertInfo.get("projectId"));
						projectService.ProcjetSkill_Update(item);
						System.out.println(" ProcjetSkill_Update!!!!!!!!!!!!!!");
					}
				}
				result.setErrorCode(0);
				result.setErrorMsg("수정성공");
			} catch (Exception e) {
				result.setErrorCode(-1);
				result.setErrorMsg("수정실패");
			}

		}

		return result;

	}// ProjectInfoInsert

	/******************************************프로젝트 상세보기******************************************************/
	@RequestMapping(value = "/ProjectDetail.do")
	public NexacroResult ProjectDetail(@ParamVariable(name = "projectId", required = false) String projectId) {
		//System.out.println("==============================" + projectId);
		Map<String, Object> INFO = projectService.ProcjetINFO(projectId);
		List<Map<String, String>> skill = projectService.projectSkill(projectId);

		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_ProjcetInfo", INFO);
		result.addDataSet("ds_project_skill", skill);
		return result;
	};
	
	/******************************************프로젝트 지원하기******************************************************/
	@RequestMapping(value = "/Project_aid.do")
	public NexacroResult ProjectDetail(@ParamVariable(name = "loginID", required = false) String loginId
									  ,@ParamVariable(name = "projectId", required = false) String projectId) {
		//System.out.println("=============================="+projectId+"!!!!!!!!"+loginId);
		Map<String, String> aid_info=new HashMap<String, String>();
		aid_info.put("loginId", loginId);
		aid_info.put("projectId", projectId);
		projectService.insert_aidINFO(aid_info);
		NexacroResult result = new NexacroResult();
		return result;
	};
	
	//------------------------------로그인한 기업이 작성한 프로젝트 list 
	@RequestMapping(value = "/co_ProList.do")
	public NexacroResult co_ProList(@ParamVariable(name = "loginID", required = false) String loginID) {
		System.out.println("프로젝트 작성한 기업 : " + loginID);
		
		List<Map<String, String>> ProList = projectService.CoProjectList(loginID);		
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_ProList", ProList);
		return result;
	};
	
	//------------------------------로그인한 기업이 작성한 프로젝트 플젝명, 마감일, 지원자수 list =========수정
	@RequestMapping(value = "/cop_appli_ProList.do")
	public NexacroResult cop_appli_ProList(@ParamDataSet(name = "ds_Search", required = false) Map<String, String> Proinfo, @ParamVariable(name = "loginID", required = false) String loginID) {
		
		System.out.println("프로젝트 작성한 기업222 : " + loginID);
		
		Proinfo.put("loginID",loginID);
		
		List<Map<String, String>> AppProList = projectService.CoAppProjectList(Proinfo);		
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_ProList", AppProList);
		return result;
	};
	
	//------------------------------일반(개발자)회원이 지원한 프로젝트 리스트 =========수정
	@RequestMapping(value = "/aidList.do")
	public NexacroResult aidList(@ParamDataSet(name = "ds_Search", required = false) Map<String, String> Userinfo, @ParamVariable(name = "loginID") String loginID) {
		
		System.out.println("aidList 지원한 프로젝트 지원자id : " + loginID);
		
		System.out.println(Userinfo);
		
		Userinfo.put("loginID",loginID);
		
		System.out.println(Userinfo);
		
		List<Map<String, String>> AidProList = projectService.aidProjectList(Userinfo);		
		NexacroResult result = new NexacroResult();
		result.addDataSet("User_projectList", AidProList);
		return result;
	};
	
	
	//------------------------------로그인한 기업이 올린 프로젝트 지원자 리스트
	@RequestMapping(value = "/proUserList.do")
	public NexacroResult proUserList(@ParamVariable(name = "projectId", required = false) String projectId) {
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa프로젝트 id : " + projectId);
	
		List<Map<String, String>> AidUserProList = projectService.aidUserProjectList(projectId);		
		NexacroResult result = new NexacroResult();
		result.addDataSet("ds_AidUserList", AidUserProList);
		return result;
	};
	
	//---------------------------일반회원 - 지원취소
	@RequestMapping(value = "/appliCancel.do")
	public NexacroResult aiappliCanceldList(@ParamVariable(name = "loginID", required = false) String loginID
											,@ParamVariable(name = "projectId", required = false) String projectId) {
		System.out.println("지원취소할 프로젝트id : " + projectId);
		System.out.println("지원취소하는 회원id : " + loginID);
		
		Map<String,String> info=new HashMap<>();
    	info.put("loginID", loginID);
    	info.put("projectId", projectId);
		
		projectService.appliCancel(info);		
		NexacroResult result = new NexacroResult();
		return result;
	};
	

};// PROJECT CONTROLLER
