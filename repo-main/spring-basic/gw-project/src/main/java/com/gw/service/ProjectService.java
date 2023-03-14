package com.gw.service;

import java.util.List;

import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.ProjectAttachDto;
import com.gw.dto.ProjectDto;
import com.gw.dto.ProjectMemberDto;
import com.gw.dto.RoleDto;

public interface ProjectService {


	// write
	void writeProject(ProjectDto project);

	// list show
	List<ProjectDto> findProjectByPage(int pageNo, int pageSize);

	// list pager
	int findProjectCount();
	
	// list By dept
	List<ProjectDto> findProjectByDept(int deptNo);
	
	// pager
	List<ProjectDto> findProjectByDeptByPage(int deptNo, int pageNo, int pageSize);

	// detail show
	ProjectDto findProjectByProjectNo(int projectNo);
	
	// detail에서 attach 
	ProjectAttachDto findProjectAttachByAttachNo(int attachNo);
	
	// edit
	void modifyProject(ProjectDto project);

	// edit attach delete
	void deleteProjectAttachment(int attachNo);
	
	// delete
	void deleteProject(int projectNo);

	// my project List show
	List<ProjectDto> findProjectByMemberNo(int memberNo);

	// my project success
	void successProject(int projectNo);

	// depts
	List<DeptDto> findDepts(int comNo);

	// 부서별 멤버
	List<MemberDto> findMembersByDept(int deptNo);
	
	// roles
	List<RoleDto> findRoles();
	
	// member detail
	List<MemberDetailDto> findMembersDetail();
	
	// member detail
	List<MemberDetailDto> findMembersListDetail();

	// member
	List<MemberDto> findMembers();

	// home-project show
	List<ProjectDto> findHomeProjectByMemberNo(int memberNo);
	
	// alert count
	int countAlert(int userNo);
	
	// alert update
	void updateAlert(int userNo);

	
	


	

	

}
