package kr.happyjob.study.cmg.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cmg.dao.ClassroomDao;
import kr.happyjob.study.cmg.model.ClassroomModel;
import kr.happyjob.study.cmg.model.EquipmentModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;

@Service
public class ClassroomServiceImpl implements ClassroomService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ClassroomDao classroomDao;
	
	/** 강의실 목록 조회 */
	public List<ClassroomModel> listClassroom(Map<String, Object> paramMap) throws Exception {
		
		List<ClassroomModel> listClassroom = classroomDao.listClassroom(paramMap);
		
		return listClassroom;
	}
	
	/** 강의실 목록 카운트 조회 */
	public int countListClassroom(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = classroomDao.countListClassroom(paramMap);
		
		return totalCount;
	}
	
	/** 강의실 한건 조회 */
	public ClassroomModel selectRoomOne(Map<String, Object> paramMap) throws Exception {

		ClassroomModel classroomModel = classroomDao.selectRoomOne(paramMap);
		return classroomModel;
	}
	
	/** 강의실 저장 */
	public int insertRoom(Map<String, Object> paramMap) throws Exception {
		
		int ret = classroomDao.insertClassRoom(paramMap);
		
		return ret;
	}
	
	/** 강의실 수정 */
	public int updateRoom(Map<String, Object> paramMap) throws Exception {
		
		int ret = classroomDao.updateClassRoom(paramMap);
		return ret;
	}
	
	/** 강의실 삭제 */
	public int deleteRoom(Map<String, Object> paramMap) throws Exception {
		
		int ret = classroomDao.deleteClassRoom(paramMap);
		
		return ret;
	}

	/** 장비목록 조회 */
	public List<EquipmentModel> listEquipment(Map<String, Object> paramMap) throws Exception {
		
		List<EquipmentModel> listEquipment = classroomDao.listEquipment(paramMap);
		
		return listEquipment;
	}
	
	/** 장비목록 카운트 조회 */
	public int countListEquipment(Map<String, Object> paramMap) throws Exception {
		
		int totalCount = classroomDao.countListEquipment(paramMap);
		
		return totalCount;
	}
	
	/** 장비 단건 조회 */
	public EquipmentModel selectCmgEqui(Map<String, Object> paramMap) throws Exception {
		
		EquipmentModel equipmentModel = classroomDao.selectCmgEqui(paramMap);
		return equipmentModel;
	}
	
	/** 장비 저장 */
	public int insertEquipment(Map<String, Object> paramMap) throws Exception {
		
		int ret = classroomDao.insertEquipment(paramMap);
		
		return ret;
	}
	
	/** 장비 수정 */
	public int updateEquipment(Map<String, Object> paramMap) throws Exception {
		
		int ret = classroomDao.updateEquipment(paramMap);
		return ret;
	}
	
	/** 장비 삭제 */
	public int deleteEquipment(Map<String, Object> paramMap) throws Exception {
		
		int ret = classroomDao.deleteEquipment(paramMap);
		
		return ret;
	}
	
}
