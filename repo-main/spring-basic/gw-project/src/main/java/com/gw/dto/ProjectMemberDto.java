package com.gw.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProjectMemberDto {

	private int mem_id_no;
	private String mem_detail_name;
	private String dept_name;
	private String role_name;
	
}