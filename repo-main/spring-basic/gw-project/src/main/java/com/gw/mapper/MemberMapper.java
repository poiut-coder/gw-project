package com.gw.mapper;

import java.lang.reflect.Member;
import java.util.List;

import org.apache.ibatis.annotations.*;

import com.gw.dto.CompanyDto;
import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.RoleDto;

//회원가입 insert한 경우를 말함
@Mapper
public interface MemberMapper {

	@Insert("INSERT INTO member ( mem_passwd, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no) "
			+ "VALUES ( #{ mem_passwd }, #{ mem_retire }, #{ mem_admin }, #{ mem_com_code }, #{ mem_dept_no }, #{ mem_position_no }) ")
	@Options(useGeneratedKeys = true, keyColumn = "mem_id_no", keyProperty = "mem_id_no")
	void insertMember(MemberDto member);

	@Select("SELECT * " +
			"FROM member " +
			"ORDER BY mem_register_date DESC LIMIT 1 ")
	MemberDto selectRegistMember();

	@Select("SELECT * " +
			"FROM company " )
	List<CompanyDto> selectAllCompanies();

	@Select("SELECT * " +
			"FROM dept " )
	List<DeptDto> selectAllDepts();

	@Select("SELECT * " +
			"FROM role " )
	List<RoleDto> selectAllRoles();

//	@Insert("INSERT INTO member_detail (mem_detail_id_no, mem_detail_name) " +
//			"VALUES (#{ mem_detail_id_no}, #{mem_detail_name} ) " )
//
//	void insertMemberDetail(MemberDetailDto memberDetail);

//	@Insert("INSERT INTO member_detail (mem_detail_id_no) " +
//			"VALUES (#{ mem_id_no }) " )
//	<member>
//
//	void insertMemberDetailId(member);

	@Insert("INSERT INTO member_detail (mem_detail_id_no, mem_detail_name, mem_detail_email ) " +
			"VALUES (#{ mem_detail_id_no}, #{mem_detail_name}, #{mem_detail_email} ) " )
	void insertMemberDetailIdNameEmail(MemberDetailDto memberDetail);

	@Select("SELECT * " +
			"FROM dept " +
			"WHERE comp_dept_id_no = #{ comp_dept_id_no } " )

	List<DeptDto> selectAllDeptsByCompanyId(int mem_com_code);


	@Select("SELECT * " +
			"FROM role " +
			"WHERE dept_role_id_no = #{ dept_role_id_no }" )
	List<RoleDto> selectAllRolesByDeptId(int dept_role_id_no);

	@Select("SELECT * " +
			"FROM role " +
			"WHERE role_comp_id_no = #{ role_comp_id_no }" )
	List<RoleDto> selectAllRolesByCompId(int role_comp_id_no);


	//	//회사정보 조회하기///대분류
	@Select("SELECT * " +
			"FROM member " +
			"WHERE mem_com_code = #{ mem_com_code } " +
			"ORDER BY mem_dept_no " )
	@Results(id = "memberResultMap",
			value = {
					@Result(column = "mem_com_code", property = "mem_com_code", id=true),
					@Result(column = "mem_com_code", property = "company", one = @One(select = "selectAllCompanies"))
			})

	List<MemberDto> selectMembersByCompany(@Param("mem_com_code") int mem_com_code);






	// 회원가입 화면에서 조회하기

	//회원가입한 회원만 로그인 할 수 있도록 구현
	@Select("SELECT mem_id_no, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no " + "FROM member "
			+ "WHERE mem_id_no = #{ mem_id_no } AND mem_passwd = #{ mem_passwd } " )

	MemberDto selectMemIdNoPasswd(@Param("mem_id_no") int mem_id_no, @Param("mem_passwd") String mem_passwd);

	//관리자 회원인지 걸러내기
	@Select("SELECT mem_id_no, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no " + "FROM member "
			+ "WHERE mem_id_no = #{ mem_id_no } AND mem_passwd = #{ mem_passwd } AND mem_admin = #{ mem_admin } " )

	MemberDto selectMemIdNoPasswdAdmin(@Param("mem_id_no") int mem_id_no, @Param("mem_passwd") String mem_passwd);

	//mem_id_no(user)가 마이페이지 조회하기
	// 1.memberid를 사용해서 member 조회하는 메서드
	@Select("SELECT mem_id_no, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no " +
			"FROM member " +
			"WHERE mem_id_no = #{ mem_id_no } " )

	MemberDto selectMemByIdNo(int mem_id_no);

	// 2.memberid를 사용해서 member_detail 조회하는 메서드
	@Select("SELECT mem_detail_id_no, mem_detail_name, mem_detail_birthday, mem_detail_email, mem_detail_phone, mem_detail_innernumber, mem_detail_fromdate, mem_detail_todate " +
			"FROM member_detail " +
			"WHERE mem_detail_id_no = #{ mem_detail_id_no }" )

	MemberDetailDto selectMemDetailByIdNo(int mem_detail_id_no);

	//회사 아이디로 회사정보 조회하기
	@Select("SELECT comp_id_no, comp_name " +
			"FROM company " +
			"WHERE comp_id_no = #{comp_id_no} " )
	CompanyDto selectCompanyByCompId(int comp_id_no);

	//부서 아이디로 부서정보 조회하기
	@Select("SELECT dept_id_no, dept_name " +
			"FROM dept " +
			"WHERE dept_id_no = #{dept_id_no} " )

