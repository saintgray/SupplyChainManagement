package kr.happyjob.study.scmStandard.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scmStandard.model.ProductFileModel;
import kr.happyjob.study.scmStandard.model.ProductModel;
import kr.happyjob.study.scmStandard.service.ProductService;

@Controller
@RequestMapping("/scmStandard/")
public class ProductController {
	
	@Autowired
	ProductService productService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	// 제품 정보 초기 화면
	@RequestMapping("productInfo.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initProductCod");
		logger.info("+ End " + className + ".initProductCod");

		return "scmStandard/productInfo";
	}
	
	
	// 제품 정보 목록
	@RequestMapping("productInfolist.do")
	public String productInfolist(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".productInfolist");
		logger.info("   - paramMap : " + paramMap);
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 제품 정보 목록 조회
		List<ProductModel> listProductCodModel = productService.listProductCod(paramMap);
		model.addAttribute("listProductCodModel", listProductCodModel);

		// 제품 정보 목록 카운트 조회
		int totalCount = productService.countListProductCod(paramMap);
		model.addAttribute("totalProductCod", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPagePDCod",currentPage);
		
		logger.info("+ End " + className + ".productInfolist");

		return "/scmStandard/productInfolist";
	}	

	
	// 제품 정보 단건 조회
	@RequestMapping("selectProductCod.do")
	@ResponseBody
	public Map<String, Object> selectProductCod(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".selectProductCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 제품 정보 단건 조회
		ProductModel productCodModel = productService.selectProductCod(paramMap);
		
		// 제품 파일 조회
		ProductFileModel selectFile = productService.selectFile(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("productCodModel", productCodModel);
		resultMap.put("selectFile", selectFile);
		
		logger.info("+ End " + className + ".selectProductCod");
		
		return resultMap;
	}
	
	
	// 제품 정보 신규 등록
	@RequestMapping("saveProductCod.do")
	@ResponseBody
	public Map<String, Object> saveProductCod(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		logger.info("+ Start " + className + ".selectProductCod");
	    logger.info("   - paramMap : " + paramMap);
	    
	    String action = (String) paramMap.get("action");
		String result = "N";
		String resultMsg = "데이터  저장 시 오류가 발생했습니다."; 
		
		try {
	         if("I".equals(action)) {
	        	 productService.insertproductcode(paramMap, request);
	             resultMsg = "데이터가 저장되었습니다.";
	         }
	         else if ("U".equals(action)) {
	        	 productService.updateProductCod(paramMap, request);
	 		 	 resultMsg = "데이터 수정 완료.";
	         }
	         
	         result = "Y";
		} catch(Exception e) {
	         
	      }
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".selectProductCod");
		
		return resultMap;
		
	}
	
	
	// 제품 정보 삭제
	@RequestMapping("deleteProductCod.do")
	@ResponseBody
	public Map<String, Object> deleteProductCod(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		
		logger.info("+ Start " + className + ".deleteProductCod");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		productService.selectFile(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 파일 삭제
		int delete = productService.deleteFile(paramMap);
		
		if (delete < 0) {
			System.out.println("파일 삭제 실패");
		} else {
		
		// 삭제 전 코드 불러오기
		ProductModel selecttaget = productService.selectProductCodpre(paramMap);
		
		paramMap.put("pdmdno", selecttaget.getPdmdno());	
		paramMap.put("pdcode", selecttaget.getPdcode());
		
		// 제품 정보 삭제
		productService.deleteProductCod(paramMap);
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteProductCod");
		
		}
		
		return resultMap;
	}
	
	
	// 제품 다운로드
	@RequestMapping("fileDownload.do")
	public void downloadBbsAtmtFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
	
		logger.info("+ Start " + className + ".downloadBbsAtmtFil");
		logger.info("   - paramMap : " + paramMap);
		
		// 첨부파일 조회
		ProductFileModel selectFile = productService.selectFile(paramMap);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(selectFile.getFile_new_name()));
		
		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(selectFile.getFile_ofname(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("+ End " + className + ".fileDown");
	}
}
