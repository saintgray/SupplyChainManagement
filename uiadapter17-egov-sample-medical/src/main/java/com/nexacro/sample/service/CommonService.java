package com.nexacro.sample.service;

import java.util.List;
import java.util.Map;

import com.nexacro.sample.vo.CommonVO;

/**
 * 
 * <pre>
 * @desc    공통 모듈 처리.
 * @package com.nexacro.sample.service
 * <pre>
 * 
 * @author  황기현
 * @since   2019. 9. 9.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2019. 9. 9.	황기현	       최초작성
 */
public interface CommonService {
	List<CommonVO> selectcommcdcombo(String grpCd);
    
}
