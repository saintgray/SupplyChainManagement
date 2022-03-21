package kr.happyjob.study.sup.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.happyjob.study.sup.service.AdviceMgtService;

@Controller
@RequestMapping("/sup/")
public class AdviceMgtController {

  @Autowired
  AdviceMgtService adviceMgtService;

  private final Logger logger = LogManager.getLogger(this.getClass());

  // Get class name for logger
  private final String className = this.getClass().toString();

  /** 과정 목록 초기 화면 */
  @RequestMapping("adviceMgt.do")
  public String initAdviceMgt() throws Exception {

    logger.info("+ Start " + className + ".initAdviceMgt");

    return "sup/adviceMgt";
  }

  /** 과정 목록 */
  @RequestMapping("adviceListCourse.do")
  public String listCourse(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

    logger.info("+ Start " + className + ".listCourse");
    logger.info("   - paramMap : " + paramMap);

    int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
    int pageIndex = (currentPage - 1) * pageSize;

    paramMap.put("pageSize", pageSize);
    paramMap.put("pageIndex", pageIndex);

    model.addAttribute("listCourse", adviceMgtService.listCourse(paramMap));
    model.addAttribute("totalCntCourse", adviceMgtService.countListCourse(paramMap));
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageCourse", currentPage);

    logger.info("+ End " + className + ".listCourse");

    return "/sup/courseListAdviceMgt";
  }

  /** 수강 학생 조회 */
  @RequestMapping("listUser.do")
  public String listUser(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

    logger.info("+ Start " + className + ".listUser");
    logger.info("   - paramMap : " + paramMap);

    int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
    int pageIndex = (currentPage - 1) * pageSize;

    paramMap.put("pageSize", pageSize);
    paramMap.put("pageIndex", pageIndex);

    model.addAttribute("listUser", adviceMgtService.listUser(paramMap));
    model.addAttribute("totalCntUser", adviceMgtService.countListUser(paramMap));
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageUser", currentPage);

    logger.info("+ End " + className + ".listCourse");

    return "/sup/userList";
  }

  /** 상담 목록 조회 */
  @RequestMapping("listAdvice.do")
  public String listAdvice(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

    logger.info("+ Start " + className + ".listAdvice");
    logger.info("   - paramMap : " + paramMap);

    int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
    int pageIndex = (currentPage - 1) * pageSize;

    paramMap.put("pageSize", pageSize);
    paramMap.put("pageIndex", pageIndex);

    model.addAttribute("listAdvice", adviceMgtService.listAdvice(paramMap));
    model.addAttribute("totalCntAdvice", adviceMgtService.countListAdvice(paramMap));
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageAdvice", currentPage);
    model.addAttribute("user_name", paramMap.get("user_name"));

    logger.info("+ End " + className + ".listAdvice");

    return "/sup/adviceList";
  }

  /** 상담 조회 */
  @RequestMapping("selectConsult.do")
  @ResponseBody
  public Map<String, Object> selectConsult(@RequestParam Map<String, Object> paramMap) throws Exception {

    logger.info("+ Start " + className + ".selectConsult");
    logger.info("   - paramMap : " + paramMap);

    String result = "SUCCESS";
    String resultMsg = "조회 되었습니다.";

    Map<String, Object> resultMap = new HashMap<String, Object>();

    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);
    resultMap.put("adviceMgtModel", adviceMgtService.selectConsult(paramMap));

    logger.info("+ End " + className + ".selectConsult");

    return resultMap;
  }

  /** 상담 저장 */
  @RequestMapping("saveConsult.do")
  @ResponseBody
  public Map<String, Object> saveConsult(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {

    logger.info("+ Start " + className + ".saveConsult");
    logger.info("   - paramMap : " + paramMap);

    String action = (String)paramMap.get("action");
    String result = "SUCCESS";
    String resultMsg = "저장 되었습니다.";

    if (action.equals("I")) {

      adviceMgtService.insertConsult(paramMap);

    } else if(action.equals("U")) {

      adviceMgtService.updateConsult(paramMap);

    } else {

      result = "FALSE";
      resultMsg = "알수 없는 요청 입니다.";

    }

    Map<String, Object> resultMap = new HashMap<String, Object>();
    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);

    logger.info("+ End " + className + ".saveConsult");

    return resultMap;
  }

}
