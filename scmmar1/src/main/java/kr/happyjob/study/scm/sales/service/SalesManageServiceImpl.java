package kr.happyjob.study.scm.sales.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.happyjob.study.common.comnUtils.NewFileUtil;
import kr.happyjob.study.scm.model.FileModel;
import kr.happyjob.study.scm.sales.dao.SalesManageDao;
import kr.happyjob.study.scm.sales.model.PageInfo;
import kr.happyjob.study.scm.sales.model.SalesDetails;
import kr.happyjob.study.scm.sales.model.SalesRegData;

@Service
public class SalesManageServiceImpl implements SalesManageService{
	
	
	private SqlSessionTemplate sst;
	private SalesManageDao smDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	@Value("${fileUpload.salesItemPath}")
	private String salesItemPath;
	
	public SalesManageServiceImpl() {
	
	}
	
	@Autowired
	public SalesManageServiceImpl(SqlSessionTemplate sst) {
		
		this.sst = sst;

	}

	@Override
	@Transactional
	public PageInfo getSalesList(PageInfo info) {
		
		info.setTotalCount(sst.getMapper(SalesManageDao.class).getTotalCount(info));
		
		int selectPage=info.getSelectPage();
		int rowsPerPage=info.getRowsPerPage();
		int total=info.getTotalCount();
		
		int totalPage=total/rowsPerPage;
		totalPage=total%rowsPerPage>0? totalPage+1 : totalPage;
		
		selectPage=selectPage>totalPage? totalPage : selectPage;
		
		info.setSelectPage(selectPage);
		
		
		
		info.setFirstIndex(info.getRowsPerPage()*(info.getSelectPage()-1));
		
		info.setSalesList(sst.getMapper(SalesManageDao.class).getSalesList(info));
		
		
		
		return info;
	}
	
	
	@Override
	public SalesDetails getSalesDetails(String sales_id){
		// 상품상세정보 가져오기
		SalesDetails info = sst.getMapper(SalesManageDao.class).getSalesDetails(sales_id);
		
		
		// 상품에 대한 첨부파일들 DB 정보 가져오기
		// SalesDetails 안의 fileList에 저장
		//...
		//..
		List<FileModel> files=sst.getMapper(SalesManageDao.class).getFilesBySalesID(sales_id);
		info.setFiles(files);
		//...
		////////////////////////////
		
		return info;
		
	}
	
	@Override
	@Transactional
	public int deleteSales(String idx) {
		
		// DAO 할당
		smDao=sst.getMapper(SalesManageDao.class);
		
		// 삭제된 결과
		int result=0;
		
		// 해당 상품에 대한 모든 사진 파일 Data 를 가져온다
		List<FileModel> files=smDao.getFilesBySalesID(idx);
		
		// 해당 상품 데이터를 지운다
		result=smDao.deleteSales(idx);
		
		if(result==1){
			
			int fileDeleteResult=0;
			
			try{
				
				// 가져온 상품 사진 데이터를 tv_sales_file 에서 모두 지운다
				fileDeleteResult= smDao.deleteFiles(files);
				
				// file_local_path 경로에 있는 파일을 모두 삭제한다
				NewFileUtil.deleteFiles(files);
				
			}catch(Exception e){
				e.printStackTrace();
				if(fileDeleteResult!=files.size()){
					System.out.println("DB 통신 에러 또는 파일 일부가 로컬경로에서 삭제되지 않음");
				}
			}
		}
		
		
		
		
		return result;
	}

	@Override
	public int updateSales(SalesRegData data) {
		
		return 1;
	}

	@Override
	@Transactional
	public int insertSales(SalesRegData data, HttpServletRequest req) throws Exception {
		
		
		
		// 상품 정보 추가
		int result=sst.getMapper(SalesManageDao.class).insertSales(data);
		if(result==1){
			
			
			NewFileUtil fUtil=new NewFileUtil(req, rootPath, virtualRootPath, salesItemPath);
			// OK
			Map<String, List<FileModel>> filesMap = fUtil.uploadFiles(data.getSales_id());
			
			
			List<FileModel> files= filesMap.get("files");
			
			// 상품-파일 테이블 하나에만 추가하면 되므로 별도 로직 필요 없음
			try{
				sst.getMapper(SalesManageDao.class).insertFiles(files);
			}catch(Exception e){
				
				e.printStackTrace();
				
				result=0;
				
				
				
				// 파일 등록 도중 오류 발생시
				// 정상적으로 등록했던 모든 파일을 지운다
				// + Transactional 처리로 최초 들어간 상품에 대해서도 rollback 처리
				NewFileUtil.deleteFiles(files);
			}
			
			
			
			
//			DB 배열(테이블당) FileModel 데이터 추가
//			
//			for(List<FileModel> files : filesArray){
//				// 상품-파일 테이블 하나에만 추가하면 되므로 별도 로직 필요 없음
//				try{
//					sst.getMapper(SalesManageDao.class).insertFiles(files);
//				}catch(Exception e){
//					
//					e.printStackTrace();
//					
//					result=0;
//					
//					// 파일 등록 도중 오류 발생시
//					// 정상적으로 등록했던 모든 파일을 지운다
//					// + Transactional 처리로 최초 들어간 상품에 대해서도 rollback 처리
//					fUtil.deleteFiles(files);
//				}
//				
//			}
			
		}
		
		
		
		
		
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
