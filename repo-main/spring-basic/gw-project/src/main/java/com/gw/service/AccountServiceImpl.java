package com.gw.service;


import java.util.List;

import com.gw.common.Util;
import com.gw.dto.*;
import com.gw.mapper.MemberMapper;

import lombok.Setter;

public class AccountServiceImpl implements AccountService {


	@Setter
	private MemberMapper memberMapper;

	@Override
	public void registerMember(MemberDto member) {

		String memPasswd = Util.getHashedString(member.getMem_passwd(), "SHA-256");
		member.setMem_passwd(memPasswd);
		memberMapper.insertMember(member);//1. insert + mem_id_no를 가지고옴


		MemberDetailDto memberDetail = member.getMemberDetail(); //2.member에서 mem_Detail객체 꺼내기
		memberDetail.setMem_detail_id_no(member.getMem_id_no()); //3.detail에 mem_id저장하기
		memberDetail.setMem_detail_email(memberDetail.getMem_detail_email());


		//memberDetail.setMem_detail_email(member.getMemberDetail().getMem_detail_email());

		//memberMapper.insertMemberDetail(memberDetail);
		memberMapper.insertMemberDetailIdNameEmail(memberDetail);

	}

	@Override
	public List<MemberDto> findMembersByCompany(int mem_com_code) {
		List<MemberDto> members = memberMapper.selectMembersByCompany(mem_com_code);

		return members;
	}


	@Override
	public List<CompanyDto> findAllCompanies() {

		List<CompanyDto> companies = memberMapper.selectAllCompanies();

		return companies;
	}

	@Override
	public List<DeptDto> findAllDepts() {

		List<DeptDto> depts = memberMapper.selectAllDepts();

		return depts;
	}

	@Override
	public List<RoleDto> findAllRoles() {

		List<RoleDto> roles = memberMapper.selectAllRoles();

		return roles;
	}

	@Override
	public List<DeptDto> findAllDeptsByCompId(int mem_com_code) {
		List<DeptDto> depts = memberMapper.selectAllDeptsByCompanyId(mem_com_code);

		return depts;
	}

	@Override
	public List<RoleDto> findAllRolesByCompId(int role_comp_id_no) {
		List<RoleDto> roles = memberMapper.selectAllRolesByCompId(role_comp_id_no);
		return roles;
	}


	//로그인
	@Override
	public MemberDto findMemIdNoPasswd(int mem_id_no, String mem_passwd) {

		mem_passwd = Util.getHashedString(mem_passwd, "SHA-256");
		MemberDto memberDto = memberMapper.selectMemIdNoPasswd(mem_id_no, mem_passwd);

		if (memberDto != null) {
			MemberDetailDto memberDetailDto = memberMapper.selectMemDetailByIdNo(mem_id_no);
			memberDto.setMemberDetail(memberDetailDto);
		}
		return memberDto;
	}

//	@Override
//	public MemberDto findMemAdmin(int mem_id_no, String mem_passwd, int mem_admin) {
//
//		mem_passwd = Util.getHashedString(mem_passwd, "SHA-256");
//		MemberDto memAdmin = memberMapper.selectMemIdNoPasswdAdmin(mem_id_no, mem_passwd);
//
//		return memAdmin;
//	}


	//마이페이지 조회 시 정보 입력
	@Override
	public MemberDto findMemById(int mem_id_no) {
		MemberDto memberDto = memberMapper.selectMemByIdNo(mem_id_no);

		CompanyDto company = memberMapper.selectCompanyByCompId(memberDto.getMem_com_code());
		memberDto.setCompany(company);
		DeptDto dept = memberMapper.selectDeptByDeptId(memberDto.getMem_dept_no());
		memberDto.setDept(dept);
		RoleDto role = memberMapper.selectRoleByRoleId(memberDto.getMem_position_no());
		memberDto.setRole(role);

		MemberDetailDto memberDetailDto = memberMapper.selectMemDetailByIdNo(mem_id_no);
		memberDto.setMemberDetail(memberDetailDto);
		return memberDto;
	}

	@Override
	public MemberDetailDto findMemDetailById(int mem_detail_id_no) {
		MemberDetailDto memberDetailDto = memberMapper.selectMemDetailByIdNo(mem_detail_id_no);
		return memberDetailDto;

	}

	//마이페이지 조회 및 수정
	@Override
	public void modifyMypage(MemberDetailDto member) {
		//MemberDetailDto memberDetailDto =
		memberMapper.updateMemberDetail(member);
		//return memberDetailDto;
	}


	@Override
	public List<MemberDto> findAllMemberByPage(int pageNo, int pageSize) {
		int from = (pageNo - 1) * pageSize;
		int count = pageSize;

		List<MemberDto> members = memberMapper.selectAllMembersByPage(from, count);

		for (MemberDto memberDto : members) {
			CompanyDto company = memberMapper.selectCompanyByCompId(memberDto.getMem_com_code());
			memberDto.setCompany(company);
			DeptDto dept = memberMapper.selectDeptByDeptId(memberDto.getMem_dept_no());
			memberDto.setDept(dept);
			RoleDto role = memberMapper.selectRoleByRoleId(memberDto.getMem_position_no());
			memberDto.setRole(role);
			MemberDetailDto detail = memberMapper.selectMemberDetailByDetailId(memberDto.getMem_id_no());
			memberDto.setMemberDetail(detail);

		}
		return members;
	}

