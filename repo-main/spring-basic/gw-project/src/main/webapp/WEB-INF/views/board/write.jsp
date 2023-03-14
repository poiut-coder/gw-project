<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    	 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>게시글 쓰기</title>

  <jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
  <!-- summernote -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="/gw-project/resources/plugins/summernote/summernote-bs4.min.css">
  
</head>

<body class="hold-transition sidebar-mini">
	<div class="wrapper">

		<!-- Preloader -->
		<div
			class="preloader flex-column justify-content-center align-items-center">
			<img class="animation__shake"
				src="/gw-project/resources/dist/img/AdminLTELogo.png"
				alt="AdminLTELogo" height="60" width="60">
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
							<h1>게시글 쓰기</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
								<li class="breadcrumb-item active">Write</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- Main content -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h3 class="card-title">게시글 쓰기</h3>
								</div>
								<form id="write-form" action="write" method="post" enctype="multipart/form-data">
									<!-- 첨부파일 업로드 하면 enctype="multipart/form-data" 넣기 -->
									<!-- /.card-header -->
									<div class="card-body">
										<div class="form-group">
											- 게시판 선택 <select name="typeIdNo" class="form-control"
												id="change-typeIdNo">
												<option value="1">공지사항</option>
												<option value="2">익명게시판</option>
											</select>
										</div>
										<div class="form-group">
											- 제목 <input class="form-control" name="title" />
										</div>
										<div class="form-group" id="writer-notice"
											style="color: lightgray;">
											${loginuser.memberDetail.mem_detail_name} <input
												type="hidden" name="noticeMemNo"
												value="${loginuser.mem_id_no}">
										</div>
										<div class="form-group" id="writer-unknown"
											style="color: lightgray; display: none;">익명</div>
										<div class="form-group input-passwd" style="display: none;">
											- 2차 비밀번호 : <input type="password" name="unRewritePasswd"
												class="input-passwd" placeholder=" 게시글 수정시 필요한 비밀번호를 입력하세요."
												style="display: none; width: 400px;" />
										</div>
										<div class="form-group">
											<div class="btn btn-default btn-file">
												<i class="fas fa-paperclip"></i> 첨부파일 <input type="file"
													name="attach" style="width: 580px; height: 20px;" />
											</div>
											<span id="selected-file-name"></span> <br>
											<br>
											<div class="form-group">

												<textarea id="compose-textarea" class="form-control"
													name="content"></textarea>
											</div>
										</div>
									</div>
									<!-- /.card-body -->
									<div class="card-footer">
										<div class="float-right">
											<!-- <button type="button" class="btn btn-default"><i class="fas fa-pencil-alt"></i></button> -->
											<button type="reset" id="btn-write-cancel"
												class="btn btn-default">
												<i class="fas fa-times"></i> 취소
											</button>
											<button type="submit" id="btn-submit" class="btn btn-primary">
												<i class="far fa-envelope"></i> 등록
											</button>
										</div>
									</div>
									<!-- /.card-footer -->
								</form>
							</div>
							<!-- /.card -->
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
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
	<script
		src="/gw-project/resources/plugins/summernote/summernote-bs4.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Page specific script -->
	<script type="text/javascript">

  $(function () {
	$('#compose-textarea').summernote({
		dialogsInBody: true,
		tabsixe: 2,
		height: 400,
		onImageUpload: function(files, editor, welEditable) {
				// 서버로 이미지 전송
				upload_image_file(files[0], editor, welEditable);
			}
	});
	
	function upload_image_file(file, editor, welEditable) {
		
		formData = new FormData();
		formData.append("file", file);
		$.ajax({
			data : formData,
			type : "post",
			url : "/gw-project/board/upload-image-file",
			cache : false,
			contentType : false,
			processData : false,
			success : function(url) {
				editor.insertImage(welEditable, url);
			},
			error : function(err) {
				alert(err + '이미지 파일 업로드에 실패했습니다.');
			}
		});
	}
	
	$('#btn-submit').on('click', function(event) {
		event.preventDefault();
		const titleValue = $('input[name=title]').val();
		const contentValue = $('textarea[name=content]').val();
		
		if (titleValue.length == 0) {
			alert("게시글 제목을 입력하세요.");
			return;
		} else if (contentValue.length == 0) {
			alert("게시글 내용을 입력하세요.");
			return;
		} 
		
		$('#write-form')[0].submit();
	});
	  
	$('#change-typeIdNo').on('change', function(event) {
		
		var typeIdNo = $('select[name=typeIdNo] option:selected').val();
		  
		 if (typeIdNo == 1) {
			 $('#writer-notice').css("display","");
			 $('.input-passwd').css("display","none");
			 $('#writer-unknown').css("display","none");
		} else if (typeIdNo == 2) {	 
			 $('.input-passwd').css("display","");
			 $('#writer-unknown').css("display","");
			 $('#writer-notice').css("display","none");
		 }
	 });
	
	$('#btn-write-cancel').on('click', function(event) {
		var typeIdNo = ${typeIdNo};
		
		if (typeIdNo == 1) {
			location.href = 'notice';
		} else if (typeIdNo == 2) {
			location.href = 'unknown';
		}
 	});
	
	$('input[name=attach]').on('change', function(event) {
		$('#selected-file-name').text($(this).val());
	});
  })
</script>
</body>
</html>

