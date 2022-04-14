package kr.happyjob.study.ged.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.ged.dao.ProfitAndLossDao;
import kr.happyjob.study.ged.model.ProfitAndLossModel;



@Service
public class ProfitAndLossServiceImpl implements ProfitAndLossService{
	
	@Autowired
	ProfitAndLossDao profitAndLossDao;

	@Override
	public List<ProfitAndLossModel> ProfitAndLossList(Map<String, Object> paramMap) throws Exception {
		
		List<ProfitAndLossModel> ProfitAndLossList = profitAndLossDao.ProfitAndLossList(paramMap);
		return ProfitAndLossList;
	}

	@Override
	public int ProfitAndLossCnt(Map<String, Object> paramMap) throws Exception {
		int ProfitAndLossCnt = profitAndLossDao.ProfitAndLossCnt(paramMap);
		return ProfitAndLossCnt;
	}

	@Override
	public List<ProfitAndLossModel> ProfitAndLossOne(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return profitAndLossDao.ProfitAndLossOne(paramMap);
	}

	@Override
	public int ProfitAndLossOneCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return profitAndLossDao.ProfitAndLossOneCnt(paramMap);
	}

}
