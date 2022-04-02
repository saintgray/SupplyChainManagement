package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.nexacro.Login.vo.UserVO;
import com.nexacro.sample.service.impl.ibatis.PersonListDAO;
import com.nexacro.sample.vo.PersonListDTO;
import com.nexacro.sample.service.PersonListService;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;
import com.nexacro17.xapi.data.DataSet;
  
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

@Service("PersonListDAO")
public class PersonListServicelmpl extends NexacroIbatisAbstractDAO implements PersonListService{

	@Resource(name = "personListDAO")
	private PersonListDAO personListDAO;
	
	@Override
	public List<PersonListDTO> searchList(Map<String, String> map) {
		//PersonListDTO dto = new PersonListDTO();
		List<PersonListDTO> dto = personListDAO.searchList(map);
		return dto;
	}

	@Override
	public void save(DataSet set) {
		// TODO Auto-generated method stub
		
	}

  
    
    
}
