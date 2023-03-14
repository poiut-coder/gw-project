<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Projects</title>


  <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
  <!-- SweetAlert2 -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
  <!-- Toastr -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/toastr/toastr.min.css">
  
  
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
            <h1>Project List</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
              <li class="breadcrumb-item active">Projects</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <!--  -->
    <section class="content">
    
    <input type="hidden" name="sche_mem_id_no" value="${ loginuser.mem_id_no }">

      <!-- Default box -->
      <div class="card" id="project_list_by_dept">
        
        <div class="card-header">
          <h3 class="card-title">Projects</h3>
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
        
        <div class="card-body p-0">
          <table class="table table-striped projects">
              <thead>
                  <tr>
                      <th style="width: 5%">
                          Number
                      </th>
                      <th style="width: 7%">
                          Project No
                      </th>
                      <th style="width: 15%">
                          Project Name
                      </th>
                      <th style="width: 14%">
                          Project Period
                      </th>
                      <th style="width: 7%">
                          Leader
                      </th>
                      <th style="width: 7%">
                          Team
                      </th>
                      <th style="width: 7%">
                          Writer
                      </th>
                      <th style="width: 9%">
                          Client
                      </th>
                      <th style="width: 7%" class="text-center">
                          Status
                      </th>
                      <th style="width: 20%">
                      </th>
                  </tr>
              </thead>
              <tbody>
              	  
              	  <c:forEach var="projects" items="${ projects }">
              	  <c:set var="sum" value="${ sum + 1 }"></c:set>
                  <tr>
                  	  <td>
                      	#${ sum }
                      </td>
                      <td>
                      		<c:choose>
                      		<c:when test="${ projects.sche_deleted }">
                      			<span style="color:lightgray">${ projects.sche_id_no }</span>
                      		</c:when>
                      		<c:otherwise>
                      	 		<a>
                          			${ projects.sche_id_no }
                          		</a>
                      		</c:otherwise>
                      		</c:choose>
                      </td>
                      <td>
                      		<c:choose>
                      		<c:when test="${ projects.sche_deleted }">
                      			<span style="color:lightgray">${ projects.sche_title }</span>
                      		</c:when>
                      		<c:otherwise>
                      	 		<a href="#" data-sche_id_no="${ projects.sche_id_no }" id="detail${ projects.sche_id_no }">
                          			${ projects.sche_title }
                          		</a>
                          		<br>
                          		<small>${ projects.sche_reg_date }</small>
                      		</c:otherwise>
                      		</c:choose>
                      </td>
                      <!-- 마감기한이 지난 프로젝트 -->
                      <!-- 마감기한이 지난 프로젝트 -->
                      <!-- 마감기한이 지난 프로젝트 -->
                      <!-- 마감기한이 지난 프로젝트 -->
                      <!-- 마감기한이 지난 프로젝트 -->
                      <!-- 마감기한이 지난 프로젝트 -->
                      <td>
                          <ul class="list-inline">
                            <c:choose>
                      		<c:when test="${ projects.sche_deleted }">
                      			<span style="color:lightgray">${ projects.sche_start_date } ~ ${ projects.sche_end_date }</span>
                      		</c:when>
                      		<c:otherwise>
                              <li class="list-inline-item">
                              	${ projects.sche_start_date } ~ ${ projects.sche_end_date } 
                              </li>
                            </c:otherwise>
                            </c:choose>
                          </ul>
                      </td>
                      <td>
                          <ul class="list-inline">
                            <c:choose>
                      	    <c:when test="${ projects.sche_deleted }">
                      			<span style="color:lightgray">
                      			<c:forEach var="member" items="${ members }">
                          		<c:if test="${ projects.sche_leader == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                          		</c:forEach>
                      			</span>
                      		</c:when>
                      		<c:otherwise>
                              <li class="list-inline-item">
                               	<c:forEach var="member" items="${ members }">
                         		<c:if test="${ projects.sche_leader == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                       		    </c:forEach>
                              </li>
                            </c:otherwise>
                            </c:choose>
                          </ul>
                      </td>
                      <td>
                          <ul class="list-inline">
                            <c:choose>
                      	    <c:when test="${ projects.sche_deleted }">
                      			<span style="color:lightgray">
                      			<c:forEach var="member" items="${ members }">
                        	    <c:if test="${ projects.sche_team == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                        	    </c:forEach>
                      			</span>
                      		</c:when>
                      		<c:otherwise>
                              <li class="list-inline-item">
                               	<c:forEach var="member" items="${ members }">
                         		<c:if test="${ projects.sche_team == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                         		</c:forEach>
                              </li>
                            </c:otherwise>
                            </c:choose>
                          </ul>
                      </td>
                       <td>
                          <ul class="list-inline">
                            <c:choose>
                      	    <c:when test="${ projects.sche_deleted }">
                      			<span style="color:lightgray">
                      			<c:forEach var="member" items="${ members }">
                        	    <c:if test="${ projects.sche_writer == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                        	    </c:forEach>
                      			</span>
                      		</c:when>
                      		<c:otherwise>
                              <li class="list-inline-item">
                               	<c:forEach var="member" items="${ members }">
                         		<c:if test="${ projects.sche_writer == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                         		</c:forEach>
                              </li>
                            </c:otherwise>
                            </c:choose>
                          </ul>
                      </td>
                      <td>
                          <ul class="list-inline">
                            <c:choose>
                      	    <c:when test="${ projects.sche_deleted }">
                      			<span style="color:lightgray">${ projects.sche_client }</span>
                      		</c:when>
                      		<c:otherwise>
                              <li class="list-inline-item">
                               	${ projects.sche_client }
                              </li>
                            </c:otherwise>
                            </c:choose>
                          </ul>
                      </td>
                      <td class="project-state">
                      		<c:choose>
                      	    <c:when test="${ projects.sche_deleted }">
                      			<span style="color:lightgray">[ CANCELED ]</span>
                      		</c:when>
                      		<c:when test="${ projects.sche_status eq 'On Hold' }">
                      			<span class="badge badge-warning">${ projects.sche_status }</span>
                      		</c:when>
                      		<c:when test="${ projects.sche_status eq 'In Progress' }">
                      			<span class="badge badge-primary">${ projects.sche_status }</span>
                      		</c:when>
                      		<c:otherwise>
                      			<span class="badge badge-success">${ projects.sche_status }</span>
                            </c:otherwise>
                            </c:choose>
                      </td>
                      <td class="project-actions text-right">
                      		<c:choose>
                      	    <c:when test="${ projects.sche_deleted }">
                      			<span style="color:lightgray">[ PROJECT CANCELED ]</span>
                      		</c:when>
                      		<c:otherwise>
                          		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-primary" data-sche_id_no="${ projects.sche_id_no }" id="detail${ projects.sche_id_no }">
                  				<i class="fas fa-folder"></i>
                  				Detail
                				</button>
                          		<button id="list_edit${ projects.sche_id_no }" type="button" class="btn btn-info" data-sche_id_no="${ projects.sche_id_no }" data-sche_writer="${ projects.sche_writer }" data-sche_leader="${ projects.sche_leader }" data-sche_status="${ projects.sche_status }">
           						<i class="fas fa-pencil-alt"></i>
           						Edit
          						</button>
          						<button id="list_delete${ projects.sche_id_no }" type="button" class="btn btn-danger" data-sche_id_no="${ projects.sche_id_no }" data-sche_writer="${ projects.sche_writer }" data-sche_leader="${ projects.sche_leader }" data-sche_status="${ projects.sche_status }">
                  				<i class="fas fa-trash"></i>
                  				Delete
                				</button>
                            </c:otherwise>
                            </c:choose>
                          
                      </td>
                  </tr>
                  </c:forEach>
                 
                  </tbody>
          </table>
        </div>
        <!-- /.card-body -->
         		<div class="card-footer p-0">
                <!-- /.btn-group -->
                	<div class="float-center">
                 			${ pager }
                  <!-- /.btn-group -->
                	</div>
                <!-- /.float-right -->
              	</div>
      </div>
      <!-- /.card -->
      </section>
      	<!-- card pagination -->
	
  </div>
  <!-- /.content-wrapper -->
      
      
       				<!-- Modal -->
				      <div class="modal fade" id="modal-info" data-bs-backdrop="static">
				        <div class="modal-dialog">
				          <div class="modal-content bg-info">
				            <div class="modal-header">
				              <h4 class="modal-title">Project Edit</h4>
				              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                <span aria-hidden="true">&times;</span>
				              </button>
				            </div>
				            <div class="modal-body">
				              <p>프로젝트를 편집하시겠습니까?</p>
				            </div>
				            <div class="modal-footer justify-content-between">
				              <button type="button" class="btn btn-outline-light" data-dismiss="modal">Close</button>
				              <button type="button" class="btn btn-outline-light" id="edit_button">Edit</button>
				            </div>
				          </div>
				          <!-- /.modal-content -->
				        </div>
				        <!-- /.modal-dialog -->
				      </div>
				      <!-- /.modal -->
				      
				      <div class="modal fade" id="modal-danger" data-bs-backdrop="static">
				        <div class="modal-dialog">
				          <div class="modal-content bg-danger">
				            <div class="modal-header">
				              <h4 class="modal-title">Project Delete</h4>
				              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                <span aria-hidden="true">&times;</span>
				              </button>
				            </div>
				            <div class="modal-body">
				              <p>프로젝트를 삭제하시겠습니까?</p>
				            </div>
				            <div class="modal-footer justify-content-between">
				              <button type="button" class="btn btn-outline-light" data-dismiss="modal">Close</button>
				              <button type="submit" class="btn btn-outline-light" id="delete_button">Delete</button>
				            </div>
				          </div>
				          <!-- /.modal-content -->
				        </div>
				        <!-- /.modal-dialog -->
				      </div>
				      <!-- /.modal -->

      				<!-- WARNING MODAL 1 -->
				<div class="modal fade" id="modal-warning" data-bs-backdrop="static">
					<div class="modal-dialog">
						<div class="modal-content bg-warning">
							<div class="modal-header">
								<h4 class="modal-title">권한이 없습니다.</h4>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<p>작성자나 담당자가 아닙니다.</p>
							</div>
							<div class="modal-footer justify-content-between">
								<button type="button" class="btn btn-outline-dark"
									data-dismiss="modal">Return</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->

			
    <!-- </form> -->
    <!-- /.content -->
	

  <!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
  <!-- /.footer -->

  <!-- Control Sidebar -->
  <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
  <!-- /.control-sidebar -->
  
