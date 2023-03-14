package com.gw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;

import com.gw.dto.BoardAttachDto;
import com.gw.dto.BoardDto;
import com.gw.dto.BoardNoticeDto;
import com.gw.dto.BoardUnknownDto;

@Mapper
public interface BoardMapper {
	
	// 공지사항 리스트 조회
	@Select("SELECT b.b_type_id_no typeIdNo, b.b_write_id_no writeIdNo, b.b_title title, n.n_mem_no noticeMemNo, md.mem_detail_name noticeWriter, b.b_content content, b.b_regdate regDate, b.b_readcount readCount " +
			"FROM board b " +
			"LEFT OUTER JOIN notice n " +
			"ON b.b_write_id_no = n.b_write_id_no " +
			"LEFT OUTER JOIN member_detail md " +
			"ON n.n_mem_no = md.mem_detail_id_no " +
			"WHERE b.b_type_id_no = 1 " +
			"ORDER BY b.b_write_id_no DESC " +
			"LIMIT #{from}, #{count} ")
	List<BoardNoticeDto> selectBoardNoticeByPage(@Param("from")int from, @Param("count")int count);
	
	// 익명게시판 리스트 조회
	@Select("SELECT b.b_type_id_no typeIdNo, b.b_write_id_no writeIdNo, b.b_title title, b.b_content content, b.b_regdate regDate, b.b_readcount readCount, un.un_rewrite_passwd unRewritePasswd " +
			"FROM board b " +
			"LEFT OUTER JOIN unknown_board un " +
			"ON b.b_write_id_no = un.b_write_id_no " +
			"WHERE b.b_type_id_no = 2 " +
			"ORDER BY b.b_write_id_no DESC " +
			"LIMIT #{from}, #{count} ")
	List<BoardUnknownDto> selectBoardUnknownByPage(@Param("from")int from, @Param("count")int count);
	
	@SelectProvider(type=BoardSearchProvider.class, method="makeSelectBoardCountQuery")
	int selectBoardCount(BoardDto board);
	
	// 공지사항 글상세보기 조회
	@Select("SELECT b.b_type_id_no, b.b_write_id_no, b.b_title, n.n_mem_no, md.mem_detail_name, b.b_content, b.b_regdate, b.b_readcount " +
			"FROM board b " +
			"LEFT OUTER JOIN notice n " +
			"ON b.b_write_id_no = n.b_write_id_no " +
			"LEFT OUTER JOIN member_detail md " +
			"ON n.n_mem_no = md.mem_detail_id_no " +
			"WHERE b.b_type_id_no = 1 AND b.b_write_id_no = #{writeIdNo} AND b.b_deleted = FALSE ")
	@Results(id="boardNoticeResultMap",
			 value= {
					 @Result(column="b_type_id_no", property="typeIdNo"),
					 @Result(column="b_write_id_no", property="writeIdNo", id=true),
					 @Result(column="b_title", property="title"),
					 @Result(column="n_mem_no", property="noticeMemNo"),
					 @Result(column="mem_detail_name", property="noticeWriter"),
					 @Result(column="b_content", property="content"),
					 @Result(column="b_regdate", property="regDate"),
					 @Result(column="b_readcount", property="readCount"),
					 @Result(column="b_write_id_no", property="attachments",
							 many = @Many(select="selectBoardAttachByWriteIdNo")),
					 @Result(column="b_write_id_no", property="comments",
							 many = @Many(select="com.gw.mapper.BoardCommentMapper.selectBoardCommentByWriteIdNo"))
			 })
	BoardNoticeDto selectNoticeBoardByWriteIdNo(int writeIdNo);
	
	// 익명게시판 글상세보기 조회
	@Select("SELECT b.b_type_id_no, b.b_write_id_no, b.b_title, b.b_content, b.b_regdate, b.b_readcount, un.un_rewrite_passwd " +
			"FROM board b " +
			"LEFT OUTER JOIN unknown_board un " +
			"ON b.b_write_id_no = un.b_write_id_no " +
			"WHERE b.b_type_id_no = 2 AND b.b_write_id_no = #{writeIdNo} AND b.b_deleted = FALSE ")
	@Results(id="boardUnknownResultMap",
	 value= {
			 @Result(column="b_type_id_no", property="typeIdNo"),
			 @Result(column="b_write_id_no", property="writeIdNo", id=true),
			 @Result(column="b_title", property="title"),
			 @Result(column="b_content", property="content"),
			 @Result(column="b_regdate", property="regDate"),
			 @Result(column="b_readcount", property="readCount"),
			 @Result(column="un_rewrite_passwd", property="unRewritePasswd"),
			 @Result(column="b_write_id_no", property="attachments",
					 many = @Many(select="selectBoardAttachByWriteIdNo")),
			 @Result(column="b_write_id_no", property="comments",
			 many = @Many(select="com.gw.mapper.BoardCommentMapper.selectBoardCommentByWriteIdNo"))
	 })
	BoardUnknownDto selectUnknownBoardByWriteIdNo(int writeIdNo);

