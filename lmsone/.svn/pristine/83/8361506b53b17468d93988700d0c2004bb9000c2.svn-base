package kr.happyjob.study.sup.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.happyjob.study.sup.model.CourseModel;
import kr.happyjob.study.sup.service.CourseService;

@Controller
@RequestMapping("/sup/")
public class CourseController {

  @Autowired
  CourseService courseService;

  private final Logger logger = LogManager.getLogger(this.getClass());

  // Get class name for logger
  private final String className = this.getClass().toString();

  /** 과정 목록 초기 화면 */
  @RequestMapping("course.do")
  public String initCourse() throws Exception {

    logger.info("+ Start " + className + ".initCourse");
    logger.info("+ End " + className + ".initCourse");

    return "sup/course";
  }

  /** 과정 목록 */
  @RequestMapping("listCourse.do")
  public String listCourse(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

    logger.info("+ Start " + className + ".listCourse");
    logger.info("   - paramMap : " + paramMap);

    int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
    int pageIndex = (currentPage - 1) * pageSize;

    paramMap.put("pageSize", pageSize);
    paramMap.put("pageIndex", pageIndex);

    model.addAttribute("listCourse", courseService.listCourse(paramMap));
    model.addAttribute("totalCntCourse", courseService.countListCourse(paramMap));
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageCourse", currentPage);

    logger.info("+ End " + className + ".listCourse");

    return "/sup/courseList";
  }

  /** 과정 상세 */
  @RequestMapping("deatilCourse.do")
  @ResponseBody
  public Map<String, Object> detailCourse(@RequestParam Map<String, Object> paramMap) throws Exception {

    logger.info("+ Start " + className + ".detailCourse");
    logger.info("   - paramMap : " + paramMap);

    Map<String, Object> resultMap = new HashMap<String, Object>();

    resultMap.put("result", "SUCCESS");
    resultMap.put("courseModel", courseService.selectCourse(paramMap));
    logger.info("+ End " + className + ".detailCourse");

    return resultMap;
  }

  /** 수강신청 */
  @RequestMapping("insertCourse.do")
  @ResponseBody
  public Map<String, Object> insertCourse(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {

    logger.info("+ Start " + className + ".insertCourse");
    logger.info("   - paramMap : " + paramMap);

    paramMap.put("loginId", session.getAttribute("loginId"));

    Map<String, Object> resultMap = new HashMap<String, Object>();

    CourseModel courseModel = courseService.selectCourse(paramMap);

    try {

      if (courseModel.getUser_cnt() < courseModel.getClass_totalcnt()) {

        courseService.insertCourse(paramMap);

        resultMap.put("result", "SUCCESS");
        resultMap.put("resultMsg", "수강 신청 되었습니다.");

      } else {

        resultMap.put("result", "FAIL");
        resultMap.put("resultMsg", "수강 신청 인원 마감 되었습니다.");

      }

    } catch (DuplicateKeyException e) {

      resultMap.put("result", "FAIL");
      resultMap.put("resultMsg", "이미 수강 신청 했습니다.");

    }

    logger.info("+ End " + className + ".insertCourse");

    return resultMap;
  }

}
