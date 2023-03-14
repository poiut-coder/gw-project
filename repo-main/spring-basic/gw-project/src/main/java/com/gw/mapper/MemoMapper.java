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

import com.gw.dto.MemoDto;
import com.gw.dto.MemberDetailDto;

@Mapper // Memo-context.xml 파일의 <bean id="MemoMapper" class="...MapperFactoryBean" ..을
		// 대신하는 annotation
public interface MemoMapper {

	// 사용자가 작성한 게시글 정보를 받아서 데이터베이스에 저장
	@Insert("INSERT INTO memo (m_id_no, m_sender, m_receiver, m_content) "
			+ "VALUES (#{ m_id_no }, #{ m_sender }, #{ m_receiver }, #{ m_content })")
	@Options(useGeneratedKeys = true, keyColumn = "m_id_no", keyProperty = "m_id_no")
	void insertMemo(MemoDto memo);
	
//	// 전체글번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A " + "ON C.mem_id_no = A.m_receiver or C.mem_id_no = A.m_sender "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = FALSE "
			+ "GROUP BY A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "ORDER BY A.m_id_no DESC " + "LIMIT #{ from },#{ count } ")
	List<MemoDto> selectMemoByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);

//	// 받은글번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A " + "ON C.mem_id_no = A.m_receiver "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = FALSE "
			+ "GROUP BY A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "ORDER BY A.m_id_no DESC " + "LIMIT #{ from },#{ count } ")
	List<MemoDto> selectMemoReceivedByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);
	
//	// 보낸글번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A " + "ON C.mem_id_no = A.m_sender "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = FALSE "
			+ "GROUP BY A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "ORDER BY A.m_id_no DESC " + "LIMIT #{ from },#{ count } ")
	List<MemoDto> selectMemoSendByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);
	
//	// 내게쓴글번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A " + "ON C.mem_id_no = A.m_sender AND C.mem_id_no = A.m_receiver "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = FALSE "
			+ "GROUP BY A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "ORDER BY A.m_id_no DESC " + "LIMIT #{ from },#{ count } ")
	List<MemoDto> selectMemoMyByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);
	
	// 삭제글 번호를 받아서 읽음 처리 ( update )
	@Select("SELECT C.mem_id_no, A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A " + "ON C.mem_id_no = A.m_receiver or C.mem_id_no = A.m_sender "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = TRUE "
			+ "GROUP BY A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "ORDER BY A.m_id_no DESC " + "LIMIT #{ from },#{ count } ")
	List<MemoDto> selectMemoDeleteByPage(@Param("mem_id_no") int mem_id_no, @Param("from") int from, @Param("count") int count);

	// 쪽지함 상세보기
	@Select("SELECT m_id_no, m_sender, m_receiver, m_content, m_regdate " + "FROM memo "
			+ "WHERE m_id_no = #{ m_id_no } ")
	MemoDto selectMemoBymem_id_no(@Param("m_id_no") int m_id_no);

	// 모든 게시글 조회해서 반환
	@Select("SELECT mem_id_no, title, writer, receiver, regdate, deleted " + "FROM memo "
			+ "ORDER BY mem_id_no DESC ")
	List<MemoDto> selectAllMemo();

	// 모든 게시글 조회해서 반환(EX)
	@Select("SELECT mem_detail_id_no, mem_detail_name, mem_detail_email " + "FROM member_detail ")
	List<MemberDetailDto> selectAllEXMemo();

	// 글 번호를 받아서 게시글 삭제
	@Update("UPDATE memo " + "SET m_deleted = TRUE " + "WHERE m_id_no = #{ m_id_no }")
	void deleteMemo(@Param("m_id_no") int m_id_no);
	
	// 전체글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A ON C.mem_id_no = A.m_receiver or C.mem_id_no = A.m_sender "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = FALSE ")
	int selectMemoCount(int mem_id_no);

	// 받은글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A ON C.mem_id_no = A.m_receiver "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = FALSE ")
	int selectMemoReceivedCount(int mem_id_no);
	
	// 보낸글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A ON C.mem_id_no = A.m_sender "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = FALSE ")
	int selectMemoSendCount(int mem_id_no);

	// 내게쓴글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A ON C.mem_id_no = A.m_receiver AND C.mem_id_no = A.m_sender "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = FALSE ")
	int selectMemoMyCount(int mem_id_no);
	
	// 삭제글 카운트
	@Select("SELECT COUNT(C.mem_id_no), A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A ON C.mem_id_no = A.m_receiver or C.mem_id_no = A.m_sender "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND A.m_deleted = TRUE ")
	int selectMemoDeleteCount(int mem_id_no);

	// 글번호, 제목, 내용을 받아서 글 수정 처리 (반환 X)
	@Update("UPDATE memo " + "SET m_title = #{ m_title }, m_content = #{ m_content } " + "WHERE mem_id_no = #{ mem_id_no } ")
	void updateMemo(MemoDto Memo);

	// 전체쪽지 검색기능 
	@Select("SELECT C.mem_id_no, A.m_id_no, A.m_sender, A.m_receiver, A.m_content, A.m_regdate, A.m_deleted "
			+ "FROM member AS C INNER JOIN memo AS A ON C.mem_id_no = A.m_receiver or C.mem_id_no = A.m_sender "
			+ "WHERE C.mem_id_no = #{ mem_id_no } AND (A.m_id_no like '${search}' or A.m_content like '${search}' or A.m_sender like '${search}') Order By A.m_regdate DESC ")
	List<MemoDto> selectBySearch(@Param("search")String search, @Param("mem_id_no")int mem_id_no);

	// 휴지통에서 글 완전 삭제 
	@Delete("DELETE " + "FROM memo " + "WHERE m_id_no = #{ m_id_no }")
	void deleteInstanceMemo(int m_id_no);




	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
