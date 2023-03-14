<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>글상세보기</title>
<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<link rel="stylesheet"
	href="/gw-project/resources/plugins/summernote/summernote-bs4.min.css">


</head>
<body class="hold-transition sidebar-mini layout-fixed">
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
		<jsp:include page="/WEB-INF/views/modules/sidebar.jsp" />
		<!-- /.Main Sidebar Container -->
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>전체메일함</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
								<li class="breadcrumb-item active">전체메일함</li>
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
						<!-- mail menu -->
						<jsp:include page="/WEB-INF/views/modules/mail-min-menu.jsp" />
						<!-- /.card-body -->

						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h2 class="card-title">제목 : ${ mail.title }</h2>
									<div class="float-right">
										<h6>${ mail.regDate }</h6>
									</div>
								</div>

								<!-- /.card-header -->
								<div class="card-body">
									<div class="form-group">보낸사람 : ${ mail.writer }</div>
									<div class="form-group">받는사람 : ${ mail.receiver }</div>
									<div class="form-group">
										<c:forEach var="attachment" items="${ mail.attachments }">
											<a href="download.action?attachNo=${ attachment.attachNo }"
												style="text-decoration: none"><i
												class="fas fa-paperclip"></i> ${ attachment.userFileName } </a>
			                [${ attachment.downloadCount }]
										</c:forEach>
									</div>
									<table>
										<tr>
											<td>
<c:set var="enter" value="
" />									
	${ fn:replace(mail.content, enter, "<br>") }
	
	</td>
										</tr>
									</table>

									<div class="form-group">
										<div></div>
										<div class="form-group"></div>
										<p class="help-block"></p>
									</div>
								</div>
								<!-- /.card-body -->
								<div class="card-footer">
									<div class="float-right">
										<button type="button" id="tolist_button"
											class="btn btn-default">
											<i class=""></i> 목록보기
										</button>

									</div>

									<button type="button" id="delete_button"
										class="btn btn-default" >
										<i class="fas fa-times"></i> 삭제
									</button>
								</div>
								<!-- /.card-footer -->
							</div>
							<!-- /.card -->
						</div>


						<br> <br>



					</div>
				</div>
			</section>
		</div>
		<!-- /.content -->

		<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>

		<script type="text/javascript">
			$(function() {
				$('#tolist_button')
						.on(
								'click',
								function(event) {

									location.href = 'mail-list.action?pageNo=${ requestScope.pageNo }';
								});

				$('#delete_button')
						.on(
								'click',
								function(event) {
									const ok = confirm("${ mail.mailNo }번 글을 삭제할까요?");
									if (!ok)
										return;

									//location.href = 'delete.action?mailNo=${mail.mailNo}&pageNo=${pageNo}';
									location.href = '${mail.mailNo}/delete.action?pageNo=${pageNo}';
								});

				$('#update_button')
						.on(
								'click',
								function(event) {
									location.href = 'edit.action?mailNo=${mail.mailNo}&pageNo=${pageNo}';
								});
			});
		</script>

	</div>
	<!-- /.content-wrapper -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
	<!-- /.footer -->

	<!-- Control Sidebar -->
	<jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
	<!-- /.control-sidebar -->

	<!-- ./wrapper -->

	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
	<!-- Summernote -->
	<script
		src="/gw-project/resources/plugins/summernote/summernote-bs4.min.js"></script>

	<!-- Page specific script -->
	<script>
		$(function() {
			//Add text editor
			$('#compose-textarea').summernote()
		})
	</script>
</body>
</html>










