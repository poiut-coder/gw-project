<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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