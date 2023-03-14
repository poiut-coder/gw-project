<%@ page import="com.gw.dto.MemberDto" %>
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
<section class="wrapper">

  <!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="/gw-project/resources/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>

  <!-- Navbar -->
  <jsp:include page="/WEB-INF/views/modules/navbar.jsp" />
  <!-- /.navbar -->
  <!-- header include -->

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
            <h4>관리자 권한으로 수정</h4>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
              <li class="breadcrumb-item active"><a href="/gw-project/member/member-detail">수정하기</a></li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">

            <div class="card card-warning" style="width: 1000px; margin: auto">

            <div class="card-header" style="padding: 10px;">
              <h3 class="card-title">${ member.memberDetail.mem_detail_name }님 정보수정</h3>
            </div>
          <form style="padding:45px;" id="admin-modified-member" action="admin-modified-member" method="post" class="form-horizontal" enctype="multipart/form-data">

            <input type="hidden" name="memberDetail.mem_detail_email" value="${member.memberDetail.mem_detail_email}">
            <!-- input states -->
            <div class="form-group" hidden>
              <label class="col-form-label" for="inputId"><i class="fas fa-check"></i>사원명</label>
              <input type="text" class="form-control" id="inputId" name ="mem_id_no" value="${ member.mem_id_no }" readonly>
            </div>


            <%--                        이름--%>
            <div class="form-group">
              <label class="col-form-label" for="inputName"><i class="fas fa-check"></i>사원명</label>
              <input type="text" class="form-control" id="inputName" name="mem_detail_name" value="${ member.memberDetail.mem_detail_name }" readonly>
            </div>

            <%--                        회사--%>

            <div class="form-group">
              <label class="col-form-label" for="inputCompany"><i class="fas fa-check"></i>회사</label>
              <input type="text" class="form-control" id="inputCompany" value="${ member.company.comp_name }" readonly>
              <input type="hidden" name="mem_com_code" value="${member.mem_com_code}" />
            </div>


            <%--                        부서--%>
            <div class="form-group">
              <label class="col-form-label" for="department"><i class="fas fa-check"></i>부서명</label>


              <select name="mem_dept_no" class="form-control" onchange="loadRole();" id = "department">
                <option value="">선택해주세요.</option>
                <c:forEach var="dept" items="${depts}">
                  <option value="${dept.dept_id_no}" <c:if test ="${dept.dept_id_no eq member.mem_dept_no}">selected="selected"</c:if>>${dept.dept_name}</option>
                </c:forEach>
              </select>


            </div>

            <%--직급--%>
            <div class="form-group">
              <label class="col-form-label" for="role"><i class="fas fa-check"></i>직급명</label>
              <select name="mem_position_no" class="form-control" id ="role" onchange="loadRole();" >
                <option value="">선택해주세요.</option>
                <c:forEach var="role" items="${roles}">
                  <option value="${role.role_id_no}" <c:if test ="${role.role_id_no eq member.mem_position_no}">selected="selected"</c:if>>${role.role_name}</option>
                </c:forEach>
              </select>
            </div>


            <%--                        관리자--%>
            <% MemberDto member = (MemberDto) request.getAttribute("member"); %>
            <input type="hidden" value="<%= member.getMem_id_no()%>" />
            <div class="form-group">
              <label class="col-form-label" for="role"><i class="fas fa-check"></i>직급명</label>
              <div class="form-check" >
                <input class="form-check-input" type="radio" value="0" name="mem_admin" <%= (member.getMem_admin() == 0) ? "checked='checked'" : ""  %>>
                <label class="form-check-label">일반회원</label>
              </div>
              <div class="form-check" >
                <input class="form-check-input" type="radio" value="1" name="mem_admin" <%= (member.getMem_admin() == 1) ? "checked='checked'" : ""  %>>
                <label class="form-check-label">관리자 회원</label>
              </div>
              <div class="form-check" >
                <input class="form-check-input" type="radio" value="2" name="mem_admin" <%= (member.getMem_admin() == 2) ? "checked='checked'" : ""  %>>
                <label class="form-check-label">승인대기회원</label>
              </div>
            </div>


            <%--                        재직여부--%>
            <div class="form-group">
              <label class="col-form-label" for="role"><i class="fas fa-check"></i>퇴사여부</label>
              <div class="form-check" >
                <input class="form-check-input" type="radio" value="1" name="mem_retire" <%= member.isMem_retire()? "checked='checked'" : ""  %>>
                <label class="form-check-label">퇴사자</label>
              </div>
              <div class="form-check" >
                <input class="form-check-input" type="radio" value="0" name="mem_retire" <%= !member.isMem_retire()? "checked='checked'" : ""  %>>
                <label class="form-check-label">재직중</label>
              </div>
            </div>

            <button class="btn btn-warning">수정 완료/메일 전송</button>&nbsp;&nbsp;
            <button class="btn btn-primary" ><a style="color: white" href = "/gw-project/member/admin/member-list">목록보기</a></button>


