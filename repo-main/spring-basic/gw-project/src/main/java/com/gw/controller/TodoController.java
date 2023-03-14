package com.gw.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gw.service.TodoService;
import com.gw.dto.MemberDto;
import com.gw.dto.TodoDto;

@Controller
@RequestMapping("/todo")

public class TodoController {

	@Autowired
	@Qualifier("todoService")
	private TodoService todoService;

//  todo todo_no로 검색 (home)
		@GetMapping(path = { "/loade-todoDto" }, produces="application/json;charset=utf-8")
		@ResponseBody
		public TodoDto loadeTodoDto(@RequestParam int todo_no, Model model) {
			System.out.println(" /loade-todoDto searchByNo todo get 실행 ");

				TodoDto todos = todoService.findTodoByTodo_no(todo_no);
				System.out.println(todos);


			return todos;
		}
	
	
	// todo list 출력
	@GetMapping(path = { "/list.action" })
	public String list(Model model, HttpSession session) throws Exception {
		session.setAttribute("searchedDate", null);
		session.setAttribute("todayTodoDate", null);
		//기존 데이터 초기화 
		
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int monthValue = now.getMonthValue();
		int dayOfMonth = now.getDayOfMonth();

		System.out.println("write get 실행 ");

		session.setAttribute("nowDay", dayOfMonth);
		session.setAttribute("nowMonth", monthValue);
		session.setAttribute("nowYear", year);

		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		if (member == null) {
			return "/home";
		}

		List<TodoDto> todos = todoService.findTodoByMemberId(member.getMem_id_no());

		model.addAttribute("todos", todos);
		return "todo/list";
	}

	// todo 검색
	@GetMapping(path = { "/searhByDate.action" })
	public String searchByDate(TodoDto todo, Model model, HttpSession session) {
		System.out.println("searchByDate todo get 실행 ");

		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		todo.setWriter(member.getMem_id_no());

		System.out.println(todo);

		if (todo.getTitle().equals("title")) {
			List<TodoDto> todos = todoService.findTodoByMemberIdAndTitle(todo);
			model.addAttribute("todos", todos);


		} else if (todo.getTitle().equals("content")) {
			List<TodoDto> todos = todoService.findTodoByMemberIdAndContent(todo);
			model.addAttribute("todos", todos);


		}


		session.setAttribute("searchedDate", todo);
		session.setAttribute("todayTodoDate", null);

		return "todo/list";
	}
	
	

	// 오늘 할일 검색
	@GetMapping(path = { "/searchTodoay.action" })
	public String searchTodoay(Model model, HttpSession session) throws Exception {
		System.out.println("searchTodoay get 실행 ");

		MemberDto member = (MemberDto) session.getAttribute("loginuser");

		List<TodoDto> todos = todoService.searchTodoay(todaydate(), member.getMem_id_no());
		model.addAttribute("todos", todos);

		session.setAttribute("todayTodoDate", "trues");

		session.setAttribute("searchedDate", null);

		return "todo/list";
	}

	// 시작 날짜순 정렬

	@GetMapping(path = { "/oderByStartDate.action" })
	public String oderByStartDate(Model model, HttpSession session) throws Exception {
		System.out.println("oderByStartDate get 실행 ");
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		System.out.println(member.getMem_id_no());

		TodoDto searchedDate = (TodoDto) session.getAttribute("searchedDate");
		System.out.println(searchedDate);

		String todayTodoDate = (String) session.getAttribute("todayTodoDate");
		System.out.println(todayTodoDate);

		if (searchedDate != null) {
			searchedDate.setWriter(member.getMem_id_no());

			List<TodoDto> todos = todoService.findTodoByMemberIdAndDateOrderByStartDate(searchedDate);
			model.addAttribute("todos", todos);

		} else if (todayTodoDate != null) {
			List<TodoDto> todos = todoService.searchTodoayOrderByStartDate(todaydate(), member.getMem_id_no());
			model.addAttribute("todos", todos);

		} else {
			List<TodoDto> todos = todoService.findTodoByMemberIdOrderByStartDate(member.getMem_id_no());
			model.addAttribute("todos", todos);

		}

		return "todo/list";
	}

