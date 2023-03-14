<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@ page import="com.gw.dto.DeptDto" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:forEach var="attachment" items="${ project.sche_attachments }">
	<div class='attach-item-div' data-attachidno="${ attachment.sche_attach_id_no }">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" id="attach_delete${ attachment.sche_attach_id_no }" data-sche_attach_id_no="${ attachment.sche_attach_id_no }">X</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="download?attachNo=${ attachment.sche_attach_id_no }" class="btn-link text-secondary">${ attachment.sche_attach_userfilename }</a>
    </div>
</c:forEach>
