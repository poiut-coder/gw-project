package com.gw.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MailDto {

	private int mailNo;
	private String title;
	private String writer;
	private String receiver;
	private String content;
	private Date regDate;
	private int readCount;
	private boolean deleted;
	private int attachCount;
	private int draft;
	
	// Board 테이블과 BoartAttach 테이블 사이의 1:Many 관계를 구현한 필드 (변수)
	private List<MailAttachDto> attachments;
	// Board 테이블과 BoartAttach 테이블 사이의 1:1 관계를 구현한 필드 (변수)
	// private BoardAttachDto attachment;	

}
