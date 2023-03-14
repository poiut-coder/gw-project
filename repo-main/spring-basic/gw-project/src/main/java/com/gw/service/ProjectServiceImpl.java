package com.gw.service;

import java.util.List;

import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.ProjectAttachDto;
import com.gw.dto.ProjectDto;
import com.gw.dto.ProjectMemberDto;
import com.gw.dto.RoleDto;
import com.gw.mapper.ProjectMapper;

import lombok.Setter;

public class ProjectServiceImpl implements ProjectService {
	
	@Setter
	private ProjectMapper projectMapper;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// write
	@Override
	public void writeProject(ProjectDto project) {
		
		projectMapper.insertProject1(project);
		
		ProjectDto projectDto = projectMapper.selectScheId();
		project.setSche_id_no(projectDto.getSche_id_no());
		
		projectMapper.insertProject2(project);
		
		ProjectDto projectAttach = projectMapper.selectDeptScheId();
		project.setDept_sche_id_no(projectAttach.getDept_sche_id_no());
		
		if (project.getSche_attachments() != null) {
			for (ProjectAttachDto attachment : project.getSche_attachments()) {
				
				attachment.setDept_sche_id_no(project.getDept_sche_id_no());
				
				projectMapper.insertProjectAttach(attachment);
			}
		}
	}
	
	// list show
	@Override
	public List<ProjectDto> findProjectByPage(int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		
		List<ProjectDto> projects = projectMapper.selectProjectByPage(from, count);
		
		return projects;
	}

	// list pager show
	@Override
	public int findProjectCount() {

		int projectCount = projectMapper.selectProjectCount();
		
		return projectCount;
	}
	
	// list By dept
	@Override
	public List<ProjectDto> findProjectByDept(int deptNo) {

		List<ProjectDto> projectByDept = projectMapper.selectProjectByDeptNo(deptNo);
		
		return projectByDept;
	}
	
	// list pager
	@Override
	public List<ProjectDto> findProjectByDeptByPage(int deptNo, int pageNo, int pageSize) {
		
		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		
		List<ProjectDto> projectByDept = projectMapper.selectProjectByDeptNoByPage(deptNo, from, count);
		
		return projectByDept;
	}
	
	// detail & attach show
	@Override
	public ProjectDto findProjectByProjectNo(int projectNo) {
		
		ProjectDto project = projectMapper.selectProjectByProjectNo(projectNo);
		
		if (project != null) {
			
			List<ProjectAttachDto> attachments = projectMapper.selectProjectAttachByProjectNo(projectNo);
			project.setSche_attachments(attachments);
		}
		
		return project;
	}
	
	// attach download
	@Override
	public ProjectAttachDto findProjectAttachByAttachNo(int attachNo) {
		
		ProjectAttachDto attachment = projectMapper.selectProjectAttachByAttachNo(attachNo);
		
		return attachment;
	}

	// edit
	@Override
	public void modifyProject(ProjectDto project) {
		
		projectMapper.updateProject1(project);
		
		ProjectDto projectDto = projectMapper.selectScheId();
		project.setSche_id_no(projectDto.getSche_id_no());
		
		projectMapper.updateProject2(project);
		
		if (project.getSche_attachments() != null) {
			for (ProjectAttachDto attachment : project.getSche_attachments()) {
				
				attachment.setDept_sche_id_no(project.getDept_sche_id_no());
				
				projectMapper.insertProjectAttach(attachment);
			}
		}
	}
	
	// edit attachment
	@Override
	public void deleteProjectAttachment(int attachNo) {
		
		projectMapper.deleteProjectAttach(attachNo);
	}
	
	// delete
	@Override
	public void deleteProject(int projectNo) {

		projectMapper.removeProject(projectNo);
	}

	// my project List show
	@Override
	public List<ProjectDto> findProjectByMemberNo(int memberNo) {

		List<ProjectDto> projects = projectMapper.selectProjectByMemberNo(memberNo);
		
		return projects;
	}

	// my project success
	@Override
	public void successProject(int projectNo) {

		projectMapper.successStatusProject(projectNo);
	}

	// dept
	@Override
	public List<DeptDto> findDepts(int comNo) {
		
		List<DeptDto> depts = projectMapper.selectDepts(comNo);
		return depts;
	}

	// 부서별 멤버
	@Override
	public List<MemberDto> findMembersByDept(int deptNo) {
		
		List<MemberDto> members = projectMapper.selectMembersByDept(deptNo);
		
		return members;
	}
	
	// role
	@Override
	public List<RoleDto> findRoles() {
		
		List<RoleDto>  roles = projectMapper.selectRoles();
		
		return roles;
	}
	

	// member detail
	@Override
	public List<MemberDetailDto> findMembersDetail() {
		
		return null;
	}
	
	// member detail
	@Override
	public List<MemberDetailDto> findMembersListDetail() {
			
		List<MemberDetailDto> membersDetail = projectMapper.selectMembersDetail();

		return membersDetail;
	}

	// member
	@Override
	public List<MemberDto> findMembers() {
		
		List<MemberDto> members = projectMapper.selectMembers();
		
		return members;
	}

	// home-project show
	@Override
	public List<ProjectDto> findHomeProjectByMemberNo(int memberNo) {
		
		List<ProjectDto> projects = projectMapper.SelectHomeProjectByMemberNo(memberNo);
		
		return projects;
	}

	// alert count
	@Override
	public int countAlert(int userNo) {
		
		return projectMapper.countProjectAlert(userNo);
	}
	
	// alert 확인 후 수정
	@Override
	public void updateAlert(int userNo) {
		
		projectMapper.updateProjectAlert(userNo);
	}

	
	
}
