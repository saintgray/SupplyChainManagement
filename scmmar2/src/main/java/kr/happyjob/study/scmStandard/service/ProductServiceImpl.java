package kr.happyjob.study.scmStandard.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.NewFileUtil;
import kr.happyjob.study.scm.model.FileModel;
import kr.happyjob.study.scmStandard.dao.ProductDao;
import kr.happyjob.study.scmStandard.model.ProductFileModel;
import kr.happyjob.study.scmStandard.model.ProductModel;
import kr.happyjob.study.scmStandard.util.ProductFileUtil;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDao productDao;
	
	@Value("${fileUpload.virtualRootPath}")
	private static String virtualRootPath;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;	
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	/** 제품 정보 목록 조회 */
	public List<ProductModel> listProductCod(Map<String, Object> paramMap) throws Exception {
		
		List<ProductModel> listProductCod = productDao.listProductCod(paramMap);
		
		return listProductCod;
	}
	
	/** 제품 정보 목록 카운트 조회 */
	public int countListProductCod(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = productDao.countListProductCod(paramMap);
		
		return totalCount;
	}
	
	/** 제품 정보 단건 조회 */
	public ProductModel selectProductCod(Map<String, Object> paramMap) throws Exception {
		
		ProductModel productCodModel = productDao.selectProductCod(paramMap);
		
		return productCodModel;
	}
	
	/** 파일 정보 조회 */
	public ProductFileModel selectFile(Map<String, Object> paramMap) throws Exception {
		
		ProductFileModel selectFile = productDao.selectFile(paramMap);
		
		return selectFile;
	}

	/** 제품 모델 및 제품 정보 저장 */
	@Transactional 
	@Override
	public int insertproductcode(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		String itemFilePath = noticePath + File.separator; // 파일 구분자(os별로 다르기 때문에 java에서 자동 적용)
		ProductFileUtil fileUtil = new ProductFileUtil(request, rootPath, virtualRootPath, itemFilePath); //request와 파일저장루트, 디렉토리루트 전달
		
		List<ProductFileModel> fileInfo = null;
		try {
			fileInfo = fileUtil.uploadFiles();
		} catch (Exception e) {
			e.printStackTrace();
		}
		Iterator<ProductFileModel> iter = fileInfo.iterator();

		String file_server_path = "";	
		String file_local_path = "";
		String file_new_name = "";
		String file_ofname = "";
		int file_size = 0;
		
		int detail = productDao.insertproductcode(paramMap);
		
		while(iter.hasNext()) {
			ProductFileModel tempFileInfo = (ProductFileModel)iter.next();
			file_server_path = tempFileInfo.getFile_server_path();
			file_local_path = tempFileInfo.getFile_local_path();
			file_new_name = tempFileInfo.getFile_new_name();
			file_ofname = tempFileInfo.getFile_ofname();
			file_size = tempFileInfo.getFile_size();
			
			String dbfile_local_path = "/serverfile" + File.separator + itemFilePath + file_ofname;
			String dbfile_new_name = rootPath + File.separator + itemFilePath + file_ofname;
			
//			System.out.println(">> file_server_path : " + dbfile_local_path);
//			System.out.println(">> file_local_path : " + dbfile_local_path);
//			System.out.println(">> file_new_name : " + dbfile_new_name);
//			System.out.println(">> file_ofname : " + file_ofname);
//			System.out.println(">> file_size : " + file_size);
//			
//			System.out.println("---->> dbfile_local_path : " + dbfile_local_path);
//			System.out.println("---->> dbfile_new_name : " + dbfile_new_name);
			
			//쿼리 파라미터 값 넣기
			paramMap.put("file_server_path", dbfile_local_path);
			paramMap.put("file_local_path", dbfile_local_path);
			paramMap.put("file_new_name", dbfile_new_name);
			paramMap.put("file_ofname", file_ofname);
			paramMap.put("file_size", file_size);
			
			int result = productDao.insertProducteFile(paramMap);
		}
		
		return detail;
	}
	
	/** 제품 정보 삭제 전 조회 */
	public ProductModel selectProductCodpre(Map<String, Object> paramMap) throws Exception {
		
		ProductModel selecttaget = productDao.selectProductCodpre(paramMap);
		
		return selecttaget;
		
	}
	
	/** 제품 정보 삭제 */
	public void deleteProductCod(Map<String, Object> paramMap) throws Exception {
		
		productDao.deleteProductCod(paramMap);
		
	}
	
	/** 제품 모델 정보 삭제 */
	public void deleteModelCod(Map<String, Object> paramMap) throws Exception {
		
		productDao.deleteModelCod(paramMap);
		
	}
	
	/** 제품 정보 수정 */
	@Transactional 
	@Override
	public int updateProductCod(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		int resultPd = 0;
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		List<ProductFileModel> deleteFile = new ArrayList<ProductFileModel>();//빈 리스트 생성 (한번에 많은 파일 삭제 대비용으로)
		String itemFilePath = noticePath + File.separator; // 파일 구분자(os별로 다르기 때문에 java에서 자동 적용)
		ProductFileUtil fileUtil = new ProductFileUtil(request, rootPath, virtualRootPath, itemFilePath); //request와 파일저장루트, 디렉토리루트 전달

		ProductFileModel selectFile = productDao.selectFile(paramMap);
		
		if (selectFile != null) {
			
			deleteFile.add(selectFile);
			
			try {
				fileUtil.deleteFiles(deleteFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			List<ProductFileModel> fileInfo = null;
			try {
				fileInfo = fileUtil.uploadFiles();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			Iterator<ProductFileModel> iter = fileInfo.iterator();
			
			String file_server_path = "";	
			String file_local_path = "";
			String file_new_name = "";
			String file_ofname = "";
			int file_size = 0;
			
			resultPd = productDao.updateProductCod(paramMap);
			
			if (fileInfo == null || fileInfo.isEmpty()) {
				
				int resultdf = productDao.deleteFile(paramMap);
				
				while(iter.hasNext()) {
					ProductFileModel tempFileInfo = (ProductFileModel)iter.next();
					file_server_path = tempFileInfo.getFile_server_path();
					file_local_path = tempFileInfo.getFile_local_path();
					file_new_name = tempFileInfo.getFile_new_name();
					file_ofname = tempFileInfo.getFile_ofname();
					file_size = tempFileInfo.getFile_size();
					
					String dbfile_local_path = "/serverfile" + File.separator + itemFilePath + file_ofname;
					String dbfile_new_name = rootPath + File.separator + itemFilePath + file_ofname;
					
//					System.out.println(">> file_server_path : " + dbfile_local_path);
//					System.out.println(">> file_local_path : " + dbfile_local_path);
//					System.out.println(">> file_new_name : " + dbfile_new_name);
//					System.out.println(">> file_ofname : " + file_ofname);
//					System.out.println(">> file_size : " + file_size);
//					
//					System.out.println("---->> dbfile_local_path : " + dbfile_local_path);
//					System.out.println("---->> dbfile_new_name : " + dbfile_new_name);
					
					//쿼리 파라미터 값 넣기
					paramMap.put("file_server_path", dbfile_local_path);
					paramMap.put("file_local_path", dbfile_local_path);
					paramMap.put("file_new_name", dbfile_new_name);
					paramMap.put("file_ofname", file_ofname);
					paramMap.put("file_size", file_size);
					
					int result = productDao.insertProducteFile(paramMap);
					
				}
			
			}
			
		} else {
			
			resultPd = productDao.updateProductCod(paramMap);
		}
			return resultPd;
	}
	
	/** 제품 파일 삭제 */
	public int deleteFile(Map<String, Object> paramMap) throws Exception {
		
		int delete = productDao.deleteFile(paramMap);
		
		return delete;
		
	}
	
}
