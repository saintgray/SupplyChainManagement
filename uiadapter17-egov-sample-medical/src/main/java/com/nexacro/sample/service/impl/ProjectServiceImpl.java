package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.nexacro.sample.service.ProjectService;
import com.nexacro.sample.service.impl.ibatis.ProjectDAO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


/**
 * 
 * <pre>
 * 
 * @desc 공통코드.
 * @package com.nexacro.sample.service
 * 
 *          <pre>
 * 
 * @author 이미혜
 * @since 2019. 9. 26.
 * @version 1.0
 * @see =================== 변경 내역 ================== 날짜 변경자 내용
 *      ------------------------------------------------
 * 
 */
@Service("projectService")
public class ProjectServiceImpl extends EgovAbstractServiceImpl implements ProjectService {
	private Logger logger = LoggerFactory.getLogger(UiAdapterSampleServiceImpl.class);
	
	@Resource(name = "projectDAO")
	private ProjectDAO projectDAO;

	@Override
	public List<Map<String, String>> ProjectList(Map<String, String> Proinfo) {
		return projectDAO.ProjectList(Proinfo);
	}

	@Override
	public void ProcjetINFO_Insert(Map<String, String> insertInfo) {
		 projectDAO.ProcjetINFO_Insert(insertInfo);
	}

	@Override
	public void ProcjetSkill_Insert(Map<String, String> skillInfo) {
		 projectDAO.ProcjetSkill_Insert(skillInfo);
		
	}
	
	
	@Override
	public void ProcjetINFO_Update(Map<String, String> insertInfo) {
		projectDAO.ProcjetINFO_Update(insertInfo);
	}

	@Override
	public void ProcjetSkill_Delete(Map<String, String> skillInfo) {
		projectDAO.ProcjetSkill_Delete(skillInfo);
	}

	@Override
	public void ProcjetSkill_Update(Map<String, String> skillInfo) {
		projectDAO.ProcjetSkill_Update(skillInfo);
	}

	
	
	
	
	
	
	
	
	
	/*******************************프로젝트 상세정보******************************************/
	@Override
	public Map<String, Object> ProcjetINFO(String projectId) {
		return projectDAO.ProjectINFO_read(projectId);
	}

	@Override
	public List<Map<String, String>> projectSkill(String projectId) {
		return projectDAO.ProjectSkill_read(projectId);
	}

	@Override
	public void insert_aidINFO(Map<String, String> aid_info) {
		projectDAO.Prj_aid_insert(aid_info);
	}

	//로그인한 회사의 프로젝트
	@Override
	public List<Map<String, String>> CoProjectList(String loginID) {
		return projectDAO.CoProjectList(loginID);
	}

	//로그인한 회사 프로젝트명, 마감일, 지원자수
	@Override
	public List<Map<String, String>> CoAppProjectList(Map<String, String> proinfo) {
		return projectDAO.CoAppProjectList(proinfo);
	}

	//일반회원이 지원한 프로젝트 리스트
	@Override
	public List<Map<String, String>> aidProjectList(Map<String, String> userinfo) {
		return projectDAO.AidProjectList(userinfo);
	}

	//프로젝트 지원자 리스트
	@Override
	public List<Map<String, String>> aidUserProjectList(String projectId) {
		return projectDAO.AidUserProjectList(projectId);
	}

	//프로젝트 지원 취소
	@Override
	public void appliCancel(Map<String, String> info) {
		 projectDAO.appliCancel(info);
	}



}
