package com.gw.dto;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardCommentDto {

	private int comIdNo; // 댓글번호
	private int writeIdNo; // 글번호
	private String comContent; // 댓글내용
	private int comWriter; // 작성자-사원번호 = mem_id_no
	private String comWriter2;
	private Date comRegDate; // 댓글작성일자
	private boolean comDeleted; // 댓글삭제여부
	private int groupNo; // 댓글 그룹번호
	private int step; // 대댓글순서
	private int depth; // 대댓글위치

	private String comPasswd; // 익명게시판-댓글비밀번호

	private List<BoardAttachDto> attachments;

	private List<BoardCommentDto> comments;
	
	public String dateForm(Date ComRegDate) {
		  SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		  return format.format(ComRegDate);
	}
	
	public String getComDateFormForJsp() {
		dateForm(getComRegDate());
		return dateForm(getComRegDate());
	}
}
