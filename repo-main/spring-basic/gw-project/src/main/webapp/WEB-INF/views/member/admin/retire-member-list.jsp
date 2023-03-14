<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원상세정보</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/gw-project/resources/dist/css/adminlte.min.css">

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

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

  <!-- Main Sidebar Container -->
  <jsp:include page="/WEB-INF/views/member/admin/admin-sidebar.jsp" />
  <!-- /.Main Sidebar Container -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>탈퇴 회원 조회</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
              <li class="breadcrumb-item active"><a href="/gw-project/member/member-detail">회원상세정보</a></li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">

            <div class="card">
              <div class="card-header">
                <h3 class="card-title">탈퇴 회원 조회</h3>

                <form method="post" name="member-search" action="member-search" style="float: right">
                  <div class="form-inline">
                    <div class="input-group" data-widget="sidebar-search">
                      </select>
                      <input class="form-control form-control-sidebar" name="memberSearchByName" type="search" placeholder="사원명으로 검색하기" aria-label="Search">
                      <div class="input-group-append">
                        <button class="btn btn-sidebar" type="submit">
                          <i class="fas fa-search fa-fw"></i>
                        </button>
                      </div>
                    </div>
                  </div>
                </form>


              </div>
              <!-- /.card-header -->

              <div class="card-body">
                <form:form id="retire-member-list" name = "retire-member-list" action="retire-member-list" method="get" modelAttribute="memberDto">
                  <table id="example2" class="table table-bordered table-hover">
                    <thead>
                    <tr>
                      <th>번호</th>
                      <th>가입날짜</th>
                      <th>사원번호</th>
                      <th>사원명</th>
                      <th>퇴사여부</th>
                      <th>회사명</th>
                      <th>부서</th>
                      <th>직급</th>
                      <th>관리자여부</th>
                      <th>수정</th>
                    </tr>


                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="member" items="${ members }">
                      <c:set var="sum" value="${ sum + 1 }"></c:set>
                      <%--                      <tr class="member-tr" >--%>
                      <tr class="member-tr" data-no='${ member.mem_id_no }' >
                        <td>시작&nbsp;${ sum }</td>
                        <td>${ member.mem_register_date }</td>
                        <td name="mem_id_no">${ member.mem_id_no }</td>
                          <%--                        <td><input type="text" class="form-control" name="mem_id_no" id="inputID" value="${ member.mem_id_no }" readonly></td>--%>
                        <td>${ member.memberDetail.mem_detail_name }</td>
                        <td>${ member.mem_retire }</td>
                        <td>${ member.company.comp_name }</td>
                        <td>${ member.dept.dept_name }</td>
                        <td>${ member.role.role_name }</td>
                        <td>${ member.mem_admin }</td>
                        <td>
                          <button class="btn btn-primary" id = "btn"><a style="color: white" href = "/gw-project/member/admin/admin-modified-member?mem_id_no=${ member.mem_id_no }">상세보기</a></button>
                        </td>
                      </tr>
                    </c:forEach>
                    </tbody>
                  </table>
                </form:form>
              </div><!-- /.card-body -->


              <%--pagination              --%>
              <div class="card-header">
                <div class="card-tools">
                  <ul class="pagination pagination-sm float-sm-none">
                    <li class="page-item"><a class="page-link" href="/gw-project/member/admin/retire-member-list?pageNo=1">«</a><li>
                    <c:choose>
                    <c:when test="${pageNo eq 1}">
                    <li class="paginate_button page-item previous"><a class="page-link" href="#">이전</a><li>
                    </c:when>
                    <c:otherwise>
                    <li class="paginate_button page-item"><a class="page-link" href="/gw-project/member/admin/retire-member-list?pageNo=${pageNo - 1}">이전</a><li>
                    </c:otherwise>
                    </c:choose>
                    <li class="paginate_button page-item active"> ${ pager } </li>
                    <c:choose>
                    <c:when test="${pageNo eq pageCount }">
                    <li class="paginate_button page-item"><a class="page-link" href="#">다음</a><li>
                    </c:when>
                    <c:otherwise>
                    <li class="paginate_button page-item"><a class="page-link" href="/gw-project/member/admin/retire-member-list?pageNo=${pageNo + 1}">다음</a><li>
                    </c:otherwise>
                    </c:choose>
                    <li class="paginate_button page-item "><a class="page-link" href="/gw-project/member/admin/retire-member-list?pageNo=${pageCount}">»</a><li>
                  </ul>
                </div>
              </div>



            </div> <!-- /.card -->
          </div><!-- /.col-md-3 -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </section><!-- /.section content-->
  </div><!-- /.contentwrapper -->


  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
  <!-- /.footer -->

  <!-- Control Sidebar -->
  <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
  <!-- /.control-sidebar -->

</div>
<!-- ./wrapper -->

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<!-- DataTables  & Plugins -->
<script src="/gw-project/resources/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="/gw-project/resources/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
<script src="/gw-project/resources/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
<script src="/gw-project/resources/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
<script src="/gw-project/resources/plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
<script src="/gw-project/resources/plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<script>


</script>

</body>
</html>