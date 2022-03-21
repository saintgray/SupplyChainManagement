package kr.happyjob.study.jmg.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import kr.happyjob.study.jmg.model.ResumeAwardInfoDto;
import kr.happyjob.study.jmg.model.ResumeCareerInfoDto;
import kr.happyjob.study.jmg.model.ResumeClassInfoDto;
import kr.happyjob.study.jmg.model.ResumeUserInfoDto;
import kr.happyjob.study.jmg.service.ResumeService;
import kr.happyjob.study.mng.model.ClassListUserInfoDto;
import kr.happyjob.study.system.model.PagingVo;

@Controller
@RequestMapping("/jmg/")
public class ResumeController {

	@Autowired
	private ResumeService resumeService;
	
	@RequestMapping("resumeMgt.do")
	public String resumeStart(){
		
		
		return "jmg/resume";
		
	}
	
	@RequestMapping("resumeAllClassList.do")
	@ResponseBody
	public Map<String, Object> selectAllClassList(int nowPage, String searchKeyword,@SessionAttribute("loginId") String loginID) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		int allClassListCnt;
		List<ResumeClassInfoDto> allClassList = null;
		PagingVo allClassListPaging = null;
		RowBounds rb = null;
		String keyword = null;
		if(searchKeyword==null||searchKeyword.trim()==""){
			keyword = "%%";
		}else{
			keyword = "%"+searchKeyword+"%";
		}
		allClassListCnt = resumeService.selectAllClassListCnt(keyword);
		allClassListPaging = new PagingVo(allClassListCnt, nowPage, 10, 10);
		rb = new RowBounds(allClassListPaging.getStart()-1, allClassListPaging.getCntPerPage());
		allClassList = resumeService.selectAllClassList(keyword,rb);
		
		resultMap.put("allClassList", allClassList);
		resultMap.put("allClassListPaging", allClassListPaging);
		
		return resultMap;
		
		
	}
	
	@RequestMapping("resumeUserList.do")
	@ResponseBody
	public Map<String, Object> selectUserList(int class_No,int nowPage) throws Exception{
		
		List<ResumeUserInfoDto> resumeUserList = null;
		int resumeUserListCnt;
		RowBounds rb = null;
		PagingVo resumeUserListPaging = null;
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		resumeUserListCnt = resumeService.selectResumeUserListCnt(class_No);
		resumeUserListPaging = new PagingVo(resumeUserListCnt, nowPage, 5, 10);
		rb = new RowBounds(resumeUserListPaging.getStart()-1, resumeUserListPaging.getCntPerPage());
		resumeUserList = resumeService.selectResumeUserList(class_No, rb);
		
		resultMap.put("resumeUserListPaging", resumeUserListPaging);
		resultMap.put("resumeUserList", resumeUserList);
		
		
		
		return resultMap;
		
		
		
		
		
	}
	
	@RequestMapping("resumeUser.do")
	@ResponseBody
	public ResumeUserInfoDto selectUser(String loginID) throws Exception{
		
		ResumeUserInfoDto user = null;
		
		
		
		user = resumeService.selectUser(loginID);
		
		
		
		
		return user;	
		
		
		
	}
	@RequestMapping("resumeUserClassList.do")
	@ResponseBody
	public Map<String, Object> selectUserClassList(String loginID,int nowPage) throws Exception{
		

		List<ResumeClassInfoDto> userClassList = null;
		int userClassListCnt;
		RowBounds rb = null;
		PagingVo userClassListPaging = null;
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		userClassListCnt = resumeService.selectUserClassListCnt(loginID);
		userClassListPaging = new PagingVo(userClassListCnt, nowPage, 5, 10);
		rb = new RowBounds(userClassListPaging.getStart()-1, userClassListPaging.getCntPerPage());
		userClassList = resumeService.selectUserClassList(loginID, rb);
		
		resultMap.put("userClassList", userClassList);
		resultMap.put("userClassListPaging", userClassListPaging);
		
		
		
		return resultMap;
		
		
		
		
		
	}
	@RequestMapping("resumeUserAwardList.do")
	@ResponseBody
	public Map<String, Object> selectUserAwardList(String loginID,int nowPage) throws Exception{
		
		List<ResumeAwardInfoDto> userAwardList = null;
		int userAwardListCnt;
		RowBounds rb = null;
		PagingVo userAwardListPaging = null;
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		userAwardListCnt = resumeService.selectUserAwardListCnt(loginID);
		userAwardListPaging = new PagingVo(userAwardListCnt, nowPage, 5, 10);
		rb = new RowBounds(userAwardListPaging.getStart()-1, userAwardListPaging.getCntPerPage());
		userAwardList = resumeService.selectUserAwardList(loginID, rb);
		
		resultMap.put("userAwardListPaging", userAwardListPaging);
		resultMap.put("userAwardList", userAwardList);
		
		
		
		return resultMap;
		
		
		
		
		
	}
	
	@RequestMapping("resumeUserCareerList.do")
	@ResponseBody
	public Map<String, Object> selectUserCareerList(String loginID,int nowPage) throws Exception{
		
		List<ResumeCareerInfoDto> userCareerList = null;
		int userCareerListCnt;
		RowBounds rb = null;
		PagingVo userCareerListPaging = null;
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		userCareerListCnt = resumeService.selectUserCareerListCnt(loginID);
		userCareerListPaging = new PagingVo(userCareerListCnt, nowPage, 5, 10);
		rb = new RowBounds(userCareerListPaging.getStart()-1, userCareerListPaging.getCntPerPage());
		userCareerList = resumeService.selectUserCareerList(loginID, rb);
		
		resultMap.put("userCareerListPaging", userCareerListPaging);
		resultMap.put("userCareerList", userCareerList);
		
		
		
		return resultMap;
		
		
		
		
		
	}
	
	
	
}
