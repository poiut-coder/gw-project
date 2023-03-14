package com.gw.service;

import java.util.List;

import com.gw.dto.MailAttachDto;
import com.gw.dto.MailDto;
import com.gw.dto.MemberDetailDto;
import com.gw.mapper.MailMapper;

import lombok.Setter;

public class MailServiceImpl implements MailService {

	@Setter
	private MailMapper mailMapper;

	// 사용자가 입력한 게시글 데이터를 받아서 글쓰기 처리
	@Override
	public void writeMail(MailDto mail) {

		mailMapper.insertMail(mail); // insert 하면서 MailNo 자동 생성 ( 글 번호 가져오기 필요 )

		if (mail.getAttachments() != null) {
			for (MailAttachDto attachment : mail.getAttachments()) {
				attachment.setMailNo(mail.getMailNo()); // 새로 만들어진 글번호를 Attach 객체에 저장
				mailMapper.insertMailAttach(attachment);
			}
		}

	}

	// 글 번호를 받아서 게시글 임시저장 
	@Override
	public void draftMail(MailDto mail) {

		mailMapper.draftMail(mail);

		if (mail.getAttachments() != null) {
			for (MailAttachDto attachment : mail.getAttachments()) {
				attachment.setMailNo(mail.getMailNo()); // 새로 만들어진 글번호를 Attach 객체에 저장
				mailMapper.insertMailAttach(attachment);
			}
		}
		
	}
	
	// 모든 게시글 조회해서 반환
	@Override
	public List<MailDto> findAllMail() {

		// MailDao MailDao = new MailDao();
		List<MailDto> mails = mailMapper.selectAllMail();
		return mails;

	}

	// 모든 게시글 조회해서 반환 EX
	@Override
	public List<MemberDetailDto> findAllEXMail() {

		// MailDao MailDao = new MailDao();
		List<MemberDetailDto> mails = mailMapper.selectAllEXMail();
		return mails;

	}

	// 전체글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MailDto> findMailByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;

