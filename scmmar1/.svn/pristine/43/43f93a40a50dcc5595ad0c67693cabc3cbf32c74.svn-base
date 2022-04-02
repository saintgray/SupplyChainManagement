package kr.happyjob.study.system.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.system.model.comcombo;
import kr.happyjob.study.system.service.ComnComboService;

@Controller
@RequestMapping("/system/")
public class ComnComboController {
	
	@Autowired
	ComnComboService comnComboService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 *  공통 콤보 
	 */
	@RequestMapping("selectComCombo.do")
	@ResponseBody
	public Map<String, Object> selectComCombo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectComCombo");
		logger.info("   - paramMap : " + paramMap);

		String ComType = (String) paramMap.get("comtype");
			
		List<comcombo> comComboModel = new ArrayList<>();
		
		logger.info("   - ComType : " + ComType);
		
		if("cli".equals(ComType)) {
			// 공통 콤보 거래처
			comComboModel = comnComboService.selectclientlist(paramMap);

		} else if("wh".equals(ComType)) {
			// 공통 콤보 조회 창고
			comComboModel = comnComboService.selectwhlist(paramMap);
		}
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("list", comComboModel);
		
		logger.info("+ End " + className + ".selectComCombo");
		
		return resultMap;
	}
	
	
	/**
	 *  제품 공통 콤보 
	 */
	@RequestMapping("selectGoodComCombo.do")
	@ResponseBody
	public Map<String, Object> selectGoodComCombo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectGoodComCombo");
		logger.info("   - paramMap : " + paramMap);
			
		List<comcombo> comComboModel = new ArrayList<>();
					
		comComboModel = comnComboService.selectGoodComCombo(paramMap);		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("list", comComboModel);
		
		logger.info("+ End " + className + ".selectGoodComCombo");
		
		return resultMap;
	}	
	
}
