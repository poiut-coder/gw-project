package com.gw.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.gw.common.Util;
import com.gw.dto.BoardAttachDto;
import com.gw.dto.BoardCommentDto;

import com.gw.dto.BoardDto;
import com.gw.dto.BoardNoticeDto;
import com.gw.dto.BoardUnknownDto;
import com.gw.dto.MemberDto;
import com.gw.mapper.BoardMapper;
import com.gw.service.BoardService;
import com.gw.service.BoardServiceImpl;
import com.gw.ui.BoardPager;
import com.gw.view.BoardDownloadView;

@Controller
@RequestMapping(path = { "/board" })
public class BoardController {

	private final int PAGE_SIZE =  5;
	private final int PAGER_SIZE = 3;
	private final String N_LINK_URL = "notice";
	private final String U_LINK_URL = "unknown";

	@Autowired
	@Qualifier("boardService")
	private BoardService boardService;
	
	// 공지사항 게시판 조회 + 페이지
	@GetMapping(path = {"/notice"}) 
	public String showBoardNotice(@RequestParam(defaultValue="1")int pageNo,
								  Model model, BoardDto board) {
		
		board.setTypeIdNo(1);
		List<BoardNoticeDto> boards = boardService.findBoardNoticeByPage(pageNo, PAGE_SIZE);
		int boardCount = boardService.findBoardCount(board);
		
		BoardPager pager = new BoardPager(boardCount, pageNo, PAGE_SIZE, PAGER_SIZE, N_LINK_URL);
		
		model.addAttribute("boards", boards);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageCount", pager.getPageCount());
		
		return "board/notice"; 
	}
	
	// 익명 게시판 조회
	@GetMapping(path = {"/unknown"}) 
	public String showBoardUnknown(@RequestParam(defaultValue="1")int pageNo,
								   Model model, BoardDto board) {
		
		board.setTypeIdNo(2);
		List<BoardUnknownDto> boards = boardService.findBoardUnknownByPage(pageNo, PAGE_SIZE);
		int boardCount = boardService.findBoardCount(board);

		BoardPager pager = new BoardPager(boardCount, pageNo, PAGE_SIZE, PAGER_SIZE, U_LINK_URL);
		
		model.addAttribute("boards", boards);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageCount", pager.getPageCount());
		
		return "board/unknown";
	}

	// 글상세보기
	@GetMapping(path= {"/detail"})
	public String showBoardDetail(@RequestParam(defaultValue = "-1")int writeIdNo,
								  @RequestParam(defaultValue = "1")int pageNo,
								  @RequestParam(defaultValue= "1")int typeIdNo,
								  BoardDto board,
								  HttpSession session,
								  Model model) {
				
		ArrayList<Integer> boardList = (ArrayList<Integer>)session.getAttribute("board-list");
		if(boardList == null) {	// 세션에 목록이 없으면
			boardList = new ArrayList<>();	// 목록 새로 만들기
			session.setAttribute("board-list", boardList);	// 세션에 목록 등록
		}
		
		// 조회수 증가
		if(!boardList.contains(writeIdNo)) {	// 현재 글번호가 읽은 글목록에 포함되지 않은 경우
			boardService.increaseBoardReadCount(writeIdNo);	// 글 조회수 증가
			boardList.add(writeIdNo);	// 읽은 글목록에 현재 글번호 추가
		}
		
		// 해당 게시글 이전 페이지(<) 조회
		BoardDto prevBoard = boardService.movePreviousBoard(writeIdNo, typeIdNo);
		model.addAttribute("prevBoard", prevBoard);
		
		// 해당 게시글 다음 페이지(>) 조회
		BoardDto nextBoard = boardService.moveNextBoard(writeIdNo, typeIdNo);
		model.addAttribute("nextBoard", nextBoard);
		
		// 각자 게시판에서 DB에 저장된 글 조회
		if (typeIdNo == 1) {
			BoardNoticeDto boardNotice = boardService.findNoticeBoardByWriteIdNo(writeIdNo);
			if (boardNotice == null) {	// 조회되지 않는 경우
				return "redirect:notice";
			}
			model.addAttribute("boardNotice", boardNotice);
		} else if (typeIdNo == 2) {
			BoardUnknownDto boardUnknown = boardService.findUnknownBoardByWriteIdNo(writeIdNo);
			if (boardUnknown == null) {	// 조회되지 않는 경우
				return "redirect:unknown";
			}
			model.addAttribute("boardUnknown", boardUnknown);
		}
		model.addAttribute("board", board);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("typeIdNo", typeIdNo);
		model.addAttribute("writeIdNo", writeIdNo);
		
		return "board/detail";
		}

