<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<div class="card">
<div class="card-header">
  <h3 class="card-title">문서 양식 (공통)</h3>

  <div class="card-tools">
    <button type="button" class="btn btn-tool" data-card-widget="collapse">
      <i class="fas fa-minus"></i>
    </button>
  </div>
</div>
<!-- /.card-header -->
<div class="card-body p-0">
  <ul class="nav nav-pills flex-column">
  <c:forEach var="sheet" items="${ sheets }">
  <c:if test="${sheet.sheet_all}">
  <li class="nav-item">
  	<a data-sheet_id_no="${sheet.sheet_id_no}" data-sheet_alert="공통 양식은 삭제할 수 없습니다." id="approval_sheet${sheet.sheet_id_no}" class="nav-link" href="#"><i class="far fa-circle text-info"></i>&nbsp;&nbsp;${ sheet.sheet_name }</a>
  </li>
  </c:if>
  </c:forEach>
  </ul>
</div>
<!-- /.card-body -->
</div>

<div class="card">
  <div class="card-header">
    <h3 class="card-title">문서 양식 (개인)</h3>

    <div class="card-tools">
      <button type="button" class="recomment-link btn btn-sm btn-success" id="sheet_add">
      추가
      </button>
      <button type="button" class="recomment-link btn btn-sm btn-danger" id="sheet_del">
      삭제
      </button>
    </div>
  </div>
  <!-- /.card-header -->
<div class="card-body p-0">
  <ul class="nav nav-pills flex-column">
  <c:forEach var="sheet" items="${ sheets }">
  <c:if test="${not sheet.sheet_all and sheet.mem_id_no == loginuser.mem_id_no}">
  <li class="nav-item">
  	<a data-sheet_id_no="${sheet.sheet_id_no}" data-sheet_alert="" id="approval_sheet${sheet.sheet_id_no}" class="nav-link" href="#"><i class="far fa-circle text-info"></i>&nbsp;&nbsp;${ sheet.sheet_name }</a>
  </li>
  </c:if>
  </c:forEach>
  </ul>
</div>
<!-- /.card-body -->
</div>
<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<script type="text/javascript">

$(function() {
	$('a[id^=approval_sheet]').css({
        "border" : "solid 1px gray"    
    });
})
</script>