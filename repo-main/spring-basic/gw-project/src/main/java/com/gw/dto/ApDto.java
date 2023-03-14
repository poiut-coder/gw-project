package com.gw.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ApDto {
	
	private int appr_id_no;
	private int appr_doc_no;
	private int appr_receiver;
	private int appr_status;
	private Date appr_regdate;
	private int appr_sender;
	private int appr_turn;
	private int appr_valid;
	private int appr_group;
	private int appr_preturn;
	private String appr_memo;
	private String appr_reject_memo;

}