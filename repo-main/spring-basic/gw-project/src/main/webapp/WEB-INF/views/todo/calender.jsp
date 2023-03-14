<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gw.dto.TodoDto"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AdminLTE 3 | Calendar</title>
<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
	
<!-- fullCalendar -->
<link rel="stylesheet"
		href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<link rel="stylesheet"
	href="/gw-project/resources/plugins/fullcalendar/main.css">
<style type="text/css">
#submit {
	float: right;
}





</style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">
	
	<!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="/gw-project/resources/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>
		<!-- Navbar -->
		<jsp:include page="/WEB-INF/views/modules/navbar.jsp" />

		<!-- /.navbar -->

		<!-- Main Sidebar Container -->
		<jsp:include page="/WEB-INF/views/modules/sidebar.jsp" />


		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>Calendar</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active">Calendar</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-3">
							<div >
								<div class="card">

									<!-- the events -->
									<!-- /.card-body -->
								</div>
								
								<!-- /.card -->
								<div class="card">
									<form:form action="calendar.action" method="post" modelAttribute="todo">

										<div class="card-header">
											<h3 class="card-title">Create Event</h3>
											<input type="submit" value="submit" id="submit" />

										</div>


										<div class="card-body">
											<h7>Event title</h7>

											<div class="btn-group"
												style="width: 100%; margin-bottom: 10px;">
												<ul class="fc-color-picker" id="color-chooser">
													<li style="color: #007bff"><a class="text-primary" href="#" ><i
															class="fas fa-square"  style="color: #007bff"></i></a></li>
													<li style="color: #ffc107!important"><a class="text-warning" href="#"><i
															class="fas fa-square"  style="color: #ffc107!important"></i></a></li>
													<li style="color: green"><a class="text-success" href="#"><i
															class="fas fa-square"  style="color: green"></i></a></li>
													<li style="color:  rgb(167, 29, 42)"><a class="text-danger" href="#"><i
															class="fas fa-square"  style="color:  rgb(167, 29, 42)"></i></a></li>
													<li style="color: hotpink"><a class="text-muted" href="#"><i
															class="fas fa-square"  style="color: hotpink"></i></a></li>
												</ul>
											</div>


