package com.gw.service;

import java.util.List;

import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.RoleDto;
import com.gw.mapper.ContactsMapper;

import lombok.Setter;

public class ContactsServiceImpl implements ContactsService {

	@Setter
	private ContactsMapper contactsMapper;

	// list pager
	@Override
	public int findContactsCount() {

		int contactsCount = contactsMapper.selectContactsCount();
		
		return contactsCount;
	}

	// list pager show
	@Override
	public List<MemberDto> findMembersByPage(int pageNo, int pageSize) {

		int from = (pageNo -1) * pageSize;
		int count = pageSize;
		
		List<MemberDto> members = contactsMapper.selectMembersByPage(from, count);
		
		return members;
	}
	
	// list 부서별 멤버
	@Override
	public List<MemberDto> findMembersByDept(int deptNo) {

		
		List<MemberDto> members = contactsMapper.selectMembersByDept(deptNo);
		
		return members;
	}

	// 부서
	@Override
	public List<DeptDto> findDept(int comNo) {

		List<DeptDto> depts = contactsMapper.selectDept(comNo);
		
		return depts;
	}

	// 직급
	@Override
	public List<RoleDto> findRole() {

		List<RoleDto> roles = contactsMapper.selectRole();
		
		return roles;
	}

	// 멤버 디테일
	@Override
	public List<MemberDetailDto> findMemberDetail() {

		List<MemberDetailDto> details = contactsMapper.selectMemberDetail();
		
		return details;
	}
	
	// pager에서 memberId로 멤버 리스트 찾기
	@Override
	public List<MemberDto> findMemberByMemberId(int memberId) {
		
		List<MemberDto> memberByMemberId = contactsMapper.selectMemberByMemberId(memberId);
		
		return memberByMemberId;
	}

	// 부서별 조회 pager
	@Override
	public List<MemberDto> findMembersByDeptByPage(int deptNo, int pageNo, int pageSize) {

		int from = (pageNo -1) * pageSize;
		int count = pageSize;
		
		List<MemberDto> memberByDept = contactsMapper.selectMemberByDeptByPage(deptNo, from, count);
		
		return memberByDept;
	}
	
	
}
