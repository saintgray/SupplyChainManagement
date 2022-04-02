package com.nexacro.sample.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nexacro.sample.service.CommonService;
import com.nexacro.sample.service.impl.ibatis.CommonDAO;
import com.nexacro.sample.vo.CommonVO;

import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro17.xapi.data.DataSet;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 
 * <pre>
 * 
 * @desc 공통 모듈 처리.
 * @package com.nexacro.sample.service.impl
 * 
 *          <pre>
 * 
 * @author 황기현
 * @since 2019. 9. 9.
 * @version 1.0
 * @see =================== 변경 내역 ================== 날짜 변경자 내용
 *      ------------------------------------------------ 2019. 9. 9. 황기현 최초작성
 */
@Service("commonService")
// @Service
public class CommonServiceImpl extends EgovAbstractServiceImpl implements CommonService {

	@Resource(name = "commonDAO")
	// Name 정의
	private CommonDAO commonDAO;

	@Override
	public List<CommonVO> selectcommcdcombo(String grpCd) {

		// System.out.println("UserLogInServiceImpl userInfo id : " +
		// userInfo.get("id"));
		// System.out.println("UserLogInServiceImpl userInfo password : " +
		// userInfo.get("password"));
		List<CommonVO> returnUser = commonDAO.selectcommcdcombo(grpCd);
		return returnUser;
	}

}
