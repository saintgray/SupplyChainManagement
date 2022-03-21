package kr.happyjob.study.mng.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.mng.model.ClassListUserInfoDto;
import kr.happyjob.study.mng.model.ClassTInfoDto;
import kr.happyjob.study.mng.service.ClassInfoService;
import kr.happyjob.study.system.model.PagingVo;

@RestController
@RequestMapping("/mng/")
public class ClassInfoController {
	
	@Autowired
	private ClassInfoService classInfoService;
	
	//수강인원/강의목록 초기 페이지
	@RequestMapping("classMgt.do")
	public ModelAndView classMgtStart() throws Exception{
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mng/classInfo");
		return mav;
	}
	
	//강의 목록 리스트 출력(검색결과 및 페이징처리)
	@RequestMapping("selectClassList.do")
	public Map<String, Object> selectClassList(
			@RequestParam(name = "searchStartDate",defaultValue = "1000-01-01") String searchStartDate,
			@RequestParam(name = "searchEndDate",defaultValue = "2999-12-31") String searchEndDate,
			@RequestParam(name = "searchKind",defaultValue = "class_Nm") String searchKind,
			@RequestParam(name = "nowPage",defaultValue = "1") int nowPage,String searchKeyword		
			) throws Exception{
		
		List<ClassTInfoDto> classList = null;
		int classListCnt;
		RowBounds rb = null;
		PagingVo classListPaging = null;
		String keyword = null;
		
		if(searchKeyword==null||searchKeyword.trim()==""){
			keyword ="%%";
		}else{
			keyword = "%"+searchKeyword+"%";
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("searchStartDate", searchStartDate);
		map.put("searchEndDate", searchEndDate);
		map.put("searchKind", searchKind);
		map.put("keyword", keyword);
		
		classListCnt = classInfoService.selectClassListCnt(map);
		classListPaging = new PagingVo(classListCnt, nowPage, 5, 10);
		rb = new RowBounds(classListPaging.getStart()-1, classListPaging.getCntPerPage());
		classList = classInfoService.selectClassList(map, rb);
		
		resultMap.put("classListPaging", classListPaging);
		resultMap.put("classList", classList);
		
		
		
		return resultMap;
		
		
		
		
		
	}
	
	//선택한 강의 목록에 대한 수강중인 학생 리스트(페이징)
	@RequestMapping("selectUserList.do")
	public Map<String, Object> selectUserList(int class_No,int nowPage) throws Exception{
		
		List<ClassListUserInfoDto> classUserList = null;
		int selectUserListCnt;
		RowBounds rb = null;
		PagingVo classUserListPaging = null;
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		selectUserListCnt = classInfoService.selectUserListCnt(class_No);
		classUserListPaging = new PagingVo(selectUserListCnt, nowPage, 5, 10);
		rb = new RowBounds(classUserListPaging.getStart()-1, classUserListPaging.getCntPerPage());
		classUserList = classInfoService.selectUserList(class_No, rb);
		
		resultMap.put("classUserListPaging", classUserListPaging);
		resultMap.put("classUserList", classUserList);
		
		
		
		return resultMap;
		
		
		
		
		
	}
	
	
	
	
}
