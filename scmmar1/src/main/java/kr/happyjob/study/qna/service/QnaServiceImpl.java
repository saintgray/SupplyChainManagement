package kr.happyjob.study.qna.service;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.qna.dao.QnaDao;
import kr.happyjob.study.qna.model.PageInfo;
import kr.happyjob.study.qna.model.QnaDetail;
import kr.happyjob.study.qna.model.SearchParam;

@Service
public class QnaServiceImpl implements QnaService {
	
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	private SqlSessionTemplate sst;
	private QnaDao dao;
	
	public QnaServiceImpl() {

	}
	
	@Autowired
	public QnaServiceImpl(SqlSessionTemplate sst) {
	
		this.sst = sst;
	
	}


	@Override
	public PageInfo getQnaList(PageInfo info, HttpSession session) {
		
		dao=sst.getMapper(QnaDao.class);
		
		SearchParam param=info.getParams();
		String userType=session.getAttribute("userType").toString();
		String loginID=session.getAttribute("loginId").toString();
		logger.info(userType);
		logger.info(loginID);
		param.setLoginID(loginID);
		param.setUserType(userType);
		
		int selectPage=Integer.parseInt(param.getSelectPage());
		int rowsPerPage=Integer.parseInt(param.getRowsPerPage());
		int totalCount=dao.getTotalCount(param);
		
		int totalPage=totalCount%rowsPerPage>0 ? (totalCount/rowsPerPage)+1 : totalCount/rowsPerPage;
		param.setSelectPage(String.valueOf(selectPage=totalPage<selectPage ? totalPage : selectPage));
		param.setTotalCount(String.valueOf(totalCount));
		
		
		info.setList(dao.getQnaList(param));

		return info;
	}

	@Override
	public QnaDetail getQnaDetail(String id, HttpSession session) {
		
		return null;
	}
	
	

}
