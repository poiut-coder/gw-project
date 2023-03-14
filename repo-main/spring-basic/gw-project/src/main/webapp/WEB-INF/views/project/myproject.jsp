<%@page import="java.util.Date"%>
<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>My Project</title>


 <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
  <!-- Ekko Lightbox -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/ekko-lightbox/ekko-lightbox.css">
  <!-- overlayScrollbars -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  <!-- SweetAlert2 -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
  <!-- Toastr -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/toastr/toastr.min.css">
  
  
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
  <jsp:include page="/WEB-INF/views/modules/sidebar.jsp"></jsp:include>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" id="myproject-list">
  
    <section class="content-header">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-6">
            <h1>My Project</h1>
          </div>
          <div class="col-sm-6 d-none d-sm-block">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
              <li class="breadcrumb-item active"><a href="/gw-project/project/list">List</a></li>
            </ol>
          </div>
        </div>
      </div>
    </section>
    <hr>


    <section class="content pb-3">

	  
	  <!-- 반복문으로 일단은 프로젝트 전체 가져오기 -->
	  <!-- 프로젝트 상태에 따라서 div class 변환 -->
	  <!-- 프로젝트 상태에 따라서 div class 변환 -->
	  <!-- 프로젝트 상태에 따라서 div class 변환 -->
	  <!-- 프로젝트 상태에 따라서 div class 변환 -->
	  <!-- 프로젝트 상태창의 예시 -->
	  
      <div class="container-fluid">
       
      <c:set var="i" value="0"></c:set>
      <c:set var="j" value="4"></c:set>
      
      <table>
      
      <c:forEach var="projects" items="${ projects }">
	  <input type="hidden" id="estimated_budget_number${ projects.sche_id_no }" value="${ projects.sche_estimated_budget }">
	  <input type="hidden" id="spent_budget_number${ projects.sche_id_no }" value="${ projects.sche_spent_budget }">
	  <input type="hidden" name="sche_mem_id_no" value="${ loginuser.mem_id_no }">
	  
      	<c:if test="${ i%j == 0 }">
      	<Tr style="padding-bottom: 40px">
      	</c:if>
      	
      		<td style="padding-left: 40px"><div class="card card-row card-secondary">
         
         <c:choose>
         <c:when test="${ loginuser.mem_id_no eq projects.sche_leader or loginuser.mem_id_no eq projects.sche_writer }">
         	<div class="card-header bg-info">
            <h3 class="card-title">
              #${ projects.sche_id_no }&nbsp; <a href="#" id="myproject_detail${ projects.sche_id_no }" data-sche_id_no="${ projects.sche_id_no }">${ projects.sche_title }</a>
            </h3>
          	</div>
         </c:when>
         <c:otherwise>
         	<div class="card-header">
            <h3 class="card-title">
              #${ projects.sche_id_no }&nbsp; <a href="#" id="myproject_detail${ projects.sche_id_no }" data-sche_id_no="${ projects.sche_id_no }">${ projects.sche_title }</a>
            </h3>
          	</div>
         </c:otherwise>
         </c:choose>
          
          <div class="card-body" id="card-body">
            <div class="card card-light card-outline">
              <div class="card-header">
                <h3 class="card-title"><span>About Project</span></h3>
                <br>
                <div class="card-tools">
                  <h5 class="card-title">RegDate&nbsp;:&nbsp;#${ projects.sche_reg_date }</h5>
                </div>
              </div>
              <div class="card-body">
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Status&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</a>&nbsp;&nbsp;<a id="myproject_status${ projects.sche_id_no }">${ projects.sche_status }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>시작일자&nbsp;:&nbsp;</a>&nbsp;&nbsp;<a id="myproject_start${ projects.sche_id_no }">${ projects.sche_start_date }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>종료일자&nbsp;:&nbsp;</a>&nbsp;&nbsp;<a id="myproject_end${ projects.sche_id_no }">${ projects.sche_end_date }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>예상기간&nbsp;:&nbsp;</a>&nbsp;&nbsp;<a id="myproject_duration${ projects.sche_id_no }">${ projects.sche_estimated_duration }&nbsp;개월</a>
                </div>
              </div>
            </div>
            
            
            
            <div class="card card-light card-outline">
              <div class="card-header">
                <h3 class="card-title"><span>Team Info</span></h3>
                <c:forEach var="members" items="${ members }">
                <c:if test="${ members.mem_id_no eq projects.sche_leader }">
                	<div style="text-align: right">
                	<a id="myproject_link_contacts" href="#" data-mem_dept_no="${ members.mem_dept_no }">&nbsp;&nbsp;&nbsp;담당부서</a>
                	</div>
                </c:if>
                </c:forEach>
                <div class="card-tools">
                </div>
              </div>
              <div class="card-body">
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>작성자&nbsp;:&nbsp;</a><a id="myproject_writer${ projects.sche_id_no }">
                  <c:forEach var="member" items="${ memberdetail }">
                  <c:if test="${ projects.sche_writer == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                  </c:forEach>
                  </a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>담당자&nbsp;:&nbsp;</a><a id="myproject_leader${ projects.sche_id_no }">
					<c:forEach var="member" items="${ memberdetail }">
                    <c:if test="${ projects.sche_leader == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                    </c:forEach>
				  </a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>팀원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</a><a id="myproject_team${ projects.sche_id_no }">
                  	<c:forEach var="member" items="${ memberdetail }">
                    <c:if test="${ projects.sche_team == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                    </c:forEach>
                  </a>
                </div>
              </div>
            </div>
            

            
            <div class="card card-light card-outline">
              <div class="card-header">
                <h5 class="card-title">Client Info</h5>
                <div class="card-tools">
                  <a href="#" class="btn btn-tool btn-link"></a>
                  <a href="#" class="btn btn-tool"></a>
                </div>
              </div>
              <div class="card-body">
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Name&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;</a><a id="sche_client${ projects.sche_id_no }">${ projects.sche_client }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Phone&nbsp;:&nbsp;&nbsp;&nbsp;</a><a id="sche_client_phone${ projects.sche_id_no }">${ projects.sche_client_phone }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Email&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;</a><a id="sche_client_email${ projects.sche_id_no }">${ projects.sche_client_email }</a>
                </div>
              </div>
            </div>
             <div class="card card-light card-outline">
              <div class="card-header">
                <h5 class="card-title">Budget Info</h5>
                <div class="card-tools">
                  <a href="#" class="btn btn-tool btn-link"></a>
                  <a href="#" class="btn btn-tool"></a>
                </div>
              </div>
              <div class="card-body">
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Budget&nbsp;:&nbsp;</a><a id="sche_estimated_budget${ projects.sche_id_no }">${ projects.estimated_budget }&nbsp;백만원</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</a><a id="sche_spent_budget${ projects.sche_id_no }">${ projects.spent_budget }&nbsp;백만원</a>
                </div>
              </div>
            </div>
            
            <hr>
            
            <button id="myproject_detail_button${ projects.sche_id_no }" type="button" class="btn btn-block btn-primary btn-xs" data-toggle="modal" data-target="#modal-primary" data-sche_id_no="${ projects.sche_id_no }">
            <i class="fas fa-folder"></i>&nbsp;Detail
            </button>
            
            <c:set var="loginuser.mem_id_no" value="${ loginuser.mem_id_no }"></c:set>

            	<button id="myproject_success_button${ projects.sche_id_no }" type="button" class="btn btn-block bg-gradient-success btn-xs" data-toggle="modal" data-target="#modal-success" data-sche_id_no="${ projects.sche_id_no }" data-sche_writer="${ projects.sche_writer }" data-sche_leader="${ projects.sche_leader }">
           		<i class="fas fa-pencil-alt"></i>&nbsp;Success
          		</button>
            	<button id="btn_myproject_delete_button${ projects.sche_id_no }" type="button" class="btn btn-block btn-danger btn-xs" data-toggle="modal" data-target="#modal-danger" data-sche_id_no="${ projects.sche_id_no }" data-sche_writer="${ projects.sche_writer }" data-sche_leader="${ projects.sche_leader }">
            	<i class="fas fa-trash"></i>&nbsp;Delete
            	</button>
            
            </div>
            
            </div>
            <hr></td>
      		
      	<c:if test="${ i%j == j-1 }">
      	</Tr>
      	</c:if>
      	<c:set var="i" value="${ i+1 }"></c:set>
      </c:forEach> 
      
      </table>
      
        </div>
        
     </section>
     
  </div>
		

		<div class="modal fade" id="modal-default" data-bs-backdrop="static">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Project Detail</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p>프로젝트를 상세보기 하시겠습니까?</p>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary" id="detail_button" data-dismiss="modal">Go Detail</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->

		<div class="modal fade" id="modal-success" data-bs-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content bg-success">
					<div class="modal-header">
						<h4 class="modal-title">Project Status Change</h4>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>프로젝트 상태를 success로 변경하시겠습니까?</p>
					</div>
					<div class="modal-footer justify-content-between">
						<button type="button" class="btn btn-outline-light" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-outline-light" id="myproject_success" data-dismiss="modal">Success</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->


		<div class="modal fade" id="myproject-modal" data-bs-backdrop="static">
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
						<button type="submit" class="btn btn-outline-light" id="myproject_delete" data-dismiss="modal">Delete</button>
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
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p>작성자나 담당자가 아닙니다.</p>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-outline-dark" data-dismiss="modal">Return</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
      
      <div class="modal fade" id="modal-contacts" data-bs-backdrop="static">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Contacts Link</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p>담당자의 부서로 연결하시겠습니까?</p>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary" id="contacts_button" data-dismiss="modal">Go Contacts</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
		
      
  <!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
  <!-- /.footer -->

  <!-- Control Sidebar -->
  <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
  <!-- /.control-sidebar -->
  
