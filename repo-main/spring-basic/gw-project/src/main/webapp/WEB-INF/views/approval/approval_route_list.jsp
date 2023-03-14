<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

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

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<script type="text/javascript">

$(function() {
	
	var apprNo = ${apprNo};
	
	$('#approval_route a').css({
        "border" : "solid 2px gray"    
    });
	
	if (apprNo != -1) {
		$('#routeChoose'+apprNo).css({
	        "border" : "solid 2px green"    
	    });
	}
	
})
</script>