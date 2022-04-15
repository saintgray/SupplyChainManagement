package kr.happyjob.study.scmStandard.service;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.StreamSupport;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.scm.model.FileModel;
import kr.happyjob.study.scmStandard.dao.NoticeBoardDao;
import kr.happyjob.study.scmStandard.model.NoticeBoardModel;
import kr.happyjob.study.scmStandard.model.NoticeFileModel;
import kr.happyjob.study.scmStandard.util.UploadFileUtil;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {

	@Autowired
	NoticeBoardDao noticeBoardDao;
	
	@Value("${fileUpload.virtualRootPath}")
	private static String virtualRootPath;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;	
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;		
	
	/**  공지사항 목록 조회 */
	public List<NoticeBoardModel> noticeBoardlist(Map<String, Object> paramMap) throws Exception {
		
		List<NoticeBoardModel> noticeBoardlist = noticeBoardDao.noticeBoardlist(paramMap);
		
		return noticeBoardlist;
	}
	
	/** 공지사항 카운트 조회 */
	public int countListNoticeCod(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = noticeBoardDao.countListNoticeCod(paramMap);
		
		return totalCount;
	}
	
	
	/** 공지사항 조회수 */
	public int updateNoticeCnt(Map<String, Object> paramMap) throws Exception {
		
		int cnt = noticeBoardDao.updateNoticeCnt(paramMap);
		
		return cnt;
	}

	
	/** 공지사항 단건 조회 */
	public NoticeBoardModel selectNoticeCod(Map<String, Object> paramMap) throws Exception {
		
		NoticeBoardModel noticeBoardModel = noticeBoardDao.selectNoticeCod(paramMap);
		
		System.out.println("서비스에 파일 들어가나? : " + noticeBoardModel);
		
		return noticeBoardModel;
	}
	
	
	/** 공지사항 파일 가져오기 */
	public NoticeBoardModel selectFile(Map<String, Object> paramMap) throws Exception {
		
		NoticeBoardModel selectFile = noticeBoardDao.selectFile(paramMap);
		
		return selectFile;
	}
	
	
	/** 공지사항 신규 등록 */
	@Transactional 
	@Override
	public int insertNoticecode(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		String itemFilePath = noticePath + File.separator; // 파일 구분자(os별로 다르기 때문에 java에서 자동 적용)
		UploadFileUtil fileUtil = new UploadFileUtil(request, rootPath, virtualRootPath, itemFilePath); //request와 파일저장루트, 디렉토리루트 전달
		
		List<NoticeBoardModel> fileInfo = null;
		try {
			fileInfo = fileUtil.uploadFiles();
		} catch (Exception e) {
			e.printStackTrace();
		}
		Iterator<NoticeBoardModel> iter = fileInfo.iterator();

		String file_server_path = "";	
		String file_local_path = "";
		String file_new_name = "";
		String file_ofname = "";
		int file_size = 0;
		
		while(iter.hasNext()) {
			NoticeBoardModel tempFileInfo = (NoticeBoardModel)iter.next();
			file_server_path = tempFileInfo.getFile_server_path();
			file_local_path = tempFileInfo.getFile_local_path();
			file_new_name = tempFileInfo.getFile_new_name();
			file_ofname = tempFileInfo.getFile_ofname();
			file_size = tempFileInfo.getFile_size();
			
			String dbfile_local_path = "/serverfile" + File.separator + itemFilePath + file_ofname;
			String dbfile_new_name = rootPath + File.separator + itemFilePath + file_ofname;
			
//			System.out.println("file_server_path : " + dbfile_local_path);
//			System.out.println("file_local_path : " + dbfile_local_path);
//			System.out.println("file_new_name : " + dbfile_new_name);
//			System.out.println("file_ofname : " + file_ofname);
//			System.out.println("file_size : " + file_size);
//			
//			System.out.println("dbfile_local_path : " + dbfile_local_path);
//			System.out.println("dbfile_new_name : " + dbfile_new_name);
			
			//쿼리 파라미터 값 넣기
			paramMap.put("file_server_path", dbfile_local_path);
			paramMap.put("file_local_path", dbfile_local_path);
			paramMap.put("file_new_name", dbfile_new_name);
			paramMap.put("file_ofname", file_ofname);
			paramMap.put("file_size", file_size);
		}
		
		int resultNotice = noticeBoardDao.insertNoticecode(paramMap);

		return resultNotice;
	}

	
	/** 공지사항 수정 */
	@Transactional 
	@Override
	public int updateNoticecode(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		// 파일이 단건이기 때문에 빈 객체로 생성
		NoticeBoardModel deleteFile = new NoticeBoardModel();
		String itemFilePath = noticePath + File.separator; // 파일 구분자(os별로 다르기 때문에 java에서 자동 적용)
		UploadFileUtil fileUtil = new UploadFileUtil(request, rootPath, virtualRootPath, itemFilePath); //request와 파일저장루트, 디렉토리루트 전달
		
		NoticeBoardModel selectFile = noticeBoardDao.selectFile(paramMap);
		
		deleteFile = selectFile;
		
		try {
			fileUtil.deleteFiles(deleteFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		List<NoticeBoardModel> fileInfo = null;
		try {
			fileInfo = fileUtil.uploadFiles();
		} catch (Exception e) {
			e.printStackTrace();
		}
		Iterator<NoticeBoardModel> iter = fileInfo.iterator();

		String file_server_path = "";	
		String file_local_path = "";
		String file_new_name = "";
		String file_ofname = "";
		int file_size = 0;
		
	    // 파일 업로드한 게 있을 때
		while(iter.hasNext()) {
			NoticeBoardModel tempFileInfo = (NoticeBoardModel)iter.next();
			file_server_path = tempFileInfo.getFile_server_path();
			file_local_path = tempFileInfo.getFile_local_path();
			file_new_name = tempFileInfo.getFile_new_name();
			file_ofname = tempFileInfo.getFile_ofname();
			file_size = tempFileInfo.getFile_size();
	
			String dbfile_local_path = "/serverfile" + File.separator + itemFilePath + file_ofname;
			String dbfile_new_name = rootPath + File.separator + itemFilePath + file_ofname;
			
//			System.out.println("file_server_path : " + dbfile_local_path);
//			System.out.println("file_local_path : " + dbfile_local_path);
//			System.out.println("file_new_name : " + dbfile_new_name);
//			System.out.println("file_ofname : " + file_ofname);
//			System.out.println("file_size : " + file_size);
//			
//			System.out.println("dbfile_local_path : " + dbfile_local_path);
//			System.out.println("dbfile_new_name : " + dbfile_new_name);
			
			//쿼리 파라미터 값 넣기
			paramMap.put("file_server_path", dbfile_local_path);
			paramMap.put("file_local_path", dbfile_local_path);
			paramMap.put("file_new_name", dbfile_new_name);
			paramMap.put("file_ofname", file_ofname);
			paramMap.put("file_size", file_size);		

		}	
			
		int resultNotice = noticeBoardDao.updateNoticecode(paramMap);	
		
		return resultNotice;
	}
	
	
	/** 공지사항 삭제 */
	public void deleteNoticeCod(Map<String, Object> paramMap) throws Exception {
		
		noticeBoardDao.deleteNoticeCod(paramMap);
		
	}

}
