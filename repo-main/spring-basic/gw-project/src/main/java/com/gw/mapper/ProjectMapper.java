package com.gw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.One;

import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.ProjectAttachDto;
import com.gw.dto.ProjectDto;
import com.gw.dto.RoleDto;

@Mapper
public interface ProjectMapper {


	// write
	@Insert("INSERT INTO schedule (sche_title, sche_content, sche_status, sche_start_date, sche_end_date, sche_deleted, sche_writer, sche_type_id_no) " +
			"VALUES (#{ sche_title }, #{ sche_content }, #{ sche_status }, #{ sche_start_date }, #{ sche_end_date }, #{ sche_deleted }, #{ sche_writer }, 1) ")
	void insertProject1(ProjectDto project);

	// write
	@Select("SELECT * " +
			"FROM schedule " +
			"ORDER BY sche_id_no DESC " +
			"LIMIT 1 ")
	ProjectDto selectScheId();

	// write
	@Insert("INSERT INTO pro_schedule (sche_id_no, sche_leader, sche_team, sche_client, sche_client_phone, sche_client_email, sche_estimated_budget, sche_spent_budget, sche_estimated_duration, dept_id_no, sche_alert) " +
			"VALUES (#{ sche_id_no }, #{ sche_leader }, #{ sche_team }, #{ sche_client }, #{ sche_client_phone }, #{ sche_client_email }, #{ sche_estimated_budget }, #{ sche_spent_budget }, #{ sche_estimated_duration }, #{ dept_id_no }, 1) ")
	void insertProject2(ProjectDto project);

	// write attachment
	@Select("SELECT dept_sche_id_no " +
			"FROM pro_schedule " +
			"ORDER BY dept_sche_id_no DESC " +
			"LIMIT 1 ")
	ProjectDto selectDeptScheId();

	// write attachment
	@Insert("INSERT INTO pro_attach (dept_sche_id_no, sche_attach_userfilename, sche_attach_savedfilename) " +
			"VALUES (#{ dept_sche_id_no }, #{ sche_attach_userfilename }, #{ sche_attach_savedfilename }) ")
	void insertProjectAttach(ProjectAttachDto attachment);

	// list show
	@Select("SELECT s.sche_id_no, s.sche_title, s.sche_reg_date, s.sche_start_date, s.sche_end_date, s.sche_writer, p.sche_leader, p.sche_team, p.sche_client, s.sche_status, s.sche_deleted " +
			"FROM schedule s, pro_schedule p " +
			"WHERE s.sche_id_no = p.sche_id_no " +
			"ORDER BY sche_id_no DESC " +
			"LIMIT #{ from }, #{ count } ")
	List<ProjectDto> selectProjectByPage(@Param("from") int from, @Param("count") int count);

	// list show
	@Select("SELECT COUNT(*) " +
			"FROM schedule ")
	int selectProjectCount();

	// list By dept
	@Select("SELECT * " +
			"FROM schedule s, pro_schedule p " +
			"WHERE s.sche_id_no = p.sche_id_no AND p.dept_id_no = #{ deptNo } " +
			"ORDER BY s.sche_id_no DESC ")
	List<ProjectDto> selectProjectByDeptNo(int deptNo);

	// list pager
	@Select("SELECT s.sche_id_no, s.sche_title, s.sche_reg_date, s.sche_start_date, s.sche_end_date, s.sche_writer, p.sche_leader, p.sche_team, p.sche_client, s.sche_status, s.sche_deleted " +
			"FROM schedule s, pro_schedule p " +
			"WHERE s.sche_id_no = p.sche_id_no AND p.dept_id_no = #{ deptNo } " +
			"ORDER BY sche_id_no DESC " +
			"LIMIT #{ from }, #{ count } ")
	List<ProjectDto> selectProjectByDeptNoByPage(@Param("deptNo") int deptNo, @Param("from") int from, @Param("count") int count);

	// detail show
	@Select("SELECT * " +
			"FROM schedule s, pro_schedule p " +
			"WHERE s.sche_id_no = p.sche_id_no AND s.sche_deleted = FALSE AND s.sche_id_no = #{ projectNo } ")
	ProjectDto selectProjectByProjectNo(int projectNo);

	// detail show attach
	@Select("SELECT sche_attach_id_no, sche_attach_userfilename, sche_attach_savedfilename, ps.sche_id_no " +
			"FROM pro_attach as pa " +
			"LEFT OUTER JOIN pro_schedule as ps " +
			"ON pa.dept_sche_id_no = ps.dept_sche_id_no " +
			"WHERE sche_id_no = #{ projectNo } ")
	List<ProjectAttachDto> selectProjectAttachByProjectNo(int projectNo);

