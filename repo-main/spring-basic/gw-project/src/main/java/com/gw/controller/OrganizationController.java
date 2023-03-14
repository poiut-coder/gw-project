package com.gw.controller;

import java.io.Console;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gw.dto.ApMemberDto;
import com.gw.dto.AttendanceDto;
import com.gw.dto.DeptDto;
import com.gw.dto.MemberDto;
import com.gw.service.ApprovalService;
import com.gw.service.AttendanceService;
import com.gw.service.OrganizationService;

@Controller
@RequestMapping(path = { "/organization"})
public class OrganizationController {
	
	@Autowired
	@Qualifier("organizationService")
	private OrganizationService organizationService;

	//목록 화면 - 부서목록 가져오기
	@GetMapping(path = { "/list"})
	public String showOrganizationList(HttpSession session, Model model) {
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		
		int userNo = member.getMem_id_no();
		int comNo = member.getMem_com_code();
		
		List<DeptDto> depts = organizationService.findDepts(comNo);
		List<ApMemberDto> members = organizationService.selectOrMembers(comNo);
		
		model.addAttribute("depts", depts);
		model.addAttribute("members", members);
		
		return "organization/organization_list";
	}
	
	@GetMapping(path = { "/member"})
	public String showOrganizationMember(@RequestParam(defaultValue = "-1") int deptNo, HttpSession session, Model model) {
		
		if (deptNo == -1) {
			return "redirect:list";
		}
		
		List<ApMemberDto> members = organizationService.selectOrMembers(deptNo);
		model.addAttribute("members", members);
		
		return "organization/organization_member";
	}
	
	
	
}
