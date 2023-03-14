package com.gw.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gw.dto.AttendanceDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.ProjectDto;
import com.gw.dto.TodoDto;
import com.gw.service.AttendanceService;
import com.gw.service.ProjectService;
import com.gw.service.TodoService;

@Controller // @Component + Web configuration
public class HomeController {


	@GetMapping (path = {"/"}) // FrontController에 연결 설정
	public String home() {
		return "home"; // /WEB-INF/views/ + home + .jsp
	}

	@Autowired
	@Qualifier("todoService")
	private TodoService todoService;

	@Autowired
	@Qualifier("attendanceService")
	private AttendanceService attendanceService;

	@Autowired
	@Qualifier("projectService")
	private ProjectService projectService;

	@GetMapping (path={"home2"})
	public String home2(Model model, HttpSession session){

		MemberDto member = (MemberDto) session.getAttribute("loginuser");

		List<TodoDto> todos = null;

		if (member != null) {
			todos = todoService.searchTodoayOrderByOrderByCompleteDate(todaydate(), member.getMem_id_no());

			int userNo = member.getMem_id_no();
			Date date = new Date();

			AttendanceDto at = attendanceService.findAttendance(userNo);

			List<ProjectDto> projects = projectService.findHomeProjectByMemberNo(userNo);
			List<MemberDetailDto> memberdetails = projectService.findMembersListDetail();
			List<MemberDto> members = projectService.findMembers();

			model.addAttribute("projects", projects);
			model.addAttribute("memberdetails", memberdetails);
			model.addAttribute("members", members);
			model.addAttribute("today", date);
			model.addAttribute("at", at);
		}

		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int monthValue = now.getMonthValue();
		int dayOfMonth = now.getDayOfMonth();

		model.addAttribute("nowDay", dayOfMonth);
		model.addAttribute("nowMonth", monthValue);
		model.addAttribute("nowYear", year);
		model.addAttribute("todos", todos);

		return "home2";
	}

	public String todaydate() {

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd ");

		Date today = new Date();

		return formatter.format(today);
	}

	//출근
	@GetMapping(path = { "/attd_on"})
	public String AttendanceOn(HttpSession session, Model model) {

		MemberDto member = (MemberDto)session.getAttribute("loginuser");

		int userNo = member.getMem_id_no();

		attendanceService.attdOn(userNo);

		return "redirect:/home2";
	}

	//퇴근
	@GetMapping(path = { "/attd_off"})
	public String AttendanceOff(HttpSession session, Model model) {

		MemberDto member = (MemberDto)session.getAttribute("loginuser");

		int userNo = member.getMem_id_no();

		attendanceService.attdOff(userNo);

		return "redirect:/home2";
	}





}
