package kr.happyjob.study.scm.orders.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.scm.orders.service.DirService;
import kr.happyjob.study.scm.user.service.UserInfoService;

@Controller
@RequestMapping("/scm")
public class DirController {

	private final Logger logger= LogManager.getLogger(this.getClass());
	
	private DirService dirService;
	
	
	public DirController() {
		
	}
	
	@Autowired
	public DirController(DirService dirService) {
	
		this.dirService = dirService;
		
	}





	/**
	 * 
	 * @param action : 지시서의 종류(구매 : shippingdir , 발주 : orderDir , 반품 : returnDir)
	 * @param idxList : 고유번호 배열 ( 고객 구매의 경우 구매 상세 고유번호들, 고객 반품의 경우 반품하려는 상품의 구매상세 고유번호들, 
	 * 						기업 발주의 경우 발주 상세 고유번호들, 기업 반품의 경우 반품하려는 상품의 발주 상세 고유번호를 의미한다)
	 * @param targetWh : 고유창고번호 배열 (고객 구매의 경우 어느 창고에서 뺄 것인지에 대한 창고번호의 배열
	 * 								    고객 반품의 경우 어느 창고로 반품 상품을 들여올 것인지에 대한 요소의 배열(ex) 4,1 : 4번 창고로 1번 반품상품을 들여온다)
	 * 								    기업 구매의 경우 어느 창고로 상품을 들여올 것인지에 대한 요소의 배열(ex) 8,4 : 8번 창고로 4번 상품을 들여온다)
	 * @param pur_id : 해당 주문/발주 고유번호가 발주에 대한 번호인지, 주문에 대한 고유번호였는지 확인하여 구매한 사람이 기업인지 고객인지 구분하기 위하여 사용한다.						  
	 * @param session
	 * @return
	 */
	@PostMapping("/dirManage/{action}")
	@ResponseBody
	public int doWriteDir(@PathVariable String action, 
							@RequestParam(required=false, value="idxList[]")List<String> idxList,
							@RequestParam(value="targetWh[]")List<String> targetWh,
							String pur_id,
							HttpSession session){
		int result=0;
		
		try{
			switch(action){
			case "shippingDir":
				result=dirService.insertShippingDir(idxList,targetWh,pur_id,action);
				break;
			case "orderDir":
				
				result=dirService.insertOrderDir(targetWh, session);
				break;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		
		return result;
	}
		
}
