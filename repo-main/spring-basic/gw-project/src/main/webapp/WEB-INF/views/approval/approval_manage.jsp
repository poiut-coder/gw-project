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
  <title>Project Demo Web</title>
  
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

<!-- 본문 -->
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>결재 요청</h1>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-3">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">결재 경로</h3>

                <div class="card-tools">
                 <button type="button" class="btn btn-default btn-sm" id="route_up">
                  <i class="fas fa-caret-up text-primary"></i>
                  </button>
                  <button type="button" class="btn btn-default btn-sm" id="route_down">
                  <i class="fas fa-caret-down text-primary"></i>
                  </button>
                  <button type="button" class="recomment-link btn btn-sm btn-success" id="route_add">
                  추가
                  </button>
                  <button type="button" class="recomment-link btn btn-sm btn-danger" id="route_del">
                  삭제
                  </button>
                </div>
              </div>
              <form id="approval_form">
              <div class="card-body p-0" id="approval_route">
                <ul class="nav nav-pills flex-column">
                  <c:forEach var="route" items="${ routes }">
                  <input name="apprNo" type="hidden" value="${ route.appr_id_no }">
                  <c:set var="sumOne" value="${sumOne+1}"/>
                  <li class="nav-item active">
                    <a id="routeChoose${ route.appr_id_no }" href="#" class="nav-link" data-appr_id_no="${ route.appr_id_no }">
                      <i class="fas fa-user"></i> ${ sumOne }.
                      <c:forEach var="apMember" items="${ apMembers }">
						<c:if test="${ route.appr_receiver == apMember.mem_id_no}">
						[${ apMember.dept_name }] &nbsp; [${ apMember.role_name }-${ apMember.mem_detail_name }]
						</c:if>
					  </c:forEach>
                    </a>
                  </li>
                  </c:forEach>
                </ul>
              </div>
              </form>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
            
          </div>
        <!-- /.col -->
        <div class="col-md-9" id="doc_list">
          <div class="card card-primary card-outline">
            <div class="card-header">
              <h3 class="card-title">문서 목록</h3>

              <!-- /.card-tools -->
            </div>
            <!-- /.card-header -->
            <div class="card-body p-0">
              
              <div class="table-responsive mailbox-messages">
                <table class="table table-hover table-striped" style="text-align: center;">
                  <tbody>
                  <tr>
                    <th >#</th>
                    <th style="width: 10px"><i id="starmark_nav" class='fas fa-star text-warning'></i></th>
                    <th style="width: 180px">문서명</th>
                    <th style="width: 280px">메모</th>
                    <th style="width: 10px"></th>
                    <th style="width: 10px"></th>
                    <th style="width: 10px"></th>
                    <th>결재 요청</th>
                    <th>문서 보기</th>
                    <th>문서 삭제</th>
                    <th style="width: 150px">작성일</th>
                  </tr>
                  <c:if test="${ onStar == 0 && pageNo > 1 }"><c:set var="sum" value="${ (pageNo-1)*10 }"></c:set></c:if>
                  <c:if test="${ onStar == 1 && sPageNo > 1 }"><c:set var="sum" value="${ (sPageNo-1)*10 }"></c:set></c:if>
                  <c:forEach var="doc" items="${ docs }">
                  <c:set var="sum" value="${ sum + 1 }"></c:set>
                  <tr>
                    <td>${ sum }</td>
                    <c:choose>
                    <c:when test="${doc.doc_star}">
                    <td id="starmark${ doc.doc_id_no }"><i data-doc_id_no="${ doc.doc_id_no }" class='fas fa-star text-warning'></i></td>
                    </c:when>
                    <c:otherwise>
                    <td id="starmark${ doc.doc_id_no }"><i data-doc_id_no="${ doc.doc_id_no }" class='far fa-star text-warning'></i></td>
                    </c:otherwise>
                    </c:choose>
                    
                    <td><b>${doc.doc_title}</b></td>
                    <td id="td_doc_memo${ doc.doc_id_no }">${doc.doc_memo}</td>
                    <c:choose>
                    <c:when test="${empty doc.doc_memo}">
                    <td><button data-doc_id_no="${ doc.doc_id_no }" id="btn_write_memo${ doc.doc_id_no }" class="btn-xs btn-default">작성</button></td>
                    <td></td>
                    <td></td>
                    </c:when>
                    <c:otherwise>
                    <td></td>
                    <td><button data-doc_id_no="${ doc.doc_id_no }" id="btn_modify_memo${ doc.doc_id_no }" class="btn-xs btn-default">수정</button></td>
                    <td><button data-doc_id_no="${ doc.doc_id_no }" id="btn_delete_memo${ doc.doc_id_no }" class="btn-xs btn-default">삭제</button></td>
                    </c:otherwise>
                    </c:choose>
                    <td><button data-doc_id_no="${ doc.doc_id_no }" data-doc_title="${ doc.doc_title }" id="btn_doc_approval${ doc.doc_id_no }" class="btn-sm btn-success"><i class="fas fa-user-check"></i> 결재 요청 </button></td>
                    <td><button data-doc_id_no="${ doc.doc_id_no }" id="btn_doc_detail${ doc.doc_id_no }" class="btn-sm btn-dark"><i class="fas fa-file-alt"></i> 문서 보기 </button></td>
                    <td><button data-doc_id_no="${ doc.doc_id_no }" id="btn_doc_delete${ doc.doc_id_no }" class="btn-sm btn-danger"><i class="fas fa-eraser"></i> 문서 삭제 </button></td>
                    <td>${doc.doc_regdate}</td>
                  </tr>
                  
                  </c:forEach>
                  </tbody>
                </table>
                <!-- /.table -->
              </div>
              <!-- /.mail-box-messages -->
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
          </div> 
          <!-- /.card -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <!-- /본문 -->
  
  <!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
  <!-- /.footer -->
  
  <!-- Control Sidebar -->
  <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->
