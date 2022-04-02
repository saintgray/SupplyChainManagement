package com.nexacro.sample.service.impl.ibatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nexacro.spring.dao.ibatis.NexacroIbatisAbstractDAO;

@Repository("boardDAO")
public class BoardDAO extends NexacroIbatisAbstractDAO {

	
	// ★20191101 --게시판 리스트 / 김아진 추가 
    @SuppressWarnings("unchecked")
    public List<Map<String,Object>> selectBoardList(Map<String, Object> boardMap){
    	return (List<Map<String, Object>>) list("nexacroBoard.selectBoardList", boardMap);  // ibatis 이름으로 넘김 
    }

    // 상세보기 전 조회수 1개 올리기 
    public int hitPlus(int boardNum, int hitCount){
    	Map<String, Object> hitCount1 = new HashMap<String, Object>();
    	hitCount1.put("boardNum", boardNum);
    	hitCount1.put("hitCount", hitCount+1);
    	return (int) update("nexacroBoard.hitPlus", hitCount1);
    }
    
    // ★20191104 -- 게시판 1건 상세보기 
    @SuppressWarnings("unchecked")
    public Map<String,Object> selectBoardDetail(String editor, int boardNum){
    	
    	Map<String, Object> boardDetail = new HashMap<String, Object>();
    	boardDetail.put("editor", editor);
    	boardDetail.put("boardNum", boardNum);
    	return (Map<String, Object>) select("nexacroBoard.selectBoardDetail",boardDetail); 
    }

    // ★20191104 -- 게시판 1건 추가 
    // ibatis에서 insert 성공 리턴값은 null이기 떄문에 update로  리턴 받는다. 
    public int insertBoard(Map<String, Object> insertMap){
    	return (int) update("nexacroBoard.insertBoard", insertMap);
    }
    
    // ★20191104 -- 게시판 1건 수정
    public int updateBoard(Map<String, Object> updateMap){
    	return (int) update("nexacroBoard.updateBoard", updateMap);
    }
    
    // ★20191106 -- 게시판 1건삭제
    public int deleteBoard(int boardNum){
    	return (int) delete("nexacroBoard.deleteBoard", boardNum);
    }
    
}
