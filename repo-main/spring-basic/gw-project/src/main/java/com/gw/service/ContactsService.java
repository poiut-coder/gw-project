package com.gw.service;

import java.util.List;

import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.RoleDto;

public interface ContactsService {

			
	// list pager
	int findContactsCount();
		
	// list pager show
	List<MemberDto> findMembersByPage(int pageNo, int pageSize);
	
	// list
	List<MemberDto> findMembersByDept(int deptNo);

	// dept
	List<DeptDto> findDept(int comNo);

	// role
	List<RoleDto> findRole();

	// memberDetail
	List<MemberDetailDto> findMemberDetail();
	
	// pager에서 memberId로 멤버 리스트 찾기
	List<MemberDto> findMemberByMemberId(int memberId);

	// 부서별 조회 pager
	List<MemberDto> findMembersByDeptByPage(int deptNo, int pageNo, int pageSize);
	

	

	
	
	
	
}
