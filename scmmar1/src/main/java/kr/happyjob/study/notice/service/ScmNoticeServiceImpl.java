package kr.happyjob.study.notice.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.happyjob.study.common.comnUtils.NewFileUtil;
import kr.happyjob.study.notice.dao.ScmNoticeDao;
import kr.happyjob.study.notice.model.NoticeModel;
import kr.happyjob.study.scm.model.FileModel;

@Service
public class ScmNoticeServiceImpl implements ScmNoticeService {

	@Autowired
	ScmNoticeDao noticeDao;
	
	
	//private final static String rootPath = "c://";
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;	
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;		
	
	
	@Override
	public List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception {
		
		List<NoticeModel> noticeList = noticeDao.selectNoticeList(paramMap);
		
		
		return noticeList;
	}

	@Override
	public int noticeTotalCnt(Map<String, Object> paramMap) throws Exception {
		
         int totalCnt = noticeDao.noticeTotalCnt(paramMap);
		
		return totalCnt;
	}
	

	@Override
	public NoticeModel detailNotice(Map<String, Object> paramMap) throws Exception {
	
		// 상세정보 가져오기 
		NoticeModel detailNotice = noticeDao.detailNotice(paramMap);
		return detailNotice;
	}
	
	// 파일정보 가져오기
	@Override
	public List<FileModel> selectFile(Map<String, Object> paramMap)throws Exception {
		List<FileModel> selectFile = noticeDao.selectFile(paramMap);
		return selectFile;
	}

	@Transactional 
	@Override
	public int insertNotice(NoticeModel data, HttpServletRequest request) throws Exception{
		
		String loginID=request.getSession().getAttribute("loginId").toString();
		data.setLoginID(loginID);
		System.out.println("loginID>>>>"+loginID);
		
		
		int insertNoticeResult=noticeDao.insertNotice(data);
		
		List<FileModel> files=null;
		
		if(insertNoticeResult>0){
			NewFileUtil fUtil=new NewFileUtil(request, rootPath, loginID, noticePath);
			Map<String, List<FileModel>> filesMap= fUtil.uploadFiles(loginID);
			files=filesMap.get("file");
			
			int filesNum=files.size();
			
			if(files==null || files.isEmpty()){
				int insertFilesResult=noticeDao.insertNoticeFile(files);
				if(filesNum!=insertFilesResult){
					throw new Exception();
				}
			}
		}
		
		
		return insertNoticeResult;
		
	}
	
	
	
	
//	@Transactional 
//	@Override
//	public int updateNotice(Map<String, Object> paramMap, HttpServletRequest request) throws Exception{
//		
//		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
//
//			
//		
//		List<FileModel> deleteFile = new ArrayList<FileModel>();//빈 리스트 생성 (한번에 많은 파일 삭제 대비용으로)
//		String itemFilePath = noticePath + File.separator; // 파일 구분자(os별로 다르기 때문에 java에서 자동 적용)
//		NewFileUtil fileUtil = new NewFileUtil(request, rootPath, virtualRootPath, itemFilePath); //request와 파일저장루트, 디렉토리루트 전달
//
//		FileModel selectFile = noticeDao.selectFile(paramMap);
//		deleteFile.add(selectFile);
//		try {
//			fileUtil.deleteFiles(deleteFile);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		List<FileModel> fileInfo = null;
//		try {
//			fileInfo = fileUtil.uploadFiles();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		Iterator<FileModel> iter = fileInfo.iterator();
//
//		String file_server_path = "";	
//		String file_local_path = "";
//		String file_new_name = "";
//		String file_ofname = "";
//		int file_size = 0;
//		
//		int result = noticeDao.deleteFile(paramMap);
//
//		
//		int resultCnt = noticeDao.updateNotice(paramMap);		
//		
//		while(iter.hasNext()) {
//			FileModel tempFileInfo = (FileModel)iter.next();
//			file_server_path = tempFileInfo.getFile_server_path();
//			file_local_path = tempFileInfo.getFile_local_path();
//			file_new_name = tempFileInfo.getFile_new_name();
//			file_ofname = tempFileInfo.getFile_ofname();
//			file_size = tempFileInfo.getFile_size();
//	
//			//쿼리 파라미터 값 넣기
//			paramMap.put("file_server_path", file_server_path);
//			paramMap.put("file_local_path", file_local_path);
//			paramMap.put("file_new_name", file_new_name);
//			paramMap.put("file_ofname", file_ofname);
//			paramMap.put("file_size", file_size);			
//			
//			int result2 = noticeDao.insertNoticeFile(paramMap);
//		}
//
//		
//
//		
//		return resultCnt;
//	}

	@Override
	public int deleteNotice(Map<String, Object> paramMap) throws Exception{
		int deleteNotice = noticeDao.deleteNotice(paramMap);
		return deleteNotice;
	}



}
