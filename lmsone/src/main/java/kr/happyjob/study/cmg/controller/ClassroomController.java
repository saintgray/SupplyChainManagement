package kr.happyjob.study.cmg.controller;

import java.util.HashMap;
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

import kr.happyjob.study.cmg.model.ClassroomModel;
import kr.happyjob.study.cmg.model.EquipmentModel;
import kr.happyjob.study.cmg.service.ClassroomService;
import kr.happyjob.study.system.model.ComnDtlCodModel;

@Controller
//@RequestMapping
//공통적인  부분을 클래스 단위로 RequestMapping 해 주고, 각 메서드 마다 Mapping을 한번 더 해준다면 
//URL은 클래스 -> 메서드 순으로 읽혀지게 된다.
@RequestMapping("/cmg/")
public class ClassroomController {
	//이거 왜써여?
	@Autowired
	ClassroomService classroomService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	/** 
	 * 강의실 관리 초기화면 
	 */
	@RequestMapping("lectureroomMgt.do")
	public String lectureroomMgt(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		//이게 무슨 코드인가요오??
		logger.info("+ Start " + className + ".lectureroomMgt");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lectureroomMgt");

		//jsp 화면 부름
		return "cmg/classroom";
	}  
	
	
	/**
	 * 강의실 목록조회
	 */
	@RequestMapping("lectureroomList.do")
	public String listClassroom(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listClassroom");
		logger.info("   - paramMap : " + paramMap);
		
		//classroom.jsp에 있는 param의 값을 가져와서 각각의 변수에 저장했당
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 크기
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
				
		//처음에 0,5
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 강의실 목록 조회
		List<ClassroomModel> listClassroomModel = classroomService.listClassroom(paramMap);
		
		// 강의실 목록 카운트 조회
		int totalCount = classroomService.countListClassroom(paramMap);
		
		//모델에 속성 추가
		model.addAttribute("listClassroomModel", listClassroomModel);
		model.addAttribute("totalCntClassroom", totalCount);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageClassroom", currentPage);
		
		logger.info("+ End " + className + ".listClassroom");

		return "cmg/classroomList";
	}	
	
	/**
	 *  강의실관리 단건 조회
	 */
	@RequestMapping("selectRoomOne.do")
	@ResponseBody
	public Map<String, Object> selectRoomOne (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectRoomOne");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 단건 조회
		ClassroomModel classroomModel = classroomService.selectRoomOne(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("classroomModel", classroomModel);
		
		logger.info("+ End " + className + ".selectRoomOne");
		
		return resultMap;
	}
	
	/**
	 *  강의실 관리 저장
	 */
	@RequestMapping("saveRoom.do")
	//Map 형태 redirect안할때 씀 즉 값만 바꾸겠다.라는 이야기
	@ResponseBody
	public Map<String, Object> saveRoom(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveRoom");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		
		// 사용자 정보 설정
		//paramMap.put("fst_rgst_sst_id", session.getAttribute("loginId"));
		//paramMap.put("fnl_mdfr_sst_id", session.getAttribute("loginId"));
		if ("I".equals(action)) {
			// 그룹코드 신규 저장
			classroomService.insertRoom(paramMap);
		} else if("U".equals(action)) {
			// 그룹코드 수정 저장
			classroomService.updateRoom(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveRoom");
		
		return resultMap;
	}	
	
	/**
	 *  강의실관리 삭제
	 */
	@RequestMapping("deleteRoom.do")
	@ResponseBody
	public Map<String, Object> deleteRoom(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteRoom");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 그룹코드 삭제
		classroomService.deleteRoom(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteRoom");
		
		return resultMap;
	}
	
	/**
	 * 장비목록 조회
	 */
	@RequestMapping("EquipmentList.do")
	public String listEquipment(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEquipment");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;									// 페이지 시작 row 번호
		

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 장비 목록 조회
		List<EquipmentModel> listEquipmentModel = classroomService.listEquipment(paramMap);
		model.addAttribute("listEquipmentModel", listEquipmentModel);
		
		// 장비 목록 카운트 조회
		int totalCount = classroomService.countListEquipment(paramMap);
		model.addAttribute("totalCntEquipment", totalCount);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageEquipment",currentPage);
		
		logger.info("+ End " + className + ".listEquipment");

		return "/cmg/equipmentList";
	}	
	
	
	/**
	 *  장비 단건 조회
	 */
	@RequestMapping("selectCmgEqui.do")
	@ResponseBody
	public Map<String, Object> selectCmgEqui (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectCmgEqui");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "조회 되었습니다.";
		
		// 장비 단건 조회
		EquipmentModel equipmentModel = classroomService.selectCmgEqui(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("equipmentModel", equipmentModel);
		
		logger.info("+++equipmentModel : " + equipmentModel);
		
		logger.info("+ End " + className + ".selectCmgEqui");
		
		return resultMap;
	}
	
	/**
	 *  장비 저장
	 */
	@RequestMapping("saveEqui.do")
	@ResponseBody
	public Map<String, Object> saveEqui(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveEqui");
		logger.info("   - paramMap : " + paramMap);

		String action = (String)paramMap.get("action");
		String result = "SUCCESS";
		String resultMsg = "저장 되었습니다.";
		
		// 사용자 정보 설정
		//paramMap.put("fst_rgst_sst_id", session.getAttribute("loginId"));
		//paramMap.put("fnl_mdfr_sst_id", session.getAttribute("loginId"));
		
		if ("I".equals(action)) {
			// 상세코드 신규 저장
			classroomService.insertEquipment(paramMap);
		} else if("U".equals(action)) {
			// 상세코드 수정 저장
			classroomService.updateEquipment(paramMap);
		} else {
			result = "FALSE";
			resultMsg = "알수 없는 요청 입니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".saveEqui");
		
		return resultMap;
	}
	
	
	/**
	 *  장비 삭제
	 */
	@RequestMapping("deleteEquipment.do")
	@ResponseBody
	public Map<String, Object> deleteEquipment(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".deleteEquipment");
		logger.info("   - paramMap : " + paramMap);

		String result = "SUCCESS";
		String resultMsg = "삭제 되었습니다.";
		
		// 그룹코드 삭제
		classroomService.deleteEquipment(paramMap);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		logger.info("+ End " + className + ".deleteEquipment");
		
		return resultMap;
	}
}
