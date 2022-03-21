package kr.happyjob.study.cmg.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmg.model.ClassroomModel;
import kr.happyjob.study.cmg.model.EquipmentModel;

public interface ClassroomService {

	/** 강의실 목록 조회 */
	public List<ClassroomModel> listClassroom(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 목록 카운트 조회 */
	public int countListClassroom(Map<String, Object> paramMap) throws Exception;

	/** 강의실 한건 조회 */
	public ClassroomModel selectRoomOne(Map<String, Object> paramMap) throws Exception;;
	
	/** 강의실 저장 */
	public int insertRoom(Map<String, Object> paramMap)throws Exception;
	
	/** 강의실 수정 */
	public int updateRoom(Map<String, Object> paramMap)throws Exception;

	/** 강의실 삭제 */
	public int deleteRoom(Map<String, Object> paramMap)throws Exception;

	/** 장비 목록 조회 */
	public List<EquipmentModel> listEquipment(Map<String, Object> paramMap)throws Exception;
	
	/** 장비 목록 카운트 조회 */
	public int countListEquipment(Map<String, Object> paramMap) throws Exception;

	/** 장비 단건 조회 */
	public EquipmentModel selectCmgEqui(Map<String, Object> paramMap)throws Exception;

	/** 장비 저장 */
	public int insertEquipment(Map<String, Object> paramMap)throws Exception;

	/** 장비실 수정 */
	public int updateEquipment(Map<String, Object> paramMap)throws Exception;
	
	/** 장비 삭제 */
	public int deleteEquipment(Map<String, Object> paramMap) throws Exception;

}
