<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<option hidden="" disabled="disabled" selected="selected" value="">결재자</option>
<c:forEach var="member" items="${ members }">

	<option value="${ member.mem_id_no }">
		<c:forEach var="role" items="${ roles }">
			<c:if test="${ member.mem_position_no == role.role_id_no}">${ role.role_name }</c:if>
		</c:forEach>
		-
		<c:forEach var="detail" items="${ details }">
			<c:if test="${ member.mem_id_no == detail.mem_detail_id_no}">${ detail.mem_detail_name }</c:if>
		</c:forEach>
	</option>
</c:forEach>