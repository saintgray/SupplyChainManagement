package kr.happyjob.study.cmg.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmg.model.ClassroomModel;
import kr.happyjob.study.cmg.model.EquipmentModel;

public interface ClassroomDao {

	/** 강의실 목록 조회 */
	//listClassroom 가 쿼리문 ID가 됌.
	public List<ClassroomModel> listClassroom(Map<String, Object> paramMap);
	
	/** 강의실 목록 카운트 조회 */
	public int countListClassroom(Map<String, Object> paramMap);

	/** 강의실 한건 조회 */
	public ClassroomModel selectRoomOne(Map<String, Object> paramMap);
	
	/** 강의실 저장 */
	public int insertClassRoom(Map<String, Object> paramMap);
	
	/** 강의실 수정 */
	public int updateClassRoom(Map<String, Object> paramMap);

	/**강의실 삭제*/
	public int deleteClassRoom(Map<String, Object> paramMap);	
	
	/**장비 목록 조회*/
	public List<EquipmentModel> listEquipment(Map<String, Object> paramMap);
	
	/**장비목록 카운트 조회*/
	public int countListEquipment(Map<String, Object> paramMap);
	
	/**장비 단건 조회*/
	public EquipmentModel selectCmgEqui(Map<String, Object> paramMap);

	/** 장비 저장 */
	public int insertEquipment(Map<String, Object> paramMap);
	
	/** 장비 수정 */
	public int updateEquipment(Map<String, Object> paramMap);

	/** 장비 삭제 */
	public int deleteEquipment(Map<String, Object> paramMap);

}
