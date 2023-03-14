package com.gw.controller;

import java.io.File;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.gw.common.Util;
import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.ProjectAttachDto;
import com.gw.dto.ProjectDto;
import com.gw.dto.ProjectMemberDto;
import com.gw.dto.RoleDto;
import com.gw.service.ApprovalService;
import com.gw.service.ContactsService;
import com.gw.service.ProjectService;
import com.gw.ui.ProjectDeptPager;
import com.gw.ui.ProjectPager;
import com.gw.ui.ThePager;
import com.gw.view.ProjectDownloadView;

@Controller
@RequestMapping(path = { "/project" })
public class ProjectController {

	@Autowired
	@Qualifier("projectService")
	private ProjectService projectService;

	@Autowired
	@Qualifier("approvalService")
	private ApprovalService approvalService;

	@Autowired
	@Qualifier("contactsService")
	private ContactsService contactsService;

	/////////////////////////////////////////////////////////////////////////////////////////

	private final int PAGE_SIZE = 8; // 한 페이지에 표시되는 데이터 개수
	private final int PAGER_SIZE = 4; // 한 번에 표시할 페이지 번호 개수
	private final String LINK_URL = "list"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
	private final String LINK_URL_DEPT = "list_by_dept"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로

	// 프로젝트 add 창 불러오기
	@GetMapping(path = { "/write" })
	public String showWriteProjectForm(@RequestParam(defaultValue = "-1") int comNo, HttpSession session, Model model) {

		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		comNo = member.getMem_com_code();

		List<DeptDto> depts = projectService.findDepts(comNo);
		List<MemberDetailDto> details = projectService.findMembersListDetail();

		model.addAttribute("depts", depts);
		model.addAttribute("details", details);

		return "project/write";
	}

