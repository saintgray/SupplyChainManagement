package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.nexacro.sample.service.testService;
import com.nexacro.sample.service.impl.ibatis.testDAO;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro17.xapi.data.DataSet;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 
 * <pre>
 * @desc    제공된 예제는 샘플용으로 작성된 코드로 참고용으로만
 *          사용하시기 바랍니다.
 * @package com.nexacro.sample.service.impl
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
@Service("nexacrotestService")
public class testServiceImpl extends EgovAbstractServiceImpl implements testService {

	private Logger logger = LoggerFactory.getLogger(testServiceImpl.class);
    @Resource(name = "nexacrotestDAO")
    // Name 정의
    private testDAO nexacrotestDAO;

    	
	////////////////////////////////////////////////////////////////////crud test
	
	@Override
	public List<Map<String, Object>> testselect(Map<String, String> searchInfo) {
		
		return (List) nexacrotestDAO.testselect(searchInfo);
	}

	@Override
	public void updatetest(List<Map<String, Object>> sampleList) {
		
		logger.debug("..... updatetest .....");
        int size = sampleList.size();
        for (int i=0; i<size; i++) {
        	Map<String,Object> sample = sampleList.get(i);
        	
    		int dataRowType = Integer.parseInt(String.valueOf(sample.get(DataSetRowTypeAccessor.NAME)));
    		logger.debug("..... dataRowType >>"+dataRowType);
            if (dataRowType == DataSet.ROW_TYPE_INSERTED){
            	nexacrotestDAO.inserttest(sample);
            }
            else if (dataRowType == DataSet.ROW_TYPE_UPDATED){
            	nexacrotestDAO.updatetest(sample);
            }
            else if (dataRowType == DataSet.ROW_TYPE_DELETED){
            	nexacrotestDAO.deletetest(sample);
            }
        }
	}

	

	
}