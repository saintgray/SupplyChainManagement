package kr.happyjob.study.notice.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.common.comnUtils.FileModel;
import kr.happyjob.study.notice.exception.NoticeNotExistException;
import kr.happyjob.study.notice.model.NoticeModel;
import kr.happyjob.study.notice.service.ScmNoticeService;

@RestController
@RequestMapping("/scm/vue")
public class VueNoticeController {

	private final Logger logger = LogManager.getLogger(this.getClass());

	private ScmNoticeService noticeService;

	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	@Value("${fileUpload.noticePath}")
	private String noticePath;

	public VueNoticeController() {
	}
	
	@Autowired
	public VueNoticeController(ScmNoticeService noticeService) {
		this.noticeService = noticeService;
	}

	@GetMapping("/notices")
	public ResponseEntity<?> noticeList(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) {
		
		
		logger.info("+ vue notices initiated...");
		
		
		ResponseEntity<?> result=null;

		// extraction params
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage")); // 현재페이지
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int total = Integer.parseInt(paramMap.get("total").toString());
		int totalPage = Integer.parseInt(paramMap.get("totalPage").toString());
		List<NoticeModel> noticeList=null;

		try{
			total = noticeService.noticeTotalCnt(paramMap);
			if(total>0){
				int pageIndex = (currentPage - 1) * pageSize;
				paramMap.put("pageIndex", pageIndex);
				paramMap.put("pageSize", pageSize);
				// get notice list
				noticeList = noticeService.noticeList(paramMap);
				totalPage=total/pageSize;
				totalPage=total%pageSize==0?totalPage:totalPage+1;
			}else{
				total=0;
				totalPage=1;
			}
			currentPage=currentPage>totalPage?totalPage:currentPage;
			paramMap.put("total", total);
			paramMap.put("totalPage", totalPage);
			paramMap.put("notices", noticeList);
			paramMap.put("currentPage", currentPage);
			// discard pageIndex and pageSize...
			paramMap.remove("pageIndex");
			
			result=ResponseEntity.ok(paramMap);
			
		}catch(Exception e){
			result=ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
			e.printStackTrace();
		}
		return result;
	}

	/* 공지사항 상세 정보 뿌리기 */
	@GetMapping("/notice/{idx}")
	public ResponseEntity<?> getNotice(@PathVariable(value="idx") String idx, HttpSession session) {
		ResponseEntity<?> result = null;
		try {
			NoticeModel notice = null;
			notice=noticeService.getNotice(idx);
			if (notice != null) {
				result=ResponseEntity.ok(notice);
			} else {
				// statusCode = 204
				// 삭제되었거나 없는 공지사항
				result=ResponseEntity.noContent().build();
			}
		} catch (Exception e) {
			result=ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
		return result;
	}

	// 공지사항 등록
	@PostMapping("/notice")
	public ResponseEntity<Void> insertNotice(@RequestBody NoticeModel data, List<MultipartFile> files, HttpServletRequest request)
			throws Exception {

		ResponseEntity<Void> result=null;
		int insertResult = 0;

		try {
			insertResult = noticeService.insertNotice(data, files, request);
			if(insertResult==1){
				result=ResponseEntity.status(HttpStatus.CREATED).build();
			}else{
				result=ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
			}
			
		} catch (Exception e) {
			result=ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
		return result;
	}

	// 공지사항 수정
	
	@PutMapping("/notice/{idx}")
	public ResponseEntity<Void> updateNotice(@RequestBody Map<String, Object> params, @PathVariable(value="idx") String idx,List<MultipartFile> files,
			List<String> delTargets, HttpServletRequest req) {

		ResponseEntity<Void> result=null;
		
		int updateResult = 0;

		try {
			// 기존 공지사항의 정보를 가져온다
			NoticeModel latestNoticeInfo = noticeService.detailNotice(params);
			latestNoticeInfo.setFilesInfo(noticeService.selectFilesByNoticeId(params));
			// 삭제하려는 파일들의 정보
			List<FileModel> deleteFileInfo = noticeService.selectFilesByFileNo(delTargets);
			// 기존에 첨부했던 파일의 백업본 생성
			updateResult = noticeService.updateNotice(latestNoticeInfo, params, files, delTargets, req);
			if(updateResult==1){
				result=ResponseEntity.status(HttpStatus.CREATED).build();
			}else{
				// 삭제되었거나 없는 공지사항
				result=ResponseEntity.noContent().build();
			}
		} catch (Exception e) {
			if (!(e instanceof NoticeNotExistException)) {
				result=ResponseEntity.noContent().build();
			}
		}
		return result;
	}

	// 공지사항 삭제
	
	@DeleteMapping("/notice/{idx}")
	public ResponseEntity<Void> deleteNotice(@PathVariable String idx) {

		ResponseEntity<Void> result=null;
		int delResult = 0;

		try {
			delResult = noticeService.deleteNotice(idx);
			if(delResult==1){
				result=ResponseEntity.ok().build();
			}else{
				// 삭제되었거나 없는 공지사항
				result=ResponseEntity.noContent().build();
			}
		} catch (Exception e) {
			result=ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}

		return result;
	}

	@RequestMapping("fileDown.do")
	public void downloadBbsAtmtFil(@RequestParam Map<String, Object> paramMap, HttpServletResponse response)
			throws Exception {

		
		logger.info("   - paramMap : " + paramMap);

		// 첨부파일 조회
		FileModel file = noticeService.selectOneFile(paramMap.get("file_no").toString());

		byte fileByte[] = FileUtils.readFileToByteArray(new File(file.getFile_local_path()));

		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(file.getFile_ofname(), "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.getOutputStream().write(fileByte);

		response.getOutputStream().flush();
		response.getOutputStream().close();

	}

}
