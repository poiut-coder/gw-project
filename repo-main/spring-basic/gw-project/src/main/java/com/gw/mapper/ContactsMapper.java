package com.gw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.One;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;

import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.RoleDto;

@Mapper
public interface ContactsMapper {

	
	// list pager  
	@Select("SELECT COUNT(*) " +
			"FROM member ")
	int selectContactsCount();

	// list pager show
	@Select("SELECT * FROM member m, member_detail md " +
			"WHERE m.mem_id_no = md.mem_detail_id_no " +
			"LIMIT #{ from }, #{ count } ")
	List<MemberDto> selectMembersByPage(@Param("from") int from, @Param("count") int count);
	
	// 부서별 멤버 가져오기
	@Select("SELECT * FROM member WHERE mem_dept_no = #{ deptNo } ORDER BY mem_position_no ")
	@Results(id = "memberResultMap",
	 value = {
			 @Result(column = "mem_id_no", property = "mem_id_no", id = true),
			 @Result(column = "mem_id_no", property = "memberDetail",
			 		 one = @One(select = "selectMembersDetailByMemberId"))
	})
	List<MemberDto> selectMembersByDept(@Param("deptNo") int deptNo);

	// 조건있는 member detail 
	@Select("SELECT * FROM member where mem_id_no = #{ memberId } ")
	List<MemberDto> selectMemberByMemberId(int memberId);
	
	// 부서 
	@Select("SELECT * FROM dept " +
			"WHERE comp_dept_id_no = #{ comNo } ")
	List<DeptDto> selectDept(int comNo);
	
	// 직급
	@Select("SELECT * FROM role ")
	List<RoleDto> selectRole();
	
	// 멤버 디테일
	@Select("SELECT * FROM member_detail ")
	List<MemberDetailDto> selectMemberDetail();

	// 부서별 contacts 조회
	@Select("SELECT * FROM member m, member_detail md " +
			"WHERE m.mem_id_no = md.mem_detail_id_no AND m.mem_dept_no = #{ deptNo } " +
			"LIMIT #{ from }, #{ count } ")
	List<MemberDto> selectMemberByDeptByPage(@Param("deptNo") int deptNo, @Param("from") int from, @Param("count") int count);
		
	
	
}