<%--											<div class="btn-group"--%>
<%--												 style="width: 100%; margin-bottom: 10px;">--%>
<%--												<ul class="fc-color-picker" id="color-chooser">--%>
<%--													<li style="color: #007bff"><a class="text-primary" href="#" ><i--%>
<%--															class="fas fa-square" ></i></a></li>--%>
<%--													<li style="color: #ffc107!important"><a class="text-warning" href="#"><i--%>
<%--															class="fas fa-square"  ></i></a></li>--%>
<%--													<li style="color: green"><a class="text-success" href="#"><i--%>
<%--															class="fas fa-square"  ></i></a></li>--%>
<%--													<li style="color:  rgb(167, 29, 42)"><a class="text-danger" href="#"><i--%>
<%--															class="fas fa-square" ></i></a></li>--%>
<%--													<li style="color: hotpink"><a class="text-muted" href="#"><i--%>
<%--															class="fas fa-square" ></i></a></li>--%>
<%--												</ul>--%>
<%--											</div>--%>
											<!-- /btn-group -->
											<div class="input-group">

												<input id="new-event" type="text" class="form-control"
													placeholder="Event Title" name="title">

												<div class="input-group-append title">
													<button style = " opacity: 1;" id="add-new-event" class="btn btn-primary" disabled>color</button>

												</div>
												
												<!-- /btn-group -->
											</div>
											<br><form:errors path="title" class="error"/>
											<!-- /input-group -->
										</div>

										<!-- 2번 -->
										<div class="card-body">
											<h7>Event time</h7>
											<br>
											<p>Start</p>
											<div class="input-group">
												<select name="startYear" id="selectedYear"  class="selectedYear" data-todo-no="">
													<c:forEach var="i" begin="2022" end="2040">  
														<c:choose>
															<c:when test="${i== nowYear }"><!-- 현재 년도 선택  -->
																<option value=${i} selected>${i}년 </option> 																	 
															</c:when>
															<c:otherwise>
																<option value=${i}>${i}년</option> 
															 </c:otherwise>
														</c:choose>
													</c:forEach>
												</select> 
												<select name="startMonth" id="selectedMonth"  class="selectedMonth" data-todo-no="" >
													<c:forEach var="i" begin="1" end="12">  
														<c:choose>
															<c:when test="${i== nowMonth }"><!-- 현재 년도 선택  -->
																<option value=${i} selected>${i}월 </option> 																	 
															</c:when>
															<c:otherwise>
																<option value=${i}>${i}월</option> 
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select> 
												
												<select name="startDay" id="selectedDay">
													<c:forEach var="i" begin="1" end="31">  
														<c:choose>
															<c:when test="${i== nowDay }">
																<option value=${i} selected>${i}일  </option> 																	 
															</c:when>
															<c:otherwise>
																<option value=${i}>${i}일</option> 
															</c:otherwise>
														</c:choose>
													</c:forEach>
												</select>
												<label for="start_date"></label> <input type="text" name="start_date" id="start_date" class="form-control" placeholder="일자 미정" autocomplete="off">

											</div>
											
											<br>
											<p>End</p>
											<div class="input-group">
												<select name="completeYear" id="selectedcompleteYear" class="selectedcompleteYear" data-todo-no="">
													<c:forEach var="i" begin="2022" end="2040">  
														<c:choose>
															<c:when test="${i== nowYear }"><!-- 현재 년도 선택  -->
																<option value=${i} selected>${i}년 </option> 																	 
															</c:when>
															<c:otherwise>
																<option value=${i}>${i}년</option> 
															 </c:otherwise>
														</c:choose>
													</c:forEach>
												</select> 
												<select name="completeMonth" id="selectedcompleteMonth" class="selectedcompleteMonth" data-todo-no="">
													<c:forEach var="i" begin="1" end="12">  
															<c:choose>
																<c:when test="${i== nowMonth }"><!-- 현재 년도 선택  -->
																	<option value=${i} selected>${i}월 </option> 																	 
																</c:when>
																<c:otherwise>
																	<option value=${i}>${i}월</option> 
																</c:otherwise>
														</c:choose>
													</c:forEach>
												</select> 
												<select name="completeDay" id="selectedcompleteDay">
													<c:forEach var="i" begin="1" end="31">  
														
														<c:choose>
															<c:when test="${i== nowDay }"><!-- 현재 년도 선택  -->
																<option value=${i} selected>${i}일  </option> 																	 
															</c:when>
															<c:otherwise>
																<option value="${i}">${i}일</option> 
															</c:otherwise>
														</c:choose>
														
												</c:forEach>
												</select>
												<label for="complete_date"></label> <input type="text" name="complete_date" id="complete_date" class="form-control" placeholder="일자 미정" autocomplete="off">
												
											</div>
											<!-- /input-group -->
										</div>
										<div class="card-body">
											<h7>Event content</h7>
											<div class="input-group">
												<textarea id="new-event" class="form-control" name="content"  placeholder="input your content"></textarea>
												<input type="hidden" id="event_color" name="event_color" value="#3c8dbc" />
												<input type="hidden" id="writer" name="writer" value="${ loginuser.mem_id_no }" />
													
											</div>
											<!-- /input-group -->
										</div>
									</form:form>

								</div>
							</div>


							<div id="external-events"></div>
						</div>
						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary">
								<div class="card-body p-0">
									<!-- THE CALENDAR -->
									<div id="calendar"></div>
								</div>
								<!-- /.card-body -->
							</div>
							<!-- /.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<jsp:include page="/WEB-INF/views/modules/footer.jsp" />


		<!-- Control Sidebar -->
		<jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />

		<!-- Control sidebar content goes here -->
	</div>
	<!-- ./wrapper -->
	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />

	<!-- jQuery -->
	<!-- Bootstrap -->
	<!-- fullCalendar 2.2.5 -->
	<script src="/gw-project/resources/plugins/moment/moment.min.js"></script>
	<script src="/gw-project/resources/plugins/fullcalendar/main.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
	<!-- ./시작 날짜 설랙션 출력 js -->

	<jsp:include page="/WEB-INF/views/todo/startDateSelection-js.jsp" />

	<!-- ./완 날짜 설랙션 출력 js -->

	<jsp:include page="/WEB-INF/views/todo/completeDateSelection-js.jsp" />
	<script>
		$(function() {
			<c:if test ="${not empty fail_todo}">
			alert("시작일자가 완료일자보다 더 늦을 수 없습니다 ")
			</c:if>
			//$("#selectedDay").val("13").prop("selected", true);테스트 코드 


			/* initialize the calendar
			 -----------------------------------------------------------------*/
			//Date for the calendar events (dummy data)
			var date = new Date()
			var d = date.getDate(), m = date.getMonth(), y = date.getFullYear()

			var Calendar = FullCalendar.Calendar;
			var Draggable = FullCalendar.Draggable;

			var containerEl = document.getElementById('external-events');
			var checkbox = document.getElementById('drop-remove');
			var calendarEl = document.getElementById('calendar');

			
			//todo 생성 
			var calendar = new Calendar(calendarEl, {
				headerToolbar : {
					left : 'prev,next today',
					center : 'title',
					right : 'dayGridMonth,timeGridWeek,timeGridDay'
				},
				themeSystem : 'bootstrap',
				//Random default events
				events : [ 
					<c:forEach var="todo" items="${ todos }">

					{
					
					title : '${ todo.title }',
					start : new Date(${ todo.startDateForJsp }),
			        end   : new Date(${ todo.completeDateForJsp }),
					backgroundColor : '${ todo.event_color }', //red
					borderColor : '${ todo.event_color }', //007bff blue
					allDay : true,
					editable: false

				},
					</c:forEach>
 
				 ],
				editable : true
			});

			calendar.render();
			/* ADDING EVENTS */
			// Color chooser button
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

			$('#start_date').datepicker(
					{
						showOn : 'button',
						onSelect : function() {
							date = $(this).datepicker('getDate'),

							day = date.getDate(), 
							month = date.getMonth() + 1,
							year = date.getFullYear();
							$("#selectedDay").val(day).prop("selected",true); //값이 1인 option 선택
							$("#selectedMonth").val(month).prop("selected",true); //값이 1인 option 선택
							$("#selectedYear").val(year).prop("selected",true); //값이 1인 option 선택


						}
					});
			$('#complete_date').datepicker(
					{
						showOn : 'button',
						onSelect : function() {
							date = $(this).datepicker('getDate'),

							day = date.getDate(), 
							month = date.getMonth() + 1,
							year = date.getFullYear();
							$("#selectedcompleteDay").val(day).prop("selected",true); //값이 1인 option 선택
							$("#selectedcompleteMonth").val(month).prop("selected",true); //값이 1인 option 선택
							$("#selectedcompleteYear").val(year).prop("selected",true); //값이 1인 option 선택


						}
					});
			$('#start_date').css('display', 'none');
			$('#complete_date').css('display', 'none');
			


			
		})
	</script>

	
	
</body>
</html>

