<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>글상세보기</title>

<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<!-- summernote -->
<link rel="stylesheet"
	href="/gw-project/resources/plugins/summernote/summernote-bs4.min.css">

</head>
<body class="hold-transition sidebar-mini">
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
			<section class="content-header">
				<div class="container-fluid">
					<div class="row mb-2">
						<div class="col-sm-6">
							<h1>글상세보기</h1>
						</div>
						<div class="col-sm-6">
							<ol class="breadcrumb float-sm-right">
								<li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
								<li class="breadcrumb-item active">Detail</li>
							</ol>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</section>

			<div class="col-md-9">
				<div class="card card-primary card-outline">
					<div class="card-header">
						<h3 class="card-title"></h3>	
					<div class="card-tools">
						<c:choose>
							<c:when test="${empty prevBoard eq false}">
								<a href="detail?writeIdNo=${prevBoard.writeIdNo}&typeIdNo=${prevBoard.typeIdNo}" class="btn btn-tool" title="Previous"><i class="fas fa-chevron-left"></i></a>
							</c:when>
							<c:otherwise>
								<a href="#" class="btn btn-tool" title="Previous"><i id="btn-first" class="fas fa-chevron-left"></i></a>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${empty nextBoard eq false}">
								<a href="detail?writeIdNo=${nextBoard.writeIdNo}&typeIdNo=${nextBoard.typeIdNo}" class="btn btn-tool" title="Next"><i class="fas fa-chevron-right"></i></a>
							</c:when>
							<c:otherwise>
								<a href="#" class="btn btn-tool" title="Previous"><i id="btn-last" class="fas fa-chevron-right"></i></a>
							</c:otherwise>
						</c:choose>
						</div>
					</div>
					<!-- /.card-header -->
					<div class="card-body p-0">
						<div class="mailbox-read-info">
							<h5>
								<c:choose>
									<c:when test="${boardNotice.typeIdNo eq 1}">
										${boardNotice.title}
									</c:when>
									<c:otherwise>
	          							${boardUnknown.title}
	          						</c:otherwise>
								</c:choose>
							</h5>
							<h6>
								<c:choose>
									<c:when test="${boardNotice.typeIdNo eq 1}">
										${boardNotice.noticeWriter}
									</c:when>
									<c:otherwise>
	          							익명
	          						</c:otherwise>
								</c:choose>
								<span class="mailbox-read-time float-right">
									<c:choose>
										<c:when test="${boardNotice.typeIdNo eq 1}">
											${boardNotice.dateFormForJsp}
									</c:when>
									<c:otherwise>
	          								${boardUnknown.dateFormForJsp}
	          						</c:otherwise>
									</c:choose>
								</span>
							</h6>
						</div>
						<div class="mailbox-read-info">
							<h6><i class="fas fa-paperclip"></i> 첨부파일</h6>
							<c:choose>
								<c:when test="${boardNotice.typeIdNo eq 1}">
									<c:forEach var="attachment" items="${boardNotice.attachments}">
										<a href="download?attachIdNo=${attachment.attachIdNo}">
											${attachment.attachUserFileName}</a>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="attachment" items="${boardUnknown.attachments}">
										<a href="download?attachIdNo=${attachment.attachIdNo}">
											${attachment.attachUserFileName}</a>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
						<!-- /.mailbox-read-info -->
						<div class="mailbox-read-message">
							<c:choose>
								<c:when test="${boardNotice.typeIdNo eq 1}">
									${boardNotice.content}
								</c:when>
								<c:otherwise>
	          						${boardUnknown.content}
	          					</c:otherwise>
							</c:choose>
						</div>
						<input type="hidden" id="rewrite-passwd" value="${boardUnknown.unRewritePasswd}" />
						<!-- /.mailbox-read-message -->
					</div>
					<!-- /.card-body -->
					<!-- /.card-footer -->
					<div class="card-footer">
						<div class="float-right">
							<button id="btn-list" type="button" class="btn btn-default">
								<i class="fas fa-reply"></i> 목록보기</a>
							</button>
							<c:choose>
								<c:when test="${boardNotice.typeIdNo eq 1}">
									<input type="hidden" name="writeIdNo" value="${boardNotice.writeIdNo}" data-writeIdNo="${boardNotice.writeIdNo}" />
									<input type="hidden" name="typeIdNo" value="${boardNotice.typeIdNo}" data-typeIdNo="${boardNotice.typeIdNo}"/>
								</c:when>
								<c:otherwise>
									<input type="hidden" name="writeIdNo" value="${boardUnknown.writeIdNo}" data-writeIdNo="${boardUnknown.writeIdNo}" />
									<input type="hidden" name="typeIdNo" value="${boardUnknown.typeIdNo}" data-typeIdNo="${boardUnknown.typeIdNo}" />
								</c:otherwise>
							</c:choose>
							<input type="hidden" name="pageNo" value="${pageNo}" data-pageNo="${pageNo}" />
							<c:choose>
								<c:when test="${boardNotice.typeIdNo eq 1}">
									<c:if test="${(not empty loginuser and loginuser.mem_id_no eq boardNotice.noticeMemNo) || adminuser  eq 1}">
										<button id="btn-edit" type="button" class="btn btn-default">
											<i class="fas fa-print"></i> 편집
										</button>
										<button id="btn-delete" type="button" class="btn btn-default">
											<i class="far fa-trash-alt"></i> 삭제
										</button>
									</c:if>
								</c:when>
								<c:otherwise>
									<button id="btn-edit" type="button" class="btn btn-default">
										<i class="fas fa-print"></i> 편집
									</button>
									<button id="btn-delete" type="button" class="btn btn-default">
										<i class="far fa-trash-alt"></i> 삭제
									</button>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<!-- /.card-footer -->
				</div>
				<!-- /.card -->
				
				<!-- write comment area -->
				<div class="card-footer">
					<form id="comment-form" action="write-comment" method="post">
						<c:choose>
							<c:when test="${boardNotice.typeIdNo eq 1}">
								<input type="hidden" name="writeIdNo" value="${boardNotice.writeIdNo}" />
								<input type="hidden" name="comWriter" value="${loginuser.mem_id_no}" />
								<input type="hidden" name="typeIdNo" value="${boardNotice.typeIdNo}" />
							</c:when>
							<c:otherwise>
								<input type="hidden" name="writeIdNo" value="${boardUnknown.writeIdNo}" />
								<input type="hidden" name="comWriter" value="1">
								<input type="hidden" name="typeIdNo" value="${boardUnknown.typeIdNo}" />
							</c:otherwise>
						</c:choose>
						<input type="hidden" name="pageNo" value="${pageNo}" />

							<span class="username">
							<c:choose>
								<c:when test="${boardNotice.typeIdNo eq 1}">
									${loginuser.memberDetail.mem_detail_name}
								</c:when>
								<c:otherwise>
									<span> *비밀번호 : 
									<input id="comment-passwd" type="password" name="comPasswd" placeholder="수정/삭제시 필요한 비밀번호를 입력하세요." style="width:350px;"/>
									</span>
								</c:otherwise>
							</c:choose>
							</span>
							<div class="input-group">
								<input type="text" id="comment-content" name="comContent" placeholder="댓글을 입력하세요." class="form-control">
								<span class="input-group-append">
									<button id="write-comment" type="button" class="btn btn-primary">등록</button>
								</span>
							</div>
					</form>
				</div>
				<!-- write comment area -->
				<!-- comment -->
				<div id="comment-list" class="card-footer card-comments">
			
				</div>
				<!-- /.comment -->
				
			</div>
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
	
	<!-- recomment modal -->
	<div class="modal fade show" id="recomment-modal" style="display: none; padding-right: 17px;" aria-modal="true" role="dialog">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">댓글쓰기</h4>
              <button type="button" id="btn-close" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">×</span>
              </button>
            </div>
            <div class="modal-body">
              <form id="recomment-form" action="write-recomment" method="post">
              	<input type="hidden" name="comIdNo" value="" />
              	<c:choose>
              		<c:when test="${boardNotice.typeIdNo eq 1}">
              			<span style="font-weight:bold;">작성자</span> ${loginuser.memberDetail.mem_detail_name}
              			<input type="hidden" name="comWriter" value="${loginuser.mem_id_no}" />
              		</c:when>
              		<c:otherwise>
              			<input type="hidden" name="comWriter" value="${loginuser.mem_id_no}" />
						<span> *비밀번호 :
							<input id="recomment-passwd" type="password" name="comPasswd" placeholder="수정/삭제시 필요한 비밀번호를 입력하세요." style="width: 350px;" />
						</span>
					</c:otherwise>
              	</c:choose>
              	
              	<textarea class="recomment-content" name="comContent" style="width:460px;"></textarea>
              </form>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-primary btn-write ">등록</button>
            </div>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.recomment modal -->

	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
	<!-- Summernote -->
	<script
		src="/gw-project/resources/plugins/summernote/summernote-bs4.min.js"></script>

	<!-- Page specific script -->
	<script type="text/javascript">
		$(function() {
			
			// 이전페이지(<)
			$('#btn-first').on('click', function(event) {
				alert('첫번째 게시글입니다.');
			});
			
			// 다음페이지(>)
			$('#btn-last').on('click', function(event) {
				alert('마지막 게시글입니다.');
			});
			
			var typeIdNo = ${typeIdNo};
			
			// 목록보기
			$('#btn-list').on('click', function(event) {
				
				if (typeIdNo == 1) {
					location.href = 'notice?pageNo=${pageNo}';
				} else if (typeIdNo == 2) {
					location.href = 'unknown?pageNo=${pageNo}';
				}
			});
			
			var rewritePasswd = $('#rewrite-passwd').val();
			
			// 편집(edit.jsp로 이동)
			$('#btn-edit').on('click', function(event) {

				if (typeIdNo == 1) {
					location.href = 'edit?writeIdNo=${boardNotice.writeIdNo}&typeIdNo=${boardNotice.typeIdNo}&pageNo=${pageNo}';
				} else if (typeIdNo == 2) {
					// 2차 비밀번호가 맞아야 넘어갈 수 있게 함.
					var inputPasswd = prompt('2차 비밀번호를 입력하세요.');
					
					if (inputPasswd == rewritePasswd) {
						location.href = 'edit?writeIdNo=${boardUnknown.writeIdNo}&typeIdNo=${boardUnknown.typeIdNo}&pageNo=${pageNo}';
					} else {
						return;
					}
				}
			});

			// 게시글 삭제
			$('.card-footer').on('click', '#btn-delete', function(event) {
				
				var writeIdNo = $('input[name=writeIdNo]').val();
				var typeIdNo = $('input[name=typeIdNo]').val();
				var pageNo = $('input[name=pageNo]').val();
				var ok = null;
				
				if (typeIdNo == 1) {
					ok = confirm("해당 게시글을 삭제하시겠습니까?");
				} else if (typeIdNo == 2) {
					
					var adminuser = ${adminuser eq 1};
					if (adminuser) {
						ok = confirm("해당 게시글을 삭제하시겠습니까?");
					} else {
						var inputPasswd = prompt('2차 비밀번호를 입력하세요.');
						
						if (inputPasswd == rewritePasswd) {
							ok = confirm("해당 게시글을 삭제하시겠습니까?");
						} else {
							alert('비밀번호가 맞지 않습니다!');
							return;
						}
					}	
				}
				
				if (ok) {
					$.ajax({
						"url" : "/gw-project/board/delete/" + writeIdNo,
						"type" : "get",
						"data" : {
							"writeIdNo" : writeIdNo,
							"typeIdNo" : typeIdNo,
							"pageNo" : pageNo
						},
						"success" : function(data, status, xhr) {
							if (typeIdNo == 1) {
								location.href = 'notice?typeIdNo=' + ${boardNotice.typeIdNo} + '&pageNo=' + ${pageNo};	
							} else if (typeIdNo == 2){
								location.href = 'unknown?typeIdNo=' + ${boardUnknown.typeIdNo} + '&pageNo=' + ${pageNo};
								// 2차 비밀번호가 맞아야 넘어갈 수 있게 함.
							}
						},
						"error" : function(data, status, err) {
							alert("삭제 실패");
						}
					})
					
				} else if (!ok) return;
			});
			
			// 댓글 ///////////////////////////////////////////////////////////////
			// 댓글 리스트
			if (typeIdNo == 1) {
				$('#comment-list').load("comment-list?writeIdNo=${boardNotice.writeIdNo}&typeIdNo=" + typeIdNo );	
			} else if (typeIdNo == 2) {
				$('#comment-list').load("comment-list?writeIdNo=${boardUnknown.writeIdNo}&typeIdNo=" + typeIdNo);
			}
			
			// 댓글 쓰기
			// 댓글 등록 함수
			function writeComment() {
				
				const formData = $('#comment-form').serialize();	// form 내부의 모든 입력 요소의 값을 전송가능한 문자열
				// const formData = $('#comment-form').serialize();	// form 내부의 모든 입력 요소의 값을 전송가능한 객체 배열 형식으로 반환
				
				$.ajax({
					"url" : "write-comment",
					"method" : "post",
					"data" : formData,
					"success" : function(data, status, xhr) {
						if (data == "success") {
							if (typeIdNo == 1) {
								$('#comment-list').load("comment-list?writeIdNo=${boardNotice.writeIdNo}&typeIdNo=" + typeIdNo );	
							} else if (typeIdNo == 2) {
								$('#comment-list').load("comment-list?writeIdNo=${boardUnknown.writeIdNo}&typeIdNo=" + typeIdNo);
							}
						}
						$('#comment-content').val("");	// 댓글등록후 입력창 비우기
						$('#comment-passwd').val("");
					},
					"error" : function(data, status, err) {
						alert("댓글 등록에 실패했습니다1");
					}
				})
			}
			
			// enter시 댓글 등록
			$('#comment-content').on('keypress', function(event) {
				if(event.keyCode == '13') {
					if(window.event) {
						event.preventDefault();
						writeComment();
					} else {
						alert('댓글 등록에 실패했습니다2');	
					}
				} 
			});
			
			// 댓글 쓰기
			$('#write-comment').on('click', function(event) {
				event.preventDefault();
				writeComment();
			});
			
			// 댓글 삭제
			$('#comment-list').on('click', '.delete-comment', function(event) {
				
				event.preventDefault();
				var comIdNo = $(this).data('comment-no');
				var comPasswd = $('#comment-rewritepw').val();
				var yn = null;
				 
				if (typeIdNo == 1) {
					yn = confirm(comIdNo + "번 댓글을 삭제하시겠습니까?");
					if(!yn) return;
				} else if (typeIdNo == 2) {
					var adminuser = ${adminuser eq 1};
					if (adminuser) {
						yn = confirm(comIdNo + "번 댓글을 삭제하시겠습니까?");
						if(!yn) return;
					} else {
						var passwd = prompt('비밀번호를 입력하세요.');
						if (comPasswd == passwd) {
							const viewArea = $('#comment-view-area-' + comIdNo);
							viewArea.find('#comment-rewritepw').val();
							yn = confirm(comIdNo + "번 댓글을 삭제하시겠습니까?");
							if(!yn) return;
						} else {
							alert('비밀번호가 맞지 않습니다!');
							return;
						}
					}
				}
					
				$.ajax({
					"url": "delete-comment",
					"method" : "get",
					"data" : "comIdNo=" + comIdNo,
					"success" : function(data, status, xhr) {
						if (data == "success") {
							if (typeIdNo == 1) {
								$('#comment-list').load("comment-list?writeIdNo=${boardNotice.writeIdNo}&typeIdNo=" + typeIdNo);	
							} else if (typeIdNo == 2) {
								$('#comment-list').load("comment-list?writeIdNo=${boardUnknown.writeIdNo}&typeIdNo=" + typeIdNo);
							}
						} else {
							alert('댓글 삭제에 실패했습니다2');
						}
					},
					"error" : function(data, status, err) {
						alert('댓글 삭제에 실패했습니다1');
					}
				})
			});
			
			// 댓글 수정
			// 편집 버튼 클릭시 댓글창 바뀜
			var currentEditComIdNo = null;
			
			$('#comment-list').on('click', '.edit-comment', function(event) {
				event.preventDefault();
				
				if (currentEditComIdNo != null) {
					$('#comment-view-area-' + currentEditComIdNo).show();
					$('#comment-edit-area-' + currentEditComIdNo).hide();
				}
				
				var comIdNo = $(this).data('comment-no');
				var comPasswd = $('#comment-rewritepw').val();
				
				if (typeIdNo == 1) {
					$('#comment-view-area-' + currentEditComIdNo).hide();
					$('#comment-edit-area-' + currentEditComIdNo).show();
				} else if (typeIdNo == 2) {
					$('#comment-view-area-' + currentEditComIdNo).hide();
				
					var passwd = prompt('비밀번호를 입력하세요.');
					if (comPasswd == passwd) {
						const editArea = $('#comment-edit-area-' + currentEditComIdNo);
						editArea.find('input[name=comPasswd]').val(passwd);
						$('#comment-edit-area-' + currentEditComIdNo).show();
					} else {
						alert('비밀번호가 맞지 않습니다!');
					}
				}
				
				currentEditComIdNo = comIdNo;
			});
			
			// 댓글 수정하기 취소
			$('#comment-list').on('click', '.cancel-edit-comment', function(event) {
				event.preventDefault();
				
				var comIdNo = $(this).data('comment-no');
				const editForm =$('#comment-edit-area-' + comIdNo+ ' form');
				editForm[0].reset();
				
				$('#comment-view-area-' + currentEditComIdNo).show();
				$('#comment-edit-area-' + currentEditComIdNo).hide();

				currentEditComIdNo = null;
			});	
			
			// 수정한 댓글 내용 등록
			$('#comment-list').on('click', '.update-comment', function(event) {
				const comIdNo = $(this).data('comment-no');
				const editForm =$('#comment-edit-area-' + comIdNo + ' form');
				
				$.ajax({
					"url" : "/gw-project/board/update-comment",
					"method" : "post",
					"data" : editForm.serialize(),
					"success" : function(data) {
						if (data == "success") {
							if (typeIdNo == 1) {
								$('#comment-list').load("comment-list?writeIdNo=${boardNotice.writeIdNo}&typeIdNo=" + typeIdNo);	
							} else if (typeIdNo == 2) {
								$('#comment-list').load("comment-list?writeIdNo=${boardUnknown.writeIdNo}&typeIdNo=" + typeIdNo);
							}
						}
					},
					"error" : function(xhr, status, err) {
						alert('댓글 수정에 실패했습니다.');
					}
				})
			});
			
			// 대댓글
 			$('#comment-list').on('click', '.recomment-link', function(event) {
				event.preventDefault();
				
				var comIdNo = $(this).data('comment-no');
				$('#recomment-form')[0].reset();
				$('#recomment-form input[name=comIdNo]').val(comIdNo);
				
				$('#recomment-modal').modal('show');
				
			});
			
 			$('#recomment-modal .btn-write').on('click', function(event) {
				if ($('#recomment-form textarea').val().length == 0) {
					alert('댓글을 작성하세요.');
					return;
				}
				
				var formData = $('#recomment-form').serialize();
				
				$.ajax({
					"url" : "write-recomment",
					"method" : "post",
					"data" : formData,
					"success" : function(data) {
						if (data == "success") {
							if (typeIdNo == 1) {
								$('#comment-list').load("comment-list?writeIdNo=${boardNotice.writeIdNo}&typeIdNo=" + typeIdNo);	
							} else if (typeIdNo == 2) {
								$('#comment-list').load("comment-list?writeIdNo=${boardUnknown.writeIdNo}&typeIdNo=" + typeIdNo);
							} 
							$('#recomment-modal').modal('hide');
						}
					},
					"error" : function() {
						
					}
				})
			});
 			$('#btn-close').on('click', function(event) {
 				$('#recomment-modal').modal('hide');
 			});
		});
	</script>
</body>
</html>

