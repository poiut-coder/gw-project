package com.gw.dto;

import lombok.Data;

@Data
public class BoardAttachDto {

	private int writeIdNo;	// 글번호
	private int attachIdNo;	// 게시판첨부번호
	private String attachUserFileName;	// 사용자파일이름
	private String attachSavedFileName;	// 저장된파일이름
	
}
