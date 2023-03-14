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

import com.gw.dto.AttendanceDto;
import com.gw.dto.MemberDto;
import com.gw.service.ApprovalService;
import com.gw.service.AttendanceService;

@Controller
@RequestMapping(path = { "/attendance"})
public class AttendanceController {
	
	@Autowired
	@Qualifier("attendanceService")
	private AttendanceService attendanceService;

	//출퇴근 데이터 가져오기
	@GetMapping(path = { "/list"})
	public String showAttendanceList(@RequestParam(defaultValue = "-1") int year, @RequestParam(defaultValue = "-1") int month, HttpSession session, Model model) {
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		
		int userNo = member.getMem_id_no();
		
		SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
		SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
	    
		Date date = new Date();
		
		year = Integer.parseInt(yearFormat.format(date));
	    month = Integer.parseInt(monthFormat.format(date));
		
		List<AttendanceDto> ats = attendanceService.findAttendances(userNo);
		
		List<AttendanceDto> lateAllAts = new ArrayList<>();
		
		for (AttendanceDto at : ats) {
			
			int hh = at.setHour(at.getAttd_on());
			int mm = at.setMin(at.getAttd_on());
			at.setHourAndSec(hh, mm);
			
			if (at.getHh() > 9 || (at.getHh() == 9 && at.getMm() >= 1)) {
				lateAllAts.add(at);
			}
			
		}
		
		List<AttendanceDto> monthAts = attendanceService.findMonthAttendances(userNo,year,month);
		
		List<AttendanceDto> lateAts = new ArrayList<>();
		
		for (AttendanceDto at : monthAts) {
			
			int hh = at.setHour(at.getAttd_on());
			int mm = at.setMin(at.getAttd_on());
			at.setHourAndSec(hh, mm);
			
			if (at.getHh() > 9 || (at.getHh() == 9 && at.getMm() >= 1)) {
				lateAts.add(at);
			}
			
		}
		
		int allAttd = ats.size();
		int allLate = lateAllAts.size();
		
		int attd = monthAts.size();
		int late = lateAts.size();
		
		AttendanceDto at = attendanceService.findAttendance(userNo);
		
		model.addAttribute("ats", ats);
		model.addAttribute("validAt", at);
		model.addAttribute("attd", attd);
		model.addAttribute("late", late);
		model.addAttribute("allAttd", allAttd);
		model.addAttribute("allLate", allLate);
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		
		return "attendance/attendance_list";
	}
	
	//출근
	@GetMapping(path = { "/attd_on"})
	public String AttendanceOn(HttpSession session, Model model) {
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		
		int userNo = member.getMem_id_no();
		
		attendanceService.attdOn(userNo);
		
		return "redirect:list";
	}
	
	//퇴근
	@GetMapping(path = { "/attd_off"})
	public String AttendanceOff(HttpSession session, Model model) {
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		
		int userNo = member.getMem_id_no();
		
		attendanceService.attdOff(userNo);
		
		return "redirect:list";
	}
	
	//월별 데이터 가져오기
	@GetMapping(path = { "/month_status"})
	public String AttendanceMonthStatus(@RequestParam(defaultValue = "-1") int year, @RequestParam(defaultValue = "-1") int month, HttpSession session, Model model) {
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		
		int userNo = member.getMem_id_no();
		
		List<AttendanceDto> ats = attendanceService.findMonthAttendances(userNo,year,month);
		
		List<AttendanceDto> lateAts = new ArrayList<>();
		
		for (AttendanceDto at : ats) {
			
			int hh = at.setHour(at.getAttd_on());
			int mm = at.setMin(at.getAttd_on());
			at.setHourAndSec(hh, mm);
			
			if (at.getHh() > 9 || (at.getHh() == 9 && at.getMm() >= 1)) {
				lateAts.add(at);
			}
			
		}
		
		int attd = ats.size();
		int late = lateAts.size();
		model.addAttribute("attd", attd);
		model.addAttribute("late", late);
		model.addAttribute("year", year);
		model.addAttribute("month", month);		
		
		return "attendance/attendance_status";
	}
	
	
	
}