	// 등록일짜순 정렬

	@GetMapping(path = { "/oderByRegDate.action" })
	public String oderByRegDate(Model model, HttpSession session) throws Exception {
		System.out.println("oderByStartDate get 실행 ");
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		System.out.println(member.getMem_id_no());

		TodoDto searchedDate = (TodoDto) session.getAttribute("searchedDate");
		System.out.println(searchedDate);

		String todayTodoDate = (String) session.getAttribute("todayTodoDate");

		if (searchedDate != null) {
			searchedDate.setWriter(member.getMem_id_no());

			List<TodoDto> todos = todoService.findTodoByMemberIdAndDateOrderByRegDate(searchedDate);
			model.addAttribute("todos", todos);

		} else if (todayTodoDate != null) {
			List<TodoDto> todos = todoService.searchTodoayOrderByRegDate(todaydate(), member.getMem_id_no());
			model.addAttribute("todos", todos);

		} else {
			List<TodoDto> todos = todoService.findTodoByMemberIdOrderByRegDate(member.getMem_id_no());
			model.addAttribute("todos", todos);

		}
		session.setAttribute("isAcs", true);

		return "todo/list";
	}

	// 완료일짜순 정렬
	@GetMapping(path = { "/oderByCompleteDate.action" })
	public String oderByCompleteDate(Model model, HttpSession session) throws Exception {
		System.out.println("oderByCompleteDate get 실행 ");
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		System.out.println(member.getMem_id_no());

		TodoDto searchedDate = (TodoDto) session.getAttribute("searchedDate");
		System.out.println(searchedDate);

		String todayTodoDate = (String) session.getAttribute("todayTodoDate");

		if (searchedDate != null) {
			searchedDate.setWriter(member.getMem_id_no());

			List<TodoDto> todos = todoService.findTodoByMemberIdAndDateOrderByCompleteDate(searchedDate);
			model.addAttribute("todos", todos);

		} else if (todayTodoDate != null) {
			// searchedDate.setWriter(member.getMem_id_no());
			List<TodoDto> todos = todoService.searchTodoayOrderByOrderByCompleteDate(todaydate(),
					member.getMem_id_no());
			model.addAttribute("todos", todos);

		} else {
			List<TodoDto> todos = todoService.findTodoByMemberIdOrderByCompleteDate(member.getMem_id_no());
			model.addAttribute("todos", todos);

		}
		session.setAttribute("isAcs", true);

		return "todo/list";
	}

	// delete
	@GetMapping(path = { "/delete.action" })
	@ResponseBody // 반환 값은 view 이름이 아니고 응답 컨텐츠 입니다.
	public String delete(@RequestParam int todo_no) {
		System.out.println("delete get 실행 " + todo_no);

		todoService.deleteTodo(todo_no);
		return "success";
	}

	// delete list
	@GetMapping(path = { "/delete-list.action" })
	public String delete_list() {
		System.out.println("delete list get 실행 ");

		return "todo/dList";
	}

	// edit
	@GetMapping(path = { "/edit.action" })
	public String edit_list(TodoDto todo, Model model, HttpSession session) {
		System.out.println("edit todo get 실행 ");
		MemberDto member = (MemberDto) session.getAttribute("loginuser");

		// 유효성 검사
		if ((todo.getStartYear() * 10000) + (todo.getStartMonth() * 100)
				+ (todo.getStartDay()) > (todo.getCompleteYear() * 10000) + (todo.getCompleteMonth() * 100)
						+ (todo.getCompleteDay())) {
			System.out.println("시작일자가 늦을 수 없습니다 ");
			model.addAttribute("fail_todo2", todo.getCompleteDay());
			List<TodoDto> todos = todoService.findTodoByMemberId(member.getMem_id_no());
			model.addAttribute("todos", todos);

			return "todo/list";
		}
		
		System.out.println(todo);

		todoService.editTodo(todo);
		
		return "redirect:list.action";
	}
	