	// 글쓰기 페이지 연결
	@GetMapping(path= {"/write"})
	public String showBoardWriteForm(@RequestParam(defaultValue= "1")int typeIdNo,
									 BoardAttachDto attachment,
									 Model model) {
		
		model.addAttribute("typeIdNo", typeIdNo);
	
		return "board/write";
	}

	// 작성한 게시글 내용 저장 후 typeIdNo에 따라 게시판 연결
	@PostMapping(path = { "/write" })
	public String writeBoard(BoardUnknownDto boardUnknown, BoardNoticeDto boardNotice, BoardDto board, MemberDto member, MultipartHttpServletRequest req) {

		MultipartFile attach = req.getFile("attach");
		
		if(attach != null) {	// 내용이 있는 경우
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/board-attachments");
			String fileName = attach.getOriginalFilename();	// 파일 이름 가져오기
			
			if(fileName != null && fileName.length() > 0) {
				String uniqueFileName = Util.makeUniqueFileName(fileName);
				
				try {
					attach.transferTo(new File(path, uniqueFileName));	// 파일 저장
					// 등록한 파일명이 아닌 고유한 파일명으로 저장되어 같은 파일명을 가진 사진도 계속 업로드 가능
					
					ArrayList<BoardAttachDto> attachments = new ArrayList<>();	// 첨부파일 정보를 저장한 DTO 객체
					// 첨부파일 정보를 객체에 저장
					BoardAttachDto attachment = new BoardAttachDto();
					attachment.setAttachUserFileName(fileName);
					attachment.setAttachSavedFileName(uniqueFileName);
					attachments.add(attachment);
					board.setAttachments(attachments);
				} catch (Exception e) {
					e.printStackTrace();
				}	
			}
		}
		
		int typeIdNo = board.getTypeIdNo();
		boardService.writeBoard(board);

		if (typeIdNo == 1) { // 공지사항
			boardNotice.setWriteIdNo(board.getWriteIdNo());
			boardService.saveNoticeMemNo(boardNotice);
			return "redirect:notice";
		} else if (typeIdNo == 2) { // 익명게시판
			boardUnknown.setWriteIdNo(board.getWriteIdNo());
			boardService.inputRewritePasswd(boardUnknown);
			return "redirect:unknown";
		} else {
			return "board/write";
		}
	}
	
	@GetMapping(path= {"/edit"})
	public String showBoardEditForm(@RequestParam(defaultValue = "-1")int writeIdNo,
			  						@RequestParam(defaultValue = "1")int pageNo,
			  						@RequestParam(defaultValue= "1")int typeIdNo,
			  						Model model) {
		
		if (typeIdNo == 1) {
			BoardNoticeDto boardNotice = boardService.findNoticeBoardByWriteIdNo(writeIdNo);
			if (boardNotice == null) {	// 조회되지 않는 경우
				return "redirect:notice";
			}
			model.addAttribute("boardNotice", boardNotice);
		} else if (typeIdNo == 2) {
			BoardUnknownDto boardUnknown = boardService.findUnknownBoardByWriteIdNo(writeIdNo);
			if (boardUnknown == null) {	// 조회되지 않는 경우
				return "redirect:unknown";
			}
			model.addAttribute("boardUnknown", boardUnknown);
		}
		
		
		model.addAttribute("writeIdNo", writeIdNo);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("typeIdNo", typeIdNo);

		return "board/edit";
	}
	
