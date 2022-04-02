package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.sample.vo.SampleVO;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

/**
 * 
 * <pre>
 * @desc    제공된 예제는 샘플용으로 작성된 코드로 참고용으로만
 *          사용하시기 바랍니다.
 * @package com.nexacro.sample.service.impl.ibatis
 * <pre>
 * 
 * @author  TOBESOFT
 * @since   2018. 1. 18.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2018. 1. 18.		TOBESOFT	최초작성
 */
@Repository("nexacrotestDAO")
public class testDAO extends NexacroIbatisAbstractDAO {
  
    ////////////////////////////////////////////////// crudtest
	
    public List<Map> testselect(Map<String,String> searchInfo) {
    	return (List<Map>) list("nexacrotest.testselect", searchInfo);
    }
    
    public void deletetest(Map<String,Object> sample) {
        delete("nexacrotest.deletetest", sample);
    }
    
    public void inserttest(Map<String,Object> sample) {
        insert("nexacrotest.inserttest", sample);
    }
    
    public void updatetest(Map<String,Object> sample) {
        update("nexacrotest.updatetest", sample);
    }
}
