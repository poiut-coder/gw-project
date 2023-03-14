package com.gw.service;

import java.util.List;

import com.gw.dto.MailAttachDto;
import com.gw.dto.MailDto;
import com.gw.dto.MemberDetailDto;

public interface MailService {

	void writeMail(MailDto mail);
	
	void draftMail(MailDto mail);
	
	List<MailDto> findAllMail();
	
	void increaseMailReadCount(int mailNo);

	void deleteMail(int mailNo);

	MailAttachDto findMailAttachByAttachNo(int attachNo);

	void modifyMail(MailDto mail);

	
	// 메일 목록
	
	List<MailDto> findMailByPage(int loginuserid, int pageNo, int pageSize);

	List<MailDto> findMailReceivedByPage(int loginuserid, int pageNo, int pageSize);
	
	List<MailDto> findMailSendByPage(int loginuserid, int pageNo, int pageSize);
	
	List<MailDto> findMailDraftByPage(int loginuserid, int pageNo, int pageSize);
	
	List<MailDto> findMailMyByPage(int loginuserid, int pageNo, int pageSize);
	
	List<MailDto> findMailDeleteByPage(int loginuserid, int pageNo, int pageSize);
	
	int findMailCount(int loginuserid);
	
	int findMailReceivedCount(int loginuserid);
	
	int findMailSendCount(int loginuserid);
	
	int findMailDraftCount(int loginuserid);
	
	int findMailMyCount(int loginuserid);
	
	int findMailDeleteCount(int loginuserid);
	
	// 메일 상세보기
	
	MailDto findMailByMailNo(int mailNo);
	
	MailDto findMailReceivedByMailNo(int mailNo);
	
	MailDto findMailSendByMailNo(int mailNo);

	MailDto findMailDraftByMailNo(int mailNo);
	
	MailDto findMailMyByMailNo(int mailNo);
	
	MailDto findMailDeletedByMailNo(int mailNo);

	List<MemberDetailDto> findAllEXMail();

	List<MailDto> findMailBySearch(String search, int loginuserid); // 검색기능 구현 

	void deleteInstanceMail(int mailNo);








	
















}
