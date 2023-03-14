package com.gw.dto;

import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberDto {
	// 처음 DB설정 시 순서대로 정의할것
//	private enum USER_TYPE  {
//		NOT_VERIFIED,
//		USER,
//		ADMIN
//	}

	// member

	//	private Integer code;
//	private String msg;
//	private T data;
	private int mem_id_no;// 사원번호
	//	@NotBlank(message="비밀번호를 입력하세요")
//	@Pattern(regexp="[A-za-z0-9] {3-10}",  message  = " 세글자 이상 ")
	private String mem_passwd; // 비밀번호
	private boolean mem_retire;// 퇴직여부
	private int mem_admin; //(0: 그냥 일반 홈만 볼 수 있는 유저, 1: 승인이 되지 않는 유저, 2: 승인 된 유저;
	//private boolean mem_admin;// 관리자
	private int mem_com_code;// 회사코드
	private int mem_dept_no;// 부서번호
	private int mem_position_no;// 직급번호
	//@DateTimeFormat(pattern = "yyyy-MM-dd-")
	private String mem_register_date;
	private int member_no;

	private MemberDetailDto memberDetail;
	private CompanyDto company;
	private DeptDto dept;
	private RoleDto role;

}
