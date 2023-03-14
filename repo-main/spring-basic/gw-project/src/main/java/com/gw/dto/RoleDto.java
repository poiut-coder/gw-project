package com.gw.dto;

import lombok.Data;

@Data
public class RoleDto {
	// 직급
	private int role_id_no; // 직급번호 == (사원)의 직급번호(mem_position_no)와 연결
	private String role_name; // 직급명
	private int role_comp_id_no;
	private int dept_role_id_no;

	private CompanyDto company;
}
