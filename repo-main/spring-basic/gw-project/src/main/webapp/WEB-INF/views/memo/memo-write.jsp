
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>쪽지쓰기</title>

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
							<h1>쪽지쓰기</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
								<li class="breadcrumb-item active">쪽지쓰기</li>
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
 <div class="col-md-3">
          <a href="/gw-project/memo/memo-write.action" class="btn btn-primary btn-block mb-3">쪽지쓰기</a>

          <div class="card">
            <div class="card-header">
              <h3 class="card-title">메뉴</h3>

              <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                  <i class="fas fa-minus"></i>
                </button>
              </div>
            </div>
            <div class="card-body p-0">
              <ul class="nav nav-pills flex-column">
                                <li class="nav-item">
                  <a href="/gw-project/memo/memo-all-list.action" class="nav-link">
                    <i class="far fa-envelope"></i> 전체쪽지함
                  </a>
                </li>
                <li class="nav-item active">
                  <a href="/gw-project/memo/memo-received-list.action" class="nav-link">
                    <i class="fas fa-inbox"></i> 받은쪽지함
                    <span class="badge bg-primary float-right"></span>
                  </a>
                </li>
                <li class="nav-item active">
                  <a href="/gw-project/memo/memo-send-list.action" class="nav-link">
                    <i class="fas fa-inbox"></i> 보낸쪽지함
                  </a>
                </li>
                <li class="nav-item">
                  <a href="/gw-project/memo/memo-my-list.action" class="nav-link">
                    <i class="far fa-file-alt"></i> 내게쓴쪽지함
                  </a>
                </li>
                <li class="nav-item">
                  <a href="/gw-project/memo/memo-deleted-list.action" class="nav-link">
                    <i class="far fa-trash-alt"></i> 휴지통
                  </a>
                </li>
              </ul>
            </div>
            <!-- /.card-body -->
          
          <!-- /.card -->
          
            <!-- /.card-body -->
          </div>
          <!-- /.card -->
        </div>
						<!-- /.card-body -->

						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h3 class="card-title">쪽지쓰기</h3>
								</div>
								<!-- /.card-header -->
								<form id="memo-write-form" action="memo-write.action" method="post"
									enctype="multipart/form-data">
									<div class="card-body">
										<input type="hidden" name="m_sender"
											value="${ loginuser.mem_id_no }">
												<input type="hidden" name="m_receiver" id="changeInput"/>
										<select id="changeTest" class="form-control">
										<option selected >받는사람:</option>
											<c:forEach var="ex" items="${ EX }">
												<option><c:out
														value=" ${ ex.mem_detail_id_no } " > 
													</c:out></option>
											</c:forEach>

										</select>
										<div class="form-group">
										</div>
										<div class="form-group">
											<textarea id="compose-textarea" class="form-control" name="m_content" style="height: 300px"></textarea>
										</div>

									</div>
									<!-- /.card-body -->
									<div class="card-footer">
										<div class="float-right">
											<input type="submit" class="btn btn-primary" value="쪽지전송" />
										</div>
										<a type="reset" class="btn btn-default"
											href='memo-all-list.action'> <i class="fas fa-times"></i>취소
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

	<script>
		$(function() {
			$("#changeTest").change(function(){
				console.log("값변경테스트: " + $(this).val());
				$("#changeInput").val($(this).val());
			});
		});
	</script>
	

</body>
</html>