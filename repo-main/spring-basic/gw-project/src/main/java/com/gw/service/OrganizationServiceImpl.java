package com.gw.service;

import java.util.List;

import com.gw.dto.ApMemberDto;
import com.gw.dto.AttendanceDto;
import com.gw.dto.DeptDto;
import com.gw.mapper.AttendanceMapper;
import com.gw.mapper.OrganizationMapper;

import lombok.Setter;

public class OrganizationServiceImpl implements OrganizationService {

	@Setter
	private OrganizationMapper organizationMapper;

	@Override
	public List<DeptDto> findDepts(int comNo) {
		List<DeptDto> depts = organizationMapper.selectDepts(comNo);
		return depts;
	}

	@Override
	public List<ApMemberDto> selectOrMembers(int deptNo) {
		List<ApMemberDto> members = organizationMapper.selectOrMembers(deptNo);
		return members;
	}
	
}
