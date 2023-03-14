package com.gw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gw.dto.BoardCommentDto;

@Mapper
public interface BoardCommentMapper {

	// 글번호로 댓글 조회 및 반환
	@Select("SELECT c.com_id_no comIdNo, c.mem_id_no comWriter, md.mem_detail_name comWriter2, c.com_content comContent, c.com_passwd comPasswd, c.com_regdate comRegDate, c.com_groupno groupNo, c.com_step step, c.com_depth depth " +
			"FROM comment c " + 
			"LEFT OUTER JOIN member_detail md " +
			"ON c.mem_id_no = md.mem_detail_id_no " +
			"WHERE c.b_write_id_no = #{writeIdNo} " + 
			"ORDER BY c.com_groupno DESC, c.com_step ASC ")
	List<BoardCommentDto> selectBoardCommentByWriteIdNo(int writeIdNo);

	// 댓글 쓰기
	@Insert("INSERT INTO comment (b_write_id_no, mem_id_no, com_content, com_passwd, com_groupno, com_step, com_depth) " +
			"VALUES (#{writeIdNo}, #{comWriter}, #{comContent}, #{comPasswd}, -1, 1, 0) ")
	@Options(useGeneratedKeys=true, keyColumn="com_id_no", keyProperty="comIdNo")
	void insertComment(BoardCommentDto comment);
	
	@Update("UPDATE comment " +
			"SET com_groupno = #{groupNo} " +
			"WHERE com_id_no = #{comIdNo} ")
	void updateGroupNo(@Param("comIdNo")int comIdNo, @Param("groupNo")int groupNo);

	// 댓글 삭제
	@Delete("DELETE FROM comment " +
			"WHERE com_id_no = ${comIdNo} ")
	void deleteComment(int comIdNo);

	// 댓글 수정
	@Update("UPDATE comment " +
			"SET com_content = #{comContent} " +
			"WHERE com_id_no = #{comIdNo} " +
			"AND com_passwd = #{comPasswd} ")
	void updateComment(BoardCommentDto comment);
	
	// 익명 댓글 삭제
	@Delete("DELETE FROM comment " +
			"WHERE com_id_no = #{comIdNo} " + 
			"AND com_passwd = #{comPasswd} ")
	void deleteUnknownComment(int comIdNo, String comPasswd);

	// 익명 댓글 수정
	@Update("UPDATE comment " +
			"SET com_content = #{comContent} " +
			"WHERE com_id_no = #{comIdNo} " +
			"AND com_passwd = #{comPasswd} ")
	void updateUnknownComment(BoardCommentDto comment);

	// 대댓글
	@Insert("INSERT INTO comment (b_write_id_no, mem_id_no, com_content, com_passwd, com_groupno, com_step, com_depth) " +
			"VALUES (#{writeIdNo}, #{comWriter}, #{comContent}, #{comPasswd}, #{groupNo}, #{step}, #{depth}) ")
	void insertRecomment(BoardCommentDto comment);

	@Update("UPDATE comment " +
			"SET com_step = com_step + 1 " +
			"WHERE com_groupno = #{groupNo} " +
			"AND com_step > #{step} ")
	void updateStepNo(@Param("groupNo")int groupNo, @Param("step")int step);

	@Select("SELECT com_id_no comIdNo, b_write_id_no writeIdNo, mem_id_no comWriter, com_regdate comRegDate, com_groupno groupNo, com_step step, com_depth depth " +
			"FROM comment " +
			"WHERE com_id_no = #{comIdNo} ")
	BoardCommentDto selectCommentByComIdNo(int comIdNo);
}
