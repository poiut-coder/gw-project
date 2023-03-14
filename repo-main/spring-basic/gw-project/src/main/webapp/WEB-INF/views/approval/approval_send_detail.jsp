<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@page import="com.gw.dto.ApDocDto"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    	 
    	 
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

  <!-- Main Sidebar Container -->
  <jsp:include page="/WEB-INF/views/modules/sidebar.jsp" />
  <!-- /.Main Sidebar Container -->

<!-- 본문 -->
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>결재 보기</h1>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-3">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">결재 정보</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-file text-info"></i> 결재 내용 : ${ap.appr_memo}</span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-calendar-alt text-info"></i> 기안일자 : ${ap.appr_regdate}</span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-user text-info"></i> 기안자 :
                  <c:forEach var="apMember" items="${ apMembers }">
                  <c:if test="${ap.appr_sender == apMember.mem_id_no}">[${ apMember.dept_name }] [&nbsp;${ apMember.role_name } - ${ apMember.mem_detail_name }&nbsp;]</c:if>
                  </c:forEach>                
                  </span>
                  </li>
                  <c:if test="${ ap.appr_status == 2 }">
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="fas fa-ban text-danger"></i> 반려사유 : ${ap.appr_reject_memo}</span>
                  </li>
                  </c:if>
                </ul>
              </div>
              
              <!-- /.card-body -->
            </div>
            
             <div class="card">
              <div class="card-header">
                <h3 class="card-title">결재자</h3>
              </div>
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                  <c:forEach var="receiver" items="${ receivers }">
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-user text-warning"></i>
                  ${receiver.appr_turn}.
                  
                  <c:forEach var="apMember" items="${ apMembers }">
                  <c:if test="${receiver.appr_receiver == apMember.mem_id_no}">[${ apMember.dept_name }] [&nbsp;${ apMember.role_name } - ${ apMember.mem_detail_name }&nbsp;]</c:if>
                  </c:forEach> 
                 
                 &nbsp;
                  
                 <c:choose>
	             <c:when test="${ receiver.appr_status == 0 }">
	             <span class="badge badge-success float-right">
	             &nbsp;대기중&nbsp;
	             </span>
	             </c:when>
	             <c:when test="${ receiver.appr_status == 1 }">
	             <span class="badge badge-primary float-right">
	             &nbsp;승인&nbsp;
	             </span>
	             </c:when>
	             <c:when test="${ receiver.appr_status == 2 }">
	             <span class="badge badge-danger float-right">
	             &nbsp;반려&nbsp;
	             </span>
	             </c:when>
	             <c:otherwise>
	             <span class="badge bg-secondary float-right">
	             &nbsp;중단&nbsp;
	             </span>
	             </c:otherwise>
	             </c:choose>
                  
                  </span>
                  </li>
                  </c:forEach>
                </ul>
              </div>
              
              <!-- /.card-body -->
            </div>
            
            <!-- /.card -->
            
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">목록 보기</h3>
                <div class="card-tools">
                  <button type="button" class="btn-sm btn-dark" id="go_send_list">
                  목록
                  </button>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            
          </div>
        <!-- /.col -->
        <div class="col-md-9">
          <div class="card card-primary card-outline">
            <div class="card-header">
              <h3 class="card-title">문서</h3>

              <!-- /.card-tools -->
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
              <div id="editor">
             	${doc.doc_content}
              </div>
              <!-- /.mail-box-messages -->
            </div>
            <!-- /.card-body -->
            <div class="card-footer p-0">
                <!-- /.btn-group -->
                <!-- /.float-right -->
              </div>
            </div>
          </div>
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <!-- /본문 -->
  
  <!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
  <!-- /.footer -->
  
  <!-- Control Sidebar -->
  <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<script src="https://cdn.ckeditor.com/ckeditor5/35.2.0/decoupled-document/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/35.2.0/decoupled-document/translations/ko.js"></script>
<script type="text/javascript">
	$(function() {
		//CKEDITOR5 적용
		DecoupledEditor
	    .create( document.querySelector( '#editor' ),{ language: "ko" } )
	    .then( editor => {
	    	editor.enableReadOnlyMode( 'editor' );
			editor.isReadOnly;
	    } )
	    .catch( error => {
	        console.error( error );
	    } );
		
		
		$('#go_send_list').on('click',function(event) {
			
			location.href='send?pageNo=' + ${ pageNo };
		})
	})
</script>

</body>
</html>