	//active-member-list pager show
	@Override
	public int findActiveMemberCount() {
		int memberCount = memberMapper.selectActiveMemberCount();
		return memberCount;
	}

	//retire-member-list pager show
	@Override
	public int findRetireMemberCount() {
		int memberCount = memberMapper.selectRetireMemberCount();
		return memberCount;
	}

	@Override
	public MemberDto findDetailMemAdminById(int mem_id_no) {
		MemberDto member = memberMapper.selectDetailMemberById(mem_id_no);

		CompanyDto company = memberMapper.selectCompanyByCompId(member.getMem_com_code());
		member.setCompany(company);
		DeptDto dept = memberMapper.selectDeptByDeptId(member.getMem_dept_no());
		member.setDept(dept);
		RoleDto role = memberMapper.selectRoleByRoleId(member.getMem_position_no());
		member.setRole(role);
		MemberDetailDto memberDetailDto = memberMapper.selectMemDetailByIdNo(mem_id_no);
		member.setMemberDetail(memberDetailDto);

		return member;
	}

	@Override
	public List<CompanyDto> findMemCompanies() {
		List<CompanyDto> modiCompanies = memberMapper.selectAllCompanies();
		return modiCompanies;
	}


	@Override
	public List<DeptDto> findMemDeptsByCompId(int mem_com_code) {
		List<DeptDto> modiDepts = memberMapper.selectAllDeptsByCompanyId(mem_com_code);
		return modiDepts;
	}


	@Override
	public List<RoleDto> findMemRolesByCompId(int mem_com_code) {
		List<RoleDto> modiRoles = memberMapper.selectAllRolesByCompId(mem_com_code);

		return modiRoles;
	}


	@Override
	public void modifiedMember(MemberDto member) {

		memberMapper.updateMemberAdminAndDept(member);
	}

	@Override
	public List<CompanyDto> editCompanies() {
		List<CompanyDto> editCompany = memberMapper.selectAllCompanies();
		return editCompany;
	}

	@Override
	public List<DeptDto> editDepts() {

		List<DeptDto> editDept = memberMapper.selectAllDepts();
		return editDept;
	}

	@Override
	public List<RoleDto> editRoles() {
		List<RoleDto> editRole = memberMapper.selectAllRoles();
		return editRole;
	}

	@Override
	public void deletedMember(boolean member) {
		memberMapper.updateMemberRetire(member);
	}

	@Override
	public List<MemberDto> findRetireMemberByPage(int pageNo, int pageSize) {
		int from = (pageNo - 1) * pageSize;
		int count = pageSize;

		List<MemberDto> members = memberMapper.selectRetireMembersByPage(from, count);

		for (MemberDto memberDto : members) {
			MemberDetailDto member = memberMapper.selectMemDetailByIdNo(memberDto.getMem_id_no());
			memberDto.setMemberDetail(member);
			CompanyDto company = memberMapper.selectCompanyByCompId(memberDto.getMem_com_code());
			memberDto.setCompany(company);
			DeptDto dept = memberMapper.selectDeptByDeptId(memberDto.getMem_dept_no());
			memberDto.setDept(dept);
			RoleDto role = memberMapper.selectRoleByRoleId(memberDto.getMem_position_no());
			memberDto.setRole(role);

		}
		return members;
	}

	@Override
	public List<MemberDto> findSearchMembersByName(String memberSearchByName) {
		List<MemberDto> members = memberMapper.selectAllMembers();

		for (MemberDto memberDto : members) {
			MemberDetailDto member = memberMapper.selectMemDetailByIdNo(memberDto.getMem_id_no());
			memberDto.setMemberDetail(member);
			CompanyDto company = memberMapper.selectCompanyByCompId(memberDto.getMem_com_code());
			memberDto.setCompany(company);
			DeptDto dept = memberMapper.selectDeptByDeptId(memberDto.getMem_dept_no());
			memberDto.setDept(dept);
			RoleDto role = memberMapper.selectRoleByRoleId(memberDto.getMem_position_no());
			memberDto.setRole(role);
		}

		return members;
	}

	@Override
	public MemberDto findAllMemberByMemId(int mem_id_no) {
		MemberDto member = memberMapper.selectMemByIdNo(mem_id_no);
		return member;
	}


//	@Override
//	public List<MemberDto> searchMembersByName(String search, int memAdmin){
//
//		int mem_id_no = loginuserid;
//		String searchWithWildCard = "%"+search+"%";
//		List<MemberDto> searchedMemberList =memberMapper.selectMembersByName(searchWithWildCard, mem_id_no);
//		list<MemberDetailDto searchedMemberList2 =memberMapper.selectMembersByName(searchWithWildCard, mem_id_no);
//
//		for(MemberDto member : searchedMemberList) {
//
//			String Name -
//
//
//
//
//
//		}
//		return null;
//	}
//
//	@Override
//	public List<MemberDto> searchMembersByCompName(){
//		List<MemberDto> searchMemberByCompany = memberMapper.selectMemberByCompName();
//		return searchMemberByCompany;
//	}

}