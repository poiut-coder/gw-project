package com.gw.mapper;

import com.gw.dto.BoardDto;
import com.gw.dto.BoardNoticeDto;
import com.gw.dto.BoardUnknownDto;

public class BoardSearchProvider {
	
	public String makeSelectBoardNoticeSearchQuery(BoardNoticeDto boardNotice) {
		String strSQL = "SELECT b.b_type_id_no typeIdNo, b.b_write_id_no writeIdNo, b.b_title title, n.n_mem_no noticeMemNo, md.mem_detail_name noticeWriter, b.b_content content, b.b_regdate regDate, b.b_readcount readCount " +
				"FROM board b " +
				"LEFT OUTER JOIN notice n " +
				"ON b.b_write_id_no = n.b_write_id_no " +
				"LEFT OUTER JOIN member_detail md " +
				"ON n.n_mem_no = md.mem_detail_id_no " +
				"WHERE b.b_type_id_no = 1 ";

		
		if (boardNotice.getSearchOption().equals("title")) {
			strSQL += "AND b.b_title LIKE '%" + boardNotice.getSearch() + "%' ";
		} else if (boardNotice.getSearchOption().equals("content")) {
			strSQL += "AND b.b_content LIKE '%" + boardNotice.getSearch() + "%' ";
		}
		
		strSQL += "ORDER BY b.b_write_id_no DESC";
		return strSQL;
		
	}
	
	public String makeSelectBoardUnknownSearchQuery(BoardUnknownDto boardUnknown) {
		String strSQL = "SELECT b.b_type_id_no typeIdNo, b.b_write_id_no writeIdNo, b.b_title title, b.b_content content, b.b_regdate regDate, b.b_readcount readCount, un.un_rewrite_passwd unRewritePasswd " +
				"FROM board b " +
				"LEFT OUTER JOIN unknown_board un " +
				"ON b.b_write_id_no = un.b_write_id_no " +
				"WHERE b.b_type_id_no = 2 ";
		
		if (boardUnknown.getSearchOption().equals("title")) {
			strSQL += "AND b.b_title LIKE '%" + boardUnknown.getSearch() + "%' ";
		} else if (boardUnknown.getSearchOption().equals("content")) {
			strSQL += "AND b.b_content LIKE '%" + boardUnknown.getSearch() + "%' ";
		}
		
		strSQL += "ORDER BY b.b_write_id_no DESC";
		return strSQL;
		
	}
	
	public String makeSelectBoardCountQuery(BoardDto board) {
		String strSQL = "SELECT COUNT(*) " +
				"FROM board " +
				"WHERE b_type_id_no = " + board.getTypeIdNo() + " ";
		
		if (board.getSearch() == null || board.getSearch().length() == 0) {
			// strSQL += "";
		} else if (board.getSearchOption().equals("title")) {
			strSQL += "AND b_title LIKE '%" + board.getSearch() + "%' ";
		} else if (board.getSearchOption().equals("content")) {
			strSQL += "AND b_content LIKE '%" + board.getSearch() + "%' ";
		}
		return strSQL;
	}
}