	@PostMapping(path= {"/edit"})
	public String modifyBoard(@RequestParam(defaultValue = "1")int pageNo,
							  BoardDto board, Model model, MultipartHttpServletRequest req) {
		
		MultipartFile attach = req.getFile("attach");
		
		if(attach != null) {	// 내용이 있는 경우
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/board-attachments");
			String fileName = attach.getOriginalFilename();	// 파일 이름 가져오기
			
			if(fileName != null && fileName.length() > 0) {
				String uniqueFileName = Util.makeUniqueFileName(fileName);
				
				try {
					attach.transferTo(new File(path, uniqueFileName));	// 파일 저장
					// 등록한 파일명이 아닌 고유한 파일명으로 저장되어 같은 파일명을 가진 사진도 계속 업로드 가능
					
					ArrayList<BoardAttachDto> attachments = new ArrayList<>();	// 첨부파일 정보를 저장한 DTO 객체
					// 첨부파일 정보를 객체에 저장
					BoardAttachDto attachment = new BoardAttachDto();
					attachment.setAttachUserFileName(fileName);
					attachment.setAttachSavedFileName(uniqueFileName);
					attachments.add(attachment);
					board.setAttachments(attachments);
				} catch (Exception e) {
					e.printStackTrace();
				}	
			}
		}
		
		boardService.modifyBoard(board);
		
		return "redirect:detail?writeIdNo=" + board.getWriteIdNo() + "&typeIdNo=" + board.getTypeIdNo() + "&pageNo=" + pageNo;
	}
	
	// 게시글 삭제
	@ResponseBody
	@RequestMapping(value= "/delete/{writeIdNo}", method = RequestMethod.GET)
	public String deleteBoard(@PathVariable("writeIdNo")int writeIdNo,
							  @RequestParam(defaultValue = "1")int pageNo,
							  @RequestParam(defaultValue= "1")int typeIdNo) {
		
		boardService.deleteCommentInBoard(writeIdNo);
		if (typeIdNo == 1) {
			boardService.deleteBoardNotice(writeIdNo);
		} else if (typeIdNo == 2){
			boardService.deleteBoardUnknown(writeIdNo);
		} 
		boardService.deleteBoard(writeIdNo);
		
		return "success";
	}
	
	// 첨부파일 저장
	@GetMapping(path= {"/download"})
	public View download(@RequestParam(defaultValue = "1")int attachIdNo,
						 Model model) {
		
		BoardAttachDto attachment = boardService.findBoardAttachByAttachIdNo(attachIdNo);
		
		// View에게 전달할 데이터 저장
		model.addAttribute("attachment", attachment);
		BoardDownloadView view = new BoardDownloadView();
		
		return view;
	}
	
	// 첨부파일 삭제
	@ResponseBody
	@RequestMapping(value = {"/delete-attach/{attachIdNo}"})
	public String deleteBoardAttach(@PathVariable("attachIdNo")int attachIdNo) {

		boardService.deleteBoardAttachByAttachIdNo(attachIdNo);

		return "success";
	}
	
