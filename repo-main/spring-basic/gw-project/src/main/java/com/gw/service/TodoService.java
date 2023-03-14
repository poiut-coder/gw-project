package com.gw.service;

import java.util.Date;
import java.util.List;

import com.gw.dto.TodoDto;

public interface TodoService {


void insertTodo(TodoDto todo);

List<TodoDto> findTodo();

void deleteTodo(int todo_no);

TodoDto findTodoByTodo_no(int todo_no);

void editTodo(TodoDto todo);

List<TodoDto> findTodoByMemberId(int mem_id_no);

List<TodoDto> findTodoByMemberIdAndTitle(TodoDto todo);

List<TodoDto> findTodoByMemberIdAndDateOrderByStartDate(TodoDto todo);

List<TodoDto> findTodoByMemberIdOrderByStartDate(int mem_id_no);

List<TodoDto> findTodoByMemberIdAndDateOrderByCompleteDate(TodoDto searchedDate);

List<TodoDto> findTodoByMemberIdOrderByCompleteDate(int mem_id_no);

List<TodoDto> findTodoByMemberIdAndDateOrderByRegDate(TodoDto searchedDate);

List<TodoDto> findTodoByMemberIdOrderByRegDate(int mem_id_no);

List<TodoDto> searchTodoay(String string, int mem_id_no);

List<TodoDto> searchTodoayOrderByRegDate(String todaydate, int mem_id_no);

List<TodoDto> searchTodoayOrderByOrderByCompleteDate(String todaydate, int mem_id_no);

List<TodoDto> searchTodoayOrderByStartDate(String todaydate, int mem_id_no);


List<TodoDto> findTodoByMemberIdAndContent(TodoDto todo);

}
