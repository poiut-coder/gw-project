<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    	 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>게시글 수정</title>

  <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
  <!-- summernote -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/summernote/summernote-bs4.min.css">
  
</head>
<body class="hold-transition sidebar-mini">
<div class="wrapper">
  
  <!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="/gw-project/resources/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>
  
  <!-- Navbar -->
  <jsp:include page="/WEB-INF/views/modules/navbar.jsp" />	
  <!-- /.navbar -->

	<c:choose>
		<c:when test="${adminuser eq 1}">
			<!-- Main Sidebar Container -->
			<jsp:include page="/WEB-INF/views/member/admin/admin-sidebar.jsp" />
			<!-- /.Main Sidebar Container -->
		</c:when>
		<c:otherwise>
			<!-- Main Sidebar Container -->
			<jsp:include page="/WEB-INF/views/modules/sidebar.jsp" />
			<!-- /.Main Sidebar Container -->
		</c:otherwise>
	</c:choose>

<!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>게시글 수정</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
              <li class="breadcrumb-item active">Edit</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <!-- /.col -->
          <div class="col-md-9">
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">게시글 수정</h3>
              </div>
              <form action="edit" method="post" enctype="multipart/form-data">
              <input type="hidden" name="writeIdNo" value="${writeIdNo}" />
              <input type="hidden" name="typeIdNo" value="${typeIdNo}" />
              <input type="hidden" name="pageNo" value="${pageNo}" />
              <!-- /.card-header -->
              <div class="card-body">
	              <div class="form-group">
		          	<select name="typeIdNo" class="form-control" disabled>
						<c:choose>
							<c:when test="${typeIdNo eq 1}">
								<option value="1">공지사항</option>
							</c:when>
							<c:otherwise>
								<option value="2">익명게시판</option>							
							</c:otherwise>
						</c:choose>
		            </select>
	              </div>
	              <div class="form-group">
	              	<c:choose>
					<c:when test="${typeIdNo eq 1}">
						<input class="form-control" placeholder="제목" name="title" value="${boardNotice.title}" />
					</c:when>
					<c:otherwise>
						<input class="form-control" placeholder="제목" name="title" value="${boardUnknown.title}" />
					</c:otherwise>
					</c:choose>
	              </div>
	              <div class="form-group">
					<c:choose>
					<c:when test="${typeIdNo eq 1}">
						${boardNotice.noticeWriter}
					</c:when>
					<c:otherwise>
						익명
					</c:otherwise>
					</c:choose>
				  </div>	
	              <div class="form-group">
	              	<div class="btn btn-default btn-file">
	                	<i class="fas fa-paperclip"></i> 첨부파일
	                	<input type="file" name="attach" style="width:580px; height: 20px; "/>
	                </div>
	                <span id="selected-file-name"></span>
					
					<span class="attach-list">
					<input type="hidden" name="attachIdNo" value="${attachIdNo}" />		
					<c:choose>
						<c:when test="${boardNotice.typeIdNo eq 1}">
							<span id="notice-attach">
							<c:forEach var="attachment" items="${boardNotice.attachments}">
								<a href="download?attachIdNo=${attachment.attachIdNo}">
								${attachment.attachUserFileName}</a>
								<button type="button" class="delete-attach" data-attach-no="${attachment.attachIdNo}" style="border:none; background-color:white;">
									<span>×</span>
								</button>
							</c:forEach>
							</span>
						</c:when>
						<c:otherwise>
							<span id="unknown-attach">
							<c:forEach var="attachment" items="${boardUnknown.attachments}">
								<a href="download?attachIdNo=${attachment.attachIdNo}">
									${attachment.attachUserFileName}</a>
								<button type="button" class="delete-attach" data-attach-no="${attachment.attachIdNo}" style="border:none; background-color:white;">
									<span>×</span>
								</button>
							</c:forEach>
							</span>
						</c:otherwise>
					</c:choose>
					
					</span>
					
					<br><br>
	              	<div class="form-group">
		              	<c:choose>
						<c:when test="${typeIdNo eq 1}">
							<textarea id="compose-textarea" class="form-control" style="height: 300px" name="content">${boardNotice.content}</textarea>
						</c:when>
						<c:otherwise>
							<textarea id="compose-textarea" class="form-control" style="height: 300px" name="content">${boardUnknown.content}</textarea>
						</c:otherwise>
						</c:choose>
	              		
	             	</div>
	              </div>
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                <div class="float-right"> 
                  <!-- <button type="button" class="btn btn-default"><i class="fas fa-pencil-alt"></i></button> -->
                  <button type="submit" class="btn btn-primary"><i class="far fa-envelope"></i> 등록</button>
                </div>
                <button id="btn-edit-cancel" type="reset" class="btn btn-default"><i class="fas fa-times"></i> 취소</button>
              </div>
              <!-- /.card-footer -->
            </form>
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
  
  <!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
  <!-- /.footer -->

  <!-- Control Sidebar -->
  <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
  <!-- /.control-sidebar -->
  
</div>
<!-- ./wrapper -->

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<!-- Summernote -->
<script src="/gw-project/resources/plugins/summernote/summernote-bs4.min.js"></script>

<!-- Page specific script -->
<script type="text/javascript">
	$(function() {
		$('#compose-textarea').summernote();
	});
	
	$('#btn-edit-cancel').on('click', function(event) {
		var typeIdNo = ${typeIdNo};
		
		if (typeIdNo == 1) {
			location.href = 'detail?writeIdNo=${boardNotice.writeIdNo}&typeIdNo=${boardNotice.typeIdNo}&pageNo=${pageNo}';
		} else if (typeIdNo == 2) {
			location.href = 'detail?writeIdNo=${boardUnknown.writeIdNo}&typeIdNo=${boardUnknown.typeIdNo}&pageNo=${pageNo}';
		}
	});
	
	$('.attach-list').on('click', '.delete-attach', function(event) {
		event.preventDefault();
		
		var attachIdNo = $(this).data('attach-no');
		var writeIdNo = $('input[name=writeIdNo]').val();
		var typeIdNo = $('input[name=typeIdNo]').val();
		var pageNo = $('input[name=pageNo]').val();
		
		$.ajax({
			"url" : "delete-attach/" + attachIdNo,
			"type" : "get",
			"data" : {
				"attachIdNo" : attachIdNo,
				"writeIdNo" : writeIdNo,
				"typeIdNo" : typeIdNo,
				"pageNo" : pageNo
			},
			"success" : function(data, status, xhr) {
				alert(writeIdNo + "번 게시글 첨부파일을 삭제했습니다.");
				if(typeIdNo == 1) {
					$('#notice-attach').remove();
				} else if(typeIdNo == 2) {
					$('#unknown-attach').remove();
				}
			},
			"error" : function(data, status, err) {
				alert("첨부파일 삭제 실패");
			}
		})
	});
	
	$('input[name=attach]').on('change', function(event) {
		$('#selected-file-name').text($(this).val());
	});
</script>
</body>
</html>

