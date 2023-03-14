<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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