package kr.happyjob.study.scmStandard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scmStandard.model.UserInfoModel;
import kr.happyjob.study.scmStandard.service.UserInfoService;


@Controller
@RequestMapping("/scmStandard/")
public class UserInfoController {
	
	@Autowired
	UserInfoService userInfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	   
	
	/**
	 * 고객정보 관리 초기화면
	 */
	@RequestMapping("userInfo.do")
	public String initUserInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initUserInfo");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initUserInfo");

		return "scmStandard/userInfo";
	}
	
	
	/**
	 * 고객정보 조회
	 */
	@RequestMapping("listUserInfo.do")
	public String listUserInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listUserInfo");
		logger.info("   - paramMap : " + paramMap);		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);		
		
		// 고객정보 목록 조회
		List<UserInfoModel> listUserInfoModel = userInfoService.listUserInfo(paramMap);
		model.addAttribute("listUserInfoModel", listUserInfoModel);
		
		// 고객정보 목록 카운트 조회
		int totalCount = userInfoService.countListUserInfo(paramMap);
		model.addAttribute("totalCntUserInfo", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageUserInfo",currentPage);		
		
		logger.info("+ End " + className + ".listUserInfo");
		

		return "/scmStandard/userInfoList";
	}	
	
	/**
	 *  고객정보 단건 조회
	 */
	@RequestMapping("selectUserInfo.do")
	@ResponseBody
	public Map<String, Object> selectUserInfo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectUserInfo");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 공통 그룹 코드 단건 조회
		UserInfoModel userInfoModel = userInfoService.selectUserInfo(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("userInfoModel", userInfoModel);
		
		logger.info("+ End " + className + ".selectUserInfo");
		
		return resultMap;
	}
	
	
	/**
	 *  고객정보 저장
	 */
	@RequestMapping("saveUserInfo.do")
	//Map 형태 redirect안할때 씀 즉 값만 바꾸겠다.라는 이야기
	@ResponseBody
	public Map<String, Object> saveUserInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveUserInfo");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		
		// 사용자 정보 설정
//		paramMap.put("fst_rgst_sst_id", session.getAttribute("loginId"));
		paramMap.put("fnl_mdfr_sst_id", session.getAttribute("loginId"));
		if ("I".equals(action)) {
			// 그룹코드 신규 저장
			userInfoService.insertUserInfo(paramMap);
		} else if("U".equals(action)) {
			// 그룹코드 수정 저장
			userInfoService.updateUserInfo(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveUserInfo");
		
		return resultMap;
	}
	
	/**
	 *  고객정보 삭제
	 */
	@RequestMapping("deleteUserInfo.do")
	@ResponseBody
	public Map<String, Object> deleteUserInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteUserInfo");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 그룹코드 삭제
		userInfoService.deleteUserInfo(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteUserInfo");
		
		return resultMap;
	}

}
