package com.gw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gw.dto.TodoDto;

@Mapper // board-context.xml 파일의 <bean id="boardMapper" class="...MapperFactoryBean" ..을
		// 대신하는 annotation
public interface TodoMapper {

	// todo입력
	@Insert("insert into todo(title,writer,content,completedate,regdate,startDate,event_color ) "
			+ "values (#{title},#{writer},#{content},#{completeDateForSql},#{regDate},#{startDateForSql},#{event_color})")
	@Options(useGeneratedKeys = true, keyColumn = "todo_no", keyProperty = "todo_no")
	void insertTodo(TodoDto todo);

	// todo list출력
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo " + " where is_deleted=false")
	List<TodoDto> findTodo();

	// todo삭제
	@Update("update  todo " + " set is_deleted=true" + " where todo_no=#{todo_no}")
	void deleteTodo(int todo_no);

	// todo todo_no를 통해 찾기
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color , day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear" 
			+" from todo "
			+ " where todo_no=#{todo_no}")
	TodoDto findTodoByTodo_no(int todo_no);

	// todo 편집
	@Update("update  todo "
			+ " set title=#{title}, content=#{content},completedate=#{completeDateForSql}, startdate=#{startDateForSql} ,event_color= #{event_color }"
			+ " where todo_no=#{todo_no}")
	void editTodo(TodoDto todo);

	// id를 통해 todo 검색
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo " + " where is_deleted=false and writer= #{mem_id_no} ")
	List<TodoDto> findTodoByMemberId(int mem_id_no);

	//  검색
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo "
			+ " where is_deleted=false and writer= #{writer} and completedate <= #{completeDateForSql}  and startdate >= #{ startDateForSql} and title like  #{contentForSql}  ")
	List<TodoDto> findTodoByMemberIdAndTitle(TodoDto todo);

	// 검색된 todo시작 날짜순으로 정렬
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo "
			+ " where is_deleted=false and writer= #{writer} and completedate <= #{completeDateForSql}  and startdate >= #{ startDateForSql} and title like  #{contentForSql} "
			+ "order by startdate asc")
	List<TodoDto> findTodoByMemberIdAndDateOrderByStartDate(TodoDto todo);

	// todo 시작 날짜순으로 정렬
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo " + " where is_deleted=false and writer= #{mem_id_no} " + "order by startdate asc")
	List<TodoDto> findTodoByMemberIdOrderByStartDate(int mem_id_no);

	// 검색된 todo완료 날짜순으로 정렬
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo "
			+ " where is_deleted=false and writer= #{writer} and completedate <= #{completeDateForSql}  and startdate >= #{ startDateForSql} and title like  #{contentForSql} "
			+ "order by completedate asc")
	List<TodoDto> findTodoByMemberIdAndDateOrderByCompleteDate(TodoDto searchedDate);

	// todo 완료 날짜순으로 정렬
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo " + " where is_deleted=false and writer= #{mem_id_no} " + "order by completedate asc")
	List<TodoDto> findTodoByMemberIdOrderByCompleteDate(int mem_id_no);

	// 검색된 todo등록 날짜순으로 정렬
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo "
			+ " where is_deleted=false and writer= #{writer} and completedate <= #{completeDateForSql}  and startdate >= #{ startDateForSql} and title like  #{contentForSql}"
			+ "order by regdate asc")
	List<TodoDto> findTodoByMemberIdAndDateOrderByRegDate(TodoDto searchedDate);

	// todo 등록 날짜순으로 정렬
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo " + " where is_deleted=false and writer= #{mem_id_no} " + "order by regdate asc")
	List<TodoDto> findTodoByMemberIdOrderByRegDate(int mem_id_no);

	// 오늘 할일
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo "
			+ " where is_deleted=false and writer= #{mem_id_no}  and #{today}  <= completedate  and #{today} >= startdate "
			)
	List<TodoDto> searchTodoay(@Param("today") String today, @Param("mem_id_no") int mem_id_no);

	// 오늘 할일 등록 날짜순으로 정렬
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo "
			+ " where is_deleted=false and writer= #{mem_id_no}  and #{todaydate}  <= completedate  and #{todaydate} >= startdate "
			+ "order by regdate asc")
	List<TodoDto> searchTodoayOrderByRegDate(@Param("todaydate") String todaydate,@Param("mem_id_no") int mem_id_no);

	// 오늘 할일 완료 날짜순으로 정렬
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo "
			+ " where is_deleted=false and writer= #{mem_id_no}  and #{todaydate}  <= completedate  and #{todaydate} >= startdate "
			+ "order by completedate asc")
	List<TodoDto> searchTodoayOrderByOrderByCompleteDate(@Param("todaydate") String todaydate,@Param("mem_id_no") int mem_id_no);

	// 오늘 할일 시작 날짜순으로 정렬
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo "
			+ " where is_deleted=false and writer= #{mem_id_no}  and #{todaydate}  <= completedate  and #{todaydate} >= startdate "
			+ "order by startdate asc")
	List<TodoDto> searchTodoayOrderByStartDate(@Param("todaydate") String todaydate, @Param("mem_id_no") int mem_id_no);

	//내용으로 검색 
	@Select("select title,writer,content,completedate,regdate,startdate,todo_no,event_color, day(completedate) completeDay, month(completedate) completeMonth, year(completedate) completeYear,  day(startdate) startDay ,month(startdate) startMonth,year(startdate) startYear "
			+ " from todo "
			+ " where is_deleted=false and writer= #{writer} and completedate <= #{completeDateForSql}  and startdate >= #{ startDateForSql} and content like  #{contentForSql}  ")
	List<TodoDto> findTodoByMemberIdAndContent(TodoDto todo);

}