<%--            <a href="/gw-project/member/admin/member-list">목록보기</a>--%>
          </form>




            </div>

        </div>
        </div>
    </section>
  </div>

<%--          <div class="col-md-3">--%>

            <!-- Profile Image -->
<%--            <div class="card card-primary card-outline">--%>
<%--              <div class="card-body box-profile">--%>
<%--                <div class="text-center">--%>
<%--                  <img class="profile-user-img img-fluid img-circle"--%>
<%--                       src="/gw-project/resources/dist/img/woman.png"--%>
<%--                       alt="User profile picture">--%>
<%--                </div>--%>

<%--                <a style="font-size: 30px; text-align: center;">--%>
<%--                  ${ member.memberDetail.mem_detail_name }님 정보 수정하기</a>--%>

<%--                <br>--%>

<%--                <ul class="list-group list-group-unbordered mb-3">--%>
<%--                  <li class="list-group-item">--%>
<%--                    <b>Followers</b> <a class="float-right">1,322</a>--%>
<%--                  </li>--%>
<%--                  <li class="list-group-item">--%>
<%--                    <b>Following</b> <a class="float-right">543</a>--%>
<%--                  </li>--%>
<%--                  <li class="list-group-item">--%>
<%--                    <b>Friends</b> <a class="float-right">13,287</a>--%>
<%--                  </li>--%>
<%--                </ul>--%>

<%--                <a href="#" class="btn btn-primary btn-block"><b>Follow</b></a>--%>
<%--              </div>--%>
<%--              <!-- /.card-body -->--%>
<%--            </div>--%>
            <!-- /.card -->

            <!-- About Me Box -->
<%--            <div class="card card-primary">--%>
<%--              <div class="card-header">--%>
<%--                <h3 class="card-title">About Me</h3>--%>
<%--              </div>--%>
<%--              <!-- /.card-header -->--%>
<%--              <div class="card-body">--%>
<%--                <strong><i class="fas fa-book mr-1"></i> Education</strong>--%>

<%--                &lt;%&ndash;                <p class="text-muted">&ndash;%&gt;--%>
<%--                &lt;%&ndash;                  강남그린컴퓨터학원&ndash;%&gt;--%>
<%--                &lt;%&ndash;                </p>&ndash;%&gt;--%>

<%--                <hr>--%>

<%--                <strong><i class="fas fa-map-marker-alt mr-1"></i> Location</strong>--%>

<%--                <p class="text-muted">Malibu, California</p>--%>

<%--                <hr>--%>

<%--                <strong><i class="fas fa-pencil-alt mr-1"></i> Skills</strong>--%>

<%--                <p class="text-muted">--%>
<%--                  <span class="tag tag-danger">UI Design</span>--%>
<%--                  <span class="tag tag-success">Coding</span>--%>
<%--                  <span class="tag tag-info">Javascript</span>--%>
<%--                  <span class="tag tag-warning">PHP</span>--%>
<%--                  <span class="tag tag-primary">Node.js</span>--%>
<%--                </p>--%>

<%--                <hr>--%>

<%--                <strong><i class="far fa-file-alt mr-1"></i> Notes</strong>--%>

<%--                <p class="text-muted">자기소개 한 줄 써 넣기</p>--%>
<%--              </div>--%>
<%--              <!-- /.card-body -->--%>
<%--            </div>--%>
            <!-- /.card -->
<%--          </div>--%>
          <!-- /.col -->
<%--          <div class="col-md-9">--%>
<%--            <div class="card">--%>

