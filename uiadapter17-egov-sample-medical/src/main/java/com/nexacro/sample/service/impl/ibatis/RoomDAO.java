package com.nexacro.sample.service.impl.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("roomDAO")
public class RoomDAO extends NexacroIbatisAbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileListMap(Map<String, Object> fileMap){
		return (List<Map<String, Object>>) list("room.selectRoomList",fileMap);
		
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> viewMorqueInfo(Map<String, String> viewinfo){
		return (List<Map<String, Object>>) list("room.viewMorqueInfo",viewinfo);
	}
	
	public void insertMorque(Map<String, Object> fileUpdate){
		insert("room.insertMorque", fileUpdate);
		return;
	}
	public void updateMorque(Map<String, Object> fileUpdate){
		update("room.updateMorque", fileUpdate);
		return;
	}
	public void deleteMorque(Map<String, Object> fileDelete){
		delete("room.deleteMorque", fileDelete);
		return;
	}
	
}
