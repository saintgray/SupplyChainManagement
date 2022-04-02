package com.nexacro.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.nexacro.sample.service.RoomService;
import com.nexacro.sample.service.impl.ibatis.RoomDAO;
import com.nexacro.sample.web.UiAdapterFileController;
import com.nexacro.uiadapter17.spring.core.data.DataSetRowTypeAccessor;
import com.nexacro17.xapi.data.DataSet;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;





@Service("roomService")
public class RoomServiceImpl extends EgovAbstractServiceImpl implements RoomService {
	private Logger logger = LoggerFactory.getLogger(UiAdapterFileController.class);
	int size;
	int dataRowType;
	
	@Resource(name = "roomDAO")
	private RoomDAO roomDAO;
	
	@Override
	public List<Map<String, Object>> selectFileListMap(Map<String, Object> fileMap){
		return roomDAO.selectFileListMap(fileMap);
	}
	
	@Override
	public List<Map<String, Object>> viewMorqueInfo(Map<String, String> viewinfo){
		return roomDAO.viewMorqueInfo(viewinfo);
	}
	
	@Override 
	//fileUpdate
	public void ISDMorque(Map<String, Object> fileUpdate){
		
		//size=fileUpdate.size();
		
		System.out.println("================= : " + fileUpdate.toString());
		
		if((fileUpdate.get("wno")== null)) {
			//insert
			roomDAO.insertMorque(fileUpdate);
			
		} else {
			//update
			roomDAO.updateMorque(fileUpdate);
		}
		
	}
	
	
	@Override 
	//fileUpdate
	public void deleteMorque(Map<String, Object> fileDelete){
		
		System.out.println("================= : " + fileDelete.toString());
		
			roomDAO.deleteMorque(fileDelete);
			
	}
	
	

}
