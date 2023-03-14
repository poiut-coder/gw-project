<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>내게쓴쪽지함</title>
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
							<h1>내게쓴쪽지함</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
								<li class="breadcrumb-item active">내게쓴쪽지함</li>
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
          </div>
          <!-- /.card -->
        </div>
						<!-- /.Main Sidebar Container -->
						<!-- /.col -->
						<div class="col-md-9">
							<div class="card card-primary card-outline">
								<div class="card-header">
									<h3 class="card-title">내게쓴쪽지함</h3>

									<div class="card-tools">
										<div class="input-group input-group-sm">
											<div class="input-group-append">
												<form action="my-list-search.action" method="post">
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
									<div class="memobox-controls">
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
												href='memo-my-list.action?pageNo=1'> <i
												class="fas fa-reply"></i></a> <a type="button"
												class="btn btn-default btn-sm"
												href='memo-my-list.action?pageNo=${ pageCount }'> <i
												class="fas fa-share"></i></a>
										</div>
										<!-- /.btn-group -->
										<a type="button" class="btn btn-default btn-sm"
											href='memo-my-list.action'><i class="fas fa-sync-alt"></i> </a>
										<div class="float-right">
											${ memoCount }
											<div class="btn-group">
												<a type="button" class="btn btn-default btn-sm"
													href='memo-my-list.action?pageNo=${ pageBefore }'> <i
													class="fas fa-chevron-left"></i>
												</a> <a type="button" class="btn btn-default btn-sm"
													href='memo-my-list.action?pageNo=${ pageNext }'> <i
													class="fas fa-chevron-right"></i></a>
											</div>
											<!-- /.btn-group -->
										</div>
										<!-- /.float-right -->
									</div>
									<div class="table-responsive memobox-messages">
										<table class="table table-hover table-striped">
											<tbody>
												<c:forEach var="memo" items="${ memos }">
														<tr class='memo-tr' data-memo-no='${memo.m_id_no}'
															style="height: 30px">
															<td>
																<div class="icheck-primary">
																	<input type="checkbox" value="" id="check1"> <label
																		for="check1"></label>
																</div>
															</td>
															<td>${ memo.m_sender }</td>
															<td style="text-align: left; padding-left: 5px;"><a
																href='memo-my-detail.action?m_id_no=${ memo.m_id_no }&pageNo=${ pageNo }'>
																	${ memo.m_content } </a></td>
															<td>${ memo.m_regdate }</td>
														</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<!-- /.card-body -->
								<div class="card-footer p-0">
									<div class="memobox-controls">
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
												href='memo-my-list.action?pageNo=1'> <i
												class="fas fa-reply"></i></a> <a type="button"
												class="btn btn-default btn-sm"
												href='memo-my-list.action?pageNo=${ pageCount }'> <i
												class="fas fa-share"></i></a>
										</div>
										<!-- /.btn-group -->
										<a type="button" class="btn btn-default btn-sm"
											href='memo-my-list.action'><i class="fas fa-sync-alt"></i></a>
										<div class="float-right">
											<div class="btn-group">
												<a type="button" class="btn btn-default btn-sm"
													href='memo-my-list.action?pageNo=1'> <i
													class="fas fa-reply"></i></a> <a type="button"
													class="btn btn-default btn-sm"
													href='memo-my-list.action?pageNo=${ pageBefore }'> <i
													class="fas fa-chevron-left"></i>
												</a> ${ pager } <a type="button" class="btn btn-default btn-sm"
													href='memo-my-list.action?pageNo=${ pageNext }'> <i
													class="fas fa-chevron-right"></i></a> <a type="button"
													class="btn btn-default btn-sm"
													href='memo-my-list.action?pageNo=${ pageCount }'> <i
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

			$('.memo-tr').on(
					'click',
					function(event) {
						var m_id_no = $(this).data('memo-no'); // data-mail-no
						location.href = 'memo-my-detail.action?m_id_no='+ m_id_no + '&pageNo=' + ${pageNo};
					});
		})
	</script>
</body>
</html>











