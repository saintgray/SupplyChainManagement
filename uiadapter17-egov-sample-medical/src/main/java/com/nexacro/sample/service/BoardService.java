package com.nexacro.sample.service;


import java.util.List;
import java.util.Map;




public interface BoardService {
	
	//★ 20191101 -- 게시판 리스트 
	List<Map<String, Object>> selectBoardListMap(Map<String, Object> searchMap);
	
	//★ 20191104 -- 게시판 1건 상세보기 
	Map<String, Object> selectBoardDetail(String editor, int boardNum, int hitCount);
	
	//★ 20191104 -- 게시판 1건 추가하기 
	int insertBoard(Map<String, Object> insertMap);
	
	//★ 20191105 -- 게시판 1건 수정하기
	int updateBoard(Map<String, Object> updateMap);

	//★ 20191106 -- 게시판 1건 삭제하기
	int deleteBoard(int boardNum);

}
