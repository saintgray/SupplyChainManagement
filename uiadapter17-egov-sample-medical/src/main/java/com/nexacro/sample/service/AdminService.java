package com.nexacro.sample.service;


import java.util.List;
import java.util.Map;


import com.nexacro.sample.vo.DetailCDVO;


/**
 * 
 * <pre>
 * 
 * @desc 공통코드.
 * @package com.nexacro.sample.service
 * 
 *          <pre>
 * 
 * @author 이미혜
 * @since 2019. 9. 16.
 * @version 1.0
 * @see =================== 변경 내역 ================== 날짜 변경자 내용
 *      ------------------------------------------------
 * 
 */

public interface AdminService {
	
	List<Map<String,Object>> selectCDListMap(Map<String, Object> gcdMap);
	void GcodeUpdateMap(List<Map<String, Object>> groupUpdate);

/*******************************상세코드****************************************/
	List<DetailCDVO> DetailCDVO(String group_code);
	void DetailUpdate(List<Map<String,Object>>DetailUpdate);
	

	

}
