package kr.happyjob.study.scm.orders.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.scm.orders.model.whInventoryFormModel;
import kr.happyjob.study.scm.orders.model.whcntModel;
import kr.happyjob.study.scm.orders.service.whInventoryFormService;

@RestController
@RequestMapping("/scm/vue")
public class VueWarehouseStockController {

	private final Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private whInventoryFormService whinventoryformservice;

	public VueWarehouseStockController() {
	}

	public VueWarehouseStockController(whInventoryFormService whinventoryformservice) {
		this.whinventoryformservice = whinventoryformservice;
	}

	@PostMapping("/inventories")
	public Map<String,Object> whlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int totalPage=Integer.parseInt(paramMap.get("totalPage").toString());
		
																			
		int pageIndex = (currentPage - 1) * pageSize;

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);

		int total = whinventoryformservice.total(paramMap);
		if(total>pageSize){
			totalPage=total/pageSize;
			totalPage=total%pageSize>0?totalPage+1:totalPage;
		}
		if(currentPage>totalPage){
			currentPage=totalPage;
		}
		
		List<whInventoryFormModel> whlist = whinventoryformservice.whlist(paramMap);
		
		
		Map<String,Object> result= new HashMap<String, Object>();
		result.put("total", total);
		result.put("totalPage", totalPage);
		result.put("inventories", whlist);
		result.put("currentPage", currentPage);


		return result;
	}

	@PostMapping("/stocks/{idx}")
	public Map<String,Object> getDetailStock(Model model, @PathVariable String idx) throws Exception {
		
		Map<String,Object> result= new HashMap<>();
		
		try {
			List<whcntModel> detail = null;
			detail = whinventoryformservice.getStockState(idx);
			// model.addAttribute("detail", detail);
			result.put("detail", detail);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}
