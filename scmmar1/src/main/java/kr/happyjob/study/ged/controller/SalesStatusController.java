package kr.happyjob.study.ged.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ged/salesStatus.do")
public class SalesStatusController {
	
	
	@GetMapping
	public String initStatus(){
		// 데이터 처리
		// .. 
		// ..
		// ...
		return "ged/salesStatus";
	}

}
