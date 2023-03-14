package com.gw.dto;

import lombok.Data;

@Data
public class BoardNoticeDto extends BoardDto {

	// 공지사항
	private int noticeMemNo;		// 작성자 == memIdNo 사원번호
	private String noticeWriter;	

}
