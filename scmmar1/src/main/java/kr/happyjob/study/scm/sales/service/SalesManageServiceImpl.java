package kr.happyjob.study.scm.sales.service;

import java.io.FileNotFoundException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.common.comnUtils.NewFileUtil;
import kr.happyjob.study.scm.model.FileModel;
import kr.happyjob.study.scm.sales.dao.SalesManageDao;
import kr.happyjob.study.scm.sales.model.PageInfo;
import kr.happyjob.study.scm.sales.model.SalesDetails;
import kr.happyjob.study.scm.sales.model.SalesRegData;

@Service
public class SalesManageServiceImpl implements SalesManageService{
	
	private final Logger logger = LogManager.getLogger(this.getClass());
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
	public int deleteSales(String idx) throws Exception {
		
		// DAO 할당
		smDao=sst.getMapper(SalesManageDao.class);
		
		// 삭제된 결과
		int result=0;
		
		// 해당 상품에 대한 모든 사진 파일 Data 를 가져온다
		List<FileModel> files=smDao.getFilesBySalesID(idx);
		
		// 해당 상품 데이터를 지운다
		result=smDao.deleteSales(idx);
		
		if(result==1){
			
//			int fileDeleteResult=0;
//			상품의 삭제는 삭제유무만 업데이트한다
//			 NewFileUtil.deleteFiles(files);
//			if(fileDeleteResult!=files.size()){
//				System.out.println("DB 통신 에러 또는 파일 일부가 로컬경로에서 삭제되지 않음");
//			}
			
		}
		
		
		
		
		return result;
	}

	@Override
	@Transactional(rollbackFor={Exception.class})
	public int updateSales(SalesRegData data,HttpServletRequest req) throws Exception {
		
		smDao=sst.getMapper(SalesManageDao.class);
		NewFileUtil fUtil=new NewFileUtil(req, rootPath, virtualRootPath, salesItemPath);
		int updateResult=0;
		// 상품 정보의 업데이트
		// 1. 기존에 있던 해당 상품에 대한 파일 정보 데이터를 가져온다
		// 2. 상품 정보를 업데이트한다(on update=Cascade 설정으로 tb_sales_file 테이블의 해당 상품에 대한 파일 정보들이 전부 삭제된다)
		// 3. 새로 등록하려는 상품의 파일을 서버에 등록한다
		// 4. 새 파일 정보를 DB에 등록한다
		// 5. 1에서 가져온 데이터를 가지고 서버에 있는 해당 사진 파일들을 모두 지운다
		
		
		
		// 1.
		List<FileModel> prevFiles=smDao.getFilesBySalesID(data.getSales_id());
		for(FileModel file: prevFiles){
			System.out.println(file.getFile_no());
		}
		// 2.
		// 상품을 등록하기 전 가격으로 넘어온 값의 원화표기와 콤마를 제거한다
		data.setPrice(data.getPrice().replaceAll("[\\D]", ""));
		updateResult=smDao.updateSales(data);
		// 3.
		Map<String, List<MultipartFile>> updateFilesMap=fUtil.extractFilesMap();
		List<MultipartFile> files=updateFilesMap.get("files");
		List<FileModel> updateFiles=fUtil.uploadFiles(files,data.getSales_id());
		// 4.
		
		logger.info("+  " + updateFiles.isEmpty() + " : " + prevFiles);
		
		if(!updateFiles.isEmpty()){
			smDao.insertFiles(updateFiles);
			
			
			// 5. 
			// 새로운 상품의 사진들을 등록했으며, 이전에 그 상품에 대한 파일 정보가 남아있다면
			if(prevFiles!=null && !prevFiles.isEmpty()){
				smDao.deleteFiles(prevFiles);
				NewFileUtil.deleteFiles(prevFiles);
			}
		} 
		return updateResult;
	}

	@Override
	@Transactional(rollbackFor={Exception.class})
	public int insertSales(SalesRegData data, HttpServletRequest req) throws Exception{
		
//		스프링 프레임워크에서  @Transactional 어노테이션은 기본적으로 Checked Exception 에 대해서는 롤백시키지 않도록 설계되어 있다. 
//		그 이유는 스프링 프레임워크가 EJB에서의 관습을 따르기 때문이라고 한다.
//
//		Checked Exception : 호출하는 메소드에 대해서 발생할 수 있는 예외에 대해 예외처리를 한 경우를 의미한다.
//							예를 들어 상품 등록시에 네트워크 드라이브 경로에 파일을 등록한다고 하자
//							이 때 발생할 수 있는 예외로는 IOException, FileNotFoundException, 등등 이 있다.
//							만약 이 insertSales 메소드에서 NewFileUtil.uploadFiles 메소드를 try catch 문으로 처리하여 catch 조건에
//							발생할 수 있는 위의 예외에 대해서 처리를 해주었다면, 이미 DB에 추가된 상품데이터에 대해서는 RollBack 하지 않는다
//		Unchecked Exception : 위의 상황에서 try - catch 문으로 처리하지 않고 예외를 호출하는 쪽으로 던지는 경우에 해당한다.
//							    기본적으로 Runtime Exception 이 Unchecked Exception 으로 관리되며, Spring 은 기본적으로 Runtime Exception, 그리고 Error
//							    에 대해서만 Rollback을 하기 때문에 (= rollbackFor 를 명시하지 않을 시 기본 값은 rollbackFor={RuntimeException.class, Error.class} 라는 뜻이다)
//			
// 		기본적인 예를 보여주기 위하여 여기서는 모든 예외에 대해서 rollback 처리하며, FileNotFoundException 예외에 대해서만 rollback 처리를 하지 않았지만
//		실제 개발환경에서는 해당  Business Logic 에서 발생할 수 있는 예외를 정확히 파악하고, 작업의 최소 단위(트랜잭션)을 그 예외에 한하여 rollback 처리하는 것이 올바른 구현 방법이 되겠다.

		
		
		
		
		// 상품 정보 추가
		int result=sst.getMapper(SalesManageDao.class).insertSales(data);
		
		
		
		
		if(result==1){
			
			List<FileModel> files=null;
			
			
			// OK
			NewFileUtil fUtil=new NewFileUtil(req, rootPath, virtualRootPath, salesItemPath);
		
				
			Map<String, List<MultipartFile>> filesMap = fUtil.extractFilesMap();
			
			
			
			// 상품-파일 테이블 하나에만 추가하면 되므로 input name 별로 별도 분기 로직이 필요 없음
			files= fUtil.uploadFiles(filesMap.get("files"), data.getSales_id());
			
			sst.getMapper(SalesManageDao.class).insertFiles(files);
		
		}
		
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
