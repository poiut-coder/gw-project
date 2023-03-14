package com.gw.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ApDocDto {

	private int doc_id_no;
	private String doc_title;
	private String doc_content;
	private Date doc_regdate;
	private int doc_sender;
	private String doc_memo;
	private boolean doc_deleted;
	private boolean doc_star;

	
	
}