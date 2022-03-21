package kr.happyjob.study.mng.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.mng.model.ClassTInfoDto;
import kr.happyjob.study.mng.model.FileInfoDto;
import kr.happyjob.study.mng.model.LectureDto;
import kr.happyjob.study.mng.service.LectureService;
import kr.happyjob.study.system.model.PagingVo;


@RestController
@RequestMapping("/mng/")
public class LectureController {	
	
	@Autowired
	private LectureService lectureService;
	
	@RequestMapping("lecture.do")
	public ModelAndView startPage(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mng/lectureList");
		return mav;
	}

	@RequestMapping("selectLectureList.do")
	public Map<String, Object> selectLectureList(@SessionAttribute("loginId") String loginID, 
												@RequestParam(name = "nowPage",defaultValue = "1") int nowPage) throws Exception{
		
		List<LectureDto> lectureList = null;
		int lectureListCnt;
		RowBounds rb = null;
		PagingVo lectureListPaging = null;		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		lectureListCnt = lectureService.selectLectureListCnt(loginID);
		lectureListPaging = new PagingVo(lectureListCnt, nowPage, 5, 10);
		rb = new RowBounds(lectureListPaging.getStart()-1, lectureListPaging.getCntPerPage());
		lectureList = lectureService.selectLectureList(loginID, rb);
		
		resultMap.put("lectureList", lectureList);
		resultMap.put("lectureListPaging", lectureListPaging);
		
		
		
		return resultMap;
		
		
		
		
		
	}
	
	@RequestMapping("selectLecture.do")
	public LectureDto selectLecture(int class_No) throws Exception{
		
		LectureDto lecture = null;
		
		lecture = lectureService.selectLecture(class_No);
		
		
		return lecture;
		
		
		
		
		
	}
	
	@RequestMapping("planFlieDownload.do")
	public void asfasfafsafs(HttpServletResponse response, int no) throws Exception{
		FileInfoDto fileInfo = null;
		fileInfo = lectureService.selectPlanFileInfo(no);
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
	
}
