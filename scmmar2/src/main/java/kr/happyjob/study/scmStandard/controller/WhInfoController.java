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

import kr.happyjob.study.scmStandard.model.WhInfoModel;
import kr.happyjob.study.scmStandard.service.WhInfoService;
import kr.happyjob.study.system.model.ComnCodUtilModel;


@Controller
@RequestMapping("/scmStandard/")
public class WhInfoController {
	
	@Autowired
	WhInfoService warehouseInfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	   
	
	/**
	 * 창고정보 관리 초기화면
	 */
	@RequestMapping("warehouseInfo.do")
	public String initWarehouseInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initWarehouseInfo");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initWarehouseInfo");

		return "scmStandard/whInfo";
	}
	
	
	/**
	 * 창고정보 조회
	 */
	@RequestMapping("listWarehouseInfo.do")
	public String listWarehouseInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listWarehouseInfo");
		logger.info("   - paramMap : " + paramMap);		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);		
		
		// 창고정보 목록 조회
		List<WhInfoModel> listWarehouseInfoModel = warehouseInfoService.listWarehouseInfo(paramMap);
		model.addAttribute("listWarehouseInfoModel", listWarehouseInfoModel);
		
		// 창고정보 목록 카운트 조회
		int totalCount = warehouseInfoService.countListWarehouseInfo(paramMap);
		model.addAttribute("totalCntWarehouseInfo", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageWarehouseInfo",currentPage);		
		
		logger.info("+ End " + className + ".listWarehouseInfo");
		

		return "/scmStandard/whInfoList";
	}	
	
	/**
	 *  창고정보 단건 조회
	 */
	@RequestMapping("selectWarehouseInfo.do")
	@ResponseBody
	public Map<String, Object> selectWarehouseInfo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectWarehouseInfo");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 창고정보 단건 조회
		WhInfoModel warehouseInfoModel = warehouseInfoService.selectWarehouseInfo(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("warehouseInfoModel", warehouseInfoModel);
		
		logger.info("+ End " + className + ".selectWarehouseInfo");
		
		return resultMap;
	}
	
	
	/**
	 *  창고정보 저장
	 */
	@RequestMapping("saveWarehouseInfo.do")
	//Map 형태 redirect안할때 씀 즉 값만 바꾸겠다.라는 이야기
	@ResponseBody
	public Map<String, Object> saveWarehouseInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveWarehouseInfo");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		
		// 창고정보 설정
//		paramMap.put("fst_rgst_sst_id", session.getAttribute("loginId"));
		paramMap.put("fnl_mdfr_sst_id", session.getAttribute("loginId"));
		if ("I".equals(action)) {
			// 창고정보 신규 저장
			warehouseInfoService.insertWarehouseInfo(paramMap);
		} else if("U".equals(action)) {
			// 창고정보 수정 저장
			warehouseInfoService.updateWarehouseInfo(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveWarehouseInfo");
		
		return resultMap;
	}
	
	/**
	 *  창고정보 삭제
	 */
	@RequestMapping("deleteWarehouseInfo.do")
	@ResponseBody
	public Map<String, Object> deleteWarehouseInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteWarehouseInfo");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 창고정보 삭제
		warehouseInfoService.deleteWarehouseInfo(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteWarehouseInfo");
		
		return resultMap;
	}
	
	/**
	 * 창고 담당자 목록 조회
	 */
	@RequestMapping("mgrnmList.do")
	@ResponseBody
	public Map<String, Object> mgrnmList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".mgrnmList");
		logger.info("   - paramMap : " + paramMap);		
		
		// 창고 담당자 목록 목록 조회
		List<ComnCodUtilModel> mgrnmList = warehouseInfoService.mgrnmList(paramMap);
//		request.setAttribute("mgrList", mgrnmList);
//		
//		logger.info("+ End " + className + ".mgrnmList");
		Map<String,Object> map=new HashMap<>();
		map.put("list", mgrnmList);

		return map;
	}	


}
