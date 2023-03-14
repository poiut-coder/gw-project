<%@page import="com.gw.dto.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Notice Board</title>

<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />

</head>
<body class="hold-transition sidebar-mini layout-fixed">
	<div class="wrapper">

		<!-- Preloader -->
		<!--<div
			class="preloader flex-column justify-content-center align-items-center">
			<img class="animation__shake"
				src="/gw-project/resources/dist/img/AdminLTELogo.png"
				alt="AdminLTELogo" height="60" width="60">
		</div> -->
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
			<div class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1 class="m-0">공지사항</h1>
						</div>
						<!-- /.col -->
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
								<li class="breadcrumb-item active">Board</li>
							</ol>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- /.content-header -->

			<!-- Main content -->
			<div class="row">
				<div class="col-12">
					<div class="card">
<%--						<div class="card-header">--%>
<%--							<h3 class="card-title">Notice</h3>--%>

<%--							<!-- 검색 -->--%>
<%--							<div class="card-tools" style="width: 30%">--%>

<%--								<button type="button" id="btn-write" class="btn btn-block btn-primary" style="width: 50%;">글쓰기</button>--%>

<%--								<div class="input-group input-group-sm">--%>
<%--									<form id="search-form" name="search-form" style="float: right">--%>
<%--										<input type="hidden" name="typeIdNo" value="1" />--%>
<%--										<div>--%>
<%--											<select class="select2 select2-hidden-accessible" id="searchOption" name="searchOption">--%>
<%--												<option value="title">제목</option>--%>
<%--												<option value="content">내용</option>--%>
<%--											</select>--%>
<%--											<input type="search" name="search" class="form-control form-control-sidebar" placeholder="Search">--%>
<%--											<div class="input-group-append">--%>
<%--												<button type="submit" id="btn-search" class="btn btn-sidebar"><i class="fas fa-search fa-fw"></i></button>--%>
<%--											</div>--%>
<%--										</div>--%>
<%--									</form>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--							<!-- /.검색 -->--%>
<%--						</div>--%>
<%--	//////////////////////폼 수림수정부분///////////////////////////////--%>
	<div class="card-header">
	<table style="width: 100%;">
	<tr>
		<th>
			<h3 class="card-title">Notice </h3>
			<div class="card-tools" style="width: 30%"></div>
		</th>
		<th></th>
		<th>
			<button type="button" id="btn-write" class="btn btn-block btn-primary" style="width: 24%;float: right;">글쓰기</button>
		</th>
	</tr>
	</thead>
	<tbody>
	<tr>
		<th></th>
		<th></th>
		<th>
			<form id="search-form" name="search-form" style="float: right">
							<div class="form-inline">
								<div class="input-group">
									<input type="hidden" name="typeIdNo" value="1" />
									<select class="select2 select2-hidden-accessible" id="searchOption" name="searchOption">
										<option value="title">제목</option>
										<option value="content">내용</option>
									</select>
									<input class="form-control form-control"  name="search" type="search" placeholder="검색하기" >
									<div class="input-group-append">
										<button class="btn btn-sidebar" type="submit" id="btn-search" >
											<i class="fas fa-search fa-fw"></i>
										</button>
									</div>
								</div>
							</div>
						</form>
		</th>
	</tr>
	</tbody>
</table>
	</div>
<%--	<div class="card-header">--%>
<%--		<h3 class="card-title">Notice </h3>--%>
<%--		<div class="card-tools" style="width: 30%">--%>
<%--		<button type="button" id="btn-write" class="btn btn-block btn-primary" style="width: 50%;">글쓰기</button>--%>
<%--		</div>--%>

