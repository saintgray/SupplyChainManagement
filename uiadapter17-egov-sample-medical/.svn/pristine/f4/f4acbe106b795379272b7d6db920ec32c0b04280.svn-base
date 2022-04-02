package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.nexacro.sample.service.AdminService;
import com.nexacro.sample.service.impl.ibatis.AdminDAO;
import com.nexacro.sample.vo.DetailCDVO;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro17.xapi.data.DataSet;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

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

@Service("adminService")
public class AdminServiceImpl extends EgovAbstractServiceImpl implements AdminService {
	private Logger logger = LoggerFactory.getLogger(UiAdapterSampleServiceImpl.class);
	int size;
	int dataRowType;
	// size 두개 사용해서 전역으로 선언함;
	@Resource(name = "adminDAO")
	private AdminDAO adminDAO;

	
	@Override
	public List<Map<String, Object>> selectCDListMap(Map<String, Object> gcdMap) {
		return adminDAO.selectCDListMap(gcdMap);
	}

	/* GcodeUpdateMap---- insert,update,delete START */
	@Override
	public void GcodeUpdateMap(List<Map<String, Object>> groupUpdate) {
		logger.debug("..... GcodeUpdateMap......................... .....");
		size = groupUpdate.size();

		for (int i = 0; i < size; i++) {
			Map<String, Object> type = groupUpdate.get(i);
			dataRowType = Integer.parseInt(String.valueOf(type.get(DataSetRowTypeAccessor.NAME)));
			logger.debug("..... dataRowType >>" + dataRowType);

			if (dataRowType == DataSet.ROW_TYPE_INSERTED) {
				adminDAO.GcodeinsertMap(type);
			} else if (dataRowType == DataSet.ROW_TYPE_UPDATED) {
				adminDAO.GcodeUpdateMap(type);
			} else if (dataRowType == DataSet.ROW_TYPE_DELETED) {
				adminDAO.GcodeDeletetMap(type);
			}
		}
	}
	/* GcodeUpdateMap---- insert,update,delete END */

	/***********************************상세코드 처리 ************************************************/
	@Override
	public List<DetailCDVO> DetailCDVO(String group_code) {
		return adminDAO.selectDCDListVO(group_code);
	}

	/* DetailUpdate---- insert,update,delete START */
	@Override
	public void DetailUpdate(List<Map<String, Object>> DetailUpdate) {
		logger.debug("DetailUpdate==============================" + DetailUpdate);
		size = DetailUpdate.size();

		for (int y = 0; y < size; y++) {
			Map<String, Object> type = DetailUpdate.get(y);
			dataRowType = Integer.parseInt(String.valueOf(type.get(DataSetRowTypeAccessor.NAME)));

			if (dataRowType == DataSet.ROW_TYPE_INSERTED) {
				adminDAO.DetailInsertMap(type);
			} else if (dataRowType == DataSet.ROW_TYPE_UPDATED) {
				adminDAO.DetailUpdateMap(type);
			} else if (dataRowType == DataSet.ROW_TYPE_DELETED) {
				adminDAO.DetailDeleteMap(type);
			}
		}
	}
	/* DetailUpdate---- insert,update,delete END */
	
	
	


	
	
	
	
	
	
	
	

}// AdminServiceImpl
