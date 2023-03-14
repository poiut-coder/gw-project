<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
    	 
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
            <h1>결재 문서 편집</h1>
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
                <h3 class="card-title">문서 메모</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0" id="sheets">
                <ul class="nav nav-pills flex-column">
                  <li class="nav-item">
                    <span class ="nav-link" style="font-weight: bold;"><i class="fas fa-comment-alt"></i> 메모 : ${doc.doc_memo}</span>
                  </li>
                </ul>
              </div>
              <!-- /.card-body -->
            </div>
            
          </div>
          <!-- /.col -->
          <div class="col-md-9">
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title"> 문서 편집</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="form-group">
                  <input name="doc_title" class="form-control" value="${doc.doc_title}">
                </div>
                <div id="toolbar-container">
                </div>
                <div id="editor">
                	${doc.doc_content}
                </div>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                <div class="float-right">
                  <button id="modify_approval_doc" class="btn btn-primary"><i class="fas fa-check"></i> 저장 </button>
                  <button id="modify_cancel" class="btn btn-danger"><i class="fas fa-times"></i> 취소 </button>
                </div>
              </div>
              <!-- /.card-footer -->
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
	    	myEditor = editor;
	    	
	        const toolbarContainer = document.querySelector( '#toolbar-container' );

	        toolbarContainer.appendChild( editor.ui.view.toolbar.element );
	    } )
	    .catch( error => {
	        console.error( error );
	    } );
		
		//결재 문서 수정
		$('#modify_approval_doc').on('click',function(event) {
			
			const ok = confirm("문서를 수정 하시겠습니까?");
			if (!ok)
				return;
			
			var title = $('input[name=doc_title]').val();
			var editorData = myEditor.getData();
			var writeData= {
				    "doc_id_no": ${doc.doc_id_no},
				    "doc_title": title,
					"doc_content": editorData
				}
			if (title.length == 0 || editorData.length == 0 ) {
				alert('제목 또는 내용을 입력하세요');
				return;
			}
			
			$.ajax({
				        type: "get",
				        url : "modify_approval_doc",
				        data : writeData,
				        success : function(data, status, xhr) {
				        	location.href='detail?docNo=' + ${doc.doc_id_no} + '&pageNo=' + ${ pageNo } + '&sPageNo=' + ${ sPageNo } + '&onStar=' + ${onStar};
				        },
				 		"error" : function(xhr, status, err) {
				 			alert('실패');
				 		}
				})
			
		})
		
		$('#modify_cancel').on('click',function(event) {
			location.href='detail?docNo=' + ${doc.doc_id_no} + '&pageNo=' + ${ pageNo } + '&sPageNo=' + ${ sPageNo } + '&onStar=' + ${onStar};
		})
		
	})
</script>


</body>
</html>
