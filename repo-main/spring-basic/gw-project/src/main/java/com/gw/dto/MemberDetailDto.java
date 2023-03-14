package com.gw.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data

public class MemberDetailDto{


	//memberDetail// 외원가입 시 관리가 입력해 줄 수 있도록 구현함
	private int mem_detail_id_no; //== mem_id_no //사원번호
	private String mem_detail_name;//이름
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date mem_detail_birthday;//생년월일
	private String mem_detail_email; //이메일
	private String mem_detail_phone;//핸드폰
	private String mem_detail_innernumber;//내선번호
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date mem_detail_fromdate;//입사일자
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date mem_detail_todate;//퇴사일자

}
