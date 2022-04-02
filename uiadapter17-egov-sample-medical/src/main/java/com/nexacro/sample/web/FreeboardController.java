package com.nexacro.sample.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nexacro.sample.service.BoardService;
import com.nexacro.uiadapter17.spring.core.annotation.ParamDataSet;
import com.nexacro.uiadapter17.spring.core.annotation.ParamVariable;
import com.nexacro.uiadapter17.spring.core.data.NexacroResult;

@Controller
public class FreeboardController {
	private static final Logger logger = LoggerFactory.getLogger(FreeboardController.class);
	
	// Name 정의
	@Autowired
	@Resource(name = "boardService")
	private BoardService boardService;	
	   
     
    // 20191101 -- 게시판 리스트 
    @RequestMapping(value = "/boardList.do")
    public NexacroResult selectMap(@ParamDataSet(name="dsChoiceword", required = false) Map<String, Object> searchMap){
    	
    	List<Map<String, Object>> boardList = boardService.selectBoardListMap(searchMap);
    	// serchMap -> 검색 쿼리로 넘어올 값 
    	
    	NexacroResult result = new NexacroResult(); // nexacro형으로 리턴 
    	result.addDataSet("dsList", boardList); 
    	
    	return result;
    }
 
    // 20191104 - 게시판 1개보기 
    @RequestMapping(value = "/boardInfo.do")
    public NexacroResult detailMap(@ParamVariable(name="editor") String editor
    							   ,@ParamVariable(name="boardNum") int boardNum
    							   ,@ParamVariable(name="hitCount") int hitCount) {
    	// 변수명으로 받을 때는 @ParamVariable(name="editor") 값으로만 받는다. 
    	
    	System.out.println("찍어보다 에디터 " + editor);
    	System.out.println("찍어보자 보드넘  " + boardNum);
    	System.out.println("찍어보자 카운트  " + hitCount);
    	
    	Map<String, Object> boardDetail = boardService.selectBoardDetail(editor, boardNum, hitCount);
    	
    	NexacroResult result = new NexacroResult(); 
    	result.addDataSet("boardDetail", boardDetail);
    	return result;
    }
    
    // 20191104 - 게시간 글 저장하기 
    @RequestMapping(value = "/boardInsert.do")
    public NexacroResult insertMap(@ParamDataSet(name="boardDetail", required = false) Map<String, Object> insertMap){
    	
    	int insertNum = boardService.insertBoard(insertMap);
    	
    	System.out.println("이걸 탔을까여????????? 보드 인서트!! ");
    	
    	NexacroResult result = new NexacroResult(); // nexacro형으로 리턴 
    	result.addVariable("boardDetail", insertNum);
    	return result;
    }
    
    // 20191105 - 게시글 수정하기  (왜 넥사크로에서 404가 뜨지????)
    @RequestMapping(value = "/boardUpdate.do")
    public void updateMap(@ParamDataSet(name="boardDetail", required = false) Map<String, Object> updateMap){
    	int updateNum = boardService.updateBoard(updateMap);
    	System.out.println("수정을 확인해봅시다 ! : " + updateNum);
    }
    
    // 20191106 - 게시글삭제하기 
    @RequestMapping(value ="/boardDelete.do")
    public void deleteBoard(@ParamVariable(name="boardNum") int boardNum){
    	int deleteNum = boardService.deleteBoard(boardNum);
    	System.out.println("삭제를 확인해봅시다 ! : " + deleteNum);
    }
    
    
}
