package kr.happyjob.study.notice.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.common.comnUtils.NewFileUtil;
import kr.happyjob.study.notice.dao.ScmNoticeDao;
import kr.happyjob.study.notice.exception.NoticeNotExistException;
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
		
		if(detailNotice==null){
			throw new NoticeNotExistException();
		}else{
			detailNotice.setFilesInfo(noticeDao.selectFilesByNoticeId(paramMap));
		}
		
		return detailNotice;
	}
	
	// 파일정보 가져오기
	@Override
	public List<FileModel> selectFilesByNoticeId(Map<String, Object> paramMap)throws Exception {
		List<FileModel> selectFile = noticeDao.selectFilesByNoticeId(paramMap);
		return selectFile;
	}
	
	@Override
	// 선택한 파일들의 정보 가져오기
	public List<FileModel> selectFilesByFileNo(List<String> delTargets) {
		
		return noticeDao.selectFilesByFileNo(delTargets);
	}


	
	@Override
	public FileModel selectOneFile(String file_no){
		return noticeDao.selectOneFile(file_no);
	}

	@Transactional
	@Override
	public int insertNotice(NoticeModel data,List<MultipartFile> files, HttpServletRequest request) throws Exception{
		
		String loginID=request.getSession().getAttribute("loginId").toString();
		data.setLoginID(loginID);
		System.out.println("loginID>>>>"+loginID);
		
		
		int insertNoticeResult=noticeDao.insertNotice(data);
		
		List<FileModel> filesInfoList=null;
		
		if(insertNoticeResult>0){
			
			System.out.println("files uploaded....");
			
			NewFileUtil fUtil=new NewFileUtil(request, rootPath, virtualRootPath, noticePath);
			
			filesInfoList=fUtil.uploadFiles(files, String.valueOf(data.getNtc_no()));
			
			int filesNum=files.size();
		
			
			if(!files.isEmpty()){
				
				int insertFilesResult=noticeDao.insertNoticeFile(filesInfoList);
				
				System.out.printf("업로드 파일 수 : %d , 실제 파일 insert 결과 %d \n", filesNum, insertFilesResult);
				if(filesNum!=insertFilesResult){
					throw new Exception();
				}
			}
		}
		
		
		return insertNoticeResult;
		
	}
	
	
	
	/**
	 * 
	 * @param latestNoticeInfo : 수정하려는 공지사항의 수정 전 정보
	 * @param paramMap : 수정정보를 담은 Map(제목, 내용)
	 * @param files : 수정하면서 새롭게 등록한 첨부파일들
	 * @param delTargets : 기존에 있던 첨부파일 중 수정하면서 지운 파일들의 고유번호 List
	 * @param req : HttpServletRequest
	 * @return : affected Row
	 * @throws Exception
	 */
	@Transactional 
	@Override
	public int updateNotice(NoticeModel latestNoticeInfo, Map<String, Object> paramMap, List<MultipartFile> files, List<String> delTargets,HttpServletRequest req) throws Exception{
	
		if(!(latestNoticeInfo.getNtc_title().equals(paramMap.get("ntc_title")))){
			paramMap.remove("ntc_title");
		}
		if(!(latestNoticeInfo.getNtc_content().equals(paramMap.get("ntc_content")))){
			paramMap.remove("ntc_content");
		}
		
		int updateResult=0;
		
		updateResult=noticeDao.updateNotice(paramMap);
		
		System.out.println("files null?? >>>"+String.valueOf(files!=null));
		
		if(updateResult>0 && files!=null){
			
			NewFileUtil fUtil=new NewFileUtil(req, rootPath, virtualRootPath, noticePath);
			fUtil.uploadFiles(files, String.valueOf(latestNoticeInfo.getNtc_no()));
			
			if(!(delTargets==null || delTargets.size()==0)){
				List<FileModel> deleteTargetList= noticeDao.selectFilesByFileNo(delTargets);
				noticeDao.deleteFiles(deleteTargetList);
				NewFileUtil.deleteFiles(deleteTargetList);
			}
		}
		return updateResult;
	}

	@Override
	public int deleteNotice(String idx) throws Exception{
		int deleteNotice = noticeDao.deleteNotice(idx);
		return deleteNotice;
	}



}
