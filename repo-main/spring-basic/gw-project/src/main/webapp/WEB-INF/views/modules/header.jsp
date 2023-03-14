<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<div class = "login_check" style="color:grey; text-align:right;" >
<c:choose>
<c:when test="${empty loginuser}">
	<a href="/gw-project/member/login">로그인</a>
</c:when>
<c:otherwise>
	${ loginuser.mem_id_no }님 안녕하세여^^
	
	<a href="/gw-project/member/logout.action">로그아웃</a>
</c:otherwise>
</c:choose>
</div>