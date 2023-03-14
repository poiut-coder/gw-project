package com.gw.service;

import java.util.List;

import com.gw.dto.AttendanceDto;

public interface AttendanceService {
	
	//출근
	void attdOn(int userNo);
	
	//퇴근
	void attdOff(int userNo);
	
	//출퇴근 데이터 가져오기
	List<AttendanceDto> findAttendances(int userNo);
	
	//출퇴근 월별 데이터 가져오기
	List<AttendanceDto> findMonthAttendances(int userNo, int year, int month);
	
	//출퇴근 중복검사
	AttendanceDto findAttendance(int userNo);
	
}