<%--              <div class="card-header p-2">--%>
<%--                <ul class="nav nav-pills">--%>
<%--                  <li class="nav-item"><a class="nav-link active" href="#settings" data-toggle="tab">Settings</a></li>--%>
<%--                  <li class="nav-item"><a class="nav-link" href="#timeline" data-toggle="tab">Timeline</a></li>--%>
<%--                </ul>--%>
<%--              </div><!-- /.card-header -->--%>
<%--              <div class="card-body">--%>
<%--                <div class="tab-content">--%>

                  <!-- /.tab-pane -->

                  <!-- general form elements disabled -->
<%--                  <div class="card card-warning">--%>
<%--                    <div class="card-header">--%>
<%--                      <h3 class="card-title">General Elements</h3>--%>
<%--                    </div>--%>
<%--                    <!-- /.card-header -->--%>
<%--                    <div class="card-body">--%>
<%--                      <form:form id="admin-modified-member" action="admin-modified-member" method="post" class="form-horizontal" enctype="multipart/form-data">--%>

<%--                        <!-- input states -->--%>
<%--                        <div class="form-group" hidden>--%>
<%--                          <label class="col-form-label" for="inputId"><i class="fas fa-check"></i>사원명</label>--%>
<%--                          <input type="text" class="form-control" id="inputId" name ="mem_id_no" value="${ member.mem_id_no }" readonly>--%>
<%--                        </div>--%>


<%--                        &lt;%&ndash;                        이름&ndash;%&gt;--%>
<%--                        <div class="form-group">--%>
<%--                          <label class="col-form-label" for="inputName"><i class="fas fa-check"></i>사원명</label>--%>
<%--                          <input type="text" class="form-control" id="inputName" name="mem_detail_name" value="${ member.memberDetail.mem_detail_name }" readonly>--%>
<%--                        </div>--%>

<%--                        &lt;%&ndash;                        회사&ndash;%&gt;--%>

<%--                        <div class="form-group">--%>
<%--                          <label class="col-form-label" for="inputCompany"><i class="fas fa-check"></i>회사</label>--%>
<%--                          <input type="text" class="form-control" id="inputCompany" value="${ member.company.comp_name }" readonly>--%>
<%--                          <input type="hidden" name="mem_com_code" value="${member.mem_com_code}" />--%>
<%--                        </div>--%>


<%--                        &lt;%&ndash;                        부서&ndash;%&gt;--%>
<%--                        <div class="form-group">--%>
<%--                          <label class="col-form-label" for="department"><i class="fas fa-check"></i>부서명</label>--%>


<%--                          <select name="mem_dept_no" class="form-control" onchange="loadRole();" id = "department">--%>
<%--                            <option value="">선택해주세요.</option>--%>
<%--                            <c:forEach var="dept" items="${depts}">--%>
<%--                              <option value="${dept.dept_id_no}" <c:if test ="${dept.dept_id_no eq member.mem_dept_no}">selected="selected"</c:if>>${dept.dept_name}</option>--%>
<%--                            </c:forEach>--%>
<%--                          </select>--%>


<%--                        </div>--%>

<%--                        &lt;%&ndash;직급&ndash;%&gt;--%>
<%--                        <div class="form-group">--%>
<%--                          <label class="col-form-label" for="role"><i class="fas fa-check"></i>직급명</label>--%>
<%--                          <select name="mem_position_no" class="form-control" id ="role" onchange="loadRole();" >--%>
<%--                            <option value="">선택해주세요.</option>--%>
<%--                            <c:forEach var="role" items="${roles}">--%>
<%--                              <option value="${role.role_id_no}" <c:if test ="${role.role_id_no eq member.mem_position_no}">selected="selected"</c:if>>${role.role_name}</option>--%>
<%--                            </c:forEach>--%>
<%--                          </select>--%>
<%--                        </div>--%>


<%--                        &lt;%&ndash;                        관리자&ndash;%&gt;--%>
<%--                        <% MemberDto member = (MemberDto) request.getAttribute("member"); %>--%>
<%--                        <input type="hidden" value="<%= member.getMem_id_no()%>" />--%>
<%--                        <div class="form-group">--%>
<%--                          <label class="col-form-label" for="role"><i class="fas fa-check"></i>직급명</label>--%>
<%--                          <div class="form-check" >--%>
<%--                            <input class="form-check-input" type="radio" value="0" name="mem_admin" <%= (member.getMem_admin() == 0) ? "checked='checked'" : ""  %>>--%>
<%--                            <label class="form-check-label">인사팀</label>--%>
<%--                          </div>--%>
<%--                          <div class="form-check" >--%>
<%--                            <input class="form-check-input" type="radio" value="1" name="mem_admin" <%= (member.getMem_admin() == 1) ? "checked='checked'" : ""  %>>--%>
<%--                            <label class="form-check-label">관리자 회원</label>--%>
<%--                          </div>--%>
<%--                          <div class="form-check" >--%>
<%--                            <input class="form-check-input" type="radio" value="2" name="mem_admin" <%= (member.getMem_admin() == 2) ? "checked='checked'" : ""  %>>--%>
<%--                            <label class="form-check-label">승인대기회원</label>--%>
<%--                          </div>--%>
<%--                        </div>--%>


