<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>받은메일함</title>
<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<style>
a {
	text-decoration: none;
	color: inherit;
}
</style>
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

		<!-- 본문 -->

		<div class="content-wrapper">
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>받은메일함</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
								<li class="breadcrumb-item active">받은메일함</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>
			<section class="content">
				<div class="container-fluid">
					<div class="row">
						<!--mini note controller -->
						<jsp:include page="/WEB-INF/views/modules/mail-min-menu.jsp" />
						<!-- /.Main Sidebar Container -->
						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h3 class="card-title">받은메일함</h3>

									<div class="card-tools">
										<div class="input-group input-group-sm">
											<input type="text" class="form-control"
												placeholder="Search Mail">
											<div class="input-group-append">
												<form action="all-list-search.action" method="post">
													<label>Search: ${search}
														<input type="search" name="search"
															class="form-control form-control-sm" placeholder="Search"
															aria-controls="DataTables_Table_3">
											</label>
											</form>
											</div>
										</div>
									</div>
									<!-- /.card-tools -->
								</div>


								<div class="card-body p-0">
									<div class="mailbox-controls">
										<!-- Check all button -->
										<button type="button"
											class="btn btn-default btn-sm checkbox-toggle">
											<i class="far fa-square"></i>
										</button>
										<button type="button" class="btn btn-default btn-sm">
											<span class="blind">선택된 메일을</span><em>읽음</em><span
												class="blind">으로 표시</span>
										</button>
										<div class="btn-group">
											<button type="button" class="btn btn-default btn-sm">
												<i class="far fa-trash-alt"></i>
											</button>
											<a type="button" class="btn btn-default btn-sm"
												href='mail-received-list.action?pageNo=1'> <i
												class="fas fa-reply"></i></a> <a type="button"
												class="btn btn-default btn-sm"
												href='mail-received-list.action?pageNo=${ pageCount }'> <i
												class="fas fa-share"></i></a>
										</div>
										<!-- /.btn-group -->
										<a type="button" class="btn btn-default btn-sm"
											href='mail-received-list.action'><i class="fas fa-sync-alt"></i> </a>
										<div class="float-right">
											${ mailCount }
											<div class="btn-group">
												<a type="button" class="btn btn-default btn-sm"
													href='mail-received-list.action?pageNo=${ pageBefore }'> <i
													class="fas fa-chevron-left"></i>
												</a> <a type="button" class="btn btn-default btn-sm"
													href='mail-received-list.action?pageNo=${ pageNext }'> <i
													class="fas fa-chevron-right"></i></a>
											</div>
											<!-- /.btn-group -->
										</div>
										<!-- /.float-right -->
									</div>
									<div class="table-responsive mailbox-messages">
										<table class="table table-hover table-striped">
											<tbody>
												<c:forEach var="mail" items="${ mails }">
														<tr class='mail-tr' data-mail-no='${mail.mailNo}'
															style="height: 30px">
															<td>
																<div class="icheck-primary">
																	<input type="checkbox" value="" id="check1"> <label
																		for="check1"></label>
																</div>
															</td>
															<td class="mailbox-star"><a href="#"><i
																	class="fas fa-star text-warning"></i></a></td>
															<td><c:choose>
																	<c:when test="${ mail.readCount > 0}">읽음</c:when>
																	<c:otherwise>안읽음</c:otherwise>
																</c:choose></td>
															<td>${ mail.writer }</td>
															<td style="text-align: left; padding-left: 5px;"><a
																href='mail-received-detail.action?mailNo=${ mail.mailNo }&pageNo=${ pageNo }'>
																	${ mail.title } </a></td>
															<td><c:if test="${ mail.attachCount > 0 }">
																	<i class="fas fa-paperclip"></i>
																</c:if></td>
															<td>${ mail.regDate }</td>
														</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<!-- /.card-body -->
								<div class="card-footer p-0">
									<div class="mailbox-controls">
										<!-- Check all button -->
										<button type="button"
											class="btn btn-default btn-sm checkbox-toggle">
											<i class="far fa-square"></i>
										</button>
										<div class="btn-group">
											<button type="button" class="btn btn-default btn-sm">
												<i class="far fa-trash-alt"></i>
											</button>
											<a type="button" class="btn btn-default btn-sm"
												href='mail-received-list.action?pageNo=1'> <i
												class="fas fa-reply"></i></a> <a type="button"
												class="btn btn-default btn-sm"
												href='mail-received-list.action?pageNo=${ pageCount }'> <i
												class="fas fa-share"></i></a>
										</div>
										<!-- /.btn-group -->
										<a type="button" class="btn btn-default btn-sm"
											href='mail-received-list.action'><i class="fas fa-sync-alt"></i></a>
										<div class="float-right">
											<div class="btn-group">
												<a type="button" class="btn btn-default btn-sm"
													href='mail-received-list.action?pageNo=1'> <i
													class="fas fa-reply"></i></a> <a type="button"
													class="btn btn-default btn-sm"
													href='mail-received-list.action?pageNo=${ pageBefore }'> <i
													class="fas fa-chevron-left"></i>
												</a> ${ pager } <a type="button" class="btn btn-default btn-sm"
													href='mail-received-list.action?pageNo=${ pageNext }'> <i
													class="fas fa-chevron-right"></i></a> <a type="button"
													class="btn btn-default btn-sm"
													href='mail-received-list.action?pageNo=${ pageCount }'> <i
													class="fas fa-share"></i></a>
											</div>
											<!-- /.btn-group -->
										</div>
										<!-- /.float-right -->
									</div>

								</div>
							</div>

						</div>
					</div>
				</div>
			</section>
		</div>
	</div>


	<!-- /본문 -->

	<!-- footer -->
	<jsp:include page="/WEB-INF/views/modules/footer.jsp" />
	<!-- /.footer -->

	<!-- Control Sidebar -->
	<jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
	<!-- /.control-sidebar -->
	<!-- ./wrapper -->
	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />

	<script type="text/javascript">
		$(function() {
			$('.nav-treeview .fa-circle').before('&nbsp;&nbsp;&nbsp;');

			$('.mail-tr').on(
					'click',
					function(event) {
						var mailNo = $(this).data('mail-no'); // data-mail-no
						location.href = 'mail-received-detail.action?mailNo='+ mailNo + '&pageNo=' + ${pageNo};
					});
		})
	</script>
</body>
</html>











