package com.gw.dto;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardDto {

	// 게시판_공통
	private int writeIdNo; // 글번호
	private String title; // 제목
	private String content; // 내용
	private Date regDate; // 작성시간
	private int readCount; // 조회수
	private boolean deleted; // 삭제
	
	// 검색 필터
	private String searchOption;	// 검색 옵션
	private String search;	// 검색 내용
	
	// 게시판_구분형식
	private int typeIdNo; // 게시판형식번호
	private String typeName; // 게시판형식이름

	private List<BoardAttachDto> attachments;

	private List<BoardCommentDto> comments;

	public String dateForm(Date regDate) {
		  SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		  return format.format(regDate);
	}
	
	public String getDateFormForJsp() {
		dateForm(getRegDate());
		return dateForm(getRegDate());
	}
}