		List<MailDto> Mails = mailMapper.selectMailByPage(mem_id_no, from, count);
		return Mails;

	}

	// 받은글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MailDto> findMailReceivedByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;

		List<MailDto> Mails = mailMapper.selectMailReceivedByPage(mem_id_no, from, count);
		return Mails;

	}

	// 보낸글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MailDto> findMailSendByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;

		List<MailDto> Mails = mailMapper.selectMailSendByPage(mem_id_no, from, count);
		return Mails;

	}

	// 임시글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MailDto> findMailDraftByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;

		List<MailDto> Mails = mailMapper.selectMailDraftByPage(mem_id_no, from, count);
		return Mails;

	}
	
	// 내게쓴글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MailDto> findMailMyByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;

		List<MailDto> Mails = mailMapper.selectMailMyByPage(mem_id_no, from, count);
		return Mails;

	}

	// 삭제글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MailDto> findMailDeleteByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;
		List<MailDto> Mails = mailMapper.selectMailDeleteByPage(mem_id_no, from, count);
		return Mails;

	}

	// 글 번호를 받아서 전체메일함 조회 및 반환
	@Override
	public MailDto findMailByMailNo(int mailNo) {

		MailDto mail = mailMapper.selectMailByMailNo2(mailNo);

		// Comment 조회

		return mail;

	}

	// 글 번호를 받아서 받은메일함 조회 및 반환
	@Override
	public MailDto findMailReceivedByMailNo(int mailNo) {

		// Mail와 MailAttach를 한 번에 조회
		MailDto mail = mailMapper.selectMailReceivedByMailNo2(mailNo);

		return mail;

	}

	// 글 번호를 받아서 보낸메일함 조회 및 반환
	@Override
	public MailDto findMailSendByMailNo(int mailNo) {

		// Mail와 MailAttach를 한 번에 조회
		MailDto mail = mailMapper.selectMailSendByMailNo2(mailNo);

		return mail;

	}

	// 글 번호를 받아서 임시메일함 조회 및 반환
	@Override
	public MailDto findMailDraftByMailNo(int mailNo) {

		// Mail와 MailAttach를 한 번에 조회
		MailDto mail = mailMapper.selectMailDraftByMailNo2(mailNo);

		return mail;

	}
	
	// 글 번호를 받아서 내게쓴메일함 조회 및 반환
	@Override
	public MailDto findMailMyByMailNo(int mailNo) {

		// Mail와 MailAttach를 한 번에 조회
		MailDto mail = mailMapper.selectMailMyByMailNo2(mailNo);

		return mail;

	}

	// 글 번호를 받아서 휴지통(삭제목록) 조회 및 반환
	@Override
	public MailDto findMailDeletedByMailNo(int mailNo) {

		// Mail와 MailAttach를 한 번에 조회
		MailDto maildelete = mailMapper.selectMailDeletedByMailNo(mailNo);

		return maildelete;

	}

	// 글 번호를 받아서 게시글 조회수 증가
	@Override
	public void increaseMailReadCount(int mailNo) {

		mailMapper.updateMailReadCount(mailNo);

	}

	// 글 번호를 받아서 게시글 삭제
	@Override
	public void deleteMail(int mailNo) {

		mailMapper.deleteMail(mailNo);

	}
	
	// 글 번호를 받아서 게시글 인스턴스 삭제
	@Override
	public void deleteInstanceMail(int mailNo) {

		mailMapper.deleteInstanceMail(mailNo);

	}


	
	// 첨부파일 번호를 받아서 첨부파일 데이터 조회 및 반환
	@Override
	public MailAttachDto findMailAttachByAttachNo(int attachNo) {

		MailAttachDto attachment = mailMapper.selectMailAttachByAttachNo(attachNo);
		return attachment;

	}

	// 전체글 카운트
	@Override
	public int findMailCount(int loginuserid) {

		int mem_id_no = loginuserid;
		int mailCount = mailMapper.selectMailCount(mem_id_no);
		return mailCount;

	}

	// 받은글 카운트
	@Override
	public int findMailReceivedCount(int loginuserid) {

		int mem_id_no = loginuserid;
		int mailCount = mailMapper.selectMailReceivedCount(mem_id_no);
		return mailCount;
	}

	// 보낸글 카운트
	@Override
	public int findMailSendCount(int loginuserid) {

		int mem_id_no = loginuserid;
		int mailCount = mailMapper.selectMailSendCount(mem_id_no);
		return mailCount;
	}

	// 임시글 카운트
	@Override
	public int findMailDraftCount(int loginuserid) {

		int mem_id_no = loginuserid;
		int mailCount = mailMapper.selectMailDraftCount(mem_id_no);
		return mailCount;

	}
	
	// 내게쓴글 카운트
	@Override
	public int findMailMyCount(int loginuserid) {

		int mem_id_no = loginuserid;
		int mailCount = mailMapper.selectMailMyCount(mem_id_no);
		return mailCount;

	}

	// 삭제글 카운트
	@Override
	public int findMailDeleteCount(int loginuserid) {
		int mem_id_no = loginuserid;
		int mailCount = mailMapper.selectMailDeleteCount(mem_id_no);
		return mailCount;

	}

	//
	@Override
	public void modifyMail(MailDto mail) {

		mailMapper.updateMail(mail);

	}

	///// 검색기능 구현 
	@Override
	public List<MailDto> findMailBySearch(String search, int loginuserid) {
		
		
		int mem_id_no = loginuserid;
		String searchWithWildCard = "%"+search+"%";
		List<MailDto> searchedList = mailMapper.selectBySearch(searchWithWildCard, mem_id_no);
		
		for (MailDto mail : searchedList) {
			String title = mail.getTitle();
			title = title.replaceAll(search, String.format("<span style='color:red;font-weight:bold'>%s</span>", search));
			mail.setTitle(title);
			
			String writer = mail.getWriter();
			writer = writer.replaceAll(search, String.format("<span style='color:red;font-weight:bold'>%s</span>", search));
			mail.setWriter(writer);
			
		}
		return searchedList;
	}

}
