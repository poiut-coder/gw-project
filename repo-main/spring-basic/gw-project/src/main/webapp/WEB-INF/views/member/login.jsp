<%@ page language="java"
		 contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<style type="css"></style>
	<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
	<jsp:include page="/WEB-INF/views/modules/login-css.jsp" />


	<title>로그인</title>
</head>

	<link rel="stylesheet" href="/gw-project/resources/dist/css/adminlte.min.css">
</head>

<%--//////새로운 로그인 form 구현하기--%>


<div class="container">
	<div class="left">
<form:form id ="login" action="login" method="post">
		<div class="header">
			<h2 class="animation a1">Green Office</h2>
			<h4 class="animation a2">로그인 하세요</h4>
		</div>
		<div class="form">
			<input type="text" class="form-field animation a3" name="mem_id_no" placeholder="사원번호를 입력하세요" required>
			<input type="password" class="form-field animation a4" name="mem_passwd" placeholder="비밀번호 입력" required>
			<button id="login-btn" type="submit" class="animation a6">LOGIN</button>
		</div>
</form:form>
	</div>
	<div class="right"></div>
</div>


<!-- /.center -->


<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<script type="text/javascript">
	<%--유효성 검사 추가--%>
	$(function() {
		<c:if test="${ not empty fail }">
		alert('로그인 실패 : 아이디와 패스워드를 확인하세요');
		</c:if>

		$('#login-btn').on('click',function(){
			alert('환영합니다');
		});
	});

</script>
</body>
</html>
