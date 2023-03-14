<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
<div class="card">
              <div class="card-header">
                <h3 class="card-title">결재 정보</h3>
                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                  </button>
                </div>
              </div>
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-file text-info"></i> 결재 내용 : ${ap.appr_memo}</span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-calendar-alt text-info"></i> 기안일자 : ${ap.appr_regdate}</span>
                  </li>
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-user text-info"></i> 기안자 :
                  <c:forEach var="apMember" items="${ apMembers }">
                  <c:if test="${ap.appr_sender == apMember.mem_id_no}">[${ apMember.dept_name }] [&nbsp;${ apMember.role_name } - ${ apMember.mem_detail_name }&nbsp;]</c:if>
                  </c:forEach>                
                  </span>
                  </li>
                  <c:if test="${ ap.appr_status == 2 }">
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="fas fa-ban text-danger"></i> 반려사유 : ${ap.appr_reject_memo}</span>
                  </li>
                  </c:if>
                </ul>
              </div>
              
              <!-- /.card-body -->
            </div>
            
             <div class="card">
              <div class="card-header">
                <h3 class="card-title">결재자</h3>
              </div>
              <div class="card-body p-0">
                <ul class="nav nav-pills flex-column">
                  <c:forEach var="receiver" items="${ receivers }">
                  <li class="nav-item active">
                  <span class ="nav-link" style="font-weight: bold;"><i class="far fa-user text-warning"></i>
                  ${receiver.appr_turn}.
                  
                  <c:forEach var="apMember" items="${ apMembers }">
                  <c:if test="${receiver.appr_receiver == apMember.mem_id_no}">[${ apMember.dept_name }] [&nbsp;${ apMember.role_name } - ${ apMember.mem_detail_name }&nbsp;]</c:if>
                  </c:forEach> 
                 
                 &nbsp;
                  
                 <c:choose>
	             <c:when test="${ receiver.appr_status == 0 }">
	             <span class="badge badge-success float-right">
	             &nbsp;대기중&nbsp;
	             </span>
	             </c:when>
	             <c:when test="${ receiver.appr_status == 1 }">
	             <span class="badge badge-primary float-right">
	             &nbsp;승인&nbsp;
	             </span>
	             </c:when>
	             <c:when test="${ receiver.appr_status == 2 }">
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
                  
                  </span>
                  </li>
                  </c:forEach>
                </ul>
              </div>
              
              <!-- /.card-body -->
            </div>
            
            <!-- /.card -->
            
            <c:choose>
            <c:when test="${ ap.appr_status == 0 }">
            
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">결재 승인</h3>
                <div class="card-tools">
                  <button type="button" class="btn-sm btn-primary" data-appr_id_no="${ ap.appr_id_no }" id="admit_approval">
                  승인
                  </button>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">결재 반려</h3>
                <div class="card-tools">
                  <button type="button" class="btn-sm btn-danger" data-appr_id_no="${ ap.appr_id_no }" id="reject_approval">
                  반려
                  </button>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">목록 보기</h3>
                <div class="card-tools">
                  <button type="button" class="btn-sm btn-dark" id="go_receive_list">
                  목록
                  </button>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            </c:when>
            
            <c:otherwise>
            
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">목록 보기</h3>
                <div class="card-tools">
                  <button type="button" class="btn-sm btn-dark" id="go_receive_list">
                  목록
                  </button>
                </div>
              </div>
              <!-- /.card-body -->
            </div>
            
            </c:otherwise>
            
            </c:choose>