</div>
<!-- ./wrapper -->


<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<!-- SweetAlert2 -->
<script src="/gw-project/resources/plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- Toastr -->
<script src="/gw-project/resources/plugins/toastr/toastr.min.js"></script>


<script type="text/javascript">

$(function() {
	
	// toast
	var Toast = Swal.mixin({
		toast: true,
		position: 'top-end',
		showConfirmButton: false,
		timer: 3000
	});
	
	// var
	var scheNo;
	var member;
	var writer;
	var leader;
	var status;
	
	// detail
	$("a[id^=detail]").on("click", function(event) {
	
		event.preventDefault();
		
		setTimeout(() => location.href = 'detail?pageNo=' + ${ pageNo } + '&projectNo=' + $(this).data('sche_id_no'), 200);
	});
	
	// detail
	$("button[id^=detail]").on("click", function(event) {
		
		event.preventDefault();
		
		setTimeout(() => location.href = 'detail?pageNo=' + ${ pageNo } + '&projectNo=' + $(this).data('sche_id_no'), 200);
	});
			
	// edit modal
	$("button[id^=list_edit]").on("click", function(event) {
		
		event.preventDefault();
		
		scheNo = $(this).data('sche_id_no');
		writer = $(this).data('sche_writer');
		leader = $(this).data('sche_leader');
		status = $(this).data('sche_status');
		
		$('#modal-info').modal('show');
	});
	
	// button in edit modal
	$('#edit_button').on('click', function(event) {
		
		event.preventDefault();
		
		$('#modal-info').modal('hide');
		
		member = ${ loginuser.mem_id_no };
		  
		if (status == 'Success') {
			toastr.success('이미 성공한 프로젝트입니다.')
		} else if (member == writer || member == leader) {
			setTimeout(() => location.href = 'edit?pageNo=' + ${ pageNo } + '&projectNo=' + scheNo, 200);
		} else {
			$('#modal-warning').modal('show');
		}
	});
	
	
	// delete modal
	$("button[id^=list_delete]").on("click", function(event) {
		
		event.preventDefault();
		
		scheNo = $(this).data('sche_id_no');
		writer = $(this).data('sche_writer');
		leader = $(this).data('sche_leader');
		status = $(this).data('sche_status');
		
		$('#modal-danger').modal('show');
	});
	
	// button in delete modal
	$('#delete_button').on('click', function(event) {
		
		event.preventDefault();
		
		$('#modal-danger').modal('hide');
		
		member = ${ loginuser.mem_id_no };
		  
		if (status == 'Success') {
			toastr.success('이미 성공한 프로젝트입니다.')
		} else if (member == writer || member == leader) {
			setTimeout(() => location.href = 'delete?pageNo=' + ${ pageNo } + '&projectNo=' + scheNo, 200);
		} else {
			$('#modal-warning').modal('show');
		}
	});

	// 부서별 list 조회
	$('#project_list_by_dept').on('click', 'button[id^=show_list]', function(event) {
		
		event.preventDefault();
		
		var deptNo = $(this).data('dept_id_no');
		
		location.href = 'list_by_dept?deptNo=' + deptNo;
	});
	
	// 전체 list 조회
	$('button[id=btn_total_list]').on('click', function(event) {
		
		event.preventDefault();
		
		location.href = 'list';
	});
	
	 
		
	
});
	
</script>

</body>
</html>
