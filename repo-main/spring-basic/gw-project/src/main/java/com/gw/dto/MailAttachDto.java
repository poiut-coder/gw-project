package com.gw.dto;


import lombok.Data;

@Data
public class MailAttachDto {
	
		private int attachNo;
		private int mailNo;
		private String userFileName;
		private String savedFileName;
		private int downloadCount;
			
}
