package com.nexacro.sample.service.impl;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import com.nexacro.sample.service.BoardService;
import com.nexacro.sample.service.impl.ibatis.BoardDAO;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;


@Service("boardService")  // ????
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {
	
	private Logger logger = LoggerFactory.getLogger(UiAdapterSampleServiceImpl.class);
	
	//int size;
	//int dataRowType;
	// size 두개 사용해서 전역으로 선언함;
	
	@Resource(name = "boardDAO")  //????
	private BoardDAO boardDAO;
	
	
	// ★20191101 -- 게시판 리스트  / 검색 있음 
	@Override
	public List<Map<String, Object>> selectBoardListMap(Map<String, Object> boardMap) {
		logger.debug("자유게시판을 전체 가지고와볼거예요~~~~");
		System.out.println("검색 조건을 가지고오는지 보겠씁니다~~~~~~~~2~~~~~~~~" + boardMap.toString()); // 가지고옴 
		
		return boardDAO.selectBoardList(boardMap);
	}

	// ★20191104 -- 게시판 1건 상세보기 
	@Override
	public Map<String, Object> selectBoardDetail(String editor, int boardNum, int hitCount) {
		logger.debug("게시판 한건에 대한 상세정보를 가지고 올거예여~~~~~~ ");
		
		// 조회수 수정 _ update
		int count = boardDAO.hitPlus(boardNum,hitCount);
		System.out.println("조회수 확인 : " + count);
		
		Map<String,Object> result = null; 
		if(count == 1){
			result = boardDAO.selectBoardDetail(editor, boardNum);
			System.out.println("~~~~~~~~~~~~~~~~~~4444444444444 이거 탑니까?? " + " : " + editor + " : " + boardNum + " : " + result.size());
		}
		return result;
	}

	// ★20191104 -- 게시판 1건 추가 
	@Override
	public int insertBoard(Map<String, Object> insertMap) {
		logger.debug("글 작성 합니당 ");
		
		// ip 주소 찾기 소스 
    	InetAddress local; 
    	try { 
    		local = InetAddress.getLocalHost(); 
    		String ip = local.getHostAddress(); 
    		System.out.println("local ip : "+ip); 
    		insertMap.put("ip2", ip); // insertMap에 추가 
    		
    	} catch (UnknownHostException e1) { 
    		e1.printStackTrace(); 
    	}
		
		return boardDAO.insertBoard(insertMap);
	}

	// ★20191104 -- 게시판 1건 수정
	@Override
	public int updateBoard(Map<String, Object> updateMap) {
		logger.debug("글 수정 합니당 ");
		return boardDAO.updateBoard(updateMap);
	}

	// ★20191104 -- 게시판 1건  삭제
	@Override
	public int deleteBoard(int boardNum) {
		logger.debug("글 삭제 합니당 ");
		return boardDAO.deleteBoard(boardNum);
	}
	
	
	


	
	
	
	
	
	
	
	

}// AdminServiceImpl
