package com.gw.service;

import java.util.List;

import org.apache.ibatis.annotations.Delete;

import com.gw.dto.BoardAttachDto;
import com.gw.dto.BoardCommentDto;
import com.gw.dto.BoardDto;
import com.gw.dto.BoardNoticeDto;
import com.gw.dto.BoardUnknownDto;
import com.gw.mapper.BoardMapper;
import com.gw.mapper.BoardCommentMapper;

import lombok.Setter;

public class BoardServiceImpl implements BoardService {

	@Setter
	private BoardMapper boardMapper;
	
	@Setter
	private BoardCommentMapper commentMapper;

	// 작성한 공지사항 게시글 조회
	public List<BoardNoticeDto> findBoardNoticeByPage(int pageNo, int pageSize) {
		int from = (pageNo - 1) * pageSize;
		int count = pageSize;

		List<BoardNoticeDto> board = boardMapper.selectBoardNoticeByPage(from, count);
		return board;
	}

	@Override
	public List<BoardUnknownDto> findBoardUnknownByPage(int pageNo, int pageSize) {
		int from = (pageNo - 1) * pageSize;
		int count = pageSize;

		List<BoardUnknownDto> board = boardMapper.selectBoardUnknownByPage(from, count);
		return board;
	}

	public int findBoardCount(BoardDto board) {
		int boardCount = boardMapper.selectBoardCount(board);
		return boardCount;
	}

	// 작성한 게시글 DB에 저장
	public void writeBoard(BoardDto board) {
		// board.getWriteIdNo() --> 0
		boardMapper.insertBoard(board);	// insert하면서 writeIdNo 자동생성 (글번호 가져오기)
		// board.getWriteIdNo() --> 새로 만들어진 글번호
		if(board.getAttachments() != null) {
			for (BoardAttachDto attachment : board.getAttachments()) {
				attachment.setWriteIdNo(board.getWriteIdNo());	// 새로 만들어진 글번호를 Attach 객체에 저장
				boardMapper.insertBoardAttach(attachment);
			}
		}
	}

	// 공지사항 작성자 사원번호 DB에 저장
	@Override
	public void saveNoticeMemNo(BoardNoticeDto boardNotice) {
		boardMapper.saveNoticeMemNo(boardNotice);
	}
	
	// 익명게시판 2차 비밀번호 DB에 저장
	@Override
	public void inputRewritePasswd(BoardUnknownDto boardUnknown) {
		boardMapper.insertRewritePasswd(boardUnknown);
	}

	// 공지사항 글상세보기
	public BoardNoticeDto findNoticeBoardByWriteIdNo(int writeIdNo) {
		BoardNoticeDto boardNotice = boardMapper.selectNoticeBoardByWriteIdNo(writeIdNo);
		return boardNotice;
	}

	// 익명게시판 글상세보기
	public BoardUnknownDto findUnknownBoardByWriteIdNo(int writeIdNo) {
		BoardUnknownDto boardUnknown = boardMapper.selectUnknownBoardByWriteIdNo(writeIdNo);
		return boardUnknown;
	}

	// 해당 게시글 이전 페이지(<) 조회
	@Override
	public BoardDto movePreviousBoard(int writeIdNo, int typeIdNo) {
		BoardDto prevBoard = boardMapper.selectPreviousBoard(writeIdNo, typeIdNo);
		return prevBoard;
	}

	// 해당 게시글 다음 페이지(>) 조회
	@Override
	public BoardDto moveNextBoard(int writeIdNo, int typeIdNo) {
		BoardDto nextBoard = boardMapper.selectNextBoard(writeIdNo, typeIdNo);
		return nextBoard;
	}

	// 글번호를 받아서 게시글 조회수 증가
	@Override
	public void increaseBoardReadCount(int writeIdNo) {
		boardMapper.updateBoardReadCount(writeIdNo);
	}

