<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
    	 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    	 
<!DOCTYPE html>

<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Project Demo Web</title>
  
	<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
	<link rel="stylesheet" href="/gw-project/resources/plugins/fullcalendar/main.css">
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
  <!-- header 추가 예정 -->
  <!-- /header -->

  <!-- Main Sidebar Container -->
  <jsp:include page="/WEB-INF/views/modules/sidebar.jsp" />
  <!-- /.Main Sidebar Container -->

  <!-- Content Wrapper. Contains page content -->
    
	<div class="content-wrapper">
	    <!-- Content Header (Page header) -->
	    <section class="content-header">
	      <div class="container-fluid">
	        <div class="row mb-2">
	          <div class="col-sm-6">
	            <h1>근태관리</h1>
	          </div>
	        </div>
	      </div><!-- /.container-fluid -->
	    </section>
	
	    <!-- Main content -->
	    <section class="content">
	      <div class="container-fluid">
	        <div class="row">
	          <div class="col-md-3">
	            <div class="sticky-top mb-3">
	              <div class="card">
	                <div class="card-header">
	                  <h4 class="card-title">출-퇴근</h4>
	                </div>
	                <div class="card-body">
	                 <button type="button" class="recomment-link btn btn-sm btn-primary" id="attd_on">
	                  출근
	                  </button>
	                  <button type="button" class="recomment-link btn btn-sm btn-success" id="attd_off">
	                  퇴근
	                  </button>
	                </div>
	                <!-- /.card-body -->
	              </div>
	              <!-- /.card -->
	            </div>
	            
	            <div class="card collapsed-card">
              <div class="card-header">
                <h3 class="card-title">총 근태 정보</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-plus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-user text-info"></i> 출근 : ${ allAttd }</span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-clock text-info"></i> 지각 : ${ allLate } </span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="fas fa-plane text-info"></i> 휴가 : 0 </span>
                  </li>
                </ul>
              </div>
              <!-- /.card-body -->
            </div>
	            
	            <div class="card">
              <div class="card-header">
                <h3 class="card-title">월별 근태 정보</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column" id="attd_status">
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-calendar-alt text-info"></i> 년월 : ${ year }년&nbsp;${ month }월</span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-user text-info"></i> 출근 : ${ attd }</span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-clock text-info"></i> 지각 : ${ late } </span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="fas fa-plane text-info"></i> 휴가 : 0 </span>
                  </li>
                </ul>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
	            
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
	      </div><!-- /.container-fluid -->
	    </section>
	    <!-- /.content -->
	  </div>
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

<!-- fullCalendar 2.2.5 -->
<script src="/gw-project/resources/plugins/moment/moment.min.js"></script>
<script src="/gw-project/resources/plugins/fullcalendar/main.js"></script>
  
<script type="text/javascript">

$(function () {
	
    /* initialize the calendar
     -----------------------------------------------------------------*/

    var Calendar = FullCalendar.Calendar;
    var calendarEl = document.getElementById('calendar');

    var calendar = new Calendar(calendarEl, {
        headerToolbar: {
          left  : 'prev,next today',
          center: 'title',
          right : 'dayGridMonth'
        },
        themeSystem: 'bootstrap',
        	events: [
        		
        		<c:forEach var="at" items="${ats}">
        		
        		<c:choose>
        		
        		<c:when test="${at.hh < 9 or (at.hh == 9 and at.mm < 1)}">
        		
        		{
         	      title  : '출근',
         	      start  : '<fmt:formatDate value="${at.attd_on}" pattern="yyyy-MM-dd HH:mm"/>'
         	    },
         	    <c:if test="${not empty at.attd_off}">
         	    {
         	      title  : '퇴근',
         	      start  : '<fmt:formatDate value="${at.attd_off}" pattern="yyyy-MM-dd HH:mm"/>',
         	      color : 'green'
         	    },
         	    </c:if>
        		</c:when>
        		
        		<c:otherwise>
        		
        		{
         	      title  : '지각',
         	      start  : '<fmt:formatDate value="${at.attd_on}" pattern="yyyy-MM-dd HH:mm"/>',
         	      color : 'yellow'
         	    },
         	    <c:if test="${not empty at.attd_off}">
         	    {
         	      title  : '퇴근',
         	      start  : '<fmt:formatDate value="${at.attd_off}" pattern="yyyy-MM-dd HH:mm"/>',
         	      color : 'green'
         	    },
         	    </c:if>
        		
        		</c:otherwise>
        		
        		</c:choose>
         	    
         		</c:forEach>
                
              ]
      });
    
    calendar.render();
    
    //////////
    
    //출근
    $('#attd_on').on('click',function() {
    	
    	const ok = confirm("출근 하시겠습니까?");
		if (!ok)
			return;
    	
    	<c:if test="${not empty validAt}">
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
    	
    	<c:if test="${empty validAt}">
    	alert("출근 정보가 없습니다.");
    	return;
    	</c:if>
    	
    	<c:if test="${not empty validAt.attd_off}">
    	alert("이미 퇴근 했습니다.");
    	return;
    	</c:if>
    	
    	location.href='attd_off';
    })
    
    var date = new Date();
    var month = date.getMonth() + 1;
	var year = date.getFullYear();
    
    $('#calendar .fc-prev-button').on('click',function() {
    	
    	if (month == 1) {
			month = 12;
			year = year - 1;
		} else {
		
			month = month - 1;
			
		}
    	
    	$('#attd_status').load('month_status?year='+year+'&month='+month);
    })
    
    $('#calendar .fc-next-button').on('click',function() {
    	if (month == 12) {
			month = 1;
			year = year + 1;
		} else {
		
			month = month + 1;
			
		}
    	
    	$('#attd_status').load('month_status?year='+year+'&month='+month);
    })
    
    $('#calendar .fc-today-button').on('click',function() {
    	
    	month = date.getMonth() + 1;
    	year = date.getFullYear();
    	
    	$('#attd_status').load('month_status?year='+year+'&month='+month);
    })
    
  })

</script>


</body>
</html>