<%--                        &lt;%&ndash;                        재직여부&ndash;%&gt;--%>
<%--                        <div class="form-group">--%>
<%--                          <label class="col-form-label" for="role"><i class="fas fa-check"></i>퇴사여부</label>--%>
<%--                          <div class="form-check" >--%>
<%--                            <input class="form-check-input" type="radio" value="1" name="mem_retire" <%= member.isMem_retire()? "checked='checked'" : ""  %>>--%>
<%--                            <label class="form-check-label">퇴사자</label>--%>
<%--                          </div>--%>
<%--                          <div class="form-check" >--%>
<%--                            <input class="form-check-input" type="radio" value="0" name="mem_retire" <%= !member.isMem_retire()? "checked='checked'" : ""  %>>--%>
<%--                            <label class="form-check-label">재직중</label>--%>
<%--                          </div>--%>
<%--                        </div>--%>

<%--                        <button class="btn btn-navbar" type="submit">--%>
<%--                          <i class="fas fa-search"></i>submit--%>
<%--                        </button>--%>

<%--                        <a href="/gw-project/member/admin/member-list">목록보기</a>--%>
<%--                      </form:form>--%>
<%--                    </div>--%>
<%--                  </div>--%>
<%--&lt;%&ndash;                </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;              </div>&ndash;%&gt;--%>
<%--              &lt;%&ndash;            </card header>&ndash;%&gt;--%>
<%--              <!-- /.col -->--%>
<%--            </div>--%>
<%--          </div>--%>

<%--          <!-- /.row -->--%>
<%--        </div><!-- /.container-fluid -->--%>
<%--        <!-- /.content -->--%>
<%--    </section>--%>
<%--  </div>--%>

  <!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
  <!-- /.footer -->

  <!-- Control Sidebar -->
  <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
  <!-- /.control-sidebar -->
  <jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
</div>
<!-- ./wrapper -->
<!-- script -->


<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
  $(function(){
    $('#submit').on('click',function(event) {
      var formData = $('#member-list').serialize();
      alert(formData);
    });
  });


  //$('#mem_com_code').on('change',function (event){

  // const mem_com_code = $(this).val()
  // //member/modiDept_list
  // const url = "modiDept_list?mem_com_code" +mem_com_code;

  //   $.ajax({
  //     "url" : url,
  //     "method" : "get",
  //     // "data" : data,
  //     "success": function (data, status, xhr){
  //       $('#mem_dept_no').empty();
  //       $('#mem_dept_no').append('<option value="" selected disabled="disabled">부서 선택 </option>');
  //       $.each(data, function (idx, member){
  //         $('#mem_dept_no').append('<option value="' + member.dept.dept_id_no + '">' + member.dept.dept_name + '</option>');
  //       });
  //     },
  //     "error":function (xhr, status, data){
  //       alert('실패');
  //     }
  //   });
  // });
  //
  // $( '#mem_dept_no' ).on('change',function (event){
  //
  //   // member/modiRole_list
  //   const mem_dept_no = $(this).val();
  //   const url = "modiRole_list?mem_dept_no=" + mem_dept_no;
  //
  //   $.ajax({
  //     "url" :url,
  //     "method" : "get",
  //     "success":function (data, status, xhr){
  //       $('#mem_position_no').empty();
  //       $('#mem_position_no').append('<option value="" selected disabled="disabled">직급 선택</option>');
  //       $.each(data, function (idx, member){
  //         $('#mem_position_no').append('<option value="' + member.role.role_id_no + '">' + member.role.role_name + '</option>');
  //       });
  //     },
  //     "error":function (xhr,status,data){
  //       alert('실패');
  //     }
  //   });
  // });

  <%--});--%>

  <%--//</script>--%>


</script>





</body>
</html>