	// 해당 게시글 이전 페이지(<) 조회
	@Select("SELECT MAX(b_write_id_no) writeIdNo, b_type_id_no typeIdNo " +
			"FROM board " +
			"WHERE b_write_id_no < #{writeIdNo} " +
			"AND b_type_id_no = #{typeIdNo} ")
	BoardDto selectPreviousBoard(@Param("writeIdNo")int writeIdNo, @Param("typeIdNo")int typeIdNo);

	// 해당 게시글 다음 페이지(>) 조회
	@Select("SELECT MIN(b_write_id_no) writeIdNo, b_type_id_no typeIdNo " +
			"FROM board " +
			"WHERE b_write_id_no > #{writeIdNo} " +
			"AND b_type_id_no = #{typeIdNo} ")
	BoardDto selectNextBoard(@Param("writeIdNo")int writeIdNo, @Param("typeIdNo")int typeIdNo);
	
	// 작성한 게시글 내용 DB에 저장
	@Insert("INSERT INTO board (b_type_id_no, b_title, b_content) " +
			"VALUES (#{typeIdNo}, #{title}, #{content}) ")
	@Options(useGeneratedKeys = true, keyColumn = "b_write_id_no", keyProperty = "writeIdNo")
	void insertBoard(BoardDto board);
	
	// 공지사항 작성자 사원번호 DB에 저장
	@Insert("INSERT INTO notice (b_write_id_no, n_mem_no) " +
			"VALUES (#{writeIdNo}, #{noticeMemNo}) ")
	void saveNoticeMemNo(BoardNoticeDto boardNotice);
	
	// 익명게시판 2차 비밀번호 DB에 저장
	@Insert("INSERT INTO unknown_board (b_write_id_no, un_rewrite_passwd) " +
			"VALUES (#{writeIdNo}, #{unRewritePasswd}) ")
	void insertRewritePasswd(BoardUnknownDto boardUnknown);

	// 글번호를 받아서 게시글 조회수 증가
	@Update("UPDATE board " +
			"SET b_readcount = b_readcount + 1 " +
			"WHERE b_write_id_no = #{writeIdNo} " +
			"AND b_deleted = FALSE ")
	void updateBoardReadCount(int writeIdNo);

	// 게시글 수정
	@Update("Update board " +
			"SET b_title = #{title}, b_content = #{content} " +
			"WHERE b_write_id_no = #{writeIdNo} ")
	void updateBoard(BoardDto board);
	
	// 게시글 삭제 - board와 foregin key로 연결되어 있기 때문에 notice/unknown도 같이 삭제
	@Delete("DELETE FROM board " + 
			"WHERE b_write_id_no = #{writeIdNo} ")
	void deleteBoard(int writeIdNo);

	@Delete("DELETE FROM notice " + 
			"WHERE b_write_id_no = #{writeIdNo} ")
	void deleteBoardNotice(int writeIdNo);

	@Delete("DELETE FROM unknown_board " + 
			"WHERE b_write_id_no = #{writeIdNo} ")
	void deleteBoardUnknown(int writeIdNo);
	
	// 게시판 안에 있는 댓글 모두 삭제
	@Delete("DELETE FROM comment " +
			"WHERE b_write_id_no = #{writeIdNo} ")
	void deleteCommentInBoard(int writeIdNo);

	// 첨부파일 DB에 저장
	@Insert("INSERT INTO board_attach (b_write_id_no, b_attach_userfilename, b_attach_savedfilename) " + 
			"VALUES (#{writeIdNo}, #{attachUserFileName}, #{attachSavedFileName})")
	void insertBoardAttach(BoardAttachDto attachment);

	// 글번호 받아서 첨부파일 정보 조회하고 목록으로 반환
	@Select("SELECT b_attach_id_no attachIdNo, b_write_id_no writeIdNo, b_attach_userfilename attachUserFileName, b_attach_savedfilename attachSavedFileName " +
			"FROM board_attach " + "WHERE b_write_id_no = #{writeIdNo} ")
	List<BoardAttachDto> selectBoardAttachByWriteIdNo(int writeIdNo);

	// 첨부파일 번호를 받아서 첨부파일 조회 및 반환
	@Select("SELECT b_attach_id_no attachIdNo, b_write_id_no writeIdNo, b_attach_userfilename attachUserFileName, b_attach_savedfilename attachSavedFileName " +
			"FROM board_attach " + 
			"WHERE b_attach_id_no = #{attachIdNo} ")
	BoardAttachDto selectBoardAttachByAttachIdNo(int attachIdNo);

	// 첨부파일 삭제
	@Delete("DELETE FROM board_attach " + 
			"WHERE b_attach_id_no = #{attachIdNo} ")
	void deleteBoardAttachByAttachIdNo(int attachIdNo);
	
	// 공지사항 검색
	@SelectProvider(type=BoardSearchProvider.class, method="makeSelectBoardNoticeSearchQuery")
	List<BoardNoticeDto> selectBoardNoticeSearch(BoardNoticeDto boardNotice);

	// 익명게시판 검색
	@SelectProvider(type=BoardSearchProvider.class, method="makeSelectBoardUnknownSearchQuery")
	List<BoardUnknownDto> selectBoardUnknownSearch(BoardUnknownDto boardUnknown);
}