	// 프로젝트 add 작업
	@PostMapping(path = { "/write" })
	public String addProject(ProjectDto project, MultipartHttpServletRequest req) {

		List<MultipartFile> attaches = req.getFiles("attach");

		ArrayList<ProjectAttachDto> attachments = new ArrayList<>();

		for (MultipartFile attach : attaches) {

			if (attach != null) {

				ServletContext application = req.getServletContext();
				String path = application.getRealPath("/project-attachments");
				String fileName = attach.getOriginalFilename();
				if (fileName != null && fileName.length() > 0) {
					String uniqueFileName = Util.makeUniqueFileName(fileName);

					try {
						attach.transferTo(new File(path, uniqueFileName));

						ProjectAttachDto attachment = new ProjectAttachDto();
						attachment.setSche_attach_userfilename(fileName);
						attachment.setSche_attach_savedfilename(uniqueFileName);
						attachments.add(attachment);

					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}

		project.setSche_attachments(attachments);

		int deptNo = project.getDept_id_no();
		project.setDept_id_no(deptNo);

		projectService.writeProject(project);

		return "redirect:/project/list";
	}

	// write 창에서 담당자 및 팀원 입력
	@GetMapping(path = { "/member_list_by_dept_id_no" })
	@ResponseBody
	public List<MemberDto> addDept(@Param("deptNo") int deptNo, Model model) {

		List<MemberDto> members = projectService.findMembersByDept(deptNo);

		return members;
	}

	// 프로젝트 list 창 불러오기
	@GetMapping(path = { "/list" })
	public String showProjectList(@RequestParam(defaultValue = "1") int pageNo,
								  @RequestParam(defaultValue = "-1") int comNo, HttpSession session,Model model) {

		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		comNo = member.getMem_com_code();

		List<ProjectDto> projects = projectService.findProjectByPage(pageNo, PAGE_SIZE);
		List<MemberDetailDto> members = projectService.findMembersListDetail();
		List<DeptDto> depts = projectService.findDepts(comNo);
		int projectCount = projectService.findProjectCount();

		ProjectPager pager = new ProjectPager(projectCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);

		model.addAttribute("members", members);
		model.addAttribute("projects", projects);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("depts", depts);

		return "project/list";
	}

	// list 창에서 ajax로 부서별 일정 가져오기
	@GetMapping(path = { "/list_by_dept" })
	public String showProejctListByDept(@RequestParam(defaultValue = "1") int pageNo,
										@RequestParam(defaultValue = "-1") int deptNo,
										@RequestParam(defaultValue = "-1") int comNo, HttpSession session, Model model) {

		if (deptNo == -1) {
			return "redirect:list";
		}

		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		comNo = member.getMem_com_code();

		List<ProjectDto> projectsByDept = projectService.findProjectByDept(deptNo);
		List<ProjectDto> projectByPage = projectService.findProjectByDeptByPage(deptNo, pageNo, PAGE_SIZE);
		List<MemberDetailDto> members = projectService.findMembersListDetail();
		List<DeptDto> depts = projectService.findDepts(comNo);

		ProjectDeptPager pager = new ProjectDeptPager(projectsByDept.size(), pageNo, PAGE_SIZE, PAGER_SIZE, deptNo, LINK_URL_DEPT);

		model.addAttribute("projectByPage", projectByPage);
		model.addAttribute("members", members);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("depts", depts);

		return "project/list_dept";
	}

	// 프로젝트 detail 창 불러오기
	@GetMapping(path = { "/detail" })
	public String showProjectDetail(@RequestParam(defaultValue = "-1") int projectNo,
									@RequestParam(defaultValue = "1") int pageNo,
									Model model) {

		List<MemberDetailDto> members = projectService.findMembersListDetail();
		List<MemberDto> member = projectService.findMembers();
		ProjectDto project = projectService.findProjectByProjectNo(projectNo);

		model.addAttribute("members", members);
		model.addAttribute("member", member);
		model.addAttribute("project", project);
		model.addAttribute("projectNo", projectNo);
		model.addAttribute("pageNo", pageNo);

		return "project/detail";
	}

	// detail창에서 attach 다운로드
	@GetMapping(path = { "/download" })
	public View download(@RequestParam(defaultValue = "-1") int attachNo, Model model) {

		ProjectAttachDto attachment = projectService.findProjectAttachByAttachNo(attachNo);
		ProjectDownloadView view = new ProjectDownloadView();

		model.addAttribute("attachment", attachment);

		return view;
	}

	// 프로젝트 삭제
	@GetMapping(path = { "/delete" })
	public String deleteProject(@RequestParam(defaultValue = "-1") int projectNo,
								@RequestParam(defaultValue = "-1") int pageNo, Model model) {

		if (pageNo == -1 || projectNo == -1) {
			return "project/list";
		}

		projectService.deleteProject(projectNo);

		return "redirect:/project/list?pageNo=" + pageNo;
	}

	// edit 창으로 이동
	@GetMapping(path = { "/edit" })
	public String showProjectEditForm(@RequestParam(defaultValue = "-1") int projectNo,
									  @RequestParam(defaultValue = "-1") int pageNo,
									  @RequestParam(defaultValue = "-1") int comNo, HttpSession session, Model model) {

		if (projectNo == -1 || pageNo == -1) {
			return "project/list";
		}

		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		comNo = member.getMem_com_code();

		ProjectDto project = projectService.findProjectByProjectNo(projectNo);
		List<DeptDto> depts = projectService.findDepts(comNo);
		List<MemberDetailDto> details = projectService.findMembersListDetail();

		model.addAttribute("depts", depts);
		model.addAttribute("details", details);
		model.addAttribute("project", project);
		model.addAttribute("projectNo", projectNo);
		model.addAttribute("pageNo", pageNo);

		return "project/edit";
	}

	// edit 창에서 프로젝트 에딧 기능
	@PostMapping(path = { "/edit" })
	public String modifyProject(@RequestParam(defaultValue = "-1") int pageNo, ProjectDto project,
								int[] attach_no_to_delete, MultipartHttpServletRequest req, Model model) {

		if (project.getSche_id_no() == 0 || pageNo == -1) {
			return "project/list";
		}

		List<MultipartFile> attaches = req.getFiles("attach");

		ArrayList<ProjectAttachDto> attachments = new ArrayList<>();

		for (MultipartFile attach : attaches) {

			if (attach != null) {

				ServletContext application = req.getServletContext();
				String path = application.getRealPath("/project-attachments");
				String fileName = attach.getOriginalFilename();
				if (fileName != null && fileName.length() > 0) {
					String uniqueFileName = Util.makeUniqueFileName(fileName);

					try {
						attach.transferTo(new File(path, uniqueFileName));

						ProjectAttachDto attachment = new ProjectAttachDto();
						attachment.setSche_attach_userfilename(fileName);
						attachment.setSche_attach_savedfilename(uniqueFileName);
						attachments.add(attachment);

					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}

		if (attach_no_to_delete != null) {
			for (int i : attach_no_to_delete) {
				projectService.deleteProjectAttachment(i);
			}
		}

		project.setSche_attachments(attachments);

		projectService.modifyProject(project);

		return "redirect:detail?projectNo=" + project.getSche_id_no() + "&pageNo=" + pageNo;
	}

	// edit 창에서 담당자 및 팀원 입력
	@GetMapping(path = { "/member_edit_by_dept_id_no" })
	@ResponseBody
	public List<MemberDto> eidtDept(@Param("deptNo") int deptNo, Model model) {

		List<MemberDto> members = projectService.findMembersByDept(deptNo);

		return members;
	}

	// edit attachment ajax 갱신
	@GetMapping(path = {"attachment-list"})
	public String showEditAttachment(@RequestParam(defaultValue = "-1") int projectNo, Model model) {

		ProjectDto project = projectService.findProjectByProjectNo(projectNo);

		model.addAttribute("project", project);

		return "project/edit-attach";
	}

	// edit 창에서 attachments 삭제
	@GetMapping(path = { "/delete_attaches" })
	@ResponseBody
	public String editProjectAttachment(@Param("attachNo") int attachNo) {

		projectService.deleteProjectAttachment(attachNo);

		return "success";
	}

	// my project 창 불러오기
	@GetMapping(path = { "/myproject" })
	public String showMyProjectList(@RequestParam(defaultValue = "-1") int memberNo,
									@RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {

		MemberDto member = (MemberDto) session.getAttribute("loginuser");

		if (member != null) {
			memberNo = member.getMem_id_no();
		}

		List<ProjectDto> projects = projectService.findProjectByMemberNo(memberNo);

		DecimalFormat df = new DecimalFormat("###,###");

		for (ProjectDto project : projects) {
			project.getSche_spent_budget();
			project.getSche_estimated_budget();

			project.setEstimated_budget(df.format(project.getSche_estimated_budget()));
			project.setSpent_budget(df.format(project.getSche_spent_budget()));
		}

		List<MemberDetailDto> memberdetails = projectService.findMembersListDetail();
		List<MemberDto> members = projectService.findMembers();
		projectService.updateAlert(memberNo);

		model.addAttribute("memberdetail", memberdetails);
		model.addAttribute("projects", projects);
		model.addAttribute("memberNo", memberNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("members", members);

		return "project/myproject";
	}

	// my project 불러오기
	@GetMapping(path = { "/myproject-list" })
	public String loadMyProjectForm(@RequestParam (defaultValue = "-1") int memberNo,
									@RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {

		MemberDto member = (MemberDto) session.getAttribute("loginuser");

		if (member != null) {
			memberNo = member.getMem_id_no();
		}

		List<ProjectDto> projects = projectService.findProjectByMemberNo(memberNo);

		DecimalFormat df = new DecimalFormat("###,###");

		for (ProjectDto project : projects) {
			project.getSche_spent_budget();
			project.getSche_estimated_budget();

			project.setEstimated_budget(df.format(project.getSche_estimated_budget()));
			project.setSpent_budget(df.format(project.getSche_spent_budget()));
		}

		List<MemberDetailDto> memberdetails = projectService.findMembersListDetail();
		List<MemberDto> members = projectService.findMembers();

		model.addAttribute("memberdetail", memberdetails);
		model.addAttribute("projects", projects);
		model.addAttribute("memberNo", memberNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("members", members);

		return "project/myproject-list";
	}

	// 마이프로젝트 삭제
	@GetMapping(path = { "/myproject-delete" })
	@ResponseBody
	public String deleteMyProject(@RequestParam(defaultValue = "-1") int memberNo, @RequestParam(defaultValue = "-1") int projectNo, Model model) {

		if (projectNo == -1) {
			return "project/list";
		}

		projectService.deleteProject(projectNo);

		return "success";
	}

	// 프로젝트 success 갱신 후 ajax로 my project-list 이동
	@GetMapping(path = { "/myproject-success" })
	@ResponseBody
	public String successMyProject(@RequestParam(defaultValue = "-1") int memberNo,
								   @RequestParam(defaultValue = "-1") int projectNo, Model model) {

		if (projectNo == -1) {
			return "project/list";
		}

		projectService.successProject(projectNo);

		return "success";
	}

	// 마이프로젝트 창에서 contacts 연결
	@GetMapping(path = { "/contacts_by_dept"})
	public String showContactsListByDept(@RequestParam(defaultValue = "1") int pageNo,
										 @RequestParam(defaultValue = "-1") int deptNo,
										 Model model, HttpSession session) {

		if (deptNo == -1) {
			return "redirect:contacts";
		}

		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int comNo = member.getMem_com_code();

		List<MemberDto> contactsByPage = contactsService.findMembersByDeptByPage(deptNo, pageNo, PAGE_SIZE);
		List<MemberDetailDto> details = contactsService.findMemberDetail();
		List<DeptDto> depts = contactsService.findDept(comNo);
		List<RoleDto> roles = contactsService.findRole();
		List<MemberDto> members = approvalService.findMembersByDept(deptNo, comNo);

		ProjectDeptPager pager = new ProjectDeptPager(members.size(), pageNo, PAGE_SIZE, PAGER_SIZE, deptNo, LINK_URL_DEPT);

		model.addAttribute("members", contactsByPage);
		model.addAttribute("details", details);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("depts", depts);
		model.addAttribute("roles", roles);

		return "contact/contacts_dept";
	}




}