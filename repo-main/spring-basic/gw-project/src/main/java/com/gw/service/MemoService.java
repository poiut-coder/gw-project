package com.gw.service;

import java.util.List;

import com.gw.dto.MemoDto;
import com.gw.dto.MemberDetailDto;

public interface MemoService {

	void writeMemo(MemoDto memo);
	
	List<MemoDto> findAllMemo();
	
	void deleteMemo(int m_id_no);

	void modifyMemo(MemoDto memo);

	
	// 메모 목록
	
	List<MemoDto> findMemoByPage(int loginuserid, int pageNo, int pageSize);

	List<MemoDto> findMemoReceivedByPage(int loginuserid, int pageNo, int pageSize);
	
	List<MemoDto> findMemoSendByPage(int loginuserid, int pageNo, int pageSize);
	
	List<MemoDto> findMemoMyByPage(int loginuserid, int pageNo, int pageSize);
	
	List<MemoDto> findMemoDeleteByPage(int loginuserid, int pageNo, int pageSize);
	
	int findMemoCount(int loginuserid);
	
	int findMemoReceivedCount(int loginuserid);
	
	int findMemoSendCount(int loginuserid);
	
	int findMemoMyCount(int loginuserid);
	
	int findMemoDeleteCount(int loginuserid);
	
	// 메일 상세보기
	
	MemoDto findMemoBymem_id_no(int m_id_no);
	
	MemoDto findMemoReceivedBymem_id_no(int m_id_no);
	
	MemoDto findMemoSendBymem_id_no(int m_id_no);

	MemoDto findMemoMyBymem_id_no(int m_id_no);
	
	MemoDto findMemoDeletedBymem_id_no(int m_id_no);

	List<MemberDetailDto> findAllEXMemo();

	List<MemoDto> findMemoBySearch(String search, int loginuserid); // 검색기능 구현 

	void deleteInstanceMemo(int m_id_no);








	







}
