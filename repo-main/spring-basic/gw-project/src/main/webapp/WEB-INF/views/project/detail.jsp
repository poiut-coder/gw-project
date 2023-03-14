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
  <title>Project Detail</title>


  <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
  <!-- SweetAlert2 -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
  <!-- Toastr -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/toastr/toastr.min.css">
  
  
</head>
<body class="hold-transition sidebar-mini">
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
            <h1>Project Detail</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
              <li class="breadcrumb-item active"><a href="/gw-project/project/list">List</a></li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- 프로젝트를 선택하세요. -->
    <!-- 프로젝트 선택 전에는 search 화면 세팅 -->
    <!-- 프로젝트 선택 이후 search 화면에서 projectDetail 로 전환 -->
    
    
    <!-- Main content -->
    <section class="content" id="project-detail">

      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">프로젝트 상세</h3>
        </div>
        
        <div class="card-body">
          <div class="row">
            <div class="col-12 col-md-12 col-lg-8 order-2 order-md-1">
              <div class="row">
                <div class="col-12 col-sm-4">
                  <div class="info-box bg-light">
                    <div class="info-box-content">
                      <span class="info-box-text text-center text-muted">예산안(원화)</span>
                      <span class="info-box-number text-center text-muted mb-0"><fmt:formatNumber value="${ project.sche_estimated_budget }"></fmt:formatNumber>&nbsp;백만원</span>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-sm-4">
                  <div class="info-box bg-light">
                    <div class="info-box-content">
                      <span class="info-box-text text-center text-muted">추정 총 비용(원화)</span>
                      <span class="info-box-number text-center text-muted mb-0"><fmt:formatNumber value="${ project.sche_spent_budget }"></fmt:formatNumber>&nbsp;백만원</span>
                    </div>
                  </div>
                </div>
                <div class="col-12 col-sm-4">
                  <div class="info-box bg-light">
                    <div class="info-box-content">
                      <span class="info-box-text text-center text-muted">프로젝트 기간(월)</span>
                      <span class="info-box-number text-center text-muted mb-0"><fmt:formatNumber value="${ project.sche_estimated_duration }"></fmt:formatNumber>&nbsp;개월</span>
                    </div>
                  </div>
                </div>
              </div>
              <!-- 프로젝트에서 프로젝트 명을 클릭하면 프로젝트 디테일로 이동하여 해당 프로젝트의 상세 표시 -->
              <div class="row">
                <div class="col-12">
                  <h4>${ project.sche_id_no }번 프로젝트 : &nbsp; ${ project.sche_title }</h4>
                  <hr>
                    <div class="post">
                      <div class="">
                        &nbsp;&nbsp;<i class="fas fa-user-check"></i>&nbsp;&nbsp;
                        <span class="username">
                        
                        <c:forEach var="member" items="${ member }">
                        <c:if test="${ member.mem_id_no eq project.sche_leader }">
                          <a href="#" id="detail_link_contacts" data-mem_dept_no="${ member.mem_dept_no }">담당자 명 : &nbsp;
                          <c:forEach var="members" items="${ members }">
                          <c:if test="${ project.sche_leader == members.mem_detail_id_no }">${ members.mem_detail_name }</c:if>
                          </c:forEach>
                          </a><!-- employees나 contacts에 연결 -->
                        </c:if>
                        </c:forEach>
                          
                        </span>
                        <br>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="description"><a>팀원 : &nbsp;
                        <c:forEach var="member" items="${ members }">
                          <c:if test="${ project.sche_team == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                          </c:forEach>
                        </a></span>
                      </div>
                      <hr>
                      <p>
                        ${ project.sche_content }
                      </p>
                      <hr>
                      <p>
                        <c:choose>
                      	    <c:when test="${ project.sche_deleted }">
                      			<a>Project Status&nbsp;&nbsp;:&nbsp;&nbsp;</a><span style="color:lightgray">[ CANCELED ]</span>
                      		</c:when>
                      		<c:when test="${ project.sche_status eq 'On Hold' }">
                      			<a>Project Status&nbsp;&nbsp;:&nbsp;&nbsp;</a><span class="badge badge-warning">${ project.sche_status }</span>
                      		</c:when>
                      		<c:when test="${ project.sche_status eq 'In Progress' }">
                      			<a>Project Status&nbsp;&nbsp;:&nbsp;&nbsp;</a><span class="badge badge-primary">${ project.sche_status }</span>
                      		</c:when>
                      		<c:otherwise>
                      			<a>Project Status&nbsp;&nbsp;:&nbsp;&nbsp;</a><span class="badge badge-success">${ project.sche_status }</span>
                            </c:otherwise>
                         </c:choose>
                      </p>
                      <hr>
                      <p>
                        시작일자 &nbsp;:&nbsp; ${ project.sche_start_date }
                      </p>
                      <p>
                        종료일자 &nbsp;:&nbsp; ${ project.sche_end_date }
                      </p>
					  <p>
                        등록일자 &nbsp;:&nbsp; ${ project.sche_reg_date }
                      </p>
                      <p>
                      </p>
                    </div>

                    
                   
                </div>
              </div>
            </div>
            
            
            <div class="col-12 col-md-12 col-lg-4 order-1 order-md-2">
              <h3 class="text-primary">Client : ${ project.sche_client }</h3>
              <p class="text-muted">프로젝트 고객 상세</p>
              <br>
              <div class="text-muted">
                
                <p class="text-sm">고객 연락처
                  <b class="d-block">${ project.sche_client_phone }</b>
                </p>
                <p class="text-sm">고객 이메일
                  <b class="d-block">${ project.sche_client_email }</b>
                </p>
              </div>
			
              <h5 class="mt-5 text-muted">프로젝트 관련 파일</h5>
              <hr>
              
              
               <c:forEach var="attachment" items="${ project.sche_attachments }">
                
                  <a href="download?attachNo=${ attachment.sche_attach_id_no }" class="btn-link text-secondary">${ attachment.sche_attach_userfilename }</a>
                  <br>
                
                </c:forEach>
                
            </div>
            
          </div>
        </div>
        <!-- /.card-body -->
      </div>
      <!-- /.card -->
	   <div class="row">
        <div class="col-12">
          <a class="btn btn-secondary float-right" data-sche_id_no="${ project.sche_id_no }" id="list${ project.sche_id_no }">List</a>
          <button id="list_edit${ project.sche_id_no }" type="button" class="btn btn-info float-right" data-sche_id_no="${ project.sche_id_no }" data-sche_writer="${ project.sche_writer }" data-sche_leader="${ project.sche_leader }" data-sche_status="${ project.sche_status }">
          <i class="fas fa-pencil-alt"></i>
          Edit
          </button>
        </div>
      </div>
      
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
      
      
      			<!-- Modal -->
				<div class="modal fade" id="modal-info" data-bs-backdrop="static">
					<div class="modal-dialog">
						<div class="modal-content bg-info">
							<div class="modal-header">
								<h4 class="modal-title">Project Edit</h4>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<p>프로젝트를 편집하시겠습니까?</p>
							</div>
							<div class="modal-footer justify-content-between">
								<button type="button" class="btn btn-outline-light"
									data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-outline-light"
									id="edit_button">Edit</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
				
				
				<div class="modal fade" id="modal-default" data-bs-backdrop="static">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Contacts Link</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p>담당자 연락처를 확인하시겠습니까?</p>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary" id="btn_link_contact${ project.sche_leader }" data-sche_leader="${ project.sche_leader }" data-dismiss="modal">Go Contacts</button>
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
				
				<!-- WARNING MODAL 2 -->
				<div class="modal fade" id="unknown-leader-warning" data-bs-backdrop="static">
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
								<p>존재하지 않는 담당자입니다.</p>
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
<!-- SweetAlert2 -->
<script src="/gw-project/resources/plugins/sweetalert2/sweetalert2.min.js"></script>
<!-- Toastr -->
<script src="/gw-project/resources/plugins/toastr/toastr.min.js"></script>


<script type="text/javascript">


$(function() {
	
	var scheNo;
	var member;
	var writer;
	var leader;
	var status;
	
	// edit modal
	$("button[id^=list_edit]").on("click", function() {
		
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
	
	// list button
	$("a[id^=list]").on("click", function(event) {
		
		event.preventDefault();
		
		setTimeout(() => location.href = 'list?pageNo=' + ${ pageNo } + '&projectNo=' + $(this).data('sche_id_no'), 200);
	});
	
	// contacts link
	$('a[id^=link_contact]').on('click', function(event) {
		
		event.preventDefault();
		
		$('#modal-default').modal('show');
		
		var memberId = $(this).data('sche_leader');
		
		$('button[id^=btn_link_contact]').on('click', function(event) {
			
			if (memberId == 0) {
				$('#unknown-leader-warning').modal('show');
			} else {
				setTimeout(() => location.href = '/gw-project/contact/contacts?pageNo=' + ${ pageNo }, 200);	
			}
			 
		});
	});
	
	// contacts by dept var
	  var deptNo;
	  
	  // contacts link modal show
	  $('#project-detail').on('click', 'a[id=detail_link_contacts]', function(event) {
		 
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
