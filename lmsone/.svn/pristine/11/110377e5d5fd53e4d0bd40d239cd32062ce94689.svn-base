package kr.happyjob.study.mng.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.mng.model.QnaDto;
import kr.happyjob.study.mng.model.QnaReplyDto;
import kr.happyjob.study.mng.service.QnaReplyService;
import kr.happyjob.study.mng.service.QnaService;
import kr.happyjob.study.system.model.NoticeDTO;
import kr.happyjob.study.system.model.PagingVo;

@Controller
@RequestMapping("/qna/")
public class QnaController {
	
	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private QnaReplyService qnaReplyService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@RequestMapping("qna.do")
	public String selectQnaList(Model model) throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		List<QnaDto> qnaList = null;
		RowBounds rb = null;
		PagingVo qnaListPaging = null;
		int qnaListCnt;
		String qnaSearchKind = "title";
		String qnaSearchKeyword = "%%";		
		map.put("qnaSearchKind", qnaSearchKind);
		map.put("qnaSearchKeyword", qnaSearchKeyword);
		qnaListCnt = qnaService.selectListCnt(map);
		qnaListPaging = new PagingVo(qnaListCnt, 1, 10, 10);
		rb = new RowBounds(qnaListPaging.getStart()-1, qnaListPaging.getCntPerPage());
		
		qnaList = qnaService.selectList(map, rb);
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("qnaListPaging", qnaListPaging);
		System.out.println(qnaListCnt);
		System.out.println(qnaList);
		
		
		return "mng/qnaList";
		
	}
	

	@RequestMapping("qnaListPageMove.do")
	@ResponseBody
	public Map<String,Object> noticeListMovePage(@RequestParam(name = "nowPage", defaultValue = "1") int nowPage
									, @RequestParam(name = "searchKind", defaultValue = "title") String searchKind
									,String searchKeyword) throws Exception{
		Map<String,Object> map = new HashMap<String,Object>();
		Map<String,Object> resultMap = new HashMap<String,Object>();
		List<QnaDto> qnaList = null;
		RowBounds rb = null;
		PagingVo qnaListPaging = null;
		int qnaListCnt;
		String qnaSearchKind = null;
		String qnaSearchKeyword = null;
		qnaSearchKind = searchKind;
		if(searchKeyword==null||searchKeyword.trim()==""){
			qnaSearchKeyword = "%%";
		}else{
			qnaSearchKeyword = "%"+searchKeyword+"%";
		}		
		map.put("qnaSearchKind", qnaSearchKind);
		map.put("qnaSearchKeyword", qnaSearchKeyword);
		
		qnaListCnt = qnaService.selectListCnt(map);
		qnaListPaging = new PagingVo(qnaListCnt, nowPage, 10, 10);
		rb = new RowBounds(qnaListPaging.getStart()-1, qnaListPaging.getCntPerPage());
		
		qnaList = qnaService.selectList(map, rb);
		
		
		
		resultMap.put("qnaList", qnaList);
		resultMap.put("qnaListPaging", qnaListPaging);
		
		
		
		
		return resultMap;
		
	}
	
	@RequestMapping("selectQnaDetail.do")
	@ResponseBody
	public Map<String,Object> selectQnaDetail(int board_No) throws Exception{
		Map<String,Object> resultMap = new HashMap<String,Object>();
		QnaDto qna = null;
		List<QnaReplyDto> qnaReplyList = null;
		RowBounds rb = null;
		PagingVo qnaReplyListPaging = null;
		int qnaReplyListCnt;
		String updateContent = null;
		qna = qnaService.selectQnaDetail(board_No);
		qnaReplyListCnt = qnaReplyService.selectListCnt(board_No);
		qnaReplyListPaging = new PagingVo(qnaReplyListCnt, 1, 3, 10);
		rb = new RowBounds(qnaReplyListPaging.getStart()-1, qnaReplyListPaging.getCntPerPage());
		qnaReplyList = qnaReplyService.selectList(board_No,rb);
		updateContent = qna.getBoard_Content().replaceAll("<br>", "\r\n");
		resultMap.put("qnaReplyListPaging", qnaReplyListPaging);
		resultMap.put("qna", qna);
		resultMap.put("qnaReplyList", qnaReplyList);
		resultMap.put("updateContent", updateContent);
		
		return resultMap;
		
	}
	
	@RequestMapping("qnaReplyPageMove.do")
	@ResponseBody
	public Map<String,Object> selectQnaReplyList(int board_No, int nowPage) throws Exception{
		Map<String,Object> resultMap = new HashMap<String,Object>();
		List<QnaReplyDto> qnaReplyList = null;
		RowBounds rb = null;
		PagingVo qnaReplyListPaging = null;
		int qnaReplyListCnt;
		qnaReplyListCnt = qnaReplyService.selectListCnt(board_No);
		qnaReplyListPaging = new PagingVo(qnaReplyListCnt, nowPage, 3, 10);
		rb = new RowBounds(qnaReplyListPaging.getStart()-1, qnaReplyListPaging.getCntPerPage());
		qnaReplyList = qnaReplyService.selectList(board_No,rb);
		System.out.println(qnaReplyListPaging);
		resultMap.put("qnaReplyListPaging", qnaReplyListPaging);
		resultMap.put("qnaReplyList", qnaReplyList);
		
		return resultMap;
		
	}
	
	@RequestMapping("insertReply.do")
	@ResponseBody
	public String insertReply(QnaReplyDto reply) throws Exception{
		reply.setReply_Content(reply.getReply_Content().replaceAll("\r\n", "<br>"));
		qnaReplyService.insertReply(reply);
		
		return "pass";
		
		
		
	}
	
	@RequestMapping("updateReply.do")
	@ResponseBody
	public String updateReply(QnaReplyDto reply) throws Exception{
		reply.setReply_Content(reply.getReply_Content().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		qnaReplyService.updateReply(reply);
		
		return "pass";
		
		
		
	}
	
	@RequestMapping("deleteReply.do")
	@ResponseBody
	public String deleteReply(int reply_No) throws Exception{
		qnaReplyService.deleteReply(reply_No);
		
		return "pass";
		
		
		
	}
	
	@RequestMapping("insertQna.do")
	@ResponseBody
	public String insertQna(QnaDto qna) throws Exception{
		qna.setBoard_Content(qna.getBoard_Content().replaceAll("\r\n", "<br>"));
		qnaService.insertQna(qna);
		
		return "pass";
		
	}
	
	@RequestMapping("updateQna.do")
	@ResponseBody
	public String updateQna(QnaDto qna) throws Exception{
		qna.setBoard_Content(qna.getBoard_Content().replaceAll("\r\n", "<br>"));
		qnaService.updateQna(qna);
		
		return "pass";
		
		
		
	}
	
	@RequestMapping("deleteQna.do")
	@ResponseBody
	public String deleteQna(int board_No) throws Exception{
		qnaService.deleteQna(board_No);
		
		return "pass";
		
		
		
	}
	
	
	
}
