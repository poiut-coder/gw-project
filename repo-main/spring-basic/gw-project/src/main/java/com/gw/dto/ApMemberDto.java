package com.gw.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ApMemberDto {

	private int mem_id_no;
	private int mem_dept_no;
	private String mem_detail_name;
	private String mem_detail_innernumber;
	private String mem_detail_email;
	private String dept_name;
	private String role_name;
}