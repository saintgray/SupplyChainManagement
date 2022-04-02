package kr.happyjob.study.sampletest.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.sample.service.SampleComnCodService;

@Controller
@RequestMapping("/sampletest/")
public class SampletestComnCodController {
   
   @Autowired
   SampleComnCodService sampleComnCodService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   @RequestMapping("samplepage1.do")
   public String samplepage1(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".initComnCod");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".initComnCod");

      return "sampletest/samplepage1";
   }
     

   @RequestMapping("samplepage2.do")
   public String samplepage2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".initComnCod");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".initComnCod");

      return "sampletest/samplepage2";
   }
   

   @RequestMapping("samplepage3.do")
   public String samplepage3(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".initComnCod");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".initComnCod");

      return "sampletest/samplepage3";
   }
   

   @RequestMapping("samplepage4.do")
   public String samplepage4(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".initComnCod");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".initComnCod");

      return "sampletest/samplepage4";
   }
   

   @RequestMapping("samplepage5.do")
   public String samplepage5(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".initComnCod");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".initComnCod");

      return "sampletest/samplepage5";
   }
   
}