package com.gw.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemoDto {

	private int m_id_no;		// 쪽지번호 = 자동증가 
	private String m_sender;	// 발신자 
	private String m_receiver;	// 수신자 
	private String m_content;	// 내용 
	private Date m_regdate;		// 작성일자 
	private boolean m_deleted;	// 삭제 
	
	// 첨부파일 쓸 일 없음.
	
}