	DeptDto selectDeptByDeptId(int dept_id_no);

	//직급 아이디로 직급정보 조회하기
	@Select("SELECT role_id_no, role_name " +
			"FROM role " +
			"WHERE role_id_no = #{role_id_no} " )
	RoleDto selectRoleByRoleId(int role_id_no);

	@Select("SELECT mem_detail_id_no, mem_detail_name, mem_detail_email " +
			"FROM member_detail " +
			"WHERE mem_detail_id_no = #{ mem_detail_id_no } " )
	MemberDetailDto selectMemberDetailByDetailId(int mem_detail_id_no);


	//	//3. member와 member detail에서 조회한 정보 기반 member insert를 해야함
//	@Insert("INSERT INTO member_detail(mem_detail_id_no, mem_detail_name, mem_detail_birthday, mem_detail_email, mem_detail_phone, mem_detail_innernumber, mem_detail_fromdate, mem_detail_todate " +
//			"VALUES (#{ mem_detail_id_no }, #{ mem_detail_name }, #{ mem_detail_birthday }, #{ mem_detail_email }, #{ mem_detail_innernumber }, #{ mem_detail_fromdate }, #{ mem_detail_todate })")
//
//	void insertMemDetailByIdNo(MemberDetailDto member);
//
/////////////////////////////////////////////////////////////////////////////
	//memberdetail에서 조회한 정보 수정
	@Update("UPDATE member_detail "
			+ "SET mem_detail_name = #{ mem_detail_name }, mem_detail_birthday = #{ mem_detail_birthday }, mem_detail_email = #{ mem_detail_email }, mem_detail_phone = #{ mem_detail_phone }, mem_detail_innernumber = #{ mem_detail_innernumber }, mem_detail_fromdate = #{ mem_detail_fromdate}, mem_detail_todate = #{ mem_detail_todate } "
			+ "WHERE mem_detail_id_no = #{ mem_detail_id_no } " )

	void updateMemberDetail(MemberDetailDto member);

	@Select("SELECT mem_id_no, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no " +
			"FROM member " +
			"WHERE mem_id_no = #{ mem_id_no } AND mem_passwd = #{ mem_passwd } AND mem_admin =#{ mem_admin } " )

	MemberDto selectMemAdmin(@Param("mem_id_no")int mem_id_no, @Param("mem_passwd")String mem_passwd, @Param("mem_admin")int mem_admin);

	//MemberList 조회
	@Select("SELECT mem_id_no, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no, mem_register_date " +
			"FROM member " +
			"ORDER BY mem_register_date DESC " )

	List<MemberDto> selectAllMembers2();


	//MemberList 조회
	@Select("SELECT mem_id_no, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no, mem_register_date " +
			"FROM member " +
			"ORDER BY mem_register_date DESC " +
			"LIMIT #{ from }, #{ count } " )

	List<MemberDto> selectAllMembers();

	//TODO 퇴사처리 화면만들기;
	@Select("SELECT mem_id_no, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no, mem_register_date " +
			"FROM member " +
			"WHERE mem_retire = TRUE " +
			"ORDER BY mem_register_date DESC " +
			"LIMIT #{ from }, #{ count } " )

	List<MemberDto> selectRetireMembersByPage(@Param("from")int from, @Param("count")int count);


	@Select("SELECT mem_id_no, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no, mem_register_date " +
			"FROM member " +
			"WHERE mem_retire = FALSE " +
			"ORDER BY mem_register_date DESC " +
			"LIMIT #{ from }, #{ count } " )

	List<MemberDto> selectAllMembersByPage(@Param("from")int from, @Param("count")int count);



	//list show
	@Select("SELECT COUNT(*) " +
			"FROM member " +
			"WHERE mem_retire = false ")
	int selectActiveMemberCount();

	//list show
	@Select("SELECT COUNT(*) " +
			"FROM member " +
			"WHERE mem_retire = true ")
	int selectRetireMemberCount();
	

	//MemberList에서 찾은 회원 하나씩 조회
	@Select("SELECT mem_id_no, mem_retire, mem_admin, mem_com_code, mem_dept_no, mem_position_no " +
			"FROM member " +
			"WHERE mem_id_no = #{ mem_id_no } " )

	MemberDto selectDetailMemberById(int mem_id_no);

	//MemberList에서 찾은 회원 정보 수정

	@Update("UPDATE member " +
			"SET mem_admin=#{ mem_admin }, mem_dept_no= #{mem_dept_no}, mem_position_no = #{ mem_position_no }, mem_retire = #{ mem_retire } " +
			"WHERE mem_id_no = #{ mem_id_no }" )

	void updateMemberAdminAndDept(MemberDto member);



	@Update("UPDATE member " +
			"SET mem_retire = #{ mem_retire } " +
			"WHERE mem_id_no = #{ mem_id_no }" )

	void updateMemberRetire(boolean member);

	//사원명으로 검색하기 쿼리
	@Select("SELECT DISTINCT mem_detail_name " +
			"FROM member " +
			"INNER JOIN member_detail " +
			"ON mem_detail_name like #%{memberSearchByName}% " )
	List<MemberDto> selectMembersByName(String memberSearchByName);

	//회사명으로 사원 검색하기
	@Select("SELECT DISTINCT mem_detail_name " +
			"FROM member " +
			"INNER JOIN member_detail " +
			"INNER JOIN company " +
			"ON mem_detail_name like #%{}% ")

	List<MemberDto> selectMemberByCompName();

}
