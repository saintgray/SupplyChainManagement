package kr.happyjob.study.scmStandard.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scmStandard.model.ProductFileModel;
import kr.happyjob.study.scmStandard.model.ProductModel;

public interface ProductDao {

	/** 제품 정보 목록 조회 */
	public List<ProductModel> listProductCod(Map<String, Object> paramMap);
	
	/** 제품 정보 목록 카운트 조회 */
	public int countListProductCod(Map<String, Object> paramMap);
	
	/** 제품 정보 단건 조회 */
	public ProductModel selectProductCod(Map<String, Object> paramMap);
	
	/** 제품 정보 저장 */
	public int insertproductcode(Map<String, Object> paramMap);
	
	/** 제품 정보 삭제 전 조회 */
	public ProductModel selectProductCodpre(Map<String, Object> paramMap);
	
	/** 제품 정보 삭제 */
	public void deleteProductCod(Map<String, Object> paramMap);

	/** 제품 모델 정보 삭제 */
	public void deleteModelCod(Map<String, Object> paramMap);
	
	/** 제품 정보 수정 */
	public int updateProductCod(Map<String, Object> paramMap);
	
	/** 제품 파일 조회 */
	public ProductFileModel selectFile(Map<String, Object> paramMap) throws Exception;
	
	/** 제품 파일 등록 */
	public int insertProducteFile(Map<String, Object> paramMap) throws Exception;
	
	/** 제품 파일 삭제 */
	public int deleteFile(Map<String, Object> paramMap) throws Exception;
}