	// edit ajax
		@GetMapping(path = { "/edit-ajax.action" })
		@ResponseBody
		public TodoDto edit_ajax(TodoDto todo) {
			System.out.println("edit todo ajax get 실행 ");
			int editTodo_no = Integer.parseInt(todo.getTodo_no());

			// 유효성 검사
			if ((todo.getStartYear() * 10000) + (todo.getStartMonth() * 100)
					+ (todo.getStartDay()) > (todo.getCompleteYear() * 10000) + (todo.getCompleteMonth() * 100)
							+ (todo.getCompleteDay())) {

				TodoDto todos = todoService.findTodoByTodo_no(editTodo_no);
				todos.setWriter(-1);

				System.out.println("시작일자가 늦을 수 없습니다 ");
				
				return todos;
			}
			
			todoService.editTodo(todo);
			TodoDto todos = todoService.findTodoByTodo_no(editTodo_no);

			return todos;
		}

	// 달력 출력
	@GetMapping(path = { "/calendar.action" })
	public String calender(@ModelAttribute("todo") TodoDto todo, Model model, HttpSession session,
			HttpServletRequest req) throws Exception {

		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int monthValue = now.getMonthValue();
		int dayOfMonth = now.getDayOfMonth();

		System.out.println("write get 실행 ");

		session.setAttribute("nowDay", dayOfMonth);
		session.setAttribute("nowMonth", monthValue);
		session.setAttribute("nowYear", year);

		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		

		List<TodoDto> todos = todoService.findTodoByMemberId(member.getMem_id_no());

		model.addAttribute("todos", todos);
		return "todo/calender";
	}

	// 일정 추가
	@PostMapping(path = { "/calendar.action" })
	public String addTodo(@Valid @ModelAttribute("todo") TodoDto todo, BindingResult br, Model model) {
		System.out.println("write 실행 ");
		if (br.hasErrors()) {
			return "todo/calender";

		}

		if ((todo.getStartYear() * 10000) + (todo.getStartMonth() * 100)
				+ (todo.getStartDay()) > (todo.getCompleteYear() * 10000) + (todo.getCompleteMonth() * 100)
						+ (todo.getCompleteDay())) {
			System.out.println("시작일자가 늦을 수 없습니다 ");
			model.addAttribute("fail_todo", todo.getCompleteDay());
			return "todo/calender";
		}

		Date now = new Date();
		todo.setRegDate(now);
		todo.setRegDate(now);
		
		
		todoService.insertTodo(todo);
		System.out.print(todo);
		
		System.out.print("calendar post 실행 ");
		return "redirect:calendar.action";
	}
	
	//home 에서 ajax로todo  생성 
	@GetMapping(path = { "/add-ajax.action" })
	@ResponseBody
	public TodoDto addTodoAtHome( @Valid @ModelAttribute("todo")TodoDto todo, Model model) {
		System.out.println("write at home2 실행 ");
		System.out.println(todo);


		if ((todo.getStartYear() * 10000) + (todo.getStartMonth() * 100)
				+ (todo.getStartDay()) > (todo.getCompleteYear() * 10000) + (todo.getCompleteMonth() * 100)
						+ (todo.getCompleteDay())) {
			System.out.println("시작일자가 늦을 수 없습니다 ");
			todo.setWriter(-1);		
			return todo;
		}

		Date now = new Date();
		todo.setRegDate(now);
		
		
		todoService.insertTodo(todo);
		
		System.out.print("add todo at home 실행 완료 ");
		System.out.print(todo);

		return todo;
	}

	public String todaydate() {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd ");
		Date today = new Date();

		return formatter.format(today);

	}

}
