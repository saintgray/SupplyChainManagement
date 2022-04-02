package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.nexacro.Login.vo.UserVO;
import com.nexacro.sample.vo.PersonListDTO;
import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("personListDAO")
public class PersonListDAO extends NexacroIbatisAbstractDAO {

	    //Map처리 추가 
	    public List<PersonListDTO> searchList(Map<String, String> map) {
	    	//return (PersonListDTO) select("map.searchList", map);
	    	
	    	return (List<PersonListDTO>) list("person.searchList",map);
	    }    
	    
	
}
