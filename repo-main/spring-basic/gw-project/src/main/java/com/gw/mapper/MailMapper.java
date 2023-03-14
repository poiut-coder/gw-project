package com.gw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gw.dto.MailAttachDto;
import com.gw.dto.MailDto;
import com.gw.dto.MemberDetailDto;

@Mapper // mail-context.xml 파일의 <bean id="mailMapper" class="...MapperFactoryBean" ..을
		// 대신하는 annotation
public interface MailMapper {

	// 사용자가 작성한 게시글 정보를 받아서 데이터베이스에 저장
	@Insert("INSERT INTO mail (title, writer, receiver, content, draft) "
			+ "VALUES (#{ title }, #{ writer }, #{ receiver }, #{ content }, #{ draft })")
	@Options(useGeneratedKeys = true, keyColumn = "mailno", keyProperty = "mailNo")
//	@SelectKey(statement = "SELECT LAST_INSERT_ID()", 
//			   resultType = Integer.class, keyProperty = "mailNo", before = false)
	void insertMail(MailDto mail);
	
	// 글 번호를 받아서 임시메일함 보관.
	@Insert("INSERT INTO mail (title, writer, receiver, content, draft) "
			+ "VALUES (#{ title }, #{ writer }, #{ receiver }, #{ content }, 1)")
	@Options(useGeneratedKeys = true, keyColumn = "mailno", keyProperty = "mailNo")
	void draftMail(MailDto mail);

//	// 전체글번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted, A.draft , COUNT(B.userFileName) attachCount "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.receiver or C.mem_id_no = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno " 
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft = 0 "
			+ "GROUP BY A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted "
			+ "ORDER BY A.mailno DESC " + "LIMIT #{ from },#{ count } ")
	List<MailDto> selectMailByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);

//	// 받은글번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted, A.draft , COUNT(B.userFileName) attachCount "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.receiver "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno " 
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft = 0 "
			+ "GROUP BY A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted "
			+ "ORDER BY A.mailno DESC " + "LIMIT #{ from },#{ count } ")
	List<MailDto> selectMailReceivedByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);
	
//	// 보낸글번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted, A.draft , COUNT(B.userFileName) attachCount "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno " 
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft = 0 "
			+ "GROUP BY A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted "
			+ "ORDER BY A.mailno DESC " + "LIMIT #{ from },#{ count } ")
	List<MailDto> selectMailSendByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);

//	// 임시글번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted, A.draft , COUNT(B.userFileName) attachCount "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno " 
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft = 1 "
			+ "GROUP BY A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted "
			+ "ORDER BY A.mailno DESC " + "LIMIT #{ from },#{ count } ")
	List<MailDto> selectMailDraftByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);
	
