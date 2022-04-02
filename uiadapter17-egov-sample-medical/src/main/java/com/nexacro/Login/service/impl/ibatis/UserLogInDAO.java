package com.nexacro.Login.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.Login.vo.UserVO;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

/**
 * <pre>
 * @desc    Login 처리를 한다.
 * @package com.nexacro.Login.service.impl.ibatis
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
@Repository("userLogInDAO")
public class UserLogInDAO extends NexacroIbatisAbstractDAO {

    //Map처리 추가 
    public UserVO login(UserVO user) {
    	return (UserVO) select("user.login", user);
    }    
    
    
}
