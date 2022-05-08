package kr.happyjob.study.scm.sales.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.scm.sales.model.PageInfo;
import kr.happyjob.study.scm.sales.model.SalesDetails;
import kr.happyjob.study.scm.sales.model.SalesRegData;
import kr.happyjob.study.scm.sales.service.SalesManageService;

@RestController
@RequestMapping("/scm/vue")
public class VueSalesManageController {

	
	
	private Logger logger=LoggerFactory.getLogger(this.getClass());
	
	private SalesManageService smService;
	
	
	public VueSalesManageController() {
	}
	
	@Autowired
	public VueSalesManageController(SalesManageService smService) {
		this.smService = smService;
	}




	// 상품 리스트 받아오기
	@PostMapping(value="/saleslist", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Map<String, Object> getSales(Model model, PageInfo info){
		logger.info(info.getKeyword());
		logger.info(info.getSearchType());
		logger.info(String.valueOf(info.getRowsPerPage()));
		logger.info(String.valueOf(info.getSelectPage()));
		
		/*logger.info(params.get("searchType").toString());
		logger.info(params.get("keyword").toString());
		logger.info(params.get("selectPage").toString());
		logger.info(params.get("rowsPerPage").toString());*/
		
		
		Map<String, Object> result= new HashMap<String, Object>();
		
		
		try{
			
			result.put("page", smService.getSalesList(info));

			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@PostMapping("/sales/{formType}/{salesID}")
	public Map<String, Object> initSalesForm(@PathVariable("formType") String formType, @PathVariable("salesID") String salesID){
		
		Map<String, Object> result=new HashMap<>();

		
		if(!formType.equalsIgnoreCase("NEW")){
			result.put("info",smService.getSalesDetails(salesID));
		}else{
			result.put("info",new SalesDetails());
		}
		
		
		return result;
	}	
	
	
	
	// RequestMethod.POST : 등록, RequestMethod.PUT(수정), RequestMethod.DELETE(삭제)
	// FormData 로 넘긴 파라미터들이 POST 방식으로 요청했을 때는 SalesRegData 객체의 변수에 바인딩이 되나
	// PUT 방식으로 요청할시에는 들어오지 않음
	@RequestMapping("/manage/{idx}")
	public int manageSales(SalesRegData data, @PathVariable("idx") String salesID, HttpServletRequest req){
		
		int result=0;
		
		// put 방식으로 들어올 시 모두 null 값
		// post 방식일 시 값 있음
		logger.info("============================");
		logger.info("+ debugging salesregdata.....");
		logger.info(data.getSales_id());
		logger.info(data.getSales_nm());
		logger.info(data.getSales_type());
		logger.info(data.getPrice());
		logger.info(data.getModel_nm());
		logger.info(data.getMfcomp());
		logger.info(data.getModel_code());
		logger.info(data.getInfo());
		logger.info("============================");
		
		try{
			
			if(Integer.parseInt(salesID)==0&&req.getMethod().equalsIgnoreCase("post")){
				logger.info("+ call insertSales ");
				result=smService.insertSales(data, req);

	
			}else if(Integer.parseInt(salesID)!=0&&req.getMethod().equalsIgnoreCase("post")){
				
				logger.info("+ call updateSales ");
				data.setSales_id(salesID);
				result=smService.updateSales(data, req);
				
			}else if(req.getMethod().equalsIgnoreCase("delete")){
				logger.info("+ call deleteSales ");
				result=smService.deleteSales(salesID);
			}
			
		}catch(Exception e){
				e.printStackTrace();
				logger.info("+ catch thrown Exception occured ServiceImpl method....");
		
		}
		
		return result;
	}

}
