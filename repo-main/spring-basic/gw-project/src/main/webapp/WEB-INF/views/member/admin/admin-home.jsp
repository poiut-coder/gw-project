<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관리자 메인페이지</title>
    <!-- fullCalendar -->
    <link rel="stylesheet"
          href="/gw-project/resources/plugins/fullcalendar/main.css">

    <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
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
    <!-- header 추가 예정 -->
    <!-- /header -->

    <!-- Main Sidebar Container -->
    <jsp:include page="/WEB-INF/views/member/admin/admin-sidebar.jsp" />
    <!-- /.Main Sidebar Container -->

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">


        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <!-- Content Header (Page header) -->
                <div class="content-header">
                    <div class="container-fluid">
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1 class="m-0">관리자 메인페이지입니다</h1>
                            </div>
                            <!-- /.col -->
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
                                    <li class="breadcrumb-item active"><a
                                            href="/gw-project/member/admin/admin-login">관리자홈</a></li>
                                </ol>
                            </div>

                            <!-- /.row -->
                        </div>
                        <!-- /.container-fluid -->
                    </div>

                    <!-- /.content-header -->
                </div>
                <!-- /.container-fluid -->



                <!-- /.col -->
                <div class="col-sm-7 ">
                    <div class="card-body p-0">
                        <div id="calendar"></div>

                    </div>
                </div>

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
<script
        src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<script src="/gw-project/resources/plugins/fullcalendar/main.js"></script>

<script type="text/javascript">
    $(function() {

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
            events : [ {
                title : 'Meeting',
                start : new Date(y, m, d, 10, 30),
                allDay : false,
                backgroundColor : '#0073b7', //Blue
                borderColor : '#0073b7',
                editable : false
            }, {
                title : 'Lunch',
                start : new Date(y, m, d, 12, 0),
                end : new Date(y, m, d, 14, 0),
                allDay : false,
                backgroundColor : '#00c0ef', //Info (aqua)
                borderColor : '#00c0ef',
                editable : false
            }, {
                title : 'Meeting',
                start : new Date(y, m, d + 1, 19, 0),
                end : new Date(y, m, d + 1, 22, 30),
                allDay : false,
                backgroundColor : '#00a65a', //Success (green)
                borderColor : '#00a65a',
                editable : false
            }

            ],
            editable : true
        });

        calendar.render();

        $("#time1").timepicker({
            timeFormat : 'h:mm p',
            interval : 60,
            minTime : '10',
            maxTime : '6:00pm',
            defaultTime : '11',
            startTime : '10:00',
            dynamic : false,
            dropdown : true,
            scrollbar : true
        });
    })
</script>


</body>
</html>