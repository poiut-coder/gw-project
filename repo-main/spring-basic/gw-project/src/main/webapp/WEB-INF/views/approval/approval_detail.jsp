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
            <h1>문서 보기</h1>
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
                <h3 class="card-title">문서 정보</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-file text-info"></i> 문서명 : ${doc.doc_title}</span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-calendar-alt text-info"></i> 작성일자 : ${doc.doc_regdate}</span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-comment-alt text-info"></i> 메모 : ${doc.doc_memo}</span>
                  </li>
                </ul>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
            
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">문서 편집</h3>
                <div class="card-tools">
                  <button type="button" class="btn-sm btn-success" id="doc_modify">
                  편집
                  </button>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">목록 보기</h3>
                <div class="card-tools">
                  <button type="button" class="btn-sm btn-primary" id="go_doc_list">
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
		
		
		$('#go_doc_list').on('click',function(event) {
			
			location.href='manage?onStar=' + ${ onStar } + 
					'&pageNo=' + ${ pageNo } + '&sPageNo=' + ${ sPageNo };
		})
		
		$('#doc_modify').on('click',function(event) {
			location.href='edit?docNo=' + ${doc.doc_id_no} + '&pageNo=' + ${pageNo} + '&sPageNo=' + ${ sPageNo } + '&onStar=' + ${onStar};
		})
	})
</script>

</body>
</html>
