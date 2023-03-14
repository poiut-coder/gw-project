package com.gw.service;

import java.util.List;
import com.gw.dto.BoardAttachDto;
import com.gw.dto.BoardCommentDto;
import com.gw.dto.BoardDto;
import com.gw.dto.BoardNoticeDto;
import com.gw.dto.BoardUnknownDto;
import com.gw.mapper.BoardMapper;

import lombok.Setter;

public interface BoardService {

	public List<BoardNoticeDto> findBoardNoticeByPage(int pageNo, int pageSize);

	public List<BoardUnknownDto> findBoardUnknownByPage(int pageNo, int pageSize);

	public void writeBoard(BoardDto board);

	public void saveNoticeMemNo(BoardNoticeDto boardNotice);

	public void inputRewritePasswd(BoardUnknownDto boardUnknown);

	public int findBoardCount(BoardDto board);

	public BoardNoticeDto findNoticeBoardByWriteIdNo(int writeIdNo);

	public BoardUnknownDto findUnknownBoardByWriteIdNo(int writeIdNo);

	public BoardDto movePreviousBoard(int writeIdNo, int typeIdNo);

	public BoardDto moveNextBoard(int writeIdNo, int typeIdNo);

	public void increaseBoardReadCount(int writeIdNo);

	public void modifyBoard(BoardDto board);

	public void deleteBoard(int writeIdNo);

	public void deleteBoardNotice(int writeIdNo);

	public void deleteBoardUnknown(int writeIdNo);
	
	public void deleteCommentInBoard(int writeIdNo);

	public BoardAttachDto findBoardAttachByAttachIdNo(int attachIdNo);

	public List<BoardCommentDto> findBoardCommentByWriteIdNo(int writeIdNo);

	public void writeComment(BoardCommentDto comment);

	public void updateGroupNo(int comIdNo, int groupNo);

	public void deleteComment(int comIdNo);

	public void updateComment(BoardCommentDto comment);
	
	public void deleteUnknownComment(int comIdNo, String comPasswd);

	public void updateUnknownComment(BoardCommentDto comment);

	public void writeRecomment(BoardCommentDto comment);

	public void deleteBoardAttachByAttachIdNo(int attachIdNo);

	public List<BoardNoticeDto> searchBoardNotice(BoardNoticeDto boardNotice);

	public List<BoardUnknownDto> searchBoardUnknown(BoardUnknownDto boardUnknown);

}
