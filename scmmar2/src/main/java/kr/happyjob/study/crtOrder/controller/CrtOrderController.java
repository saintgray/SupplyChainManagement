package kr.happyjob.study.crtOrder.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.crtOrder.model.CrtOrderModel;
import kr.happyjob.study.crtOrder.service.CrtOrderService;
import kr.happyjob.study.scmStandard.model.ProductFileModel;
import kr.happyjob.study.scmStandard.service.ProductService;

@Controller
@RequestMapping("/crt/")
public class CrtOrderController {
	
	@Autowired
	CrtOrderService crtOrderService;
	
	@Autowired
	ProductService productService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	//제품목록 초기화면	
	@RequestMapping("productList.do")
	public String productListinit(){
		return "crtOrder/productList";
	}
	
	//제품 리스트 조회
	@RequestMapping("listProduct.do")
	public ModelAndView listProduct(ModelAndView mv, @RequestParam Map<String,Object> paramMap){
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;			
		
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		
		//제품 리스트 조회
		List<CrtOrderModel> listProductModel = crtOrderService.listProduct(paramMap);
		mv.addObject("listProductModel",listProductModel);
		
		
		//제품 리스트 카운트 조회
		int totalCount = crtOrderService.countlistProduct(paramMap);
		mv.addObject("totalCntProductList", totalCount);
		
		mv.addObject("pageSize", pageSize);
		mv.addObject("currentPageProductList",currentPage);
		
		mv.setViewName("crtOrder/productListData");
		
		return mv;
	}
	
	//장비구분 콤보박스 생성
	@RequestMapping("categoryBoxList.do")
	@ResponseBody
	public List<CrtOrderModel> categoryBoxList(HttpServletResponse response){
		
		 List<CrtOrderModel> comlist = crtOrderService.categoryBoxList();
		System.out.println(comlist);
		
		response.setContentType("application/json; charset=utf-8");
		
		return comlist;
	}
	
	
	//장비구분 콤보박스 생성
		@RequestMapping("pdmdcopBoxList.do")
		@ResponseBody
		public List<CrtOrderModel> pdmdcopBoxList(HttpServletResponse response,@RequestParam Map<String,Object> paramMap){
			
			List<CrtOrderModel> pdmdcoplist = crtOrderService.pdmdcopBoxList(paramMap);
			
			response.setContentType("application/json; charset=utf-8");
			
			return pdmdcoplist;
		}
		
	//제품 상세정보
	@RequestMapping("selectProductOne.do")
	@ResponseBody
	public Map<String, Object> selectProductOne(HttpServletResponse response,@RequestParam Map<String,Object> paramMap) throws Exception {
		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		
		//제품 상세 정보
		CrtOrderModel crtOrderModel = crtOrderService.selectProductOne(paramMap);
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("crtOrderModel", crtOrderModel);
		//resultMap.put("selectFile", selectFile);
		
		return resultMap;
	}
	
	//장바구니에 등록
	@RequestMapping("inputProduct.do")
	@ResponseBody
	public Map<String, Object> inputProduct(HttpServletResponse response,@RequestParam Map<String,Object> paramMap,
			HttpSession session) throws Exception {
		logger.info("+ Start " + className + ".inputProduct");

		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		// 사용자 정보 설정
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		//int로 변환
		
		logger.info("   - paramMap : " + paramMap);

		if ("C".equals(action)) {
			// 장바구니 저장
			paramMap.put("pdcode",Integer.parseInt((String)paramMap.get("pdcode")) );
			paramMap.put("pdmdprice",Integer.parseInt((String)paramMap.get("pdmdprice")));
			paramMap.put("cartcnt", Integer.parseInt((String)paramMap.get("cartcnt")));
			paramMap.put("cartamount", (int)(paramMap.get("cartcnt"))*(int)(paramMap.get("pdmdprice")));
			
			crtOrderService.insertCartProduct(paramMap);
		} else if("O".equals(action)) {
			// 주문 저장
			paramMap.put("userID", session.getAttribute("loginId"));
			paramMap.put("pdcode",Integer.parseInt((String)paramMap.get("pdcode")) );
			paramMap.put("pdmdprice",Integer.parseInt((String)paramMap.get("pdmdprice")));
			paramMap.put("ordercnt", Integer.parseInt((String)paramMap.get("ordercnt")));
			paramMap.put("orderamount", (int)(paramMap.get("ordercnt"))*(int)(paramMap.get("pdmdprice")));

			logger.info("   - paramMap : " + paramMap);

			crtOrderService.insertOrderProduct(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".inputProduct");
		
		return resultMap;
	}
	
	
}
