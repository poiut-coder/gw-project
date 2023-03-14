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
  <title>관리자 로그인</title>
</head>

<body class="hold-transition sidebar-mini layout-fixed">

<div class="wrapper">
<!-- Preloader -->
  <div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="/gw-project/resources/dist/img/AdminLTELogo.png" alt="AdminLTELogo" height="60" width="60">
  </div>
<!-- Navbar -->
  <jsp:include page="/WEB-INF/views/modules/navbar.jsp" />	
<!-- /.navbar -->
  
<!-- Main Sidebar Container -->
  <jsp:include page="/WEB-INF/views/modules/sidebar.jsp" />
<!-- /.Main Sidebar Container -->

<!-- content Wrapper.Contains page content -->
<div class="content-wrapper">
<div class="container">
	<div class="screen">
		<div class="screen__content">
			<form:form id ="login" action="admin-login" method="post" class="login">
				<div class="login__field">
					<i class="login__icon fas fa-user"></i>
					<input type="text" name="mem_id_no" class="login__input" placeholder="사원번호를 입력하세요">
				</div>
				<div class="login__field">
					<i class="login__icon fas fa-lock"></i>
					<input type="password" name="mem_passwd" class="login__input" placeholder="비밀번호를 입력하세요">
				</div>
				<div class="login__field">
					<i class="login__icon fas fa-lock"></i>
					<input type="text" name="mem_admin" class="login__input" placeholder="관리자여부를 선택하세요">
				</div>
			
			
			<button id="btnlogin" type="submit" class="button login__submit">
					<span class="button__text">LOGIN</span>
					<i class="button__icon fas fa-chevron-right"></i>
			</button>
			</form:form>
			
			<div class="social-login">
				<h3>관리자 로그인</h3>
				<div class="social-icons">
					<a href="#" class="social-login__icon fab fa-instagram"></a>
					<a href="#" class="social-login__icon fab fa-facebook"></a>
					<a href="#" class="social-login__icon fab fa-twitter"></a>
				</div>
			</div>
		</div>
		<div class="screen__background">
			<span class="screen__background__shape screen__background__shape4"></span>
			<span class="screen__background__shape screen__background__shape3"></span>
			<span class="screen__background__shape screen__background__shape2"></span>
			<span class="screen__background__shape screen__background__shape1"></span>
		</div>
	</div>
</div>
</div>
</div>

<!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
<!-- /.footer -->
  
  <!-- Control Sidebar -->
  <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
  <!-- /.control-sidebar -->
<!-- ./wrapper -->

	
<!-- script -->
        
<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<script type="text/javascript">

$(function() {
	
	/* $('#btnregister').on('click',function(event) {
		var formData = $('#register').serialize();
		alert(formData); */

	$('#btnlogin').on('click',function(){
		alert('환영합니다');
});
});
	


</script>


</body>
</html>
