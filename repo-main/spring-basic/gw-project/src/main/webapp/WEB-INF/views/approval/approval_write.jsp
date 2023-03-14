<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
    	 
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
            <h1>결재 문서 작성</h1>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-3" id="sheets">
                        
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">문서 양식 (공통)</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                <c:forEach var="sheet" items="${ sheets }">
                <c:if test="${sheet.sheet_all}">
                <li class="nav-item">
                	<a data-sheet_id_no="${sheet.sheet_id_no}" data-sheet_alert="공통 양식은 삭제할 수 없습니다." id="approval_sheet${sheet.sheet_id_no}" class="nav-link" href="#"><i class="far fa-circle text-info"></i>&nbsp;&nbsp;${ sheet.sheet_name }</a>
                </li>
                </c:if>
                </c:forEach>
                </ul>
              </div>
              <!-- /.card-body -->
            </div>
            
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">문서 양식 (개인)</h3>

                <div class="card-tools">
                  <button type="button" class="recomment-link btn btn-sm btn-success" id="sheet_add">
                  추가
                  </button>
                  <button type="button" class="recomment-link btn btn-sm btn-danger" id="sheet_del">
                  삭제
                  </button>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                <c:forEach var="sheet" items="${ sheets }">
                <c:if test="${not sheet.sheet_all and sheet.mem_id_no == loginuser.mem_id_no}">
                <li class="nav-item">
                	<a data-sheet_id_no="${sheet.sheet_id_no}" data-sheet_alert="" id="approval_sheet${sheet.sheet_id_no}" class="nav-link" href="#"><i class="far fa-circle text-info"></i>&nbsp;&nbsp;${ sheet.sheet_name }</a>
                </li>
                </c:if>
                </c:forEach>
                </ul>
              </div>
              <!-- /.card-body -->
            </div>
            
          </div>
          <!-- /.col -->
          <div class="col-md-9">
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">새 문서 작성</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="form-group">
                  <input name="doc_title" class="form-control" placeholder="문서명">
                </div>
                <div id="toolbar-container">
                </div>
                <div id="editor">
                <h1 style="text-align:center;">새문서</h1><figure class="table"><table><tbody><tr><th>기안자</th><td>기안자</td></tr><tr><th>기안부서</th><td>기안부서</td></tr><tr><th>기안일</th><td>기안일</td></tr></tbody></table></figure><p>&nbsp;</p><figure class="table"><table><tbody><tr><th>목차1</th><td>&nbsp;</td></tr><tr><th>목차2</th><td>&nbsp;</td></tr><tr><th>목차3</th><td>&nbsp;</td></tr><tr><th>목차4</th><td>&nbsp;</td></tr><tr><th>목차5</th><td>&nbsp;</td></tr></tbody></table></figure><p>&nbsp;</p><figure class="table"><table><tbody><tr><td><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p></td></tr></tbody></table></figure>
                </div>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                <div class="float-right">
                  <button id="write_approval_doc" class="btn btn-primary"><i class="fas fa-check"></i> 저장 </button>
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

<!-- Modal -->
	<div class="modal fade" id="sheet_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="recomment-modal-Label" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="sheet_modal_Label">양식 이름</h1>
	      </div>
	      <div class="modal-body">
	        <!-- write title area -->
				<input style="width: 100%"; type="text" name="sheet_title" value="" />
			<!-- end of write title area -->
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary save_button">추가</button>
	        <button type="button" class="btn btn-secondary cancel_button" data-bs-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>

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
		
		//결재 문서 작성
		$('#write_approval_doc').on('click',function(event) {
			
			const ok = confirm("문서를 저장 하시겠습니까?");
			if (!ok)
				return;
			
			var title = $('input[name=doc_title]').val();
			var editorData = myEditor.getData();
			var writeData= {
				    "doc_sender": ${ loginuser.mem_id_no },
				    "doc_title": title,
					"doc_content": editorData
				};
			if (title.length == 0 || editorData.length == 0 ) {
				alert('제목 또는 내용을 입력하세요');
				return;
			};
			
			$.ajax({
				        type: "get",
				        url : "write_approval_doc",
				        data : writeData,
				        success : function(data, status, xhr) {
				        	location.href='manage?userNo=' + ${ loginuser.mem_id_no };
				        },
				 		"error" : function(xhr, status, err) {
				 			alert('실패');
				 		}
			});
		
		})
		
		var sheetNo;
		var sheetAlert;
		//양식 선택
		
		$('#sheets a').css({
            "border" : "solid 1px gray"    
        });
		
		$('#sheets').on('click','a',function(event) {
			$('#sheets a').css({
	            "border" : "solid 1px gray"    
	        });
			
			$(this).css({
                "border" : "solid 1px skyblue"    
            });
		});
		
		$('#sheets').on('click','a[id^=approval_sheet]',function(event) {	
			
			sheetNo = $(this).data('sheet_id_no');
			sheetAlert = $(this).data('sheet_alert')
			
		    $.ajax({
		        type: "get",
		        url : "doc_sheet",
		        data : 'sheetNo=' + sheetNo,
		        success : function(data, status, xhr) {
		        	myEditor.setData(data)
		        },
		 		"error" : function(xhr, status, err) {
		 			alert('실패');
		 		}
			});
		        
		});
		
		//결재 양식 추가
		
		$('#sheets').on('click','#sheet_add',function(event) {
			$('#sheet_modal').modal('show');
		})
		
		$('#sheet_modal').on('click', '.cancel_button', function(event) {
			$('#sheet_modal input').val("");
			$('#sheet_modal').modal('hide');
		});
		
		$('#sheet_modal').on('click','.save_button',function(event) {
			
			const ok = confirm("문서 양식을 저장 하시겠습니까?");
			if (!ok)
				return;
			
			var name = $('input[name=sheet_title]').val();
			var editorData = myEditor.getData();
			var sheetData= {
				    "mem_id_no": ${ loginuser.mem_id_no },
				    "sheet_name": name,
					"sheet_content": editorData
				};
			if (name.length == 0 || editorData.length == 0 ) {
				alert('제목 또는 문서 내용을 입력하세요');
				return;
			};
			
			$.ajax({
				        type: "get",
				        url : "add_sheet",
				        data : sheetData,
				        success : function(data, status, xhr) {
				        	$('#sheet_modal input').val("");
							$('#sheet_modal').modal('hide');
				        	$('#sheets').load('sheet_list?userNo=' + ${ loginuser.mem_id_no });
				        },
				 		"error" : function(xhr, status, err) {
				 			alert('실패');
				 		}
			});
		
		})
		
		//결재 양식 삭제
		
		$('#sheets').on('click','#sheet_del',function(event) {
			
			const ok = confirm("문서 양식을 삭제 하시겠습니까?");
			if (!ok)
				return;
			
			if(sheetAlert.length > 0 ) {
				alert(sheetAlert);
				return;
			}
			
			$.ajax({
		        type: "get",
		        url : "del_sheet",
		        data : 'sheetNo=' + sheetNo,
		        success : function(data, status, xhr) {
		        	$('#sheets').load('sheet_list?userNo=' + ${ loginuser.mem_id_no });
		        },
		 		"error" : function(xhr, status, err) {
		 			alert('실패');
		 		}
			});
		});
		
	})
</script>


</body>
</html>
