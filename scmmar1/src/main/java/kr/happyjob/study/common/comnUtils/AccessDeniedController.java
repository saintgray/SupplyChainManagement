package kr.happyjob.study.common.comnUtils;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AccessDeniedController {

	@RequestMapping("/accessdenied.do")
	public String redirectToDeniedPage(){
		
		return "common/error/error_403";
	}
}