	// 게시글 내 이미지 업로드
	@PostMapping("/upload-image-file")
	@ResponseBody	// return값이 jsp 이름이 아니고 응답데이터. 주로 ajax 응답으로 사용함. 
	public String uploadImageInBoard(MultipartHttpServletRequest req) {
		
		MultipartFile file = req.getFile("file");
		String fileName = file.getOriginalFilename();
		String unique_file_name = UUID.randomUUID().toString();
		unique_file_name += fileName.substring(fileName.lastIndexOf("."));
		
		String path = req.getServletContext().getRealPath("/resources/image/" + unique_file_name);
		try {
			file.transferTo(new File(path));	// 저장
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return "/gw-project/resources/image/" + unique_file_name;	// 서버에 저장된 파일 경로
	}
	
	// 검색
	@ResponseBody
	@GetMapping(path= {"/search"})
	public HashMap<String, Object> showSearchList(@RequestParam("searchOption")String searchOption,
									   			   @RequestParam("search")String search,
									   			   @RequestParam(defaultValue= "1")int typeIdNo,
									   			   @RequestParam(defaultValue = "1")int pageNo,
									   			   BoardDto board) {
//		if (search.equals("")) {
//			return "notice";
//		}
		
		HashMap<String, Object> returnValue = new HashMap<>();
		
		if (typeIdNo == 1) {
			BoardNoticeDto boardNotice = new BoardNoticeDto();
			boardNotice.setSearchOption(searchOption);
			boardNotice.setSearch(search);

			List<BoardNoticeDto> noticeSearch = boardService.searchBoardNotice(boardNotice);
			int boardCount = boardService.findBoardCount(board);
			BoardPager pager = new BoardPager(boardCount, pageNo, PAGE_SIZE, PAGER_SIZE, N_LINK_URL);
			 
			// return noticeSearch;
			returnValue.put("boardList", noticeSearch);
			returnValue.put("pager", pager.toString());
			
		} else {
			BoardUnknownDto boardUnknown = new BoardUnknownDto();
			boardUnknown.setSearchOption(searchOption);
			boardUnknown.setSearch(search);
			
			List<BoardUnknownDto> unknownSearch = boardService.searchBoardUnknown(boardUnknown);
			int boardCount = boardService.findBoardCount(board);
			BoardPager pager = new BoardPager(boardCount, pageNo, PAGE_SIZE, PAGER_SIZE, U_LINK_URL);
			
			// return unknownSearch;
			returnValue.put("boardList", unknownSearch);
			returnValue.put("pager", pager.toString());
		} 
		return returnValue;
	}
	
	// 댓글 /////////////////////////////////////////////////////////
	
	// 댓글 리스트
	@GetMapping(path= {"/comment-list"})
	public String showCommentList(int writeIdNo, int typeIdNo, Model model) {
		List<BoardCommentDto> comments = boardService.findBoardCommentByWriteIdNo(writeIdNo);
		model.addAttribute("comments", comments);
		model.addAttribute("typeIdNo", typeIdNo);
		
		return "board/comment-list";
	}
	
	// 댓글 쓰기
	@PostMapping(path= {"/write-comment"})
	@ResponseBody
	public String writeComment(BoardCommentDto comment, MemberDto member) {
		boardService.writeComment(comment);
		boardService.updateGroupNo(comment.getComIdNo(), comment.getComIdNo());
		return "success";
	}
	
	// 댓글 삭제
	@GetMapping(path= {"/delete-comment"})
	@ResponseBody
	public String deleteComment(@RequestParam(defaultValue="1")int comIdNo,
								@RequestParam(defaultValue="1")int typeIdNo,
								@RequestParam(defaultValue="-1")int writeIdNo,
								String comPasswd) {
		if (typeIdNo == 1) {
			boardService.deleteComment(comIdNo);
		} else if (typeIdNo == 2) {
			boardService.deleteUnknownComment(comIdNo, comPasswd);
		}
		return "success";
	}

	// 댓글 수정
	@PostMapping(path= {"/update-comment"})
	@ResponseBody
	public String updateComment(@RequestParam(defaultValue="1")int typeIdNo, BoardCommentDto comment) {
		if (typeIdNo == 1) {
			boardService.updateComment(comment);			
		} else if (typeIdNo == 2) {
			boardService.updateUnknownComment(comment);
		}
		return "success";
	}
	
	// 대댓글 등록
	@PostMapping(path= {"/write-recomment"})
	@ResponseBody
	public String writeRecomment(BoardCommentDto comment) {
		boardService.writeRecomment(comment);
		return "success";
	}
	
}
