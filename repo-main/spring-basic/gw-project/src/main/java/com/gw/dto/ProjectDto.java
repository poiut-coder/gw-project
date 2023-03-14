package com.gw.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProjectDto {

	// schedule
	private int sche_id_no;
	private String sche_title; 
	private String sche_content;
	private String sche_status;
	private Date sche_reg_date;
	private String sche_start_date;
	private String sche_end_date;
	private boolean sche_deleted;
	private int sche_writer;
	private int sche_type_id_no;
	
	// pro_schedule
	private int dept_sche_id_no;
	private int dept_id_no;
	private String sche_client; 
	private String sche_client_phone;
	private String sche_client_email;
	private int sche_estimated_budget; 
	private int sche_spent_budget; 
	private int sche_estimated_duration;
	private int sche_leader;
	private int sche_team;
	
	private String estimated_budget; 
	private String spent_budget;

	
	
	// project 테이블과 projectAttach 테이블 사이의 1:Many 관계를 구현
	private List<ProjectAttachDto> sche_attachments;
	
}
