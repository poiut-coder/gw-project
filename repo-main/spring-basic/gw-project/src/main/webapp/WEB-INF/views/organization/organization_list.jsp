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
            <h1>Organization</h1>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="callout callout-info">
              <h4><i class="fas fa-globe"></i>Company</h4>
              <i class="far fa-user text-info"></i>&nbsp;[&nbsp;사장&nbsp;]&nbsp;:&nbsp;[&nbsp;아무개&nbsp;]&nbsp;&nbsp;[&nbsp;email@naver.com&nbsp;]&nbsp;&nbsp;[&nbsp;031-1234-1234&nbsp;]
              <br>
              <i class="far fa-user text-info"></i>&nbsp;[&nbsp;부사장&nbsp;]&nbsp;:&nbsp;[&nbsp;아무개&nbsp;]&nbsp;&nbsp;[&nbsp;email@email.com&nbsp;]&nbsp;&nbsp;[&nbsp;031-1234-1234&nbsp;]
            </div>


            <!-- Main content -->
            <div class="invoice p-3 mb-3">
              <!-- title row -->
              <div class="row">
                <div class="col-12">
                  <h4>
                    <i class="fas fa-stream"></i>Department
                  </h4>
                </div>
                <!-- /.col -->
              </div>
              <!-- info row -->
              <div class="row invoice-info">
              <c:forEach var="dept" items="${ depts }">
              <div class="col-sm-4 invoice-col">
              <button type="button" data-dept_id_no="${ dept.dept_id_no }" id="show_member${ dept.dept_id_no }" class="btn btn-block btn-default btn-lg">${ dept.dept_name }</button>
              </div>
              </c:forEach>
                <!-- /.col -->
              </div>
              <!-- /.row -->

              <!-- Table row -->
              <div class="row">
                <div class="col-12 table-responsive">
                  <table class="table table-striped">
                    <thead>
                    <tr>
                      <th style="width: 5%">#</th>
                      <th style="width: 5%">부서</th>
                      <th style="width: 20%">직급</th>
                      <th style="width: 20%">이름</th>
                      <th style="width: 25%">이메일</th>
                      <th style="width: 25%">전화번호</th>
                    </tr>
                    </thead>
                    <tbody id="organization_member">
                    
                    </tbody>
                  </table>
                </div>
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- /.invoice -->
          </div><!-- /.col -->
        </div><!-- /.row -->
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
  
<script type="text/javascript">

$(function () {
	
	$('button[id^=show_member]').on('click',function(event) {
		
		var deptNo = $(this).data('dept_id_no');
		
		$('#organization_member').load('member?deptNo='+deptNo);
	})
	
})

</script>


</body>
</html>
