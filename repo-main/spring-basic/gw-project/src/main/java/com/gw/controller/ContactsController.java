package com.gw.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.ProjectDto;
import com.gw.dto.RoleDto;
import com.gw.service.ApprovalService;
import com.gw.service.ContactsService;
import com.gw.ui.ContactsPager;
import com.gw.ui.ProjectDeptPager;
import com.gw.ui.ProjectPager;

@Controller
@RequestMapping(path = { "/contact" })
public class ContactsController {

	@Autowired
	@Qualifier("contactsService")
	private ContactsService contactsService;
	
	@Autowired
	@Qualifier("approvalService")
	private ApprovalService approvalService;
	
	/////////////////////////////////////////////////////////////////////////////////////////
	
	private final int pageSize = 6;
	private final int pagerSize = 4;
	private final String LINK_URL = "contacts";
	private final String LINK_URL_DEPT = "contacts_by_dept";
	
	
	// show contacts list
	@GetMapping(path = { "/contacts"})
	public String showContactsList(@RequestParam(defaultValue = "1") int pageNo, 
								   @RequestParam(defaultValue = "-1") int deptNo,
								   @RequestParam(defaultValue = "-1") int comNo,
								   HttpSession session, Model model) {
		
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		comNo = member.getMem_com_code();
		
		List<MemberDto> members = contactsService.findMembersByPage(pageNo, pageSize);
		int contactsCount = contactsService.findContactsCount();
		List<DeptDto> depts = contactsService.findDept(comNo);
		List<RoleDto> roles = contactsService.findRole();
		List<MemberDetailDto> details = contactsService.findMemberDetail();
		
		ContactsPager pager = new ContactsPager(contactsCount, pageNo, pageSize, pagerSize, LINK_URL);
		
		model.addAttribute("members", members);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("depts", depts);
		model.addAttribute("roles", roles);
		model.addAttribute("details", details);
		
		return "contact/contacts";
	}
	
	// contacts list 창에서 부서별 contacts 가져오기
	@GetMapping(path = { "/contacts_by_dept"})
	public String showContactsListByDept(@RequestParam(defaultValue = "1") int pageNo, 
										 @RequestParam(defaultValue = "-1") int deptNo,
										 Model model, HttpSession session) {
		
		if (deptNo == -1) {
			return "redirect:contacts";
		}
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int comNo = member.getMem_com_code();
		
		List<MemberDto> contactsByPage = contactsService.findMembersByDeptByPage(deptNo, pageNo, pageSize);
		List<MemberDetailDto> details = contactsService.findMemberDetail();
		List<DeptDto> depts = contactsService.findDept(comNo);
		List<RoleDto> roles = contactsService.findRole();
		List<MemberDto> members = approvalService.findMembersByDept(deptNo, comNo);
		
		ProjectDeptPager pager = new ProjectDeptPager(members.size(), pageNo, pageSize, pagerSize, deptNo, LINK_URL_DEPT);
		
		model.addAttribute("members", contactsByPage);
		model.addAttribute("details", details);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("depts", depts);
		model.addAttribute("roles", roles);
		
		return "contact/contacts_dept";
		
	}
	
	
	
	
	
}
