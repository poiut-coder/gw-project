<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<c:forEach var="route" items="${ routes }">
<c:set var="sumTwo" value="${sumTwo+1}"/>
        <span id="addRoute${ route.appr_receiver }" style="color: green;">
        ${ sumTwo }
		<c:forEach var="apMember" items="${ apMembers }">
		<c:if test="${ route.appr_receiver == apMember.mem_id_no}">
		[${ apMember.dept_name }] [&nbsp;${ apMember.role_name } - ${ apMember.mem_detail_name }&nbsp;]
		<br>
		</c:if>
		</c:forEach>
	</span>
</c:forEach>

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<script type="text/javascript">

$(function() {
})
</script>