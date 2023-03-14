package com.gw.dto;

import lombok.Data;

@Data
public class ApSheetDto {

	private int sheet_id_no;
	private String sheet_name;
	private String sheet_content;
	private int mem_id_no;
	private boolean sheet_deleted;
	private boolean sheet_all;

	
	
}