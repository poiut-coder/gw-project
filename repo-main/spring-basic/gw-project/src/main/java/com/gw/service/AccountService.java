package com.gw.service;


import java.util.List;

import com.gw.dto.*;

public interface AccountService {

	void registerMember(MemberDto member);

	List<CompanyDto> findAllCompanies();
	List<DeptDto> findAllDepts();
	List<RoleDto> findAllRoles();


	List<DeptDto>findAllDeptsByCompId(int mem_com_code);

	List<RoleDto> findAllRolesByCompId(int mem_dept_no);


	List<MemberDto> findMembersByCompany(int mem_com_code);

	//로그인 시 관리자면 관리자 홈으로, 일반회원이면 일반 홈으로 가도록
	MemberDto findMemIdNoPasswd(int mem_id_no, String mem_passwd);
	//MemberDto findMemAdmin(int mem_id_no, String mem_passwd, int mem_admin);

	// member_id로 member 조회 메서드 만들기 (memberDto + memberDetailDto)
	MemberDto findMemById(int mem_id_no);

	MemberDetailDto findMemDetailById(int mem_detail_id_no);


	void modifyMypage(MemberDetailDto member);

	//MemberDto findMemAdmin(int mem_id_no, String mem_passwd, int mem_admin);

	//List<MemberDto> findAllMember();
	//회원정보 페이징, 찾기 조회
	List<MemberDto> findAllMemberByPage(int pageNo, int PAGE_SIZE);

	int findActiveMemberCount();
	int findRetireMemberCount();
	
	//회원 상세정보 조회
	MemberDto findDetailMemAdminById(int mem_id_no);

	//ajax사용하기 위한 블링블링
	List<CompanyDto>findMemCompanies();
	List<DeptDto>findMemDeptsByCompId(int mem_com_code);
	List<RoleDto>findMemRolesByCompId(int mem_com_code);

	//회원 정보 수정 처리
	void modifiedMember(MemberDto member);
	List<CompanyDto>editCompanies();
	List<DeptDto>editDepts();
	List<RoleDto>editRoles();

	//회원 정보 삭제처리
	void deletedMember(boolean member);

	//삭제 후 리스트 새로 조회
	List<MemberDto> findRetireMemberByPage(int pageNo, int PAGE_SIZE);


	//	//search
	List<MemberDto> findSearchMembersByName(String memberSearchByName);

	MemberDto findAllMemberByMemId(int mem_id_no);


//	List<MemberDto> searchMembersByName(String search, int loginuserid);
//
//	List<MemberDto> searchMembersByCompName();


}