//	// 내게쓴글번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted, A.draft, COUNT(B.userFileName) attachCount "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.receiver AND A.receiver = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno " 
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft = 0 "
			+ "GROUP BY A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted "
			+ "ORDER BY A.mailno DESC " + "LIMIT #{ from },#{ count } ")
	List<MailDto> selectMailMyByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);
	
	// 삭제글 번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted, A.draft, COUNT(B.userFileName) attachCount "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.receiver or C.mem_id_no = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno " 
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = TRUE AND A.draft = 0 "
			+ "GROUP BY A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted "
			+ "ORDER BY A.mailno DESC " + "LIMIT #{ from },#{ count } ")
	List<MailDto> selectMailDeleteByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);

	@Select("SELECT mailno, title, writer, receiver, content, readcount, regdate " + "FROM mail "
			+ "WHERE mailno = #{ mailNo } AND deleted = FALSE ")
	MailDto selectMailByMailNo(@Param("mailNo") int mailNo);

	@Select("SELECT attachno, mailno, userfilename, savedfilename, downloadcount " + "FROM mailattach "
			+ "WHERE mailno = #{ mailNo } ")
	List<MailAttachDto> selectMailAttachByMailNo(@Param("mailNo") int mailNo);

	// 글 번호를 받아서 전체메일함 조회 및 반환
	@Select("SELECT mailno, title, writer, receiver, content, readcount, regdate " + "FROM mail "
			+ "WHERE mailno = #{ mailNo } AND deleted = FALSE ")
	@Results(id = "mailResultMap1", value = { @Result(column = "mailno", property = "mailNo", id = true),
			@Result(column = "title", property = "title"), @Result(column = "writer", property = "writer"),
			@Result(column = "receiver", property = "receiver"), @Result(column = "content", property = "content"),
			@Result(column = "readcount", property = "readCount"), @Result(column = "regdate", property = "regDate"),
			@Result(column = "mailno", property = "attachments", many = @Many(select = "selectMailAttachByMailNo")) })
	MailDto selectMailByMailNo2(@Param("mailNo") int mailNo);

	// 글 번호를 받아서 받은메일함 조회 및 반환
	@Select("SELECT mailno, title, writer, receiver, content, readcount, regdate " + "FROM mail "
			+ "WHERE mailno = #{ mailNo } AND deleted = FALSE ")
	@Results(id = "mailResultMap2", value = { @Result(column = "mailno", property = "mailNo", id = true),
			@Result(column = "title", property = "title"), @Result(column = "writer", property = "writer"),
			@Result(column = "receiver", property = "receiver"), @Result(column = "content", property = "content"),
			@Result(column = "readcount", property = "readCount"), @Result(column = "regdate", property = "regDate"),
			@Result(column = "mailno", property = "attachments", many = @Many(select = "selectMailAttachByMailNo")) })
	MailDto selectMailReceivedByMailNo2(@Param("mailNo") int mailNo);
	
	// 글 번호를 받아서 보낸메일함 조회 및 반환
	@Select("SELECT mailno, title, writer, receiver, content, readcount, regdate " + "FROM mail "
			+ "WHERE mailno = #{ mailNo } AND deleted = FALSE ")
	@Results(id = "mailResultMap3", value = { @Result(column = "mailno", property = "mailNo", id = true),
			@Result(column = "title", property = "title"), @Result(column = "writer", property = "writer"),
			@Result(column = "receiver", property = "receiver"), @Result(column = "content", property = "content"),
			@Result(column = "readcount", property = "readCount"), @Result(column = "regdate", property = "regDate"),
			@Result(column = "mailno", property = "attachments", many = @Many(select = "selectMailAttachByMailNo")) })
	MailDto selectMailSendByMailNo2(@Param("mailNo") int mailNo);

	// 글 번호를 받아서 임시메일함 조회 및 반환
	@Select("SELECT mailno, title, writer, receiver, content, readcount, regdate " + "FROM mail "
			+ "WHERE mailno = #{ mailNo } AND deleted = FALSE ")
	@Results(id = "mailResultMap4", value = { @Result(column = "mailno", property = "mailNo", id = true),
			@Result(column = "title", property = "title"), @Result(column = "writer", property = "writer"),
			@Result(column = "receiver", property = "receiver"), @Result(column = "content", property = "content"),
			@Result(column = "readcount", property = "readCount"), @Result(column = "regdate", property = "regDate"),
			@Result(column = "mailno", property = "attachments", many = @Many(select = "selectMailAttachByMailNo")) })
	MailDto selectMailDraftByMailNo2(@Param("mailNo") int mailNo);
	
	// 글 번호를 받아서 내게쓴메일함 조회 및 반환
	@Select("SELECT mailno, title, writer, receiver, content, readcount, regdate " + "FROM mail "
			+ "WHERE mailno = #{ mailNo } AND writer = receiver AND deleted = FALSE ")
	@Results(id = "mailResultMap5", value = { @Result(column = "mailno", property = "mailNo", id = true),
			@Result(column = "title", property = "title"), @Result(column = "writer", property = "writer"),
			@Result(column = "receiver", property = "receiver"), @Result(column = "content", property = "content"),
			@Result(column = "readcount", property = "readCount"), @Result(column = "regdate", property = "regDate"),
			@Result(column = "mailno", property = "attachments", many = @Many(select = "selectMailAttachByMailNo")) })
	MailDto selectMailMyByMailNo2(@Param("mailNo") int mailNo);
	
	// 글 번호를 받아서 휴지통(삭제목록) 조회 및 반환
	@Select("SELECT mailno, title, writer, receiver, content, readcount, regdate " + "FROM mail "
			+ "WHERE mailno = #{ mailNo } AND deleted = TRUE ")
	@Results(id = "mailResultMap7", value = { @Result(column = "mailno", property = "mailNo", id = true),
			@Result(column = "title", property = "title"), @Result(column = "writer", property = "writer"),
			@Result(column = "receiver", property = "receiver"), @Result(column = "content", property = "content"),
			@Result(column = "readcount", property = "readCount"), @Result(column = "regdate", property = "regDate"),
			@Result(column = "mailno", property = "attachments", many = @Many(select = "selectMailAttachByMailNo")) })
	MailDto selectMailDeletedByMailNo(@Param("mailNo") int mailNo);

	// 사용자가 입력한 게시글 데이터를 받아서 글쓰기 처리
	@Insert("INSERT INTO mailattach (mailno, userfilename, savedfilename) "
			+ "VALUES (#{ mailNo }, #{ userFileName }, #{ savedFileName }) ")
	void insertMailAttach(MailAttachDto attachment);

	// 모든 게시글 조회해서 반환
	@Select("SELECT mailno, title, writer, receiver, readcount, regdate, deleted " + "FROM mail "
			+ "ORDER BY mailno DESC ")
	List<MailDto> selectAllMail();

	// 모든 게시글 조회해서 반환(EX)
	@Select("SELECT mem_detail_id_no, mem_detail_name, mem_detail_email " + "FROM member_detail ")
	List<MemberDetailDto> selectAllEXMail();

	// 글번호를 받아서 읽음 처리 ( update )
	@Update("UPDATE mail  " + "SET readcount = 1 " + "WHERE mailno = #{ mailNo } AND deleted = FALSE ")
	void updateMailReadCount(@Param("mailNo") int mailNo);

	// 글 번호를 받아서 게시글 삭제
	@Update("UPDATE mail " + "SET deleted = TRUE " + "WHERE mailno = #{ mailNo }")
	void deleteMail(@Param("mailNo") int mailNo);
	
	// 첨부파일 번호를 받아서 첨부파일 데이터 조회 및 반환
	@Select("SELECT attachno , mailno, userfilename, savedfilename, downloadcount " + "FROM mailattach "
			+ "WHERE attachno = #{ attachno } ")
	MailAttachDto selectMailAttachByAttachNo(int attachNo);

	// 전체글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.receiver or C.mem_id_no = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft = 0 ")
	int selectMailCount(int mem_id_no);

	// 받은글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted , A.draft "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.receiver "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft = 0 ")
	int selectMailReceivedCount(int mem_id_no);
	
	// 보낸글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted , A.draft "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft = 0 ")
	int selectMailSendCount(int mem_id_no);

	// 임시글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted, A.draft "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft=1 ")
	int selectMailDraftCount(int mem_id_no);
	
	// 내게쓴글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted , A.draft "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.receiver AND A.receiver = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = FALSE AND A.draft = 0 ")
	int selectMailMyCount(int mem_id_no);
	
	// 삭제글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.mailno, A.title, A.writer, A.receiver, A.readcount, A.regdate, A.deleted "
			+ "FROM member AS C INNER JOIN mail AS A " + "ON C.mem_id_no = A.receiver or C.mem_id_no = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B " + "ON A.mailno = B.mailno "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.deleted = TRUE AND A.draft = 0 ")
	int selectMailDeleteCount(int mem_id_no);

	// 글번호, 제목, 내용을 받아서 글 수정 처리 (반환 X)
	@Update("UPDATE mail " + "SET title = #{ title }, content = #{ content } " + "WHERE mailno = #{ mailNo } ")
	void updateMail(MailDto mail);

	// 전체메일 검색기능 
	@Select("SELECT C.mem_id_no, A.mailno, A.title, A.writer, A.receiver, A.regdate "
			+ "FROM member AS C INNER JOIN mail AS A ON C.mem_id_no = A.receiver or C.mem_id_no = A.writer "
			+ "LEFT OUTER JOIN mailattach AS B ON A.mailno = B.mailno AND A.draft = 0 "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND (A.mailno like '${search}' or A.title like '${search}' or A.writer like '${search}') Order By A.regdate DESC ")
	List<MailDto> selectBySearch(@Param("search")String search, @Param("mem_id_no")int mem_id_no);

	
	@Delete("DELETE " + "FROM mail " + "WHERE mailno = #{ mailNo } ")
	void deleteInstanceMail(int mailNo);



	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
