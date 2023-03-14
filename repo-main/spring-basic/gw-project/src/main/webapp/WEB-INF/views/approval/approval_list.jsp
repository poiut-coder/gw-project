<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
    	 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>결재함</title>
  
	<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">

  <!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="/gw-project/resources/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
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
            <h1>결재함</h1>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">결재 목록</h3>
        </div>
        
        <div class="card-body p-0">
          <table class="table table-striped projects">
              <thead>
                  <tr>
                      <th style="width: 1%">
                          #
                      </th>
                      <th style="width: 20%">
                          결재 명
                      </th>
                      <th style="width: 30%">
                          기안자
                      </th>
                      <th>
                          결재 내용
                      </th>
                      <th style="width: 8%" class="text-center">
                          상태
                      </th>
                      <th style="width: 20%">
                      </th>
                  </tr>
              </thead>
              <tbody>
                  <tr>
                      <td>
                          1
                      </td>
                      <td>
                          <a>
                              예시 1
                          </a>
                          <br/>
                          <small>
                              Created 9999.99.99
                          </small>
                      </td>
                      <td>
                          김찬연
                      </td>
                      <td class="project_progress">
                          10월 결재 서류 입니다.
                      </td>
                      <td class="project-state">
                          <span class="badge-lg badge-success">대기중</span>
                      </td>
                      <td class="project-actions text-right">
                          <a class="btn btn-primary btn-sm" href="#">
                              <i class="fas fa-check">
                              </i>
                              승인
                          </a>
                          <a class="btn btn-info btn-sm" href="#">
                              <i class="fas fa-ban">
                              </i>
                              반려
                          </a>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          2
                      </td>
                      <td>
                          <a>
                              예시 2
                          </a>
                          <br/>
                          <small>
                              Created 9999.99.99
                          </small>
                      </td>
                      <td>
                          한도희
                      </td>
                      <td class="project_progress">
                          10월 결재 서류2 입니다.
                      </td>
                      <td class="project-state">
                          <span class="badge-lg badge-success">대기중</span>
                      </td>
                      <td class="project-actions text-right">
                          <a class="btn btn-primary btn-sm" href="#">
                              <i class="fas fa-check">
                              </i>
                              승인
                          </a>
                          <a class="btn btn-info btn-sm" href="#">
                              <i class="fas fa-ban">
                              </i>
                              반려
                          </a>
                      </td>
                  </tr>
              </tbody>
          </table>
        </div>
        <!-- /.card-body -->
      </div>
      <!-- /.card -->

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

<script type="text/javascript">
	$(function() {
		$('.nav-treeview .fa-circle').before("&nbsp;&nbsp;&nbsp;");
	})
</script>
</body>
</html>
