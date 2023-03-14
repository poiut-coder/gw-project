<%--Register은 관리자 페이지 임에도 불구하고 회원가입과 연동되기 때문에 작업하였습니 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
	<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
	

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style type="css"></style>
<jsp:include page="/WEB-INF/views/modules/common-css.jsp" />
<jsp:include page="/WEB-INF/views/modules/register-css.jsp" />
<title>회원가입</title>
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
	<div class="body">
    <div class="container">
        <header>Registration</header>

        <form:form id="register" action="register" method="post" modelAttribute="memberDto">
            <div class="form first">
                <div class="details personal">

                    <span class="title">회원 기본 정보</span>


                    <div class="fields">
                        <div class="input-field">
                            <label>회사코드입력</label>
                            <select name="mem_com_code">
                                <option disabled selected>회사</option>
                                <option value="1">A</option>
                            </select>
                            <!-- <input type="text" name="mem_com_code" class="form-control" placeholder="1~5까지 입력" required> -->
                        </div>

                        <div class="input-field">
                            <label>부서코드 입력</label>
                            <select name="mem_dept_no" onchange="loadRole();" id = "department">
                            </select>
                        </div>

                        <div class="input-field">
                            <label>직급번호 입력</label>
                            <select name = "mem_position_no" id = "role">
                            </select>

                        </div>

                    </div>
                </div>
                <br><br>
                <div class="details ID">
                    <span class="title">회사정보 입력</span>

                    <div class="fields">
                            <%--                        <div class="input-field">--%>
                            <%--                            <label>사원번호</label>--%>
                            <%--                            <input type="text" name="mem_id_no,member_detail.mem_detail_id_no" class="form-control" placeholder="사원번호를 입력하세요" required>--%>
                            <%--                        </div>--%>

                        <div class="input-field">
                            <label>비밀번호</label>
                            <input type="password" name="mem_passwd" class="form-control" placeholder="비밀번호 입력" required>
                        </div>

                        <div class="input-field">
                            <label>재직여부</label>
                            <select name="mem_retire">
                                <option value="0">재직</option>
                                <option value="1">퇴직</option>
                            </select>
                        </div>

                            <%--                        <div class="input-field">--%>
                            <%--                            <label>퇴직여부</label>--%>
                            <%--                            <input type="text" name="mem_retire" class="form-control" placeholder="0,1만 입력" required>--%>
                            <%--                        </div>--%>

                            <%--


                                                    <%-- form 모양 손보기  --%>

                            <%--                        <div class="input-field">--%>
                            <%--                            <div class="form-group">--%>
                            <%--                            <label>관리자 여부</label>--%>
                            <%--                            <div class="form-check">--%>
                            <%--                                <input class="form-check-input" type="radio" name="mem_admin" value = "0">--%>
                            <%--                                <label class="form-check-label">관리자 O</label>--%>
                            <%--                                <br>--%>
                            <%--                                <input class="form-check-input" type="radio" name="mem_admin" value="1">--%>
                            <%--                                <label class="form-check-label">관리자 X</label>--%>
                            <%--                            </div>--%>


                        <div class="input-field">
                            <label>관리자</label>
                            <select name="mem_admin">
                                <option value="0">관리자회원</option>
                                <option value="1">관리자아님</option>
                            </select>
                        </div>


                        <div class="input-field">
                            <label>회원명</label>
                            <input type="text" name="memberDetail.mem_detail_name"   class="form-control" placeholder="이름입력" required>
                        </div>
                        <button id = "btnregister" class="sumbit" type="submit">
                            <span class="btnText">회원가입 완료</span>
                            <i class="uil uil-navigator"></i>
                        </button>
                    </div><!-- fields -->
                </div>
            </div><!-- form first -->
        </form:form>
				
	</div><!--container  -->
	</div><!-- body -->
<div> <!-- wrapper -->
             
            <%-- <div class="form second">
                <div class="details address">
                    <span class="title">회원 상세정보</span>
 
                    <div class="fields">
                        <div class="input-field">
                            <label>이름</label>
                            <input type="text" name="mem_detail_name" class="form-control" placeholder="1,2만 입력" required>
                        </div>
 
                        <div class="input-field">
                            <label>생년월일</label>
                            <input type="date" name="mem_detail_birth" class="form-control" placeholder="생일을 입력하세요" required>
                        </div>
 
                        <div class="input-field">
                            <label>이메일</label>
                            <input type="email" name="mem_detail_email" class="form-control" placeholder="이메일을 입력하세요" required>
                        </div>
 
                        <div class="input-field">
                            <label>핸드폰번호</label>
                            <input type="number" name="mem_detail_phone" class="form-control" placeholder="전화번호를 입력하세요" required>
                        </div>
 
                        <div class="input-field">
                            <label>내선번호</label>
                            <input type="number" name="mem_detail_innernumber" class="form-control" placeholder="내선번호를 입력하세요" required>
                        </div>
 
                        <div class="input-field">
                            <label>입사일자</label>
                            <input type="date" name="mem_detail_fromdate" class="form-control" placeholder="입사일 선택" required>
                        </div>
                        
                        <div class="input-field">
                            <label>퇴사일자</label>
                            <input type="date" name="mem_detail_todate" class="form-control" placeholder="퇴사일 지정" required>
                        </div>
                    </div>

 
                <div class="details family">
                    <span class="title">작성해 주셔서 감사합니다</span>
 
                    <div class="fields">
                        
                    </div>
 
                    <div class="buttons">
                        <div class="backBtn">
                            <i class="uil uil-navigator"></i>
                            <span class="btnText">기본정보 돌아가기</span>
                        </div>
                        
                        <button class="sumbit" type="submit">
                            <span class="btnText">회원가입 완료</span>
                            <i class="uil uil-navigator"></i>
                        </button>
                    </div>
                </div> 
            </div>
        </form:form>
        </div>
        </div> --%>
<!-- footer -->
  <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
<!-- /.footer -->

	<!-- Control Sidebar -->
	<jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
	<!-- /.control-sidebar -->
	
	<!-- script -->
	
	<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
	<script type="text/javascript">
	
	
		/* const form = document.querySelector("form"),
        btnregister = form.querySelector(".btnregister"),
        allInput = form.querySelectorAll(".first input");
		register.addEventListener("click", () => form.classList.remove('secActive')); */
		
		$(function() {

            var dept;
            var role;

            //부서 클릭하면
            ${''}

		    $.ajax({
                "url": "member_"

            })

	});

	

</script>


</body>
</html>