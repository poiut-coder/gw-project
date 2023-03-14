<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.gw.dto.TodoDto"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Todo list</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<%-- <jsp:include page="/WEB-INF/views/modules/login-css.jsp" /> --%>
</head>

<body class="hold-transition sidebar-mini layout-fixed">
	<!-- Site wrapper -->
	<div class="wrapper">
	
	<!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="/gw-project/resources/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>
		<!-- Navbar -->
		<jsp:include page="/WEB-INF/views/modules/navbar.jsp" />

		<jsp:include page="/WEB-INF/views/modules/sidebar.jsp" />

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-9">
							<h1>Todo</h1>

							<form:form action="searhByDate.action" method="get"
								modelAttribute="todo">
							
								날짜로 검색 - 시작 날짜 
								<select name="startYear" id="selectedYear" class="selectedYear"
									data-todo-no="">

									<c:forEach var="i" begin="2022" end="2040">  
										<c:choose>
											<c:when test="${i== 2022 }">
												<!-- 현재 년도 선택  -->
												<option value=${i } selected>${i}년</option> 																	 
											</c:when>
											<c:otherwise>
												<option value=${i}>${i}년</option> 
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								<select name="startMonth" id="selectedMonth"
									class="selectedMonth" data-todo-no="">
									<c:forEach var="i" begin="1" end="12"> 
										<c:choose>
											<c:when test="${i== 1 }">
												<option value=${i } selected>${i}월</option> 																	 
											</c:when>
											<c:otherwise>
												<option value=${i}>${i}월</option> 
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								<select name="startDay" id="selectedDay" class="selectedDay" data-todo-no=""> 
									<c:forEach var="i" begin="1" end="31">  
										<c:choose>
											<c:when test="${i== 1  }">
												<option value=${i } selected>${i}일</option> 																	 
											</c:when>
											<c:otherwise>
												<option value=${i}>${i}일</option> 
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								<label for="start_date"></label>
								<input type="text" name="start_date" id="s"
									class="form-control start_date" placeholder="일자 미정" autocomplete="off">
								
								
								
								
								 ~ 완료 날짜
								 <select name="completeYear" id="selectedcompleteYear"
									class="selectedcompleteYear" data-todo-no="">
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
								</select>
								<select name="completeMonth" id="selectedcompleteMonth"
									class="selectedcompleteMonth" data-todo-no="">
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
								</select>

								<select class="selectedcompleteDay" name="completeDay"
									id="selectedcompleteDay" data-todo-no="">
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
								</select>
								<label for="complete_date"></label>
								<input type="text" name="complete_date" id="c"
									 class="form-control complete_date "
									placeholder="일자 미정" autocomplete="off">


								<button type="submit" class="btn btn-lg btn-default">
									<i class="fa fa-search"></i>
								</button>
								<br>
								<form:errors path="title" class="error" />
								<br>
								<select id="selectSearchType" name="title">
									<option value="title">제목으로 검색</option> 
									<option value="content">내용으로 검색</option> 
								</select>
								<div class="form-group">
									<div class="input-group input-group-lg">
										<c:choose>
											<c:when test="${not empty searchedDate.content }">
												<input type="search" class="form-control form-control-lg"
													placeholder="Type your keywords here" name="content"
													value="${ searchedDate.content }">
											</c:when>

											<c:otherwise>
												<input type="search" class="form-control form-control-lg"
													placeholder="Type your keywords here" name="content">

											</c:otherwise>
										</c:choose>


									</div>
								</div>

							</form:form>

							<!-- 검색버튼  -->
							<br>


							<div>
								<input type="button" id="oderByStartDate" value="시작날짜순으로 정렬 " />
								<input type="button" id="oderByCompleteDate" value="완료날짜순으로 정렬 " />
								<input type="button" id="oderByRegDate" value="등록순으로 정렬 " /> <input
									type="button" id="searchEverything" value="모든 스케줄 보기  " /> <input
									type="button" id="searchTodoay" value="오늘 스케줄 보기  " />
							</div>

						</div>
						<div class="col-sm-3">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">Contacts</li>
							</ol>
						</div>
					</div>
					<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">

				<!-- Default box -->
				<div class="card card-solid">
					<div class="card-body pb-0">
						<div class="row">

							<!-- todo list 출력  -->

							<c:forEach var="todo" items="${ todos }">
								<div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column"
									id="todo-list${ todo.todo_no }">
									<form action="edit.action" method="get">
										<input type="hidden" id="event_color${ todo.todo_no }" name="event_color" value="${ todo.event_color }" />
										
										<input type="hidden" name="todo_no" value=${ todo.todo_no }>
										<div class="card bg-light d-flex flex-fill">
											<div class="card-header text-muted border-bottom-0">
												<h5>
													<b>일정 번호 : ${ todo.todo_no } </b>
												</h5>
											</div>
											<div class="card-body pt-0">
												<div class="row">
													<div class="col-12">
														<p class="text-muted text-sm">
															<b>제목 </b>
														</p>
														<input id="new-event" type="text" class="form-control"
															placeholder="Event Title" name="title"
															value=${ todo.title }> <br>
															
														<div class="" style=" margin-bottom: 10px;">
															<ul class="fc-color-picker" id="color-chooser${ todo.todo_no }" data-todo-no=${todo.todo_no }>
																<li style="color: #007bff"  data-todo-no=${todo.todo_no }><a class="text-primary"  ><i 
																		class="fas fa-square"  style="color: #007bff"></i></a></li>
																<li style="color: #ffc107!important"  data-todo-no=${todo.todo_no }><a class="text-warning" ><i
																		class="fas fa-square"  style="color: #ffc107!important"></i></a></li>
																<li style="color: green"  data-todo-no=${todo.todo_no }><a class="text-success"><i
																		class="fas fa-square"  style="color: green"></i></a></li>
																<li style="color:  rgb(167, 29, 42)"  data-todo-no=${todo.todo_no }><a class="text-danger"><i
																		class="fas fa-square"  style="color:  rgb(167, 29, 42)"></i></a></li>
																<li style="color: hotpink"  data-todo-no=${todo.todo_no }><a class="text-muted" ><i 
																		class="fas fa-square"  style="color: hotpink"></i></a></li>
															</ul>
														</div>
														<c:choose>
															<c:when test="${ not empty  todo.event_color  }">
																<div class="input-group-append title">
																	<button style = " opacity: 1; background-color: ${ todo.event_color };border-color: ${ todo.event_color };" id="add-new-event${ todo.todo_no }" class="btn btn-primary" disabled >color</button>
																</div>			
															</c:when>
															<c:otherwise>
																<div class="input-group-append title">
																	<button style = " opacity: 1; background-color: #3c8dbc;border-color: #3c8dbc;" id="add-new-event${ todo.todo_no }" class="btn btn-primary" disabled >color</button>
																</div>	
															</c:otherwise>
														</c:choose>
														<br>
										
														<p class="text-muted text-sm">
															시작 일자 : <select name="startYear"
																id="selectedYear${todo.todo_no }" class="selectedYear"
																data-todo-no=${todo.todo_no }>
																<c:forEach var="i" begin="2022" end="2040">  
																	<c:choose>
																		<c:when test="${i== todo.startYear }">
																			<option value=${i } selected>${i}년</option> 																	 
																		</c:when>
																		<c:otherwise>
																			<option value=${i}>${i}년</option> 
																		 </c:otherwise>
																	</c:choose>
																</c:forEach>
															</select> &nbsp; 
															<select name="startMonth" id="selectedMonth${todo.todo_no }" class="selectedMonth"
																data-todo-no=${todo.todo_no }>
																<c:forEach var="i" begin="1" end="12">  
																	<c:choose>
																		<c:when test="${i== todo.startMonth}">
																			<option value=${i } selected>${i}월</option> 																	 
																		</c:when>
																		<c:otherwise>
																			<option value=${i}>${i}월</option> 
																		</c:otherwise>
																	</c:choose>
																</c:forEach>
															</select> &nbsp; 
															<select name="startDay" id="selectedDay${todo.todo_no }" class="selectedDay" data-todo-no=${todo.todo_no }>
																<c:forEach var="i" begin="1" end="31">  
																			<c:choose>
																		<c:when test="${i== todo.startDay }">
																			<option value=${i } selected>${i}일</option> 																	 
																				</c:when>
																		<c:otherwise>
																			<option value=${i}>${i}일</option> 
																				 </c:otherwise>
																	</c:choose>
																</c:forEach>
															</select> <label for="start_date" data-todo-no=${todo.todo_no }></label>
															<input type="text" data-todo-no=${todo.todo_no } 
															name="start_date" id="s${todo.todo_no }" class="form-control start_date" 
															placeholder="일자 미정" autocomplete="off"> 
															<br>완료 일자 : 
															<select name="completeYear"
																id="selectedcompleteYear${todo.todo_no }"
																class="selectedcompleteYear"
																data-todo-no=${todo.todo_no }>
																<c:forEach var="i" begin="2022" end="2040">  		
																	<c:choose>
																		<c:when test="${i== todo.completeYear }">
																			<option value=${i } selected>${i}년</option> 																	 
																		</c:when>
																		<c:otherwise>
																			<option value=${i}>${i}년</option> 
																		 </c:otherwise>
																	</c:choose>
																</c:forEach>
															</select> &nbsp; 
															<select name="completeMonth"
																id="selectedcompleteMonth${todo.todo_no }"
																class="selectedcompleteMonth"
																data-todo-no=${todo.todo_no }>
																<c:forEach var="i" begin="1" end="12">  
																	<c:choose>
																		<c:when test="${i== todo.completeMonth }">
																			<option value=${i } selected>${i}월</option> 																	 
																		</c:when>
																		<c:otherwise>
																			<option value=${i}>${i}월</option> 
																		 </c:otherwise>
																	</c:choose>
																</c:forEach>
															</select> &nbsp; 
															<select name="completeDay"
																id="selectedcompleteDay${todo.todo_no }"
																class="selectedcompleteDay" data-todo-no=${todo.todo_no }>
																<c:forEach var="i" begin="1" end="31">  
																	<c:choose>
																		<c:when test="${i== todo.completeDay }">
																			<option value=${i } selected>${i}일</option> 																	 
																		</c:when>
																		<c:otherwise>
																			<option value="${i}">${i}일</option> 
																		 </c:otherwise>
																	</c:choose>
																</c:forEach>
															</select> 
															
															 <label for="complete_date" data-todo-no=${todo.todo_no }></label>
															<input type="text" data-todo-no=${todo.todo_no } 
															name="complete_date" id="c${todo.todo_no }" class="form-control complete_date" 
															placeholder="일자 미정" autocomplete="off"> 
														</p>
														<p class="text-muted text-sm">
															<b>할일 설명 </b>
														</p>
														<textarea id="new-event" class="form-control"
															name="content">${ todo.content}</textarea>
													</div>
												</div>
											</div>
											<div class="card-footer">
												<div class="text-right">
													<!-- 버튼  -->
													<button type="submit" class="btn btn-block btn-info btn-xs"
														id="edit_button" data-todo-no="${ todo.todo_no }">
														<i class="fas fa-pencil-alt"></i>&nbsp;Edit
													</button>
													<button type="button"
														class="btn btn-block btn-danger btn-xs" id="delete_button"
														data-todo-no="${ todo.todo_no }">
														<i class="fas fa-trash"></i>&nbsp;Delete
													</button>
												</div>
											</div>
										</div>
									</form>
								</div>

							</c:forEach>
						</div>
					</div>
					<div class="card-footer">
						<nav aria-label="Contacts Page Navigation">
							<ul class="pagination justify-content-center m-0">
								<li class="page-item active"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#">4</a></li>
								<li class="page-item"><a class="page-link" href="#">5</a></li>
								<li class="page-item"><a class="page-link" href="#">6</a></li>
								<li class="page-item"><a class="page-link" href="#">7</a></li>
								<li class="page-item"><a class="page-link" href="#">8</a></li>
							</ul>
						</nav>
					</div>
					<!-- /.card-footer -->
				</div>
				<!-- /.card -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<footer class="main-footer">
			<div class="float-right d-none d-sm-block">
				<b>Version</b> 3.2.0
			</div>
			<strong>Copyright &copy; 2014-2021 <a
				href="https://adminlte.io">AdminLTE.io</a>.
			</strong> All rights reserved.
		</footer>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Control sidebar content goes here -->
		</aside>
		<!-- /.control-sidebar -->
	</div>
	<!-- ./wrapper -->
	<jsp:include page="/WEB-INF/views/modules/footer.jsp" />

	<jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />

	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

	<!-- ./시작 날짜 설랙션 출력 js -->

	<jsp:include page="/WEB-INF/views/todo/startDateSelection-js.jsp" />

	<!-- ./완 날짜 설랙션 출력 js -->

	<jsp:include page="/WEB-INF/views/todo/completeDateSelection-js.jsp" />
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script>
		$(function() {
			<c:if test ="${not empty fail_todo2}">
			alert("시작일자가 완료일자보다 더 늦을 수 없습니다 ")
			</c:if>

			<c:if test ="${not empty searchedDate}">
			$(".col-sm-9 #selectedYear").val("${searchedDate.startYear}").prop(
					"selected", true); //값이 1인 option 선택
			$(".col-sm-9 #selectedMonth").val("${searchedDate.startMonth}")
					.prop("selected", true); //값이 1인 option 선택
			$(".col-sm-9 #selectedDay").val("${searchedDate.startDay}").prop(
					"selected", true); //값이 1인 option 선택
			$(".col-sm-9 #selectedcompleteYear").val(
					"${searchedDate.completeYear}").prop("selected", true); //값이 1인 option 선택
			$(".col-sm-9 #selectedcompleteMonth").val(
					"${searchedDate.completeMonth}").prop("selected", true); //값이 1인 option 선택
			$(".col-sm-9 #selectedcompleteDay").val(
					"${searchedDate.completeDay}").prop("selected", true); //값이 1인 option 선택 
			<c:if test ="${searchedDate.title eq 'title'}">
			$("#selectSearchType").val('title').prop("selected", true); //값이 1인 option 선택
			</c:if>
			<c:if test ="${ searchedDate.title eq 'content'}">
			$("#selectSearchType").val('content').prop("selected", true); //값이 1인 option 선택
			</c:if>
			</c:if>

			// date picker
			$.datepicker.setDefaults({
				dateFormat : 'yyyy-mm-dd',
				prevText : '이전 달',
				nextText : '다음 달',
				monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
						'9월', '10월', '11월', '12월' ],
				monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월',
						'8월', '9월', '10월', '11월', '12월' ],
				dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
				dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
				showMonthAfterYear : true,
				yearSuffix : '년'
			});

			   $('.start_date').datepicker({
								showOn : 'button',
								onSelect : function() {
									var todo_no = $(this).attr('id').substr(1);
									date = $(this).datepicker('getDate'),

									day = date.getDate(), month = date
											.getMonth() + 1, year = date
											.getFullYear();
									$("#selectedDay"+todo_no).val(day).prop("selected",
											true); // option 선택
									$("#selectedMonth"+todo_no).val(month).prop(
											"selected", true); //option 선택
									$("#selectedYear"+todo_no).val(year).prop(
											"selected", true); // option 선택

								}
							}); 
			  
							
							$('.complete_date').datepicker({
								showOn : 'button',
								onSelect : function() {
									var todo_no = $(this).attr('id').substr(1);//기존 datepicker의 아이디에 구변을 위해c를넣줬었음 
									date = $(this).datepicker('getDate'),

									day = date.getDate(), month = date
											.getMonth() + 1, year = date
											.getFullYear();
									$("#selectedcompleteDay"+todo_no).val(day).prop("selected",
											true); // option 선택
									$("#selectedcompleteMonth"+todo_no).val(month).prop(
											"selected", true); //option 선택
									$("#selectedcompleteYear"+todo_no).val(year).prop(
											"selected", true); // option 선택

								}
							}); 		
							
			

			$('.start_date').css('display', 'none');
			$('.complete_date').css('display', 'none');

			//삭제 버튼 구현
			//	$('#delete_button').on('click', function(event) {틀린구문 :아이디로 선택하면 하나의 객체만 선택됨 --->>>클레스 사용 
			$('.btn-danger').on(
					'click',
					function(event) {
						//alert("sss");
						var todo_no = $(this).data('todo-no');
						event.preventDefault();
						const yn = confirm(todo_no + "번 할일을 삭제하겠습니까?");
						if (!yn)
							return;
						//삭제 
						$.ajax({
							"url" : "delete.action",//해당 컨트롤러에서 리턴값으로success를 받
							"method" : "get",
							"data" : 'todo_no=' + todo_no,//지정된 변
							"success" : function(data, status, xhr) {
								if (data == "success") {
									alert(todo_no + "번 글을 삭제합니다 ")
									$('#todo-list' + todo_no).attr('class',
											'class_name');
									$('#todo-list' + todo_no).load(
											"delete-list.action");
									$('#todo-list' + todo_no).empty();// 일 선택자 초기화 

								} else {
									alert('삭제실패 2')//컨트롤러 오작
								}

							},
							"error" : function(xhr, status, err) {
								alert('삭제실패 1')

							}
						})
					})
					
			var currColor = '#3c8dbc' //Red by default

			$('.fc-color-picker > li ').click(function(e) {
			
				e.preventDefault()
				// Save color
				currColor = $(this).css('color')
				var todo_no = $(this).data('todo-no');
				
				// Add color effect to button
				$('#add-new-event'+todo_no).css({
					'background-color' : currColor,
					'border-color' : currColor
				})

				$('#event_color'+todo_no).attr("value",currColor);
			})

			//모든 일정 보기 
			$('#searchEverything').on('click', function(event) {
				location.href = "/gw-project/todo/list.action";

			})

			//시작일짜 순으로 일정 보기
			$('#oderByStartDate').on('click', function(event) {
				location.href = "/gw-project/todo/oderByStartDate.action";
			})

			//완료일짜 순으로 일정 보기
			$('#oderByCompleteDate').on('click', function(event) {
				location.href = "/gw-project/todo/oderByCompleteDate.action";
			})

			//등록일짜 순으로 일정 보기
			$('#oderByRegDate').on('click', function(event) {
				location.href = "/gw-project/todo/oderByRegDate.action";
			})

			//오늘 일정 보기
			$('#searchTodoay').on('click', function(event) {
				location.href = "/gw-project/todo/searchTodoay.action";
			})

		})
	</script>
</body>
</html>
