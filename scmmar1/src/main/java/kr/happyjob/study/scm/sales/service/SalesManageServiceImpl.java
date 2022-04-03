package kr.happyjob.study.scm.sales.service;

import java.io.FileNotFoundException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysql.jdbc.exceptions.jdbc4.MySQLSyntaxErrorException;

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
			
			// OK
			NewFileUtil fUtil=new NewFileUtil(req, rootPath, virtualRootPath, salesItemPath);
		
			
			
			try{
				
				
				
				Map<String, List<FileModel>> filesMap = fUtil.uploadFiles(data.getSales_id());
				
				List<FileModel> files= filesMap.get("files");
				
				// 상품-파일 테이블 하나에만 추가하면 되므로 별도 로직 필요 없음
				
			
				sst.getMapper(SalesManageDao.class).insertFiles(files);
			
				
				
				// 파일 등록 도중 오류 발생시
				// 정상적으로 등록했던 모든 파일을 지운다
				// + Transactional 처리로 최초 들어간 상품에 대해서도 rollback 처리
				NewFileUtil.deleteFiles(files);

					
				
				
				
				
				
				
			}catch(FileNotFoundException e){
				
				e.printStackTrace();
				
				
			}
		
		}
		
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
