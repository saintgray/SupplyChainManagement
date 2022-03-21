package kr.happyjob.study.mng.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
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
import kr.happyjob.study.mng.service.HomeworkService;
import kr.happyjob.study.system.model.PagingVo;

@Controller
@RequestMapping("/mng/")
public class HomeworkController {

	private String homeworkFilePath = "X:"+File.separator+"FileRepository"+File.separator+"homework"+File.separator;
	
	private String LocalFilePath = "c:" + File.separator + "homework" + File.separator;
	
	private String filePath = homeworkFilePath;
	
	@Autowired
	private HomeworkService homeworkService;
	
	@RequestMapping("homework.do")
	public String selectClassList(Model model,@SessionAttribute("loginId") String loginID) throws Exception{
		
		List<ClassInfoDto> classInfoList = null;
		int classInfoListCnt;
		RowBounds rb = null;
		PagingVo CIListPaging = null;
		
		classInfoListCnt = homeworkService.selectCIListCnt(loginID);
		CIListPaging = new PagingVo(classInfoListCnt, 1, 5, 10);
		rb = new RowBounds(CIListPaging.getStart()-1, CIListPaging.getCntPerPage());
		classInfoList = homeworkService.selectClassList(loginID, rb);
		model.addAttribute("classInfoList", classInfoList);
		model.addAttribute("CIListPaging", CIListPaging);

		
		return "mng/homework";
		
	}
	
	@RequestMapping("classListMovePage.do")
	@ResponseBody
	public Map<String, Object> selectCLMovePage(int nowPage,@SessionAttribute("loginId") String loginID) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<ClassInfoDto> classInfoList = null;
		int classInfoListCnt;
		RowBounds rb = null;
		PagingVo CIListPaging = null;
		
		classInfoListCnt = homeworkService.selectCIListCnt(loginID);
		CIListPaging = new PagingVo(classInfoListCnt, nowPage, 5, 10);
		rb = new RowBounds(CIListPaging.getStart()-1, CIListPaging.getCntPerPage());
		classInfoList = homeworkService.selectClassList(loginID, rb);
		resultMap.put("classInfoList", classInfoList);
		resultMap.put("CIListPaging", CIListPaging);

		
		return resultMap;
		
	}
	
	@RequestMapping("selectHomeworkList.do")
	@ResponseBody
	public Map<String, Object> selectHomeworkList(int nowPage, int class_No) throws Exception{
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<HomeworkDto> homeworkList = null;
		int homeworkListCnt;
		RowBounds rb = null;
		PagingVo homeworkListPaging = null;
		
		homeworkListCnt = homeworkService.selectHWListCnt(class_No);
		homeworkListPaging = new PagingVo(homeworkListCnt, nowPage, 5, 10);
		rb = new RowBounds(homeworkListPaging.getStart()-1, homeworkListPaging.getCntPerPage());
		homeworkList = homeworkService.selectHomeworkList(class_No, rb);
		
		
		resultMap.put("homeworkListPaging", homeworkListPaging);
		resultMap.put("homeworkList", homeworkList);
		
		return resultMap;
		
		
	}
	
	@RequestMapping("selectHomework.do")
	@ResponseBody
	public Map<String, Object> selectHomework(int hw_No,String loginID) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		HwSubmitDto hwSubmit = null;
		HwSubmitDto temp = new HwSubmitDto(hw_No, loginID);
		HomeworkDto homework = null;
		String submitCheck = null;
		
		hwSubmit = homeworkService.selectCheckSubmit(temp);
		
		if(hwSubmit==null){
			submitCheck = "N";
		}else{
			submitCheck = "Y";
		}
		
		homework = homeworkService.selectHomework(hw_No);
		resultMap.put("homework", homework);
		resultMap.put("submitCheck", submitCheck);
		
		
		return resultMap;
		
		
		
	}
	
	@RequestMapping("insertHwsubmit.do")
	@ResponseBody
	public String insertHwsubmit(HwSubmitDto hwsubmit, MultipartFile homeworkFile) throws Exception{
		FileInfoDto fileInfo = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String currentTime = sdf.format(new Date());
		int random = (int) (Math.random() * 99999 + Math.random() * 99999);
		String fileName = homeworkFile.getOriginalFilename();
		String path = filePath;
		fileInfo = new FileInfoDto(fileName,currentTime+random ,path);

		hwsubmit.setHw_Content(hwsubmit.getHw_Content().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		homeworkService.insertHwsubmit(hwsubmit,fileInfo,homeworkFile);
		
		return "pass";
		
		
	}
	
	@RequestMapping("flieDownload.do")
	public void asfasfafsafs(HttpServletResponse response, int no) throws Exception{
		FileInfoDto fileInfo = null;
		fileInfo = homeworkService.selectFileInfo(no);
		String path = fileInfo.getFile_Root();
		String dummyStr = fileInfo.getFile_Title();
		String name = fileInfo.getFile_Name();
		byte[] flieByte = FileUtils.readFileToByteArray(new File(path+dummyStr+name));
		
		response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(name, "UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");

	    response.getOutputStream().write(flieByte);
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
		
	}

	@RequestMapping("selectHwsubmit.do")
	@ResponseBody
	public Map<String, Object> selectHwsubmit(HwSubmitDto temp) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		HwSubmitDto hwSubmit = null;
		FileInfoDto fileInfo = null;
		String flieName = null;
		String updateHwsubmitContent = null;
		
		
		hwSubmit = homeworkService.selectCheckSubmit(temp);
		updateHwsubmitContent = hwSubmit.getHw_Content().replaceAll("<br>","\r\n");
		
		if(hwSubmit.getNo()!=0){
			fileInfo = homeworkService.selectFileInfo(hwSubmit.getNo());
			flieName = fileInfo.getFile_Name();
		}
		resultMap.put("flieName", flieName);
		resultMap.put("hwSubmit", hwSubmit);
		resultMap.put("updateHwsubmitContent", updateHwsubmitContent);
		
		return resultMap;
		
		
		
	}
	
	@RequestMapping("updateHwsubmit.do")
	@ResponseBody
	public String updateHwsubmit(HwSubmitDto hwsubmit, MultipartFile homeworkFile,
			@RequestParam(name = "fileCheck", defaultValue = "N") String fileCheck, @RequestParam(name = "fileDelCheck", defaultValue = "N")  String fileDelCheck) throws Exception{
		FileInfoDto fileInfo = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String currentTime = sdf.format(new Date());
		int random = (int) (Math.random() * 99999 + Math.random() * 99999);
		
		String fileName = homeworkFile.getOriginalFilename();
		String path = filePath;
		fileInfo = new FileInfoDto(fileName,currentTime+random ,path);

		hwsubmit.setHw_Content(hwsubmit.getHw_Content().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		
		homeworkService.updateHwsubmit(hwsubmit,fileInfo,homeworkFile,fileCheck, fileDelCheck );
		
		return "pass";
		
	}
	
	@RequestMapping("deleteHwsubmit.do")
	@ResponseBody
	public String deleteHwsubmit(int hw_Submit_No, @RequestParam(name = "fileCheck", defaultValue = "N") String fileCheck,int no) throws Exception{
		
		
		homeworkService.deleteHwsubmit(hw_Submit_No,fileCheck,no);
		
		return "pass";
		
	}
	
	
}
