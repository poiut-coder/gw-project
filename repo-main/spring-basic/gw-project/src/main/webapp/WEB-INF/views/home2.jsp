<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@page import="com.gw.dto.TodoDto"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Project Demo Web</title>
	<link rel="stylesheet"
		  href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
	<link rel="stylesheet" href="/gw-project/resources/plugins/fullcalendar/main.css">
	<style>
		#todo-list {
			overflow: scroll;
			height: 200px;
		}
	</style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

	<!-- Preloader -->
	<div
			class="preloader flex-column justify-content-center align-items-center">
		<img class="animation__shake"
			 src="/gw-project/resources/dist/img/AdminLTELogo.png"
			 alt="AdminLTELogo" height="60" width="60">
	</div>
	<!-- Navbar -->
	<jsp:include page="/WEB-INF/views/modules/navbar.jsp" />
	<!-- /.navbar -->
<%--	<jsp:include page="/WEB-INF/views/modules/header.jsp" />--%>
	<!-- header 추가 예정 -->
	<!-- /header -->

	<!-- Main Sidebar Container -->
	<jsp:include page="/WEB-INF/views/modules/sidebar.jsp" />
	<!-- /.Main Sidebar Container -->

	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">


		<!-- Main content -->
		<section class="content">
			<div class="container-fluid">
				<!-- Content Header (Page header) -->
				<jsp:include page="/WEB-INF/views/modules/content-header.jsp" />
				<!-- /.content-header -->
				<div class="row">
					<section class="col-lg-7 connectedSortable">
						<div class="card">
							<div class="card-header">
								<h3 class="card-title">
									<i class="ion ion-clipboard mr-1"></i> Todays To Do List
								</h3>


							</div>
							<!-- /.card-header -->
							<div class="card-body">
								<ul class="todo-list" data-widget="todo-list" id="todo-list">
									<c:choose>
										<c:when test="${ not empty todos }">
											<c:forEach var="todo" items="${todos }">
												<li id="todo-list${ todo.todo_no }"><span class="handle">
												<c:choose>
													<c:when test="${ not empty  todo.event_color  }">
														<div id="event_color${ todo.todo_no }" class="fas fa-square" style="color: ${ todo.event_color };"></div>
													</c:when>
													<c:otherwise>
														<div class="fas fa-square" style="color: #3c8dbc;"></div>

													</c:otherwise>
												</c:choose>
											</span> <!-- checkbox --> <!-- todo text -->
													<span class="text" id="todo-title${ todo.todo_no }"> ${ todo.title }  </span> <!-- Emphasis label -->
													<small class="badge badge-danger">
														<i class="far fa-clock"></i>d-day: <span id="todo-day${ todo.todo_no }">${ todo.completeYear }년  ${ todo.completeMonth }월 ${ todo.completeDay }일</span>
													</small>


													<!-- General tools such as edit or delete-->
													<a class="btn-danger "  data-todo-no=${todo.todo_no } >
														<div class="tools">
															삭제 <i class="far fa-trash-alt"></i>
														</div>
													</a>
													<a data-toggle="modal" href="#todoModal" class="edit-todo " id="edit-todo" data-todo-no=${todo.todo_no }>
														<div class="tools " style="color: #000000;">
															편집
															<i class="fas fa-edit"></i>
															<i class="fas fa-trash-o"></i>
														</div>
													</a>
												</li>
											</c:forEach>

										</c:when>
										<c:otherwise>
											<div>비어있습니다</div>
										</c:otherwise>
									</c:choose>



								</ul>
							</div>
							<!-- /.card-body -->
							<div class="card-footer clearfix" >
								<button type="button" class="btn btn-primary float-right" id="add-todo" data-toggle="modal"
										data-target="#addTodoModal">
									<i class="fas fa-plus"></i> Add todo
								</button>
							</div>
						</div>

						<jsp:include page="/WEB-INF/views/project/home-myproject.jsp" />

					</section>



					<section class="col-lg-5 connectedSortable">
						<jsp:include page="/WEB-INF/views/modules/home-attendance.jsp" />
						<jsp:include page="/WEB-INF/views/modules/home-calendar.jsp" />
					</section>



				</div>
			</div>
			<!-- /.container-fluid -->
		</section>
		<!-- /.content -->
	</div>
	<!-- /.modal for todo 추후에 jsp:include 예정  -->


	<!-- Modal -->
	<div class="modal fade" id="todoModal" tabindex="-1" role="dialog"
		 aria-labelledby="todoModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="todoModalLabel">
						<b><p id="todo-no"></p> </b>
					</h5>
					<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form  method="get" id="todo-form">
						<input type="hidden" name="todo_no" value="s" id="inputTodo_no">
						<input type="hidden" id="event_color" name="event_color" value="#3c8dbc" />

						<div class="card-body pt-0">
							<div class="row">
								<div class="col-12">
									<p class="text-muted text-sm" id="todo-title">
										<b>제목 </b>
									</p>

									<input id="new-event" type="text" class="form-control"
										   placeholder="Event Title" name="title" value=${ todo.title }>
									<br>
									<div class=""
										 style=" margin-bottom: 10px;">
										<p>원하는 색을 클릭해주세요
										<ul class="fc-color-picker" id="color-chooser">
											<li style="color: #007bff"><a class="text-primary" ><i
													class="fas fa-square"  style="color: #007bff"></i></a></li>
											<li style="color: #ffc107!important"><a class="text-warning"><i
													class="fas fa-square"  style="color: #ffc107!important"></i></a></li>
											<li style="color: green"><a class="text-success" ><i
													class="fas fa-square"  style="color: green"></i></a></li>
											<li style="color:  rgb(167, 29, 42)"><a class="text-danger" ><i
													class="fas fa-square"  style="color:  rgb(167, 29, 42)"></i></a></li>
											<li style="color: hotpink"><a class="text-muted"><i
													class="fas fa-square"  style="color: hotpink"></i></a></li>

										</ul>

									</div>
									<div class="input-group-append title">
										<button style = " opacity: 1;" id="add-new-event" class="btn btn-primary" disabled>color</button>

									</div>

									<p class="text-muted text-sm">
										시작 일자 : <select name="startYear"
														id="selectedYear" class="selectedYear"
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
										<select name="startMonth" id="selectedMonth" class="selectedMonth"
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
										<select name="startDay" id="selectedDay" class="selectedDay" data-todo-no=${todo.todo_no }>
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
										</select> <label for="start_date" data-todo-no=${todo.todo_no } ></label>
										<input type="text" data-todo-no=${todo.todo_no }
												name="start_date" id="start_date_modal" class="form-control start_date"
											   placeholder="일자 미정" autocomplete="off">
										<br>완료 일자 :
										<select name="completeYear"
												id="selectedcompleteYear"
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
												id="selectedcompleteMonth"
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
												id="selectedcompleteDay"
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
												name="complete_date" id="complete_date" class="form-control complete_date"
											   placeholder="일자 미정" autocomplete="off">
									</p>
									<p class="text-muted text-sm">
										<b>할일 설명 </b>
									</p>
									<textarea id="new-content" class="form-control" name="content">${ todo.content}</textarea>
								</div>
							</div>
						</div>
						<!-- 버튼  -->
						<div id="buttons">
							<button type="submit" class="btn btn-block btn-info btn-xs edit_button2"
									id="edit_button" data-todo-no="${ todo.todo_no }">
								<i class="fas fa-pencil-alt"></i>&nbsp;Edit
							</button>
							<button type="button" class="btn btn-block btn-danger btn-xs"
									id="delete_button" data-todo-no="${ todo.todo_no }">
								<i class="fas fa-trash"></i>&nbsp;Delete
							</button>
						</div>
					</form>


				</div>

			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/todo/addTodoModal.jsp" />

	<!-- /.content-wrapper -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
	<!-- /.footer -->

	<!-- Control Sidebar -->
	<jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
	<!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />

