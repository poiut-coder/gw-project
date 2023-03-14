<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>회원정보 수정</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="/gw-project/resources/dist/css/adminlte.min.css">
  <!-- Tempusdominus Bootstrap 4 -->
  <link rel="stylesheet" href="/gw-project/resources/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
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
  <!-- header include -->

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
            <h1>회원 상세정보</h1>
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
          <div class="col-md-3">

            <!-- Profile Image -->
            <div class="card card-primary card-outline">
              <div class="card-body box-profile">
                <div class="text-center">
                  <img class="profile-user-img img-fluid img-circle"
                       src="/gw-project/resources/dist/img/woman.png"
                       alt="User profile picture">
                </div>

                <a style="font-size: 25px; text-align: center;">
                  ${ member.memberDetail.mem_detail_name }님</a>
                <br>

                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item">
                    <b>회사</b> <a class="float-right">${ member.company.comp_name }</a>
                  </li>
                  <li class="list-group-item">
                    <b>부서</b> <a class="float-right" style="text-align: center">${ member.dept.dept_name }</a>
                  </li>
                  <li class="list-group-item">
                    <b>직급</b> <a class="float-right">${ member.role.role_name }</a>
                  </li>
                </ul>

                <button class="btn btn-primary btn-block" id="modify">수정하기</button>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

            <!-- About Me Box -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">자기소개</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">

                <strong><i class="fas fa-map-marker-alt mr-1"></i>회사 위치</strong>

                <p class="text-muted">서울특별시 강남구</p>

                <hr>

                <strong><i class="fas fa-pencil-alt mr-1"></i> Skills</strong>

                <p class="text-muted">
                  <span class="tag tag-success">Coding</span>
                  <span class="tag tag-info">Javascript</span>
                  <span class="tag tag-warning">JAVA</span>
                </p>

                <hr>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->

          <div class="col-md-9">
            <div class="card">

              <div class="card-header p-2">
                <ul class="nav nav-pills">
                  <li class="nav-item"><a class="nav-link active" href="#settings" data-toggle="tab">Settings</a></li>
                </ul>
              </div><!-- /.card-header -->
              <div class="card-body">
                <div class="tab-content">
                  <div class="active tab-pane" id="settings">
                    <form:form id="member-modify" action="member-modify" method="post" class="form-horizontal" modelAttribute="memberDetailDto">

                      <div class="form-group row">
                        <label for="inputId" class="col-sm-2 col-form-label">ID</label>
                        <div class="col-sm-10">
                          <input type="text" class="form-control" name="mem_id_no" id="inputID" value="${ member.mem_id_no }" readonly>
                        </div>
                      </div>


                      <div class="form-group row">
                        <label for="inputName" class="col-sm-2 col-form-label">이름</label>
                        <div class="col-sm-10">
                          <input type="text" class="form-control" name="memberDetail.mem_detail_name" id="inputName" value="${ member.memberDetail.mem_detail_name }">
                        </div>
                      </div>

                      <div class="form-group row">
                        <label for="inputName" class="col-sm-2 col-form-label">생년월일</label>
                        <div class="col-sm-10">
                          <input type="date" class="form-control" name="memberDetail.mem_detail_birthday" id="inputBirthday" value="${ member.memberDetail.mem_detail_birthday }">
                        </div>
                      </div>


                      <div class="form-group row">
                        <label for="inputId" class="col-sm-2 col-form-label">이메일</label>
                        <div class="col-sm-10">

                          <input type="text" class="form-control"name="memberDetail.mem_detail_email" id="inputEmail" value="${ member.memberDetail.mem_detail_email }">

                        </div>
                      </div>


                      <div class="form-group row">
                        <label for="inputId" class="col-sm-2 col-form-label">핸드폰번호</label>
                        <div class="col-sm-10">

                          <input type="text" class="form-control" name="memberDetail.mem_detail_phone" id="inputPhone" value="${ member.memberDetail.mem_detail_phone }">

                        </div>
                      </div>

                      <div class="form-group row">
                        <label for="inputId" class="col-sm-2 col-form-label">내선번호</label>
                        <div class="col-sm-10">

                          <input type="text" class="form-control" name="memberDetail.mem_detail_innernumber" id="inputInnerNum" value="${ member.memberDetail.mem_detail_innernumber }">

                        </div>
                      </div>

                      <div class="form-group row">
                        <label for="inputId" class="col-sm-2 col-form-label">직급</label>
                        <div class="col-sm-10">

                          <input type="text" class="form-control" name="member.dept.dept_name" id="deptName" value="${ member.dept.dept_name }" readonly>

                        </div>
                      </div>

                      <div class="form-group row">
                        <label for="inputId" class="col-sm-2 col-form-label">부서</label>
                        <div class="col-sm-10">

                          <input type="text" class="form-control" name="member.role.role_name" id="roleName" value="${ member.role.role_name }" readonly>

                        </div>
                      </div>


                      <div class="form-group row">
                        <div class="offset-sm-2 col-sm-10">
                          <button type="submit" class="btn btn-primary">수정하기</button>
                        </div>
                      </div>

                    </form:form>
                  </div>
                  <!-- /.tab-pane -->
                </div>
                <!-- /.tab-content -->
              </div><!-- /.card-body -->
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

  <!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
  <!-- /.footer -->

  <!-- Control Sidebar -->
  <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
  <!-- /.control-sidebar -->
  <jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
</div>
<!-- ./wrapper -->
<script type="text/javascript">
  $(function () {
    $('#datetimepicker1').datetimepicker();
  });
</script>

</body>
</html>
