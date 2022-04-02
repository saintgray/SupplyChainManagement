package com.nexacro.sample.service;

import java.util.List;
import java.util.Map;

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
 * @since 2019. 9. 26
 * @version 1.0
 * @see =================== 변경 내역 ================== 날짜 변경자 내용
 *      ------------------------------------------------
 * 
 */

public interface ProjectService {
	List<Map<String, String>> ProjectList(Map<String, String> Proinfo);
/*******************************프로젝트 신규등록******************************************/
	void ProcjetINFO_Insert(Map<String, String> insertInfo);
	void ProcjetSkill_Insert(Map<String, String> skillInfo);
	
	void ProcjetINFO_Update(Map<String, String> insertInfo);
	void ProcjetSkill_Delete(Map<String, String> skillInfo);
	void ProcjetSkill_Update(Map<String, String> skillInfo);


/*******************************프로젝트 상세정보******************************************/
	Map<String, Object> ProcjetINFO (String projectId);
	List<Map<String, String>> projectSkill(String projectId);
	void insert_aidINFO(Map<String, String> aid_info);
	
	//---------로그인한 회사의 프로젝트list
	List<Map<String, String>> CoProjectList(String loginID);
	
	//----------로그인한 회사의 프로젝트명, 지원자수, 마감일list
	List<Map<String, String>> CoAppProjectList(Map<String, String> proinfo);
	
	//-------------일반 회원이 지원한 프로젝트 리스트
	List<Map<String, String>> aidProjectList(Map<String, String> userinfo);
	
	//프로젝트 지원자 리스트
	List<Map<String, String>> aidUserProjectList(String projectId);
	
	//프로젝틎원 취소
	void appliCancel(Map<String, String> info);
	




	
	

}