<!-- ./시작 날짜 설랙션 출력 js -->

<jsp:include page="/WEB-INF/views/todo/startDateSelection-js.jsp" />

<!-- ./완 날짜 설랙션 출력 js -->

<jsp:include page="/WEB-INF/views/todo/completeDateSelection-js.jsp" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="/gw-project/resources/plugins/fullcalendar/main.js"></script>

<script type="text/javascript" >


	$(function(){


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
		$('.edit-todo').on('click', function(event){
			var todo_no=$(this).data('todo-no');
			var todo=null;
			var todo_content=null;

			$.ajax({
				"url" : "todo/loade-todoDto?todo_no="+todo_no,
				"method" : "get",
				"dataType" : "json",
				"success" : function(data, status, xhr) {


					$('#new-event').val(data.title);
					$('#new-content').val(data.content);
					$('#todo-no').text('일정번호 : '+data.todo_no);

					$("#selectedYear").val(data.startYear).prop( "selected", true); //값이 1인 option 선택
					$("#selectedMonth").val(data.startMonth).prop("selected", true); //값이 1인 option 선택
					$("#selectedDay").val(data.startDay).prop("selected", true); //값이 1인 option 선택
					$("#selectedcompleteYear").val(data.completeYear).prop("selected", true); //값이 1인 option 선택
					$("#selectedcompleteMonth").val(data.completeMonth).prop("selected", true); //값이 1인 option 선택
					$("#selectedcompleteDay").val(data.completeDay).prop("selected", true); //값이 1인 option 선택 

					$('#delete_button').attr('data-todo-no', data.todo_no)
					$('#delete_button').data('todo-no', data.todo_no);
					$('.edit_button2').data('todo-no', data.todo_no);

					$('#inputTodo_no').val(data.todo_no)

					$('#add-new-event').css({
						'background-color' : data.event_color,
						'border-color' : data.event_color
					})


				},
				"error" : function(xhr, status, err) {
					alert('편집 실패 1')

				}
			})



		});


		$('#add-todo').on('click', function(event){
			$("#selectedYearAdd").val(${nowYear}).prop( "selected", true); //값이 1인 option 선택
			$("#selectedMonthAdd").val(${nowMonth}).prop("selected", true); //값이 1인 option 선택
			$("#selectedDayAdd").val(${nowDay}).prop("selected", true); //값이 1인 option 선택
			$("#selectedcompleteYearAdd").val(${nowYear}).prop("selected", true); //값이 1인 option 선택
			$("#selectedcompleteMonthAdd").val(${nowMonth}).prop("selected", true); //값이 1인 option 선택
			$("#selectedcompleteDayAdd").val(${nowDay}).prop("selected", true); //값이 1인 option 선택

		});





		$('.start_date').datepicker({
			showOn : 'button',
			onSelect : function() {
				var todo_no = $(this).attr('id');
				date = $(this).datepicker('getDate'),

						day = date.getDate(), month = date
						.getMonth() + 1, year = date
						.getFullYear();
				$("#selectedDay").val(day).prop("selected",
						true); // option 선택
				$("#selectedMonth").val(month).prop(
						"selected", true); //option 선택
				$("#selectedYear").val(year).prop(
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
				$("#selectedcompleteDay").val(day).prop("selected",
						true); // option 선택
				$("#selectedcompleteMonth").val(month).prop(
						"selected", true); //option 선택
				$("#selectedcompleteYear").val(year).prop(
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
					var tagId = $(this).attr('id');
					var todo_no = $(this).data('todo-no');
					event.preventDefault();
					const yn = confirm(todo_no + "번 할일을 삭제하겠습니까?");
					if (!yn)
						return;
					//삭제 
					$.ajax({
						"url" : "todo/delete.action",//해당 컨트롤러에서 리턴값으로success를 받
						"method" : "get",
						"data" : 'todo_no=' + todo_no,//지정된 변
						"success" : function(data, status, xhr) {
							if (data == "success") {
								alert(todo_no + "번 글을 삭제합니다 ")

								$( '#todo-list' + todo_no).remove();
								$('#todoModal').modal('hide')


							} else {
								alert('삭제실패 2')//컨트롤러 오작
							}

						},
						"error" : function(xhr, status, err) {
							alert('삭제실패 1')

						}
					})
				})

		//ajax 로 edit 
		$('.edit_button2').on(
				'click',
				function(event) {
					//alert("sss");
					var todo = $("#todo-form").serialize() ;

					var tagId = $(this).attr('id');
					var todo_no = $(this).data('todo-no');
					event.preventDefault();
					const yn = confirm(todo_no + "번 할일을 편집하겠습니까?");
					if (!yn)
						return;
					//삭제 
					$.ajax({
						"url" : "todo/edit-ajax.action",//해당 컨트롤러에서 리턴값으로success를 받
						"method" : "get",
						"data" : todo,//지정된 변
						"success" : function(data, status, xhr) {
							if(data.writer==-1){
								$("#selectedYear").val(data.startYear).prop( "selected", true); //값이 1인 option 선택
								$("#selectedMonth").val(data.startMonth).prop("selected", true); //값이 1인 option 선택
								$("#selectedDay").val(data.startDay).prop("selected", true); //값이 1인 option 선택
								$("#selectedcompleteYear").val(data.completeYear).prop("selected", true); //값이 1인 option 선택
								$("#selectedcompleteMonth").val(data.completeMonth).prop("selected", true); //값이 1인 option 선택
								$("#selectedcompleteDay").val(data.completeDay).prop("selected", true); //값이 1인 option 선택 
								alert("시작일자가 늦을 수 없습니다 ");
								$('#todoModal').modal('show');


							}else{
								var Date= data.completeYear+ "년 "+ data.completeMonth+"월 " + data.completeDay+"일 ";
								$("#todo-title"+data.todo_no).html(data.title);
								$("#todo-day"+data.todo_no).html(Date);
								$('#event_color'+data.todo_no).css({
									'color' : data.event_color,
									'border-color' : data.event_color
								})
								$('#todoModal').modal('hide');
							}
						},
						"error" : function(xhr, status, err) {
							alert('시작일자가 늦을 수 없습니다 ');

						}
					})
				})
		var currColor = '#3c8dbc' //Red by default

		$('#color-chooser > li ').click(function(e) {
			e.preventDefault()
			// Save color
			currColor = $(this).css('color')
			// Add color effect to button
			$('#add-new-event').css({
				'background-color' : currColor,
				'border-color' : currColor
			})

			$('#event_color').attr("value",currColor);
		})


		$('#s_add').datepicker({
			showOn : 'button',
			onSelect : function() {
				date = $(this).datepicker('getDate'),

						day = date.getDate(), month = date
						.getMonth() + 1, year = date
						.getFullYear();
				$("#selectedDayAdd").val(day).prop("selected",
						true); // option 선택
				$("#selectedMonthAdd").val(month).prop(
						"selected", true); //option 선택
				$("#selectedYearAdd").val(year).prop(
						"selected", true); // option 선택

			}
		});


		$('#c_add').datepicker({
			showOn : 'button',
			onSelect : function() {
				var todo_no = $(this).attr('id').substr(1);//기존 datepicker의 아이디에 구변을 위해c를넣줬었음 
				date = $(this).datepicker('getDate'),

						day = date.getDate(), month = date
						.getMonth() + 1, year = date
						.getFullYear();
				$("#selectedcompleteDayAdd").val(day).prop("selected",
						true); // option 선택
				$("#selectedcompleteMonthAdd").val(month).prop(
						"selected", true); //option 선택
				$("#selectedcompleteYearAdd").val(year).prop(
						"selected", true); // option 선택

			}
		});


		//ajax 로 add 
		$('#add-todo2').on(
				'click',
				function(event) {
					var todo = $("#todo-add-form").serialize() ;
					//삭제 
					$.ajax({
						"url" : "todo/add-ajax.action",//해당 컨트롤러에서 리턴값으로success를 받
						"method" : "get",
						"data" : todo,//지정된 변
						"success" : function(data, status, xhr) {
							if(data!="-1"){

								$('#addTodoModal').modal('hide');

							}else if(data =="-1"){
								alert('시작일자가 늦을 수 없습니다 ');
							}
						},
						"error" : function(xhr, status, err) {

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
			$('#add-new-event-add').css({
				'background-color' : currColor,
				'border-color' : currColor
			})

			$('#event_colorAdd').attr("value",currColor);
		})


		//캘린더
		var Calendar = FullCalendar.Calendar;
		var calendarEl = document.getElementById('calendar');

		var calendar = new Calendar(calendarEl, {
			headerToolbar: {
				left  : '',
				center: 'title',
				right : ''
			},
			themeSystem: 'bootstrap'
		});

		calendar.render();


		//출근
		$('#attd_on').on('click',function() {

			const ok = confirm("출근 하시겠습니까?");
			if (!ok)
				return;

			<c:if test="${not empty at}">
			alert("이미 출근 했습니다.");
			return;
			</c:if>

			location.href='attd_on';
		})

		//퇴근
		$('#attd_off').on('click',function() {

			const ok = confirm("퇴근 하시겠습니까?");
			if (!ok)
				return;

			<c:if test="${empty at}">
			alert("출근 정보가 없습니다.");
			return;
			</c:if>

			<c:if test="${not empty at.attd_off}">
			alert("이미 퇴근 했습니다.");
			return;
			</c:if>

			location.href='attd_off';
		})

		// 프로젝트 이름 css
		$('a[id^=proTitle]').css({
			"color" : "white"
		});

		$('a[id^=proTitle]').on('mouseover',function(event) {
			$(this).css({
				"color" : "black"
			})
		})

		$('a[id^=proTitle]').on('mouseout',function(event) {
			$(this).css({
				"color" : "white"
			});
		});

		// 담당자 css
		$('a[id^=memberContacts]').css({
			"color" : "white"
		});


		$('a[id^=memberContacts]').on('mouseover',function(event) {
			$(this).css({
				"color" : "black"
			})
		})

		$('a[id^=memberContacts]').on('mouseout',function(event) {
			$(this).css({
				"color" : "white"
			});
		});



	});
</script>


</body>
</html>