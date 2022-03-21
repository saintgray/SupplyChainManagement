package kr.happyjob.study.sup.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.happyjob.study.sup.dao.CourseDao;
import kr.happyjob.study.sup.model.CourseModel;

@Service
public class CourseServiceImpl implements CourseService {

  @Autowired
  CourseDao courseDao;

  /** 과정 목록 조회 */
  public List<CourseModel> listCourse(Map<String, Object> paramMap) {
    return courseDao.listCourse(paramMap);
  }

  /** 과정 목록 카운트 조회 */
  public int countListCourse(Map<String, Object> paramMap) {
    return courseDao.countListCourse(paramMap);
  }
  
  /** 과정 상세 조회 */
  public CourseModel selectCourse(Map<String, Object> paramMap) {
	return courseDao.selectCourse(paramMap);
	}
  
  /** 수강신청 */
  public void insertCourse(Map<String, Object> paramMap) {
	  courseDao.insertCourse(paramMap);
  }
  
  /** 수강신청 인원 조회 */
  public int countListUser(Map<String, Object> paramMap) {
	  return courseDao.countListUser(paramMap);
  }

}
