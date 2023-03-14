package com.gw.dto;

import lombok.Data;

@Data
public class BoardUnknownDto extends BoardDto {
	
	// 익명게시판
	private String unRewritePasswd;	// 글수정비밀번호

}
