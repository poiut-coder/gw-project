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
      <div class="card" id="receive_list">
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
                      <th style="width: 150px">
                          기안일자
                      </th>
                      <th>
                          기안자
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
                      <th>
                      </th>
                      <th>
                      </th>
                      <th>
                      </th>
                  </tr>
              </thead>
              <tbody>
              <c:if test="${ pageNo > 1 }"><c:set var="sum" value="${ (pageNo-1)*10 }"></c:set></c:if>
              <c:forEach var="ap" items="${ aps }">
              <c:set var="sum" value="${ sum + 1 }"></c:set>
              	<tr>
              	<td>${ sum }</td>
              	<td>${ ap.appr_regdate }</td>
              	<td>
                     <c:forEach var="apMember" items="${ apMembers }">
                        <c:if test="${ ap.appr_sender == apMember.mem_id_no }">[&nbsp;${ apMember.dept_name}&nbsp;]&nbsp;[&nbsp;${ apMember.role_name }&nbsp;-&nbsp;${ apMember.mem_detail_name }&nbsp;]</c:if>
                     </c:forEach>
                </td>
              	<td>${ ap.appr_group }&nbsp;-&nbsp;${ ap.appr_turn }</td>
              	<td class="project_progress">${ ap.appr_memo }</td>
              	<td class="project-state">
                          <c:choose>
	             <c:when test="${ ap.appr_status == 0 }">
	             <span class="badge badge-success float-center">
	             &nbsp;대기중&nbsp;
	             </span>
	             </c:when>
	             <c:when test="${ ap.appr_status == 1 }">
	             <span class="badge badge-primary float-center">
	             &nbsp;승인&nbsp;
	             </span>
	             </c:when>
	             <c:when test="${ ap.appr_status == 2 }">
	             <span class="badge badge-danger float-center">
	             &nbsp;반려&nbsp;
	             </span>
	             </c:when>
	             <c:otherwise>
	             <span class="badge bg-secondary float-center">
	             &nbsp;중단&nbsp;
	             </span>
	             </c:otherwise>
	             </c:choose>
                      </td>
                <c:choose>
                <c:when test="${ ap.appr_status == 0 }">
                
                <td class="project-actions text-right">
                 <a data-appr_doc_no="${ ap.appr_doc_no }" data-appr_id_no="${ ap.appr_id_no }" id="receive_approval_detail${ ap.appr_id_no }" class="btn btn-info btn-sm" href="#">
                 <i class="fas fa-file-alt"></i>보기
                 </a>
                </td>
                <td class="project-actions text-right">
                 <a data-appr_doc_no="${ ap.appr_doc_no }" data-appr_id_no="${ ap.appr_id_no }" id="receive_approval_admit${ ap.appr_id_no }" class="btn btn-primary btn-sm" href="#">
                 <i class="fas fa-check"></i>승인
                 </a>
                </td>
                <td class="project-actions text-right">
                 <a data-appr_doc_no="${ ap.appr_doc_no }" data-appr_id_no="${ ap.appr_id_no }" id="receive_approval_reject${ ap.appr_id_no }" class="btn btn-danger btn-sm" href="#">
                 <i class="fas fa-ban"></i>반려
                 </a>
                </td>
                
                </c:when>
                
                <c:otherwise>
                
                <td></td>
                <td class="project-actions text-right">
                 <a data-appr_doc_no="${ ap.appr_doc_no }" data-appr_id_no="${ ap.appr_id_no }" id="receive_approval_detail${ ap.appr_id_no }" class="btn btn-info btn-sm" href="#">
                 <i class="fas fa-file-alt"></i>보기
                 </a>
                </td>
                <td></td>
                
                </c:otherwise>
                
                </c:choose>
              	
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

<div class="modal fade" id="reject_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="recomment-modal-Label" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title fs-5" id="reject-modal-Label">반려 사유</h2>
	      </div>
	      <div class="modal-body">
	        <!-- write comment area -->
			<form id="rejectMemoForm">
				<textarea class="form-control" name="rejectMemo" rows="3"></textarea>
			</form>
			<!-- end of write comment area -->
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary reject_button">확인</button>
	        <button type="button" class="btn btn-secondary cancel_button" data-bs-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>

<script type="text/javascript">
	$(function() {
		
		var docNo;
		var apprNo;
		var rejectMemo;
		
		// 문서 보기
		$('#receive_list').on('click','a[id^=receive_approval_detail]',function(event) {
			docNo = $(this).data('appr_doc_no');
			apprNo = $(this).data('appr_id_no');
			location.href='receive_detail?docNo=' + docNo + '&apprNo=' + apprNo + '&pageNo=' + ${ pageNo };
		});
		
		// 결재 승인
		$('#receive_list').on('click','a[id^=receive_approval_admit]',function(event) {
			docNo = $(this).data('appr_doc_no');
			apprNo = $(this).data('appr_id_no');
			
			const ok = confirm("결재번호 [" + apprNo + "] 승인 하시겠습니까?");
			if (!ok)
				return;
					
				$.ajax({
					"url" : "admit_approval",
			 		"method" : "get",
			 		"data" : 'apprNo=' + apprNo,
			 		"success" : function(data, status, xhr) {
			 			$('#receive_list').load("receive_list?pageNo=" + ${ pageNo });
			 		},
			 		"error" : function(xhr, status, err) {
			 			alert('실패');
			 		}
				});
			
		});
		
		// 결재 반려
		$('#receive_list').on('click','a[id^=receive_approval_reject]',function(event) {

			docNo = $(this).data('appr_doc_no');
			apprNo = $(this).data('appr_id_no');
			
			const ok = confirm("결재번호 [" + apprNo + "] 반려 하시겠습니까?");
			if (!ok)
				return;
			
			$('#reject_modal').modal('show');
			
		});
		
		$('#reject_modal').on('click','.reject_button',function(event) {
			
			rejectMemo = $('#rejectMemoForm').serialize();
			
			$.ajax({
				"url" : "reject_approval",
		 		"method" : "get",
		 		"data" : rejectMemo + '&apprNo=' + apprNo,
		 		"success" : function(data, status, xhr) {
		 			$('#receive_list').load("receive_list?pageNo=" + ${ pageNo });
		 			$('#reject_modal textarea').val("");
					$('#reject_modal').modal('hide');
		 		},
		 		"error" : function(xhr, status, err) {
		 			alert('실패');
		 		}
			});
		})
		
		$('#reject_modal').on('click','.cancel_button',function(event) {
			$('#reject_modal textarea').val("");
			$('#reject_modal').modal('hide');
			
		})
		
	})
</script>
</body>
</html>
