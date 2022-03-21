package kr.happyjob.study.mng.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.mng.model.ClassInfoDto;
import kr.happyjob.study.mng.model.FileInfoDto;
import kr.happyjob.study.mng.model.HomeworkDto;
import kr.happyjob.study.mng.model.HwSubmitDto;
import kr.happyjob.study.mng.model.HwSubmitInfoDto;
import kr.happyjob.study.mng.service.HomeworkService;
import kr.happyjob.study.system.model.PagingVo;

@Controller
@RequestMapping("/mng/")
public class HomeworkTController {
	
	private String homeworkFilePath = "X:"+File.separator+"FileRepository"+File.separator+"homework"+File.separator;
	
	private String LocalFilePath = "c:" + File.separator + "homework" + File.separator;

	private String filePath = homeworkFilePath;
	
	@Autowired
	private HomeworkService homeworkService;

	@RequestMapping("homeworkMgt.do")
	public String selectTClassList(Model model,@SessionAttribute("loginId") String loginID) throws Exception{
		
		List<ClassInfoDto> classInfoList = null;
		int classInfoListCnt;
		RowBounds rb = null;
		PagingVo CIListPaging = null;
		
		classInfoListCnt = homeworkService.selectCITListCnt(loginID);
		CIListPaging = new PagingVo(classInfoListCnt, 1, 5, 10);
		rb = new RowBounds(CIListPaging.getStart()-1, CIListPaging.getCntPerPage());
		classInfoList = homeworkService.selectClassTList(loginID, rb);
		model.addAttribute("classInfoList", classInfoList);
		model.addAttribute("CIListPaging", CIListPaging);

		
		return "mng/homeworkT";
		
	}
	
	@RequestMapping("tClassListMovePage.do")
	@ResponseBody
	public Map<String, Object> selectTCLMovePage(int nowPage,@SessionAttribute("loginId") String loginID) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<ClassInfoDto> classInfoList = null;
		int classInfoListCnt;
		RowBounds rb = null;
		PagingVo CIListPaging = null;
		
		classInfoListCnt = homeworkService.selectCITListCnt(loginID);
		CIListPaging = new PagingVo(classInfoListCnt, nowPage, 5, 10);
		rb = new RowBounds(CIListPaging.getStart()-1, CIListPaging.getCntPerPage());
		classInfoList = homeworkService.selectClassTList(loginID, rb);
		resultMap.put("classInfoList", classInfoList);
		resultMap.put("CIListPaging", CIListPaging);

		
		return resultMap;
		
	}
	
	
	
	
	@RequestMapping("selectTHomework.do")
	@ResponseBody
	public Map<String, Object> selectHomework(int hw_No,String loginID) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String updateHomeworkContent = "";
		HomeworkDto homework = null;	
				
		homework = homeworkService.selectHomework(hw_No);
		
		updateHomeworkContent = homework.getHw_Content().replaceAll("<br>", "\r\n");
		
		resultMap.put("homework", homework);
		resultMap.put("updateHomeworkContent", updateHomeworkContent);
		
		
		return resultMap;
		
		
		
	}
	
	@RequestMapping("insertHomework.do")
	@ResponseBody
	public String insertHomework(HomeworkDto homework, MultipartFile homeworkFile) throws Exception{
		FileInfoDto fileInfo = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String currentTime = sdf.format(new Date());
		int random = (int) (Math.random() * 99999 + Math.random() * 99999);
		System.out.println(homeworkFile.isEmpty());
		System.out.println(homeworkFile.getSize());
		System.out.println(homeworkFile.getOriginalFilename());
		String fileName = homeworkFile.getOriginalFilename();
		String path = filePath;
		fileInfo = new FileInfoDto(fileName,currentTime+random ,path);
		
		homework.setHw_Content(homework.getHw_Content().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		int hw_No = homeworkService.insertHomework(homework,fileInfo,homeworkFile);
		
		return hw_No+"";
		
		
	}
	
	@RequestMapping("updateHomework.do")
	@ResponseBody
	public String updateHomework(HomeworkDto homework, MultipartFile homeworkFile,
			@RequestParam(name = "fileCheck", defaultValue = "N") String fileCheck, @RequestParam(name = "fileDelCheck", defaultValue = "N")  String fileDelCheck) throws Exception{
		FileInfoDto fileInfo = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String currentTime = sdf.format(new Date());
		int random = (int) (Math.random() * 99999 + Math.random() * 99999);
		
		String fileName = homeworkFile.getOriginalFilename();
		String path = filePath;
		fileInfo = new FileInfoDto(fileName,currentTime+random ,path);

		homework.setHw_Content(homework.getHw_Content().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		homeworkService.updateHomework(homework,fileInfo,homeworkFile,fileCheck, fileDelCheck );
		
		return "pass";
		
	}
	
	
	
	@RequestMapping("deleteHomework.do")
	@ResponseBody
	public String deleteHomework(int hw_No, @RequestParam(name = "fileCheck", defaultValue = "N") String fileCheck,int no) throws Exception{
		
		
		homeworkService.deleteHomework(hw_No,fileCheck,no);
		
		return "pass";
	}
	

	@RequestMapping("selectHWSubmitList.do")
	@ResponseBody
	public Map<String, Object> selectHWSubmitList(int hw_No,int nowPage) throws Exception{
		
		List<HwSubmitInfoDto> HWSubmitList = null;		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int HWSubmitListCnt;
		RowBounds rb = null;
		PagingVo HWSubmitListPaging = null;
		
		HWSubmitListCnt = homeworkService.selectHWSubmitListCnt(hw_No);
		HWSubmitListPaging = new PagingVo(HWSubmitListCnt, nowPage, 5, 10);
		rb = new RowBounds(HWSubmitListPaging.getStart()-1, HWSubmitListPaging.getCntPerPage());
		HWSubmitList = homeworkService.selectHWSubmitList(hw_No, rb);
		resultMap.put("HWSubmitList", HWSubmitList);
		resultMap.put("HWSubmitListPaging", HWSubmitListPaging);

		
		return resultMap;
		
	}
	
	@RequestMapping("selectTHwsubmit.do")
	@ResponseBody
	public Map<String, Object> selectTHwsubmit(int hw_Submit_No) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		HwSubmitDto hwSubmit = null;
		FileInfoDto fileInfo = null;
		String flieName = null;
		
		
		hwSubmit = homeworkService.selectTHwsubmit(hw_Submit_No);
		
		if(hwSubmit.getNo()!=0){
			fileInfo = homeworkService.selectFileInfo(hwSubmit.getNo());
			flieName = fileInfo.getFile_Name();
		}
		resultMap.put("flieName", flieName);
		resultMap.put("hwSubmit", hwSubmit);
		
		return resultMap;
		
		
		
	}
	
}
