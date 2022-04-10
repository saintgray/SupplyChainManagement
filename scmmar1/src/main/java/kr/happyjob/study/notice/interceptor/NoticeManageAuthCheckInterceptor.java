package kr.happyjob.study.notice.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class NoticeManageAuthCheckInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		Object userType=request.getSession().getAttribute("userType");
		boolean canManage=(userType!=null && ((String)userType).equals("A"));
		if(!canManage){
			response.sendError(403);
			// response.sendRedirect("/accessdenied.do");
		}
		return canManage;
		
	}
	
	
	

}
