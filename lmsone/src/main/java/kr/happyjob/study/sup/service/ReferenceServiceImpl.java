package kr.happyjob.study.sup.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.sup.dao.ReferenceDao;

@Service
public class ReferenceServiceImpl implements ReferenceService {
	@Autowired
	ReferenceDao referenceDao;

	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.reference}")
	private String reference;

	@Override
	public List<Map<String, Object>> selectReferenceList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return referenceDao.selectReferenceList(paramMap);
	}

	@Override
	public int countReferenceList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return referenceDao.countReferenceList(paramMap);
	}

	@Override
	public void registerReferenceBoardFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;

		// 파일 저장
		String itemFilePath = reference + File.separator;
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 업로드 처리

		// 데이터 저장


		paramMap.put("fileInfo", fileInfo);

		referenceDao.registerReferenceBoardFile(paramMap);

		

	}

	@Override 
	public Map<String, Object> selectDownloadFile(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return referenceDao.selectDownloadFile(paramMap);
	}

	@Override
	public Map<String, Object> referenceDtlInfo(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return referenceDao.referenceDtlInfo(paramMap);
	}

	@Override
	public void registerReferenceBoardContent(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		referenceDao.registerReferenceBoardContent(paramMap);
	}


	@Override
	public void deleteReferenceBoardFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		String itemFilePath = reference + File.separator;
		FileUtilCho delFileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath+File.separator+itemFilePath, itemFilePath);
		/*물리 위치 삭제*/
		Map<String, Object> delFileinfo = referenceDao.selectReferenceFileInfo(paramMap);
		delFileinfo.put("file_nm", delFileinfo.get("file_name"));
		//System.out.println(rootPath+File.separator+itemFilePath+fileinfo.get("file_nm"));
		delFileUtil.deleteFiles(delFileinfo);
		
		/*물리 위치 저장*/
		FileUtilCho addFileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, itemFilePath);
		Map<String, Object> addFileinfo = addFileUtil.uploadFiles(); // 업로드 처리
		paramMap.put("fileInfo", addFileinfo);
		paramMap.put("file_no", delFileinfo.get("file_no"));
		
		/*db업데이트*/
		referenceDao.updateReferenceBoardFile(paramMap); 
		
		
		//int file_no = referenceDao.selectFile_no(paramMap);
		//paramMap.put("file_no", file_no);
		//referenceDao.updateReferenceBoardFile(file_no);
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateReferenceBoardContent(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		referenceDao.updateReferenceBoardContent(paramMap);
	}

	@Override
	public void deleteReference(Map<String, Object> paramMap, HttpServletRequest request)  throws Exception{
		// TODO Auto-generated method stub
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		String itemFilePath = reference + File.separator;
		FileUtilCho delFileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath+File.separator+itemFilePath, itemFilePath);
		
		/*물리 위치 삭제*/
		Map<String, Object> delFileinfo = referenceDao.selectReferenceFileInfo(paramMap);
		delFileinfo.put("file_nm", delFileinfo.get("file_name"));
		//System.out.println(rootPath+File.separator+itemFilePath+fileinfo.get("file_nm"));
		delFileUtil.deleteFiles(delFileinfo);
		
		/*db 삭제*/
		paramMap.put("file_no", delFileinfo.get("file_no"));
		referenceDao.deleteReferenceBoardContent(paramMap);
		referenceDao.deleteReferenceBoardFile(paramMap);
		
	}

}
