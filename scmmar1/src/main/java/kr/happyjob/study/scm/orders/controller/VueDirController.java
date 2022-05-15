package kr.happyjob.study.scm.orders.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.common.exception.NotNumbersException;
import kr.happyjob.study.scm.orders.service.DirService;

@RestController
@RequestMapping("/scm/vue")
public class VueDirController {
	
	private Logger logger = LogManager.getLogger(this.getClass());
	
	private DirService dirService;
	
	
	public VueDirController() {
		
	}

	@Autowired
	public VueDirController(DirService dirService) {
		
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
	@PostMapping("/direction")
	public void doWriteDir(
							@RequestParam String formType, 
							@RequestParam(required=false) List<String> idxList,
							@RequestParam List<String> targetWh,
							String pur_id,
							HttpSession session, HttpServletResponse resp){
		
		int result=0;
		
		try{
			switch(formType){
			case "shippingDir":
				logger.info("+ form Type is shippingDir");
				result=dirService.insertShippingDir(idxList,targetWh,pur_id,formType);
				break;
			case "orderDir":
				logger.info("+ form Type is orderDir");
				logger.info(targetWh);
				result=dirService.insertOrderDir(targetWh, session);
				break;
			}
		}catch(Exception e){
			e.printStackTrace();
			if(e instanceof NotNumbersException){
				resp.setStatus(801);
			}
		}finally{
			if(result<1){
				resp.setStatus(500);
			}
		}
		
	}
		
	
	

}


