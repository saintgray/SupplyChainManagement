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
import kr.happyjob.study.sup.service.AwardMgtService;

@Controller
@RequestMapping("/sup/")
public class AwardMgtController {

  @Autowired
  AwardMgtService awardMgtService;

  @Autowired
  AdviceMgtService adviceMgtService;

  private final Logger logger = LogManager.getLogger(this.getClass());

  // Get class name for logger
  private final String className = this.getClass().toString();

  /** 과정 목록 초기 화면 */
  @RequestMapping("awardMgt.do")
  public String initAwardMgt() throws Exception {

    logger.info("+ Start " + className + ".initAwardMgt");

    return "sup/awardMgt";
  }

  /** 과정 목록 */
  @RequestMapping("awardListCourse.do")
  public String listCourse(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

    logger.info("+ Start " + className + ".listCourse");
    logger.info("   - paramMap : " + paramMap);

    System.out.println(paramMap);
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

    return "/sup/courseListAwardMgt";
  }

  /** 수강 학생 조회 */
  @RequestMapping("awardListUser.do")
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

    return "/sup/userListAwardMgt";
  }

  /** 수상 목록 조회 */
  @RequestMapping("listAward.do")
  public String listAward(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {

    logger.info("+ Start " + className + ".listAward");
    logger.info("   - paramMap : " + paramMap);

    int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
    int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
    int pageIndex = (currentPage - 1) * pageSize;

    paramMap.put("pageSize", pageSize);
    paramMap.put("pageIndex", pageIndex);

    model.addAttribute("listAward", awardMgtService.listAward(paramMap));
    model.addAttribute("totalCntAward", awardMgtService.countListAward(paramMap));
    model.addAttribute("pageSize", pageSize);
    model.addAttribute("currentPageAward", currentPage);

    logger.info("+ End " + className + ".listAward");

    return "/sup/awardList";
  }

  /** 수상 저장 */
  @RequestMapping("saveAward.do")
  @ResponseBody
  public Map<String, Object> saveAward(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {

    logger.info("+ Start " + className + ".saveAward");
    logger.info("   - paramMap : " + paramMap);

    String action = (String)paramMap.get("action");
    String result = "SUCCESS";
    String resultMsg = "저장 되었습니다.";

    if (action.equals("I")) {

      awardMgtService.insertAward(paramMap);

    } else if(action.equals("U")) {

      awardMgtService.updateAward(paramMap);

    } else {

      result = "FALSE";
      resultMsg = "알수 없는 요청 입니다.";

    }

    Map<String, Object> resultMap = new HashMap<String, Object>();
    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);

    logger.info("+ End " + className + ".saveAward");

    return resultMap;
  }

  /** 수상 조회 */
  @RequestMapping("selectAward.do")
  @ResponseBody
  public Map<String, Object> selectAward(@RequestParam Map<String, Object> paramMap) throws Exception {

    logger.info("+ Start " + className + ".selectAward");
    logger.info("   - paramMap : " + paramMap);

    String result = "SUCCESS";
    String resultMsg = "조회 되었습니다.";

    Map<String, Object> resultMap = new HashMap<String, Object>();

    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);
    resultMap.put("awardMgtModel", awardMgtService.selectAward(paramMap));

    logger.info("+ End " + className + ".selectAward");

    return resultMap;
  }

}
