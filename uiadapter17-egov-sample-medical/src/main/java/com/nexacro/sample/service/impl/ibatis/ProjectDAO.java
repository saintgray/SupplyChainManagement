package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;




@Repository("projectDAO")
public class ProjectDAO extends NexacroIbatisAbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, String>> ProjectList(Map<String, String> Proinfo) {
		return (List<Map<String, String>>) list("project.ProjectList",Proinfo);
	}

	/*******************************새로운 프로젝트 등록  ******************************************/
	public void ProcjetINFO_Insert(Map<String, String> insertInfo) {
		 insert("project.projectInsert", insertInfo);
	}


	public void ProcjetSkill_Insert(Map<String, String> skillInfo) {
		 insert("project.projectSkillInsert", skillInfo);
		
	}
	/*******************************프로젝트 수정처리******************************************/
	public void ProcjetINFO_Update(Map<String, String> insertInfo) {
		 update("project.projectINFOUpdate", insertInfo);	
			
	}
	
	public void ProcjetSkill_Delete(Map<String, String> skillInfo) {
		 delete("project.projectSkilldelete",skillInfo);	
	}
	
	public void ProcjetSkill_Update(Map<String, String> skillInfo) {
		 update("project.projectSkillUpdate", skillInfo);	
	}

	
	
	
	

	/*******************************프로젝트 상세정보******************************************/
	@SuppressWarnings("unchecked")
	public Map<String, Object> ProjectINFO_read(String projectId) {
		return (Map<String, Object>) select("project.projectINFO",projectId);
	}


	@SuppressWarnings("unchecked")
	public List<Map<String, String>> ProjectSkill_read(String projectId) {
		return (List<Map<String, String>>) list("project.projectSkill",projectId);
	}

	public void Prj_aid_insert(Map<String, String> aid_info) {
				insert("Prj_aid_insert",aid_info);
	}

	//로그인한 회사의 프로젝트list
	public List<Map<String, String>> CoProjectList(String loginID) {
		return (List<Map<String, String>>) list("project.CoProjectList",loginID);
	}

	//로그인한 회사의 프로젝트명, 마감일, 지원자수
	public List<Map<String, String>> CoAppProjectList(Map<String, String> proinfo) {
		return (List<Map<String, String>>) list("project.CoAppProjectList",proinfo);
	}

	//일반회원이 지원한 프로젝트list
	public List<Map<String, String>> AidProjectList(Map<String, String> userinfo) {
		return (List<Map<String, String>>) list("project.AidProjectList",userinfo);
	}

	//프로젝트 지원자 list
	public List<Map<String, String>> AidUserProjectList(String projectId) {
		return (List<Map<String, String>>) list("project.AidUserList",projectId);
	}

	//프로젝트 지원 취소
	public void appliCancel(Map<String, String> info) {
		delete("project.appliCancel",info);
	}


	
	

};
