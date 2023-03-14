<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
    	 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>   
    	 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>기안함</title>
  
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
            <h1>기안함</h1>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">기안 목록</h3>
        </div>
        
        <div class="card-body p-0">
          <table class="table table-striped projects">
              <thead>
                  <tr>
                      <th style="width: 1%">
                          #
                      </th>
                      <th style="width: 150px">
                          기안일자
                      </th>
                      <th>
                          결재자
                      </th>
                      <th class="text-left">
                          결재번호&nbsp;-&nbsp;순번
                      </th>
                      <th style="width: 30%" class="text-left">
                          결재 내용
                      </th>
                      <th style="width: 8%" class="text-center">
                          상태
                      </th>
                      <th style="width: 10%">
                      </th>
                  </tr>
              </thead>
              <tbody>
              <c:if test="${ pageNo > 1 }"><c:set var="sum" value="${ (pageNo-1)*10 }"></c:set></c:if>
              <c:forEach var="ap" items="${ aps }">
              <c:set var="sum" value="${ sum + 1 }"></c:set>
              	<tr>            
                      <c:choose>
              <c:when test="${ ap.appr_turn == 1 }">
              	<td style="border-bottom: 1px solid black">
              </c:when>
              <c:otherwise>
              	<td>
              </c:otherwise>
              </c:choose>
                          ${ sum }
                      </td>
                      <c:choose>
              <c:when test="${ ap.appr_turn == 1 }">
              	<td style="border-bottom: 1px solid black">
              </c:when>
              <c:otherwise>
              	<td>
              </c:otherwise>
              </c:choose>
                      ${ ap.appr_regdate }
                      </td>
                      <c:choose>
              <c:when test="${ ap.appr_turn == 1 }">
              	<td style="border-bottom: 1px solid black">
              </c:when>
              <c:otherwise>
              	<td>
              </c:otherwise>
              </c:choose>
                      <c:forEach var="apMember" items="${ apMembers }">
                          <c:if test="${ ap.appr_receiver == apMember.mem_id_no }">[&nbsp;${ apMember.dept_name}&nbsp;]&nbsp;[&nbsp;${ apMember.role_name }&nbsp;-&nbsp;${ apMember.mem_detail_name }&nbsp;]</c:if>
                      </c:forEach>
                      </td>
              <c:choose>
              <c:when test="${ ap.appr_turn == 1 }">
              	<td style="border-bottom: 1px solid black">
              </c:when>
              <c:otherwise>
              	<td>
              </c:otherwise>
              </c:choose>
                         ${ ap.appr_group }&nbsp;-&nbsp;${ ap.appr_turn }
                      </td>
                      
                      <c:choose>
              <c:when test="${ ap.appr_turn == 1 }">
              	<td class="project_progress" style="border-bottom: 1px solid black">
              </c:when>
              <c:otherwise>
              	<td class="project_progress">
              </c:otherwise>
              </c:choose>
                          ${ ap.appr_memo }
                      </td>
               <c:choose>
              <c:when test="${ ap.appr_turn == 1 }">
              	<td class="project-state" style="border-bottom: 1px solid black">
              </c:when>
              <c:otherwise>
              	<td class="project-state">
              </c:otherwise>
              </c:choose>
                          <c:choose>
	             <c:when test="${ ap.appr_status == 0 }">
	             <span class="badge badge-success float-right">
	             &nbsp;대기중&nbsp;
	             </span>
	             </c:when>
	             <c:when test="${ ap.appr_status == 1 }">
	             <span class="badge badge-primary float-right">
	             &nbsp;승인&nbsp;
	             </span>
	             </c:when>
	             <c:when test="${ ap.appr_status == 2 }">
	             <span class="badge badge-danger float-right">
	             &nbsp;반려&nbsp;
	             </span>
	             </c:when>
	             <c:otherwise>
	             <span class="badge bg-secondary float-right">
	             &nbsp;중단&nbsp;
	             </span>
	             </c:otherwise>
	             </c:choose>
                      </td>
                      <c:choose>
              <c:when test="${ ap.appr_turn == 1 }">
              	<td class="project-actions text-right" style="border-bottom: 1px solid black">
              </c:when>
              <c:otherwise>
              	<td class="project-actions text-right">
              </c:otherwise>
              </c:choose>
                          <a data-appr_doc_no="${ ap.appr_doc_no }" data-appr_id_no="${ ap.appr_id_no }" id="send_approval_detail${ ap.appr_id_no }" class="btn btn-info btn-sm" href="#">
                              <i class="fas fa-file-alt">
                              </i>
                              결재 보기
                          </a>
                      </td>
                  </tr>
              </c:forEach>
              </tbody>
          </table>
        </div>
        <!-- /.card-body -->
        <div class="card-footer p-0">
                <!-- /.btn-group -->
                <div class="float-center">
                 			${ pager }
                  <!-- /.btn-group -->
                </div>
                <!-- /.float-right -->
              </div>
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
		
		var docNo;
		var apprNo;
		
		$('a[id^=send_approval_detail]').on('click',function(event) {
			docNo = $(this).data('appr_doc_no');
			apprNo = $(this).data('appr_id_no');
			location.href='send_detail?docNo=' + docNo + '&apprNo=' + apprNo + '&pageNo=' + ${ pageNo };
		});
		
	})
</script>
</body>
</html>
