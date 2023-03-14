
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>메일쓰기</title>

<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<!-- summernote -->
<link rel="stylesheet"
	href="/gw-project/resources/plugins/summernote/summernote-bs4.min.css">
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

		<!-- Main Sidebar Container -->
		<jsp:include page="/WEB-INF/views/modules/sidebar.jsp"></jsp:include>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>메일쓰기</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
								<li class="breadcrumb-item active">메일쓰기</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<!-- <틀> -->
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<!-- mail-min-menu -->
						<jsp:include page="/WEB-INF/views/modules/mail-min-menu.jsp" />
						<!-- /.card-body -->

						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h3 class="card-title">메일쓰기</h3>
								</div>
								<!-- /.card-header -->
								<form action="mail-write.action" method="post"
									enctype="multipart/form-data">
									<div class="card-body">
										<input type="hidden" name="writer"
											value="${ loginuser.mem_id_no }">
<!-- 										<div class="form-group"> -->
<!-- 											<input class="form-control" placeholder="To:" /> -->
<!-- 										</div> -->
										<!-- 								//---------- -->
												<input type="hidden" name="receiver" id="changeInput"/>
										<select id="changeTest" class="form-control" onchange="selectBoxChange(this.value);">
										<option selected >받는사람:</option>
											<c:forEach var="ex" items="${ EX }">
												<option><c:out
														value=" ${ ex.mem_detail_id_no } " > 
													</c:out></option>
											</c:forEach>

										</select>
										<div class="form-group">
											<input class="form-control" placeholder="제목:"
												type="text" name="title" />
										</div>
										<div class="form-group">
											<textarea id="compose-textarea" class="form-control"
												name="content" style="height: 300px">
                    					</textarea>
										</div>
										<div class="form-group">
											<div>
												<input type="file" name="attach" />
											</div>
											<!-- 											<p class="help-block">이하영. 32MB</p> -->
										</div>

									</div>
									<!-- /.card-body -->
									<div class="card-footer">
										<div class="float-right">
<!-- 											<button type="button" id="draft_button" class="btn btn-default"> -->
<!-- 												<i class="fas fa-pencil-alt"></i> 임시저장 -->
<!-- 											</button> -->
											<input type="submit" id="draft_button" class="btn btn-default" value="임시저장" />

										</div>
										<a type="reset" class="btn btn-default"
											href='mail-all-list.action'> <i class="fas fa-times"></i>취소
										</a>

									</div>
								</form>
								<!-- /.card-footer -->
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

	<!-- 	<script type="text/javascript"> -->
	<!-- // 		$(function() { -->
	<!-- // 			$('.nav-treeview .fa-circle').before('&nbsp;&nbsp;&nbsp;'); -->
	<!-- // 		}) -->
	<!-- 	</script> -->
	<script>
		$(function() {
			//Add text editor
			$('#compose-textarea').summernote()
		});
		
		$(document).ready(function(){
			$("#changeTest").change(function(){
				console.log("값변경테스트: " + $(this).val());
				$("#changeInput").val($(this).val());
			});
		});
// 		$(function() {
// 			$('#draft_button').on('click', function(event) {
// 				const ok = confirm("${ mail.mailNo }번 글을 임시저장할까요?");
// 				if (!ok) return;
// 				location.href = '${mail.mailNo}/draft.action?pageNo=${pageNo}';
// 			});
// 		});
	</script>
	

</body>
</html>