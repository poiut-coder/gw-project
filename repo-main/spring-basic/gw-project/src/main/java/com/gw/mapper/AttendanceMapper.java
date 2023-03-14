package com.gw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gw.dto.AttendanceDto;

@Mapper
public interface AttendanceMapper {
	
	//출근
	@Insert("INSERT INTO attendance (attd_mem_no) VALUES (#{userNo})")
	void insertAttdanceOn(int userNo);
	
	//퇴근
	@Update("UPDATE attendance SET attd_off = CURRENT_TIMESTAMP WHERE attd_mem_no = #{userNo} AND attd_date = curdate()")
	void insertAttdanceOff(int userNo);
	
	//출퇴근 데이터 가져오기
	@Select("SELECT * FROM attendance WHERE attd_mem_no = #{ userNo }")
	List<AttendanceDto> selectAttdancesByUserNo(int userNo);
	
	//월별 출퇴근 데이터 가져오기
	@Select("SELECT * FROM attendance WHERE attd_mem_no = #{ userNo } AND (DATE_FORMAT(attd_date,'%Y%m') = #{ year }#{ month })")
	List<AttendanceDto> selectAttdancesByUserNoAndMonth(@Param("userNo") int userNo, @Param("year") int year, @Param("month") int month);
	
	//출퇴근 중복 검사
	@Select("SELECT * FROM attendance WHERE attd_mem_no = #{ userNo } AND attd_date = curdate()")
	AttendanceDto selectAttdanceByUserNo(int userNo);
}


	