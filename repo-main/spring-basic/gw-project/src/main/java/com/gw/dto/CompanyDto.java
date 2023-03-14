package com.gw.dto;

import lombok.Data;

@Data
public class CompanyDto {
	
	//회사
	private int comp_id_no;		//회사코드 == member(사원)테이블의 회사코드(mem_com_code)와 연결 
	private String comp_name;	// 회사명

	

}
