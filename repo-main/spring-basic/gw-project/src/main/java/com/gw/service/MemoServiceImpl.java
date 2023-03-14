package com.gw.service;

import java.util.List;

import com.gw.dto.MemoDto;
import com.gw.dto.MemberDetailDto;
import com.gw.mapper.MemoMapper;

import lombok.Setter;

public class MemoServiceImpl implements MemoService {

	@Setter
	private MemoMapper memoMapper;

	// 사용자가 입력한 게시글 데이터를 받아서 글쓰기 처리
	@Override
	public void writeMemo(MemoDto memo) {

		memoMapper.insertMemo(memo); // insert 하면서 mem_id_no 자동 생성 ( 글 번호 가져오기 필요 )


	}

	// 모든 게시글 조회해서 반환
	@Override
	public List<MemoDto> findAllMemo() {

		List<MemoDto> memos = memoMapper.selectAllMemo();
		return memos;

	}

	// 모든 게시글 조회해서 반환 EX
	@Override
	public List<MemberDetailDto> findAllEXMemo() {

		List<MemberDetailDto> memos = memoMapper.selectAllEXMemo();
		return memos;

	}

	// 전체글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MemoDto> findMemoByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;

		List<MemoDto> Memos = memoMapper.selectMemoByPage(mem_id_no, from, count);
		return Memos;

	}

	// 받은글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MemoDto> findMemoReceivedByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;

		List<MemoDto> Memos = memoMapper.selectMemoReceivedByPage(mem_id_no, from, count);
		return Memos;

	}

	// 보낸글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MemoDto> findMemoSendByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;

		List<MemoDto> Memos = memoMapper.selectMemoSendByPage(mem_id_no, from, count);
		return Memos;

	}

	// 내게쓴글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MemoDto> findMemoMyByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;

		List<MemoDto> Memos = memoMapper.selectMemoMyByPage(mem_id_no, from, count);
		return Memos;

	}

	// 삭제글번호를 받아서 읽음 처리 ( update )
	@Override
	public List<MemoDto> findMemoDeleteByPage(int loginuserid, int pageNo, int pageSize) {

		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		int mem_id_no = loginuserid;
		List<MemoDto> Memos = memoMapper.selectMemoDeleteByPage(mem_id_no, from, count);
		return Memos;

	}

	// 글 번호를 받아서 전체메일함 상세보기 조회 및 반환
	@Override
	public MemoDto findMemoBymem_id_no(int m_id_no) {

		MemoDto memo = memoMapper.selectMemoBymem_id_no(m_id_no);

		return memo;

	}

	// 글 번호를 받아서 받은메일함 상세보기 조회 및 반환
	@Override
	public MemoDto findMemoReceivedBymem_id_no(int m_id_no) {

		MemoDto memo = memoMapper.selectMemoBymem_id_no(m_id_no);

		return memo;

	}

	// 글 번호를 받아서 보낸메일함 상세보기 조회 및 반환
	@Override
	public MemoDto findMemoSendBymem_id_no(int m_id_no) {

		MemoDto memo = memoMapper.selectMemoBymem_id_no(m_id_no);

		return memo;

	}

	// 글 번호를 받아서 내게쓴메일함 상세보기 조회 및 반환
	@Override
	public MemoDto findMemoMyBymem_id_no(int m_id_no) {

		MemoDto memo = memoMapper.selectMemoBymem_id_no(m_id_no);
		return memo;

	}

	// 글 번호를 받아서 휴지통(삭제목록) 상세보기 조회 및 반환
	@Override
	public MemoDto findMemoDeletedBymem_id_no(int m_id_no) {

		MemoDto memo = memoMapper.selectMemoBymem_id_no(m_id_no);
		return memo;

	}

	// 글 번호를 받아서 게시글 삭제
	@Override
	public void deleteMemo(int m_id_no) {

		memoMapper.deleteMemo(m_id_no);

	}
	
	// 글 번호를 받아서 게시글 인스턴스 삭제
	@Override
	public void deleteInstanceMemo(int m_id_no) {

		memoMapper.deleteInstanceMemo(m_id_no);

	}

	// 전체글 카운트
	@Override
	public int findMemoCount(int loginuserid) {

		int mem_id_no = loginuserid;
		int memoCount = memoMapper.selectMemoCount(mem_id_no);
		return memoCount;

	}

	// 받은글 카운트
	@Override
	public int findMemoReceivedCount(int loginuserid) {

		int mem_id_no = loginuserid;
		int memoCount = memoMapper.selectMemoReceivedCount(mem_id_no);
		return memoCount;
	}

	// 보낸글 카운트
	@Override
	public int findMemoSendCount(int loginuserid) {

		int mem_id_no = loginuserid;
		int memoCount = memoMapper.selectMemoSendCount(mem_id_no);
		return memoCount;
	}

	// 내게쓴글 카운트
	@Override
	public int findMemoMyCount(int loginuserid) {

		int mem_id_no = loginuserid;
		int memoCount = memoMapper.selectMemoMyCount(mem_id_no);
		return memoCount;

	}

	// 삭제글 카운트
	@Override
	public int findMemoDeleteCount(int loginuserid) {
		int mem_id_no = loginuserid;
		int memoCount = memoMapper.selectMemoDeleteCount(mem_id_no);
		return memoCount;

	}

	//
	@Override
	public void modifyMemo(MemoDto memo) {

		memoMapper.updateMemo(memo);

	}

	///// 검색기능 구현 
	@Override
	public List<MemoDto> findMemoBySearch(String search, int loginuserid) {
		
		
		int mem_id_no = loginuserid;
		String searchWithWildCard = "%"+search+"%";
		List<MemoDto> searchedList = memoMapper.selectBySearch(searchWithWildCard, mem_id_no);
		
		for (MemoDto memo : searchedList) {
			String content = memo.getM_content();
			content = content.replaceAll(search, String.format("<span style='color:red;font-weight:bold'>%s</span>", search));
			memo.setM_content(content);
			
			String m_sender = memo.getM_sender();
			m_sender = m_sender.replaceAll(search, String.format("<span style='color:red;font-weight:bold'>%s</span>", search));
			memo.setM_sender(m_sender);
			
		}
		return searchedList;
	}

}
