package kr.happyjob.study.sta.service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.happyjob.study.sta.dao.StudentDao;

import kr.happyjob.study.sta.model.StudentModel;

@Service
public class StudentServiceImpl implements StudentService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StudentDao  studentDao;

	@Override
	public List<StudentModel> liststa(Map<String, Object> paramMap) throws Exception {

		List<StudentModel> liststa = studentDao.liststa(paramMap);
		return liststa;
	}

	@Override
	public int countList(Map<String, Object> paramMap) throws Exception {
		
		int countList = studentDao.countList(paramMap);
		return countList;
	}

	@Override
	public StudentModel selectsatisfaction(int class_no) throws Exception {
		
		StudentModel selectsatisfaction = studentDao.selectsatisfaction(class_no);
		
		return selectsatisfaction;
	}

	@Override
	public int selectTotalCnt(Map<String, Object> resultMap) throws Exception {
		
		
		return studentDao.selectTotalCnt(resultMap);
	}

	@Override
	public List<StudentModel> selectSerchList(Map<String, Object> resultMap) throws Exception {
		// TODO Auto-generated method stub
		return studentDao.selectSerchList(resultMap);
	}

	@Override
	public List<Map<String, Object>> studentlist(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		
		
		List<Map<String, Object>> studentlist=studentDao.studentlist(paramMap);
		/*
		String startDate =	(String) paramMap.get("startdate");
		String endDate =	 (String) paramMap.get("enddate");
		System.out.println( paramMap.get("startdate")); 
		int startYear=Integer.parseInt(startDate.substring(0,4));
		int startMonth=Integer.parseInt(startDate.substring(4,6));
		int endYear=Integer.parseInt(endDate.substring(0,4));
		int endMonth=Integer.parseInt(endDate.substring(4, 6));
		
		System.out.println("startYear : " + startYear + "startMonth : " + startMonth 
										+"endYear : " + endYear +"endMonth : " + endMonth);
		
		for(;;){
			if((startYear==endYear&&startMonth>endMonth)||startYear>endYear){						
				
				
				break;				
			}else{  				
				String date = startYear+"-"+startMonth;
				int sdate = Integer.parseInt(date);
				
				studentlist =studentDao.studentlist(paramMap);
				startMonth++;
				if(startMonth==13){
					startMonth=1;
					startYear++;
				}
		}
		
}
		
	for(int i = 0; i < 13; i++){
		if((startYear==endYear&&startMonth>endMonth)||startYear>endYear){
			//여기서부터!!
			break;
		}else{
			
		}
	}
	
	*/
		
	return studentlist;
		
		
//		return studentDao.studentlist(paramMap);
	}

	@Override
	public List<StudentModel> student(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		
		List<StudentModel> student = studentDao.student(paramMap);
		return student;
	}

/*	@Override
	public StudentModel signUpCount(int class_no) throws Exception {
	
		StudentModel signUpCount = studentDao.signUpCount(class_no);
		
		return signUpCount;
	}

*/







	
	




}