<%--		<form id="search-form" name="search-form" style="float: right">--%>
<%--			<div class="form-inline">--%>
<%--				<div class="input-group">--%>
<%--					<input type="hidden" name="typeIdNo" value="1" />--%>
<%--					<select class="select2 select2-hidden-accessible" id="searchOption" name="searchOption">--%>
<%--						<option value="title">제목</option>--%>
<%--						<option value="content">내용</option>--%>
<%--					</select>--%>
<%--					<input class="form-control form-control"  name="search" type="search" placeholder="검색하기" >--%>
<%--					<div class="input-group-append">--%>
<%--						<button class="btn btn-sidebar" type="submit" id="btn-search" >--%>
<%--							<i class="fas fa-search fa-fw"></i>--%>
<%--						</button>--%>
<%--					</div>--%>
<%--				</div>--%>
<%--			</div>--%>
<%--		</form>--%>
<%--	</div>--%>
						<!-- /.card-header -->
						<div class="card-body table-responsive p-0">
							<table id="notice-table" class="table table-hover text-nowrap">
								<thead>
									<tr>
										<th>글번호</th>
										<th>제목</th>
										<th>작성자</th>
										<th>작성시간</th>
										<th>조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="board" items="${boards}">
										<tr class='board-tr' data-no='${ board.writeIdNo }'>
											<td>${board.writeIdNo}</td>
											<td>${board.title}</td>
											<td>${board.noticeWriter}</td>
											<td>${board.dateFormForJsp}</td>
											<td>${board.readCount}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
					<!-- card pagination -->
					<div class="card-header">
						<div class="card-tools">
							<ul class="pagination pagination-sm float-right">
								<!-- first page-->
								<li class="page-item"><a class="page-link"
									href="notice?pageNo=1">«</a>
								<li>
									<!-- previous page --> 
									<c:choose>
										<c:when test="${pageNo eq 1}">
											<li class="page-item"><a class="page-link" href="#">이전</a>
											<li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link"
												href="notice?pageNo=${pageNo - 1}">이전</a>
											<li>
										</c:otherwise>
									</c:choose> 
									<span id="pager-span">
									${pager}
									</span> 
									<!-- next page --> 
									<c:choose>
										<c:when test="${pageNo eq pageCount }">
											<li class="page-item"><a class="page-link" href="#">다음</a>
											<li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link"
												href="notice?pageNo=${pageNo + 1}">다음</a>
											<li>
										</c:otherwise>
									</c:choose> <!-- last page -->
								<li class="page-item"><a class="page-link"
									href="notice?pageNo=${pageCount}">»</a>
								<li>
							</ul>
						</div>
					</div>
					<!-- /card pagination -->
				</div>
			</div>

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

	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function() {
			$('.nav-treeview .fa-circle').before('&nbsp;&nbsp;&nbsp;');

			// 글쓰기
			$('#btn-write').on('click', function(event) {
				location.href= 'write?typeIdNo=' + ${boards[0].typeIdNo};
			});
			
			// 검색하기
			$('#search-form').on('click','#btn-search', function(event) {
				event.preventDefault();
				
				const searchValue =$('input[name=search]').val();
				if (searchValue.length == 0) {
					alert("검색어를 입력하세요.");
					return;
				}
				
				const formData = $('form[name=search-form]').serialize();
				
				$.ajax({
					"url" : "/gw-project/board/search",
					"method" : "get",
					"data" : formData,
					"success" : function(result) {
						if(result.boardList.length >= 1) {
							$('#notice-table tbody').empty(); // 테이블 초기화
							result.boardList.forEach(function(item) {
								str = "<tr class='board-tr' data-no='" + item.writeIdNo +"'>";
								str += "<td>" + item.writeIdNo + "</td>";
								str += "<td>" + item.title + "</td>";
								str += "<td>" + item.noticeWriter + "</td>";
								str += "<td>" + item.dateFormForJsp + "</td>";
								str += "<td>" + item.readCount + "</td>";
								str += "</tr>";
								$('#notice-table').append(str);
							});
						} else {
							alert("일치하는 게시글이 없습니다.");
						} 
						$('.page-item.page-number').remove();
						$('#pager-span').html(result.pager);
						
					},
					"error" : function(err) {
						alert("검색에 실패했습니다.");
					}
				})
			});
			
			// 상세페이지 가기
			$('#notice-table').on('click','.board-tr', function(event) {
				var dataNo = $(this).attr('data-no');
				location.href='detail?writeIdNo=' + dataNo + '&typeIdNo=' + ${boards[0].typeIdNo} + '&pageNo=' + ${pageNo};
			});
			
		})
	</script>
	 

</body>
</html>
