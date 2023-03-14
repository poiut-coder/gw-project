package com.gw.service;

import java.util.List;

import com.gw.dto.ApMemberDto;
import com.gw.dto.AttendanceDto;
import com.gw.dto.DeptDto;

public interface OrganizationService {
	
	// 부서 가져오기
	List<DeptDto> findDepts(int comNo);
	
	// 멤버 가져오기
	List<ApMemberDto> selectOrMembers(int deptNo);
	
}
