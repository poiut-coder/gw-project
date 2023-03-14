<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
    	 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:forEach var="member" items="${ members }">
<c:set var="sum" value="${sum+1}"/>
<tr>
   <td>${sum}</td>
   <td>${ member.dept_name}</td>
   <td>${ member.role_name }</td>
   <td>${ member.mem_detail_name }</td>
   <td>${ member.mem_detail_email }</td>
   <td>${ member.mem_detail_innernumber }</td>
</tr>
</c:forEach>