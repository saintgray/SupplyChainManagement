package kr.happyjob.study.jmg.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.jmg.dao.ResumeDao;
import kr.happyjob.study.jmg.model.ResumeAwardInfoDto;
import kr.happyjob.study.jmg.model.ResumeCareerInfoDto;
import kr.happyjob.study.jmg.model.ResumeClassInfoDto;
import kr.happyjob.study.jmg.model.ResumeUserInfoDto;

@Service
public class ResumeServiceImpl implements ResumeService {
	
	@Autowired
	private ResumeDao resumeDao;

	@Override
	public int selectAllClassListCnt(String keyword) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectAllClassListCnt(keyword);
	}

	@Override
	public List<ResumeClassInfoDto> selectAllClassList(String keyword, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectAllClassList(keyword,rb);
	}

	@Override
	public int selectResumeUserListCnt(int class_No) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectResumeUserListCnt(class_No);
	}

	@Override
	public List<ResumeUserInfoDto> selectResumeUserList(int class_No, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectResumeUserList(class_No,rb);
	}

	@Override
	public int selectUserClassListCnt(String loginID) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectUserClassListCnt(loginID);
	}

	@Override
	public int selectUserAwardListCnt(String loginID) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectUserAwardListCnt(loginID);
	}

	@Override
	public List<ResumeAwardInfoDto> selectUserAwardList(String loginID, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectUserAwardList(loginID,rb);
	}

	@Override
	public ResumeUserInfoDto selectUser(String loginID) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectUser(loginID);
	} 

	@Override
	public List<ResumeClassInfoDto> selectUserClassList(String loginID, RowBounds rb) throws Exception {
		List<ResumeClassInfoDto> userClassList = null;
		userClassList =  resumeDao.selectUserClassList(loginID,rb);
		int score;
		String type;
		for(int i=0;i<userClassList.size();i++){
			type = userClassList.get(i).getQ_Type();
			if(type!=null){
				score = userClassList.get(i).getScore();
				if(score>=60){
					userClassList.get(i).setState("합격");
				}else{
					userClassList.get(i).setState("과락");
				}
			}
		}
		
		
		
		return userClassList;
	}

	@Override
	public int selectUserCareerListCnt(String loginID) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectUserCareerListCnt(loginID);
	}

	@Override
	public List<ResumeCareerInfoDto> selectUserCareerList(String loginID, RowBounds rb) throws Exception {
		// TODO Auto-generated method stub
		return resumeDao.selectUserCareerList(loginID,rb);
	}

}
