package com.gw.service;

import java.util.List;

import com.gw.dto.AttendanceDto;
import com.gw.mapper.AttendanceMapper;

import lombok.Setter;

public class AttendanceServiceImpl implements AttendanceService {

	@Setter
	private AttendanceMapper attendanceMapper;

	//출근
	@Override
	public void attdOn(int userNo) {
		attendanceMapper.insertAttdanceOn(userNo);
	}
	
	//퇴근
	@Override
	public void attdOff(int userNo) {
		attendanceMapper.insertAttdanceOff(userNo);
	}

	//출퇴근 데이터 가져오기
	@Override
	public List<AttendanceDto> findAttendances(int userNo) {
		List<AttendanceDto> ats = attendanceMapper.selectAttdancesByUserNo(userNo);
		return ats;
	}

	//툴퇴근 월별 데이터 가져오기
	@Override
	public List<AttendanceDto> findMonthAttendances(int userNo, int year, int month) {
		List<AttendanceDto> ats = attendanceMapper.selectAttdancesByUserNoAndMonth(userNo,year,month);
		return ats;
	}
	
	//출퇴근 중복검사
	@Override
	public AttendanceDto findAttendance(int userNo) {
		AttendanceDto at = attendanceMapper.selectAttdanceByUserNo(userNo);
		return at;
	}

	

	
	

	
}
