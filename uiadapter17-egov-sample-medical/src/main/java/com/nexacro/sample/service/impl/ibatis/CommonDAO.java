package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.sample.vo.CommonVO;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

/**
 * <pre>
 * @desc    공통 모듈 처리.
 * @package com.nexacro.sample.service.impl.ibatis
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
@Repository("commonDAO")
public class CommonDAO extends NexacroIbatisAbstractDAO {

    //Map처리 추가 
    @SuppressWarnings("unchecked")
	public List<CommonVO> selectcommcdcombo(String grpCd) {
    	//System.out.println("UserLogInDAO userInfo id : " + userInfo.get("id"));
    	//System.out.println("UserLogInDAO userInfo password : " + userInfo.get("password"));
   	
    	return (List<CommonVO>) list("common.selectcommcdcombo", grpCd);
    }    
    
}