	// attach download
	@Select("SELECT * " +
			"FROM pro_attach " +
			"WHERE sche_attach_id_no = #{ attachNo } ")
	ProjectAttachDto selectProjectAttachByAttachNo(int attachNo);

	// edit 1
	@Update("UPDATE schedule " +
			"SET sche_title = #{ sche_title }, sche_content = #{ sche_content }, sche_reg_date = CURRENT_TIMESTAMP, sche_start_date = #{ sche_start_date }, sche_end_date = #{ sche_end_date }, sche_status = #{ sche_status } " +
			"WHERE sche_deleted = FALSE AND sche_id_no = #{ sche_id_no } ")
	void updateProject1(ProjectDto project);

	// edit 2
	@Update("UPDATE pro_schedule " +
			"SET sche_client = #{ sche_client }, sche_client_phone = #{ sche_client_phone }, sche_client_email = #{ sche_client_email }, sche_estimated_budget = #{ sche_estimated_budget }, sche_spent_budget = #{ sche_spent_budget }, sche_estimated_duration = #{ sche_estimated_duration }, sche_leader = #{ sche_leader }, sche_team = #{ sche_team } " +
			"WHERE sche_id_no = #{ sche_id_no } ")
	void updateProject2(ProjectDto project);

	// edit attachment delete
	@Delete("DELETE FROM pro_attach WHERE sche_attach_id_no = #{ attachNo }")
	void deleteProjectAttach(int attachNo);

	// delete
	@Update("UPDATE schedule " +
			"SET sche_deleted = TRUE " +
			"WHERE sche_id_no = #{ projectNo } ")
	void removeProject(int projectNo);

	// my project list show
	@Select("SELECT * " +
			"FROM schedule s, pro_schedule p " +
			"WHERE s.sche_id_no = p.sche_id_no AND s.sche_status != 'Success' AND s.sche_deleted = FALSE AND (s.sche_writer = #{ memberNo } OR p.sche_leader = #{ memberNo } OR p.sche_team = #{ memberNo }) " +
			"ORDER BY s.sche_id_no ASC ")
	List<ProjectDto> selectProjectByMemberNo(int memberNo);

	// my project success
	@Update("UPDATE schedule " +
			"SET sche_status = 'Success' " +
			"WHERE sche_id_no = #{ projectNo } ")
	void successStatusProject(int projectNo);

	// 부서
	@Select("SELECT * " +
			"FROM dept " +
			"WHERE comp_dept_id_no = #{ comNo } ")
	List<DeptDto> selectDepts(int comNo);

	// member detail
	@Select("SELECT * FROM member_detail ")
	List<MemberDetailDto> selectMembersDetail();

	// 부서별 멤버 가져오기
	@Select("SELECT * FROM member WHERE mem_dept_no = #{ deptNo } ORDER BY mem_position_no ")
	@Results(id = "memberResultMap",
			value = {
					@Result(column = "mem_id_no", property = "mem_id_no", id = true),
					@Result(column = "mem_id_no", property = "memberDetail",
							one = @One(select = "selectMembersDetailByMemberId"))
			})
	List<MemberDto> selectMembersByDept(@Param("deptNo") int deptNo);

	// member detail
	@Select("SELECT * FROM member_detail where mem_detail_id_no = #{ memberId } ")
	List<MemberDetailDto> selectMembersDetailByMemberId(int memberId);

	// 직급 불러오기
	@Select("SELECT * FROM role ")
	List<RoleDto> selectRoles();

	// member 불러오기
	@Select("SELECT * FROM member ")
	List<MemberDto> selectMembers();

	// home 마이프로젝트 show
	@Select("SELECT * " +
			"FROM schedule s, pro_schedule p " +
			"WHERE s.sche_id_no = p.sche_id_no AND s.sche_status != 'Success' AND s.sche_deleted = FALSE AND (s.sche_writer = #{ memberNo } OR p.sche_leader = #{ memberNo } OR p.sche_team = #{ memberNo }) " +
			"ORDER BY s.sche_id_no DESC " +
			"LIMIT 8 ")
	List<ProjectDto> SelectHomeProjectByMemberNo(int memberNo);

	// alert 개수
	@Select("SELECT COUNT(*) FROM pro_schedule WHERE (sche_leader = #{ userNo } OR sche_team = #{ userNo }) AND sche_alert = 1 ")
	int countProjectAlert(int userNo);
	
	// alert 확인하면 수정
	@Update("UPDATE pro_schedule SET sche_alert = 0 WHERE (sche_leader = #{ userNo } OR sche_team = #{ userNo }) AND sche_alert = 1 ")
	void updateProjectAlert(int userNo);











}