</div>
<!-- ./wrapper -->


<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<!-- Ekko Lightbox -->
<script src="/gw-project/resources/plugins/ekko-lightbox/ekko-lightbox.min.js"></script>
<!-- overlayScrollbars -->
<script src="/gw-project/resources/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
<!-- Filterizr-->
<script src="/gw-project/resources/plugins/filterizr/jquery.filterizr.min.js"></script>
<!-- SweetAlert2 -->
<script src="/gw-project/resources/plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- Toastr -->
<script src="/gw-project/resources/plugins/toastr/toastr.min.js"></script>


<script>

  $(function () {
	  
	  // number
	  // fmt:formatNumber
	  
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
  	
	  // detail modal
	  $('#myproject-list').on("click", "a[id^=myproject_detail]", function(event) {
		  
		  event.preventDefault();
		  
		  scheNo = $(this).data('sche_id_no');
		  
		  $('#modal-default').modal('show');
	  });
	  
	  // detail modal
	  $('#myproject-list').on("click", 'button[id^=myproject_detail_button]', function(event) {
		 
		  event.preventDefault();
		  
		  scheNo = $(this).data('sche_id_no');
		  
		  $('#modal-default').modal('show');
	  });
	  
	  // button in detail modal
	  $('#detail_button').on('click', function(event) {
			 
		  event.preventDefault();
		  
		  $('#modal-default').modal('hide');
		  
		  setTimeout(() => location.href = "detail?pageNo=" + ${ pageNo } + "&projectNo=" + scheNo, 200);
	  });
	  
	  // success modal
	  $('#myproject-list').on("click", 'button[id^=myproject_success]', function(event) {
		 
		  event.preventDefault();
		  
		  scheNo = $(this).data('sche_id_no');
		  writer = $(this).data('sche_writer');
		  leader = $(this).data('sche_leader');
		
		  $('#modal-success').modal('show');
	  });
	  
	  // button in success modal by ajax
	  $('#modal-success').on('click', 'button[id^=myproject_success]', function(event) {
			 
		  event.preventDefault();
		  
		  member = ${ loginuser.mem_id_no };
		  
		  if (member == writer || member == leader) {
			  
			  $.ajax({
				  "url": "myproject-success",
				  "method": "get",
				  "data": 'projectNo=' + scheNo,
			 	  "success": function(data, status, xhr) {
			 		  $('#myproject-list').load('myproject-list?memberNo=' + ${ loginuser.mem_id_no } + '&pageNo=' + ${ pageNo });
			 	  },
			 	  "error": function(xhr, status, err) {
			 		  alert('실패');
			 	  }
			  });
			  toastr.success('프로젝트가 성공했습니다!')
		  } else {
			  $('#modal-warning').modal('show');
		  }
	  });
	  
	  // delete modal
	  $('#myproject-list').on("click", "button[id^=btn_myproject_delete_button]", function(event) {
		  
		  event.preventDefault();
		  
		  scheNo = $(this).data('sche_id_no');
		  writer = $(this).data('sche_writer');
		  leader = $(this).data('sche_leader');
		  
		  $('#myproject-modal').modal('show');
	  });
	  
	  // button in delete modal by ajax
	  $('#myproject-modal').on('click', 'button[id=myproject_delete]', function(event) {
		  
		  event.preventDefault();
		  
		  member = ${ loginuser.mem_id_no };
		 
		  if (member == writer || member == leader) {
		
			 $.ajax({
				  "url": "myproject-delete",
				  "method": "get",
				  "data": 'projectNo=' + scheNo,
			 	  "success": function(data, status, xhr) {
			 		  $('#myproject-list').load('myproject-list?memberNo=' + ${ loginuser.mem_id_no } + '&pageNo=' + ${ pageNo });
			 	  },
			 	  "error": function(xhr, status, err) {
			 		  alert('실패');
			 	  }
			  });
			  toastr.error('프로젝트를 삭제했습니다.')
		  } else {
			  $('#modal-warning').modal('show');
		  }
	  });
	  
	  // contacts by dept var
	  var deptNo;
	  
	  // contacts link modal show
	  $('#myproject-list').on('click', 'a[id^=myproject_link_contacts]', function(event) {
		 
		  event.preventDefault();
		  
		  deptNo = $(this).data('mem_dept_no');
		  
		  $('#modal-contacts').modal('show');
	  });
	  
	  // contacts link function
	  $('#modal-contacts').on('click', 'button[id=contacts_button]', function(event) {
		  
		  event.preventDefault();
		  
		  setTimeout(() => location.href = 'contacts_by_dept?deptNo=' + deptNo, 200);
	  });
	  
	  
	  
  });
  
</script>
</body>
</html>
