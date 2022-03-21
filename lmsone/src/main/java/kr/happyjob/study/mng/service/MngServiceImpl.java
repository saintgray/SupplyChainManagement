package kr.happyjob.study.mng.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mng.dao.MngDAO;

@Service
public class MngServiceImpl implements MngService{

	@Autowired
	MngDAO mngDAO;
	
	@Override
	public int surveyListCnt(Map<String, Object> paramMap) {
		return mngDAO.surveyListCnt(paramMap);
	}

	@Override
	public List<Map<String, Object>> surveyListSelect(Map<String, Object> paramMap) {
		return mngDAO.surveyListSelect(paramMap);
	}

	@Override
	public Map<String, Object> surveySelectDetail(int appraisal_no) {
		return mngDAO.surveySelectDetail(appraisal_no);
	}

	@Override
	public void surveyUpdate(Map<String, Object> paramMap) {
		mngDAO.surveyUpdate(paramMap);
	}

	@Override
	public List<String> search_combo(String id) {
		// TODO Auto-generated method stub
		return mngDAO.search_combo(id);
	}
	
	@Override
	public int ResultCnt(Map<String, Object> paramMap) {
		return mngDAO.ResultCnt(paramMap);
	}

	@Override
	public List<Map<String, Object>> apResultListSelect(Map<String, Object> paramMap) {
		return mngDAO.apResultListSelect(paramMap);
	}

	@Override
	public List<Map<String, Object>> apListDtl(Map<String, Object> paramMap) {
		return mngDAO.apListDtl(paramMap);
	}

	@Override
	public int DtlResultCnt(Map<String, Object> paramMap) {
		return mngDAO.DtlResultCnt(paramMap);
	}

	@Override
	public List<Map<String, Object>> survey_endclass(Map<String, Object> paramMap) {
		return mngDAO.survey_endclass(paramMap);
		
	}

	@Override
	public void survey_insert(Map<String, Object> endmap) {
		mngDAO.survey_insert(endmap);
	}

}