<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
  
  <!-- Modal -->
	<div class="modal fade" id="route_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="recomment-modal-Label" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h3 class="modal-title fs-5" id="route-modal-Label">결재자 추가</h3>
	      </div>
	      <div class="modal-body">
	        <!-- write comment area -->
	        <div class="row">
				<div class="col-3">
	                <div class="form-group">
	                    <label>부서:</label>
	                    <select name="approval_dept" class="select2" style="width: 100%;">
	                        <option hidden="" disabled="disabled" selected="selected" value="">부서</option>
	                        <c:forEach var="dept" items="${ depts }">
	                        <option value="${ dept.dept_id_no }">${ dept.dept_name }</option>
	                        </c:forEach>
	                    </select>
	                </div>
	            </div>
	            <div class="col-3">
	                <div class="form-group">
	                    <label>결재자:</label>
	                    <select name="approval_member" class="select2" style="width: 200px;">
	                        <option hidden="" disabled="disabled" selected="selected" value="">결재자</option>
	                    </select>
	                    
	                </div>
	            </div>
            </div>
            
	            <div class="float-right">
	                <button type="button" class="btn btn-success add_button" >추가</button>
            	</div>
            	
            	<div id="added_route_list">
            	<c:forEach var="route" items="${ routes }">
            	<c:set var="sumTwo" value="${sumTwo+1}"/>
                  <span id="addRoute${ route.appr_receiver }" style="color: green;">
                  ${ sumTwo }.
                  <c:forEach var="apMember" items="${ apMembers }">
					<c:if test="${ route.appr_receiver == apMember.mem_id_no}">
					[${ apMember.dept_name }] [&nbsp;${ apMember.role_name } - ${ apMember.mem_detail_name }&nbsp;]
					<br>
					</c:if>
				  </c:forEach>
                  </span>
                 </c:forEach>
            	</div>
            	
            	<div>	
            	<form id="route_form">
            	</form>
            	</div>
			<!-- end of write comment area -->
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary check_button">확인</button>
	        <button type="button" class="btn btn-secondary cancel_button" data-bs-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="memo_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="recomment-modal-Label" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="memo-modal-Label">메모 작성</h1>
	      </div>
	      <div class="modal-body">
	        <!-- write comment area -->
			<form id="memoForm" action="write_doc_memo">
				<textarea class="form-control" name="doc_memo" rows="3"></textarea>
			</form>
			<!-- end of write comment area -->
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary write_button">쓰기</button>
	        <button type="button" class="btn btn-secondary cancel_button" data-bs-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="approval_modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="recomment-modal-Label" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h2 class="modal-title fs-5" id="approval-modal-Label">결재 내용</h2>
	      </div>
	      <div class="modal-body">
	        <!-- write comment area -->
			<form id="approvalMemoForm">
				<textarea class="form-control" name="approval_memo" rows="3"></textarea>
			</form>
			<!-- end of write comment area -->
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary write_button">확인</button>
	        <button type="button" class="btn btn-secondary cancel_button" data-bs-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
