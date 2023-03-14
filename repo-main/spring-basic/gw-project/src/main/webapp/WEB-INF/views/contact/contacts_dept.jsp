<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Contacts</title>


   <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
   
   
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
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <jsp:include page="/WEB-INF/views/modules/sidebar.jsp"></jsp:include>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Contacts</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
              <li class="breadcrumb-item active">Contacts</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content" id="contacts_list_by_dept">

      <!-- Default box -->
      <div class="card card-solid">
        
        <div class="card-header">
          <h3 class="card-title">Contacts</h3>
        </div>
			<div class="card-body p-0">
				<table id="select_dept" class="table table-striped projects">
          		<tr>
          		<th style="width: 5%; text-align:center"><button type="button" id="btn_total_list" class="btn btn-block btn-default btn-lg"><i class="fas fa-stream"></i>&nbsp;&nbsp;전체</button></th>
          		<c:forEach var="dept" items="${ depts }">
          		<th style="width: 5%; text-align:center"><button type="button" data-dept_id_no="${ dept.dept_id_no }" id="show_list${ dept.dept_id_no }" class="btn btn-block btn-default btn-lg"><i class="fas fa-building"></i>&nbsp;&nbsp;${ dept.dept_name }</button></th>
          		</c:forEach>
          		</tr>
          		</table>
        	</div>
        <hr>
        
        <div class="card-body pb-0">
          <div class="row">

          
          <c:forEach var="member" items="${ members }">
          <c:set var="sum" value="${ sum + 1 }" />
          <input type="hidden" id="memberById${ member.mem_id_no }">

          
            <div class="col-12 col-sm-6 col-md-4 d-flex align-items-stretch flex-column">
              <div class="card bg-light d-flex flex-fill">
                <div class="card-header text-muted border-bottom-0">
                  <c:forEach var="dept" items="${ depts }">
				  	<c:if test="${ member.mem_dept_no eq dept.dept_id_no }">${ dept.dept_name }&nbsp;부서</c:if>
                  </c:forEach>
                  <br>
                  <c:forEach var="role" items="${ roles }">
                  	<c:if test="${ member.mem_position_no eq role.role_id_no }">${ role.role_name }</c:if>
                  </c:forEach>
                </div>
                <div class="card-body pt-0">
                  <div class="row">
                    <div class="col-7">
                    <c:forEach var="detail" items="${ details }">
                    <c:if test="${ member.mem_id_no eq detail.mem_detail_id_no }"><h2 class="lead"><b>성함 : ${ detail.mem_detail_name }</b></h2>
                      <p class="text-muted text-sm"><b>사원번호&nbsp;:&nbsp;</b>${ member.mem_id_no }</p>
                      <ul class="ml-4 mb-0 fa-ul text-muted">
                        <li class="small"><span class="fa-li"><i class="fas fa-calendar-check"></i></span> 생년월일 : &nbsp;${ detail.mem_detail_birthday }</li>
                        <li class="small"><span class="fa-li"><i class="fas fa-calendar-alt"></i></span> 입사일자 : &nbsp;${ detail.mem_detail_fromdate }</li>
                        <li class="small"><span class="fa-li"><i class="fas fa-envelope"></i></span> Email : &nbsp;${ detail.mem_detail_email }</li>
                        <li class="small"><span class="fa-li"><i class="fas fa-lg fa-building"></i></span> 내선전화 : &nbsp;${ detail.mem_detail_innernumber }</li>
                        <li class="small"><span class="fa-li"><i class="fas fa-lg fa-phone"></i></span> 개인전화 : &nbsp;${ detail.mem_detail_phone }</li>
                      </ul>
                    </c:if>
                    </c:forEach>
                    </div>
                    
                    <div class="col-5 text-center">
                    <c:choose>
                    <c:when test="${ member.mem_retire == true }">
                    <!-- 퇴직한 사원 --><i class="fas fa-user-alt-slash fa-3x"></i>
                    </c:when>
                    <c:when test="${ member.mem_position_no == 9 }">
                    <!-- 관리자 --><i class="fas fa-user-cog fa-3x"></i>
                    </c:when>
                    <c:when test="${ member.mem_position_no == 7 || member.mem_position_no == 8 }">
                    <!-- developer --><i class="fas fa-user-edit fa-3x"></i>
                    </c:when>
                    <c:otherwise>
                    <!-- 일반 사원 --><i class="fas fa-user fa-3x"></i>
                    </c:otherwise>
                    </c:choose>
                    </div>
                  </div>
                </div>
                <%-- <div class="card-footer">
                  <div class="text-right">
                    <a href="#" class="btn btn-sm bg-teal">
                      <i class="fas fa-comments"></i>
                    </a>
                    <a href="#" class="btn btn-sm btn-primary" id="link${ member.mem_id_no }" data-mem_id_no="${ member.mem_id_no }">
                      <i class="fas fa-user"></i> View Profile
                    </a>
                  </div>
                </div> --%>
              </div>
            </div>
			<hr>
            
          </c:forEach>
            
            
          </div>
        </div>
      </div>
      <!-- /.card -->
				<div class="card-footer p-0">
                <!-- /.btn-group -->
                	<div class="float-center">
                 			${ pager }
                  <!-- /.btn-group -->
                	</div>
                <!-- /.float-right -->
              	</div>
    </section>
    <!-- /.content -->
    
  </div>
  <!-- /.content-wrapper -->

  <!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
  <!-- /.footer -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />


<script type="text/javascript">

$(function() {
	
	// 아이콘 클릭 
	$('a[id^=link]').on('click', function(event) {
		
		event.preventDefault();
		
		var memberId = $(this).data('mem_id_no');
	});
	
	// 부서별 contacts 조회
	$('#contacts_list_by_dept').on('click', 'button[id^=show_list]', function(event) {
		
		event.preventDefault();
		
		var deptNo = $(this).data('dept_id_no');
		
		location.href = 'contacts_by_dept?deptNo=' + deptNo;
	});
	
	// 전체 list 조회
	$('button[id=btn_total_list]').on('click', function(event) {
		
		event.preventDefault();
		
		location.href = '/gw-project/contact/contacts';
	});
	
	
});

</script>


</body>
</html>
