package com.gw.controller;

import com.gw.dto.DeptDto;
import com.gw.dto.RoleDto;
import com.gw.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class AccountRestController {

	@Autowired
	private AccountService accountService;

	@GetMapping(path = { "member/dept_list" })
	public List<DeptDto> addCompany(@RequestParam("mem_com_code") int mem_com_code){

		List<DeptDto> depts = accountService.findAllDeptsByCompId(mem_com_code);
//		List<MemberDto> members = accountService.findMembersByCompany(mem_com_code);

		return depts;
	}

	@GetMapping(path = { "member/role_list" })
	public List<RoleDto> addRole(@RequestParam("mem_com_code") int mem_com_code){
		List<RoleDto> roles = accountService.findAllRolesByCompId(mem_com_code);
		return roles;
	}

	@GetMapping(path={ "member/admin/modiDept_list" })
	public List<DeptDto> changedCompany(@RequestParam("mem_com_code") int mem_com_code){
		List<DeptDto> modiDepts = accountService.findMemDeptsByCompId(mem_com_code);
		return modiDepts;
	}

	@GetMapping(path={ "member/admin/modiRole_list" })
	public List<RoleDto> changeDept(@RequestParam("mem_dept_no")int mem_dept_no){
		List<RoleDto> modiRoles = accountService.findMemRolesByCompId(mem_dept_no);
		return modiRoles;
	}
	@GetMapping(path={ "member/admin/member_list" })
	public void newMember(@RequestParam("mem_retire") boolean mem_retire){
		accountService.deletedMember(mem_retire);
	}

}
