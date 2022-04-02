package com.nexacro.sample.service;

import java.util.List;
import java.util.Map;

import antlr.collections.impl.LList;

public interface RoomService {
	
	//리스트 조회
	List<Map<String, Object>> selectFileListMap(Map<String, Object> fileMap);
	
	//게시물 보기
	List<Map<String, Object>> viewMorqueInfo(Map<String, String> viewinfo);
	
	//게시물 등록,수정,삭제
	void ISDMorque(Map<String, Object> fileUpdate);
	
	void deleteMorque(Map<String, Object> fileDelete);
}
