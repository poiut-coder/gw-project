package com.gw.service;

import java.util.Date;
import java.util.List;

import com.gw.dto.TodoDto;
import com.gw.mapper.TodoMapper;

import lombok.Setter;

public class TodoServiceImpl implements TodoService {
	@Setter
	private TodoMapper todoMapper;

	// todo 생성
	@Override
	public void insertTodo(TodoDto todo) {
		todoMapper.insertTodo(todo);

	}

	// 모든 todo 검색
	@Override
	public List<TodoDto> findTodo() {
		List<TodoDto> schedules = todoMapper.findTodo();

		return schedules;
	}

	// 삭제
	@Override
	public void deleteTodo(int todo_no) {
		todoMapper.deleteTodo(todo_no);

	}

	// todo 번호로 해당 todo 검색
	@Override
	public TodoDto findTodoByTodo_no(int todo_no) {
		TodoDto todo = todoMapper.findTodoByTodo_no(todo_no);
		return todo;

	}

	// 편집
	@Override
	public void editTodo(TodoDto todo) {
		todoMapper.editTodo(todo);

	}

	// memberid를 통해 todo검색
	@Override
	public List<TodoDto> findTodoByMemberId(int mem_id_no) {
		List<TodoDto> schedules = todoMapper.findTodoByMemberId(mem_id_no);

		return schedules;
	}

	// 제목으로 todo 검색
	@Override
	public List<TodoDto> findTodoByMemberIdAndTitle(TodoDto todo) {
		List<TodoDto> schedules = todoMapper.findTodoByMemberIdAndTitle(todo);

		return schedules;
	}

	// 날짜를 통해 검색된 todo 시작 날짜기준 정렬
	@Override
	public List<TodoDto> findTodoByMemberIdAndDateOrderByStartDate(TodoDto todo) {
		List<TodoDto> schedules = todoMapper.findTodoByMemberIdAndDateOrderByStartDate(todo);

		return schedules;
	}
	
	// todo 시작 날짜기준 정렬
	@Override
	public List<TodoDto> findTodoByMemberIdOrderByStartDate(int mem_id_no) {
		List<TodoDto> schedules = todoMapper.findTodoByMemberIdOrderByStartDate(mem_id_no);
		return schedules;
	}
	
	// 날짜를 통해 검색된 todo 완료 날짜기준 정렬
	@Override
	public List<TodoDto> findTodoByMemberIdAndDateOrderByCompleteDate(TodoDto searchedDate) {
		List<TodoDto> schedules = todoMapper.findTodoByMemberIdAndDateOrderByCompleteDate(searchedDate);
		return schedules;
	}
	
	// todo 시작 날짜기준 정렬
	@Override
	public List<TodoDto> findTodoByMemberIdOrderByCompleteDate(int mem_id_no) {
		List<TodoDto> schedules = todoMapper.findTodoByMemberIdOrderByCompleteDate(mem_id_no);
		return schedules;
	}

	// 날짜를 통해 검색된 todo 등록 날짜기준 정렬
	@Override
	public List<TodoDto> findTodoByMemberIdAndDateOrderByRegDate(TodoDto searchedDate) {
		List<TodoDto> schedules = todoMapper.findTodoByMemberIdAndDateOrderByRegDate(searchedDate);
		return schedules;
	}
	// todo 등록 날짜기준 정렬
	@Override
	public List<TodoDto> findTodoByMemberIdOrderByRegDate(int mem_id_no) {
		List<TodoDto> schedules = todoMapper.findTodoByMemberIdOrderByRegDate(mem_id_no);
		return schedules;
	}
	//오늘할일 검색 
	@Override
	public List<TodoDto> searchTodoay(String today, int mem_id_no) {
		List<TodoDto> schedules = todoMapper.searchTodoay(today,mem_id_no);
		return schedules;
	}
	
	//오늘할일 등록순으로 검색 
	@Override
	public List<TodoDto> searchTodoayOrderByRegDate(String todaydate, int mem_id_no) {
		List<TodoDto> schedules = todoMapper.searchTodoayOrderByRegDate(todaydate,mem_id_no);
		return schedules;
	}

	//오늘할일 완료일짜순으로 검색 
	@Override
	public List<TodoDto> searchTodoayOrderByOrderByCompleteDate(String todaydate, int mem_id_no) {
		List<TodoDto> schedules = todoMapper.searchTodoayOrderByOrderByCompleteDate(todaydate,mem_id_no);
		return schedules;
	}
	
	//오늘할일 시작일짜순으로 검색 
	@Override
	public List<TodoDto> searchTodoayOrderByStartDate(String todaydate, int mem_id_no) {
		List<TodoDto> schedules = todoMapper.searchTodoayOrderByStartDate(todaydate,mem_id_no);
		return schedules;
	}

	//내용으로 검색 
	@Override
	public List<TodoDto> findTodoByMemberIdAndContent(TodoDto todo) {
		List<TodoDto> schedules = todoMapper.findTodoByMemberIdAndContent(todo);
		return schedules;
	}

	

}