	// 게시글 수정
	public void modifyBoard(BoardDto board) {
		boardMapper.updateBoard(board);
		if(board.getAttachments() != null) {
			for (BoardAttachDto attachment : board.getAttachments()) {
				attachment.setWriteIdNo(board.getWriteIdNo());	// 새로 만들어진 글번호를 Attach 객체에 저장
				boardMapper.insertBoardAttach(attachment);
			}
		}
	}

	// 게시글 삭제
	@Override
	public void deleteBoard(int writeIdNo) {
		boardMapper.deleteBoard(writeIdNo);
	}

	@Override
	public void deleteBoardNotice(int writeIdNo) {
		boardMapper.deleteBoardNotice(writeIdNo);
		
	}

	@Override
	public void deleteBoardUnknown(int writeIdNo) {
		boardMapper.deleteBoardUnknown(writeIdNo);
	}

	// 게시판 안에 있는 댓글 모두 삭제
	public void deleteCommentInBoard(int writeIdNo) {
		boardMapper.deleteCommentInBoard(writeIdNo);
	}
	
	// 첨부파일 저장
	@Override
	public BoardAttachDto findBoardAttachByAttachIdNo(int attachIdNo) {
		BoardAttachDto attachment = boardMapper.selectBoardAttachByAttachIdNo(attachIdNo);
		return attachment;
	}
	
	// 첨부파일 삭제
	@Override
	public void deleteBoardAttachByAttachIdNo(int attachIdNo) {
		boardMapper.deleteBoardAttachByAttachIdNo(attachIdNo);
	}

	// 공지사항 검색
	@Override
	public List<BoardNoticeDto> searchBoardNotice(BoardNoticeDto boardNotice) {
		List<BoardNoticeDto> boards = boardMapper.selectBoardNoticeSearch(boardNotice);
		return boards;
	}
	
	// 익명게시판 검색
	@Override
	public List<BoardUnknownDto> searchBoardUnknown(BoardUnknownDto boardUnknown) {
		List<BoardUnknownDto> boards = boardMapper.selectBoardUnknownSearch(boardUnknown);
		return boards;
	}
	
	// 댓글 /////////////////////////////////////////////////////////
	
	// 댓글 리스트 조회
	@Override
	public List<BoardCommentDto> findBoardCommentByWriteIdNo(int writeIdNo) {
		
		List<BoardCommentDto> comments = commentMapper.selectBoardCommentByWriteIdNo(writeIdNo);
		return comments;
	}

	// 댓글 쓰기
	@Override
	public void writeComment(BoardCommentDto comment) {
		commentMapper.insertComment(comment);
	}
	
	@Override
	public void updateGroupNo(int comIdNo, int groupNo) {
		commentMapper.updateGroupNo(comIdNo,groupNo);
	}
	
	// 댓글 삭제
	@Override
	public void deleteComment(int comIdNo) {
		commentMapper.deleteComment(comIdNo);
	}

	// 댓글 수정
	@Override
	public void updateComment(BoardCommentDto comment) {
		commentMapper.updateComment(comment);
	}
	
	// 익명 댓글 삭제
	public void deleteUnknownComment(int comIdNo, String comPasswd) {
		commentMapper.deleteUnknownComment(comIdNo, comPasswd);
	}

	// 익명 댓글 수정
	public void updateUnknownComment(BoardCommentDto comment) {
		commentMapper.updateUnknownComment(comment);
	}

	// 대댓글
	@Override
	public void writeRecomment(BoardCommentDto comment) {
		// 1. 부모 글 조회 --> 그룹번호(groupno), 그룹 내 순서번호(step)
		BoardCommentDto parent = commentMapper.selectCommentByComIdNo(comment.getComIdNo());
		comment.setWriteIdNo(parent.getWriteIdNo());
		comment.setGroupNo(parent.getGroupNo());
		comment.setStep(parent.getStep() + 1);
		comment.setDepth(parent.getDepth() + 1);
		// 2. 이미 등록된 글 중에서 삽입될 위치 뒤에 있는 글의 step 조정(1 증가)
		commentMapper.updateStepNo(parent.getGroupNo(), parent.getStep());
		// 3. 글쓰기
		commentMapper.insertRecomment(comment);
	}

}
