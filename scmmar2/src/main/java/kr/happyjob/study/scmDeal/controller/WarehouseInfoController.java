package kr.happyjob.study.scmDeal.controller;

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

import kr.happyjob.study.scmDeal.model.WarehouseInfo;
import kr.happyjob.study.scmDeal.service.WarehouseInfoService;

@RequestMapping("/scmDeal/")
@Controller
public class WarehouseInfoController {
	
	@Autowired
	private WarehouseInfoService warehouseInfoService;

	private final Logger logger = LogManager.getLogger(this.getClass());
	private String className = this.getClass().toString();
	
	/** 창고별재고 초기화면 */
	@RequestMapping("whInventoryForm.do")
	public String mainWHpage( Model model
			                , @RequestParam Map<String, Object> paramMap
			                , HttpSession session
			                , HttpServletRequest request
			                , HttpServletResponse response) throws Exception {
		logger.info(" #START: " + className + ".mainWHpage" );
		logger.info(" #Param: " + paramMap );
		logger.info(" #E N D: " + className + ".mainWHpage" );
		return "scmDeal/warehouseInfo";
	}
	
	/** 창고 목록 초기화면 */
	@RequestMapping("getWHList.do")
	public String getList( Model model
						 , @RequestParam Map<String, Object> paramMap
						 , HttpSession session
						 , HttpServletRequest request
						 , HttpServletResponse response ) throws Exception {
		logger.info(" #START: " + className + ".getList" );
		logger.info(" #Param: " + paramMap );
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int numOfPost = Integer.parseInt((String) paramMap.get("pagePostNum"));
		int pageIndex = (currentPage - 1) * numOfPost;
		
		paramMap.put("pageSize", numOfPost);
		paramMap.put("pageNumber", pageIndex);
		
		List<WarehouseInfo> items;
		items = warehouseInfoService.getList(paramMap);
		model.addAttribute("items", items);
		
		int totalCount = warehouseInfoService.getTotal(paramMap);
		model.addAttribute("totalCount", totalCount);
		
		logger.info(" #E N D: " + className + ".getList" );
		return "scmDeal/warehouseData";
	}
	
	/** 창고별 상세목록 */
	@RequestMapping("getWHdetail.do")
	public String getWHdetail( Model model
					   , @RequestParam Map<String, Object> paramMap
					   , HttpSession session
					   , HttpServletRequest request
					   , HttpServletResponse response ) throws Exception {
		
		logger.info(" #START: " + className + ".getWHdetail" );
		logger.info(" #Param: " + paramMap );
		
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		
		int pageSize = Integer.parseInt((String) paramMap.get("pagePostNum"));
		paramMap.put("pageSize", pageSize);
		
		int pageStartNo = (currentPage -1) * pageSize;
		paramMap.put("pageStartNo", pageStartNo);
		
		List<WarehouseInfo> items = warehouseInfoService.getDetail(paramMap);
		model.addAttribute("items", items);
		
		int detailTotal = warehouseInfoService.getDetailTotal(paramMap);
		model.addAttribute("detailTotal", detailTotal);

		logger.info(" #E N D: " + className + ".getWHdetail" );
		
		return "scmDeal/warehouseDetailData";
	}
	
}
