package com.gw.dto;

import lombok.Data;

@Data
public class DeptDto {

	private int dept_id_no;
	private String dept_name;
	private int comp_dept_id_no;

	private CompanyDto company;
}
