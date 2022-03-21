package kr.happyjob.study.sta.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.sta.model.StaModel;


public interface StaDao {

	public List<StaModel> liststa(Map<String, Object> paramMap) throws Exception;



	public StaModel selectsatisfaction(int class_no) throws Exception;



	public int countList(Map<String, Object> paramMap) throws Exception;



	public int selectTotalCnt(Map<String, Object> resultMap)throws Exception;



	public List<StaModel> selectSerchList(Map<String, Object> resultMap) throws Exception;




}
