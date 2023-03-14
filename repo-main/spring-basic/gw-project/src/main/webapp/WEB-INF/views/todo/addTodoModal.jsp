<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.gw.dto.TodoDto"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="addTodoModal" tabindex="-1" role="dialog"
	aria-labelledby="addTodoModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="todoModalLabel">
					<b><p id="todo-no">일정 추가</p> </b>
				</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<form:form method="get" id="todo-add-form" modelAttribute="todo">
					<input type="hidden" id="writer" name="writer"
						value="${ loginuser.mem_id_no }" />
					<input type="hidden" id="event_colorAdd" name="event_color" value="#3c8dbc" />
						

					<div class="card-body pt-0">
						<div class="row">
							<div class="col-12">
								<p class="text-muted text-sm" id="todo-title">
									<b>제목 </b>
								</p>
								<input id="new-event" type="text" class="form-control"
									placeholder="Event Title" name="title" value=" "> <br>
								<div class="" style="margin-bottom: 10px;">
									<p>원하는 색을 클릭해주세요
									<ul class="fc-color-picker" id="color-chooser">
										<li style="color: #007bff"><a class="text-primary"><i
												class="fas fa-square" style="color: #007bff"></i></a></li>
										<li style="color: #ffc107 !important"><a
											class="text-warning"><i class="fas fa-square"
												style="color: #ffc107 !important"></i></a></li>
										<li style="color: green"><a class="text-success"><i
												class="fas fa-square" style="color: green"></i></a></li>
										<li style="color: rgb(167, 29, 42)"><a
											class="text-danger"><i class="fas fa-square"
												style="color: rgb(167, 29, 42)"></i></a></li>
										<li style="color: hotpink"><a class="text-muted"><i
												class="fas fa-square" style="color: hotpink"></i></a></li>

									</ul>

								</div>
								<div class="input-group-append title">
									<button style="opacity: 1;" id="add-new-event-add"
										class="btn btn-primary" disabled>color</button>

								</div>
								<p class="text-muted text-sm">
									시작 일자 : <select name="startYear" id="selectedYearAdd"
										class="selectedYear" data-todo-no="Add">

										<c:forEach var="i" begin="2022" end="2040">  
										<c:choose>
												<c:when test="${i== nowYear }">
													<!-- 현재 년도 선택  -->
													<option value=${i } selected>${i}년</option> 																	 
											</c:when>
												<c:otherwise>
													<option value=${i}>${i}년</option> 
											</c:otherwise>
											</c:choose>
										</c:forEach>
									</select> <select name="startMonth" id="selectedMonthAdd"
										class="selectedMonth" data-todo-no="Add">
										<c:forEach var="i" begin="1" end="12"> 
										<c:choose>
												<c:when test="${i== nowMonth  }">
													<option value=${i } selected>${i}월</option> 																	 
											</c:when>
												<c:otherwise>
													<option value=${i}>${i}월</option> 
											</c:otherwise>
											</c:choose>
										</c:forEach>
									</select> <select name="startDay" id="selectedDayAdd"
										class="selectedDay" data-todo-no="Add">
										<c:forEach var="i" begin="1" end="31">  
										<c:choose>
												<c:when test="${i== nowDay   }">
													<option value=${i } selected>${i}일</option> 																	 
											</c:when>
												<c:otherwise>
													<option value=${i}>${i}일</option> 
											</c:otherwise>
											</c:choose>
										</c:forEach>
									</select> <label for="start_date"></label> <input type="text"
										name="start_date" id="s_add" data-todo-no="Add"
										class="form-control start_date" placeholder="일자 미정"
										autocomplete="off"> <br> 완료 날짜 : <select
										name="completeYear" id="selectedcompleteYearAdd"
										class="selectedcompleteYear" data-todo-no="Add">
										<c:forEach var="i" begin="2022" end="2040">  
										<c:choose>
												<c:when test="${i== nowYear }">
													<!-- 현재 년도 선택  -->
													<option value=${i } selected>${i}년</option> 																	 
											</c:when>
												<c:otherwise>
													<option value=${i}>${i}년</option> 
											</c:otherwise>
											</c:choose>
										</c:forEach>
									</select> <select name="completeMonth" id="selectedcompleteMonthAdd"
										class="selectedcompleteMonth" data-todo-no="Add">
										<c:forEach var="i" begin="1" end="12">
											<c:choose>
												<c:when test="${i== nowMonth  }">
													<option value=${i } selected>${i}월</option> 																	 
											</c:when>
												<c:otherwise>
													<option value=${i}>${i}월</option> 
											</c:otherwise>
											</c:choose>
										</c:forEach>
									</select> <select class="selectedcompleteDay" name="completeDay"
										id="selectedcompleteDayAdd" data-todo-no="Add">
										<c:forEach var="i" begin="1" end="31">  
										<c:choose>
												<c:when test="${i== nowDay  }">
													<option value=${i } selected>${i}일</option> 																	 
											</c:when>
												<c:otherwise>
													<option value=${i}>${i}일</option> 
											</c:otherwise>
											</c:choose>
										</c:forEach>
									</select> <label for="complete_date"></label> <input type="text"
										name="complete_date" id="c_add"
										class="form-control complete_date " data-todo-no="Add"
										placeholder="일자 미정" autocomplete="off">

								</p>
								<p class="text-muted text-sm">
									<b>할일 설명 </b>
								</p>
								<textarea id="new-content" class="form-control" name="content"></textarea>
							</div>
						</div>
					</div>
					<!-- 버튼  -->
					<div id="buttons">

						<button type="submit" class="btn btn-primary btn-block"
							id="add-todo2">
							<i class="fas fa-plus"></i> Add todo
						</button>
					</div>
				</form:form>


			</div>

		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>

<script type="text/javascript">
	
	
	$(function(){
		
				
	});
	</script>

