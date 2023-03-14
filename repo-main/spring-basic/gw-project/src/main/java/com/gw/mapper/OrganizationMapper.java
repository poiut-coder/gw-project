package com.gw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gw.dto.ApMemberDto;
import com.gw.dto.AttendanceDto;
import com.gw.dto.DeptDto;
import com.gw.dto.MemberDto;

@Mapper
public interface OrganizationMapper {
	//ApMemberDto 가져오기
	@Select("SELECT mem_id_no, mem_detail_name, mem_detail_innernumber, mem_detail_email, role_name, dept_name FROM member LEFT JOIN member_detail ON mem_id_no = mem_detail_id_no " +
			"LEFT JOIN dept ON mem_dept_no = dept_id_no LEFT JOIN role ON mem_position_no = role_id_no WHERE dept_id_no = #{ deptNo } ORDER BY mem_position_no")
	List<ApMemberDto> selectOrMembers(int deptNo);
	
	//부서 불러오기
	@Select("SELECT * FROM dept WHERE comp_dept_id_no = #{ comNo } ORDER BY dept_name")
	List<DeptDto> selectDepts(int comNo);
	
	//부서별 멤버 가져오기
	@Select("SELECT * FROM member WHERE mem_dept_no = #{ deptNo } and mem_com_code = #{ comNo } ORDER BY mem_position_no")
	List<MemberDto> selectMembersByDept(@Param("deptNo")int deptNo, @Param("comNo")int comNo);
}


	