<script type="text/javascript">
	$(function() {
		
		var onStar = ${onStar};
		
		// 스타 마크
			
		$('#doc_list').on('click','td[id^=starmark] i',function(event) {
			
			var docNo = $(this).data('doc_id_no')
					
				$.ajax({
					"url" : "update_starmark",
			 		"method" : "get",
			 		"data" : 'docNo=' + docNo,
			 		"success" : function(data, status, xhr) {
			 			if(onStar == 1 && $('#doc_list td[id^=td_doc_memo]').length == 1) {
			 				
			 				if (${sPageNo} == 1) {
			 					$('#doc_list').load("doc_list?onStar=" + onStar + 
					 					"&pageNo=" + ${ pageNo } + "&sPageNo=" + ${sPageNo});
							} else {
		 						location.href="manage?onStar=" + onStar + 
				 					"&pageNo=" + ${ pageNo } + "&sPageNo=" + (${sPageNo}-1);
							}
		 					return;
		 				}
			 			
			 			$('#doc_list').load("doc_list?onStar=" + onStar + 
			 					"&pageNo=" + ${ pageNo } + "&sPageNo=" + ${sPageNo});
			 			
			 		},
			 		"error" : function(xhr, status, err) {
			 			alert('실패');
			 		}
				});
			
			})
			
		// 스타 마크만 불러오기
		
		$('#doc_list').on('click','#starmark_nav',function(event) {
			
			if (onStar == 0) {
				onStar = 1;
			} else {
				onStar = 0;
			}
			
			$('#doc_list').load("doc_list?onStar=" + onStar + 
 					"&pageNo=" + ${ pageNo } + "&sPageNo=" + ${sPageNo});
		})
		
		var memoDocId;
		
		//메모 Modal
		$('#doc_list').on('click','button[id^=btn_write_memo]',function(event) {
						
			memoDocId = $(this).data('doc_id_no')
			$('#memo_modal').modal('show');
		
		});
		
		$('#doc_list').on('click','button[id^=btn_modify_memo]',function(event) {
						
			memoDocId = $(this).data('doc_id_no');
			$('#memo_modal textarea').val($('#td_doc_memo'+memoDocId).html());
			$('#memo_modal').modal('show');
		
		});
		
		$('#memo_modal').on('click', '.cancel_button', function(event) {
			$('#memo_modal textarea').val("");
			$('#memo_modal').modal('hide');
		});
		
		//메모 작성 및 수정
		$('#memo_modal').on('click','.write_button',function(event) {
			var memoFormData = 'doc_id_no=' + memoDocId + '&' + $('#memoForm').serialize();
			
			$.ajax({
				"url" : "write_memo",
		 		"method" : "post",
		 		"data" : memoFormData,
		 		"success" : function(data, status, xhr) {
		 			
		 			$('#doc_list').load("doc_list?onStar=" + onStar + 
		 					"&pageNo=" + ${ pageNo } + "&sPageNo=" + ${sPageNo});
						$('#memo_modal textarea').val("");
						$('#memo_modal').modal('hide');
		 			
		 		},
		 		"error" : function(xhr, status, err) {
		 			alert('실패');
		 		}
			});
			
		});
		
		//메모 삭제
		
		$('#doc_list').on('click','button[id^=btn_delete_memo]',function(event) {
					
			const ok = confirm("메모를 삭제하시겠습니까?");
			if (!ok)
				return;
			
			$.ajax({
				"url" : "delete_memo",
		 		"method" : "get",
		 		"data" : 'doc_id_no=' + $(this).data('doc_id_no'),
		 		"success" : function(data, status, xhr) {
		 			$('#doc_list').load("doc_list?onStar=" + onStar + 
		 					"&pageNo=" + ${ pageNo } + "&sPageNo=" + ${sPageNo});
		 		},
		 		"error" : function(xhr, status, err) {
		 			alert('실패');
		 		}
			});
			
		});
		
		// 문서 보기
		$('#doc_list').on('click','button[id^=btn_doc_detail]',function(event) {
			var docNo = $(this).data('doc_id_no');
			location.href='detail?docNo=' + docNo + '&pageNo=' + ${ pageNo } + "&sPageNo=" + ${sPageNo} + '&onStar=' + onStar; 
		});
		
		// 문서 삭제
		$('#doc_list').on('click','button[id^=btn_doc_delete]',function(event) {
			
			var docNo = $(this).data('doc_id_no')
			
			const ok = confirm("문서를 삭제하시겠습니까?");
			if (!ok)
				return;
					
				$.ajax({
					"url" : "delete_approval_doc",
			 		"method" : "get",
			 		"data" : 'docNo=' + docNo,
			 		"success" : function(data, status, xhr) {
			 			$('#doc_list').load("doc_list?onStar=" + onStar + 
			 					"&pageNo=" + ${ pageNo } + "&sPageNo=" + ${sPageNo});
			 		},
			 		"error" : function(xhr, status, err) {
			 			alert('실패');
			 		}
				});
			
		});
		
		var deptNo;
		var memberId;
		var deptName;
		var memberName;
		var count=${count};
		var apprNo;
		//경로 선택
		
		$('#approval_route a').css({
            "border" : "solid 2px gray"    
        });
		
		$('#approval_route').on('click','a',function(event) {
			$('#approval_route a').css({
	            "border" : "solid 2px gray"    
	        });
			
			$(this).css({
                "border" : "solid 2px green"
            });
			
			apprNo = $(this).data('appr_id_no');
			preTurn = $(this).data('appr_preturn');
		});
		
		//경로 추가 modal
		
		$('#route_add').on('click',function(event) {
			$.ajax({
				"url" : "count_approval_route",
		 		"method" : "get",
		 		"success" : function(data, status, xhr) {
					count = parseInt(data);
		 		},
		 		"error" : function(xhr, status, err) {
		 			alert('실패');
		 		}
			});
			$('#route_modal').modal('show');
		});
		
		$('#route_modal').on('click','.cancel_button',function(event) {
			$('#route_modal').modal('hide');
			$('select[name=approval_dept]').val("");
			$('select[name=approval_member]').val("");
			deptNo = 0;
			memberId = 0;
			$('select[name=approval_member]').load("find_approval_member?deptNo=" + deptNo);
			$("#route_form").html("");
		});
		
		//결재경로 부서 선택
		
		$('select[name=approval_dept]').on('change',function(event) {
			deptNo = $(this).val();
			memberId = 0;
			deptName = $('select[name=approval_dept] option[value=' + deptNo + ']').text();
			$('select[name=approval_member]').load("find_approval_member?deptNo=" + deptNo);	
		})
		
		$('select[name=approval_member]').on('change',function(event) {
			memberId = $(this).val();
			memberName = $('select[name=approval_member] option[value=' + memberId + ']').text();
		})
		
		//결재경로 추가		
		
		$('#route_modal').on('click','.add_button',function(event) {
			
			if (count == 5) {
				alert('최대 결재자는 5명 입니다.')
				return;
			} else if (memberId == ${ loginuser.mem_id_no }) {
				alert('결재자와 기안자가 같습니다.')
				return;
			} else if($('#addRoute'+memberId).length != 0) {
				alert('이미 추가된 결재자 입니다.')
				return;
			} else if (deptNo == 0 || memberId == 0) {
				alert('결재자를 선택 하세요.')
				return;
			}
			count = count + 1;
			
    		$("#route_form").append("<input id='addRoute" + memberId + "' type='hidden' name='memberIds' value='" + memberId + "'>");
    		$("#route_form").append(count + ".&nbsp;[" + deptName + "]" + "&nbsp;[" + memberName + "]");
    		$("#route_form").append("<br>");
		});
		
		
		//결재경로 추가 확인
		$('#route_modal').on('click','.check_button',function(event) {
			
			var routeForm = $("#route_form").serialize();
			
			if (routeForm.length == 0) {
				$('#route_modal').modal('hide');
				$('select[name=approval_dept]').val("");
				$('select[name=approval_member]').val("");
				deptNo = 0;
				memberId = 0;
				return;
			}
			
			$.ajax({
				"url" : "add_approval_route",
		 		"method" : "post",
		 		"data" : routeForm,
		 		"success" : function(data, status, xhr) {
		 			$('#route_modal').modal('hide');
		 			$('select[name=approval_dept]').val("");
					$('select[name=approval_member]').val("");
					deptNo = 0;
					memberId = 0;
					count = parseInt(data);
					
					$('#approval_route').load('route_list');
		 			$('#added_route_list').load('added_route_list');
		 			$("#route_form").html("");
		 		},
		 		"error" : function(xhr, status, err) {
		 			alert('실패');
		 		}
			});
			
		});
		
		//결재경로 삭제
		$('#route_del').on('click',function(event) {
			
			$.ajax({
				"url" : "del_approval_route",
		 		"method" : "post",
		 		"data" : "apprNo=" + apprNo,
		 		"success" : function(data, status, xhr) {
					count = parseInt(data);
					
					$('#approval_route').load('route_list');
		 			$('#added_route_list').load('added_route_list');
		 		},
		 		"error" : function(xhr, status, err) {
		 			alert('경로를 선택 하세요');
		 		}
			});
		})
		
		//결재경로 이동
		$('#route_up').on('click',function(event) {
			
			$.ajax({
				"url" : "up_approval_route",
		 		"method" : "get",
		 		"data" : "apprNo=" + apprNo,
		 		"success" : function(data, status, xhr) {
					
					$('#approval_route').load('route_list?apprNo='+apprNo);
					$('#added_route_list').load('added_route_list');
		 			
		 		},
		 		"error" : function(xhr, status, err) {
		 			alert('경로를 선택 하세요');
		 		}
			});
			
		})
		
		$('#route_down').on('click',function(event) {
			
			$.ajax({
				"url" : "down_approval_route",
		 		"method" : "get",
		 		"data" : "apprNo=" + apprNo,
		 		"success" : function(data, status, xhr) {
					
					$('#approval_route').load('route_list?apprNo='+apprNo);
		 			$('#added_route_list').load('added_route_list');
		 			
		 		},
		 		"error" : function(xhr, status, err) {
		 			alert('경로를 선택 하세요');
		 		}
			});
			
		})
		
		var apprDocNo;
		
		//전자결재 기안
		$('#doc_list').on('click','button[id^=btn_doc_approval]',function(event) {
			
			if(count == 0) {
				alert('결재자가 없습니다.')
				return;
			}
			
			const ok = confirm("[ "+$(this).data('doc_title') + " ]"  + " 문서로 결재를 요청합니다.");
			if (!ok)
				return;
			
			$('#approval_modal').modal('show');
			
			apprDocNo = $(this).data('doc_id_no')
			
			
			
		})
		
		//결재 Modal
		
		$('#approval_modal').on('click', '.cancel_button', function(event) {
			$('#approval_modal textarea').val("");
			$('#approval_modal').modal('hide');
		});
		
		$('#approval_modal').on('click','.write_button', function(event) {
			var approvalForm = $('#approval_form').serialize();
			var approvalMemoForm =$('#approvalMemoForm').serialize();
			$.ajax({
				"url" : "get_approval",
		 		"method" : "post",
		 		"data" : approvalForm + "&docNo=" + apprDocNo + "&" + approvalMemoForm,
		 		"success" : function(data, status, xhr) {
					
		 			count = parseInt(data);
					
					$('#approval_route').load('route_list');
		 			$('#added_route_list').load('added_route_list');
		 			$('#approval_modal textarea').val("");
					$('#approval_modal').modal('hide');
		 		},
		 		"error" : function(xhr, status, err) {
		 			alert('실패');
		 		}
			});
			
		})
		
	})
</script>


</body>
</html>
