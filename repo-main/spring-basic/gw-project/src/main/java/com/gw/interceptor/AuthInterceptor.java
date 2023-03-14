package com.gw.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.gw.dto.MemberDto;

public class AuthInterceptor implements HandlerInterceptor {

	// 컨트롤러를 호출하기 전에 호출되는 메서드
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler)
			throws Exception {
		// System.out.println("PreHandler");
		
		String uri = req.getRequestURI(); // 현재 요청 경로 (웹경로 : http://.../.../*.action)

		HttpSession session = req.getSession();
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		
		if (member == null) {	// 로그인 하지 않은 사용자
			if (uri.contains("/approval") ||
				uri.contains("/project") ||
				uri.contains("/attendance") ||
				uri.contains("/organization")) { // 로그인한 사용자만 볼 수 있는 요청
			
				resp.sendRedirect("/gw-project/member/login");
				return false; // 예정된 컨트롤러 호출을 취소
			}
		}
		
		return true; // 예정대로 컨트롤러 호출을 수행
	}	
	
	// 컨트롤러 처리가 끝난 후에 호출되는 메서드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// System.out.println("PostHandle");
	}	
	// View 처리까지 끝난 후에 호출되는 메서드
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// System.out.println("AfterCompletion");
	}
	
}