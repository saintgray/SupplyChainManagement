package com.nexacro.Login.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.nexacro.Login.service.UserLogInService;
import com.nexacro.Login.service.impl.ibatis.UserLogInDAO;
import com.nexacro.Login.vo.UserVO;

import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro17.xapi.data.DataSet;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 
 * <pre>
 * @desc    Login 처리를 한다.
 * @package com.nexacro.Login.service.impl
 * <pre>
 * 
 * @author  황기현
 * @since   2019. 8. 20.
 * @version 1.0
 * @see
 * =================== 변경 내역 ==================
 * 날짜			변경자		내용
 * ------------------------------------------------
 * 2019. 8. 20.	황기현	       최초작성
 */
@Service("userLogInService")
//@Service
public class UserLogInServiceImpl extends EgovAbstractServiceImpl implements UserLogInService {

    @Resource(name = "userLogInDAO")
    // Name 정의
    private UserLogInDAO userLogInDAO;

      
    @Override
    public UserVO login(UserVO userInfo) {
    	UserVO returnUser = new UserVO();
    	
        if (userInfo instanceof DataSetRowTypeAccessor){
        	returnUser = userLogInDAO.login(userInfo);
        }
             
        return returnUser;
    }
    
}
