package com.gw.aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.gw.controller.ApprovalController;
import com.gw.dto.MemberDto;
import com.gw.service.ApprovalService;
import com.gw.service.ProjectService;

@Aspect
@Component
public class AnnotationLogger {
	
	@Autowired
	@Qualifier("approvalService")
	private ApprovalService approvalService;
	
	@Autowired
	@Qualifier("projectService")
	private ProjectService projectService;
	
	@After("within(com.gw.controller*.*)")
	public void logAfter() {
		
		HttpSession session = ((ServletRequestAttributes)(RequestContextHolder.currentRequestAttributes())).getRequest().getSession();
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		if (member != null) {
			int userNo = member.getMem_id_no();
			session.setAttribute("receiveAlert", approvalService.countReceiveAlert(userNo));
			session.setAttribute("sendAlert", approvalService.countSendAlert(userNo));
			session.setAttribute("projectAlert", projectService.countAlert(userNo));
			session.setAttribute("allAlert", (approvalService.countSendAlert(userNo)+approvalService.countReceiveAlert(userNo)+projectService.countAlert(userNo)));
			
		} else {
			session.removeAttribute("receiveAlert");
			session.removeAttribute("sendAlert");
			session.removeAttribute("projectAlert");
			session.removeAttribute("allAlert");
		}
	}
}
