<%--Register은 관리자 페이지 임에도 불구하고 회원가입과 연동되기 때문에 작업하였습니 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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

        <div class="body">
            <div class="container">
                <header>Registration</header>

                <form id="register" action="register" method="post" enctype="multipart/form-data">
                    <div class="form first">
                        <div class="details personal">

                            <span class="title">회원 기본 정보</span>

                            <div class="fields">
                                <div class="input-field">
                                    <label>회사코드입력</label>
                                    <select name="mem_com_code" class="select-company" id = "mem_com_code">
                                        <option hidden="" disabled="disabled" selected="selected" value="">회사</option>
                                        <c:forEach var="company" items="${ companies }">
                                            <option value="${company.comp_id_no}">${company.comp_name }</option>
                                        </c:forEach>
                                        <%--                                <option disabled selected>회사</option>--%>
                                        <%--                                <option value="1">A</option>--%>
                                    </select>
                                    <!-- <input type="text" name="mem_com_code" class="form-control" placeholder="1~5까지 입력" required> -->
                                </div>

                                <div class="input-field">
                                    <label>부서코드 입력</label>
                                    <select name="mem_dept_no" class="mem_dept_no" id = "mem_dept_no">
                                        <option hidden="" disabled="disabled" selected="selected" value="">부서</option>
                                        <c:forEach var="dept" items="${depts}">
                                            <option value="${dept.dept_id_no}">${ dept.dept_name }</option>
                                        </c:forEach>
                                    </select>
                                </div>


                                <div class="input-field">
                                    <label>직급 입력</label>
                                    <select name="mem_position_no" class="mem_position_no" id = "mem_position_no">
                                        <option hidden="" disabled="disabled" selected="selected" value="">직급</option>
                                        <c:forEach var="role" items="${roles}">
                                            <option value="${role.role_id_no}">${ role.role_name }</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="input-field">
                                    <label>회원명</label>
                                    <input type="text" name="memberDetail.mem_detail_name"   class="form-control" placeholder="이름입력" required>
                                </div>

                                <div class="input-field">
                                    <label>비밀번호</label>
                                    <input type="password" name="mem_passwd" class="form-control" placeholder="비밀번호 입력" required>
                                </div>

                                <div class="input-field">
                                    <label>이메일</label>
                                    <input type="email" name="memberDetail.mem_detail_email"  class="form-control" placeholder="이메일을 입력하세요" required>
                                </div>

                                <div class="input-field" hidden>
                                    <label>재직여부</label>
                                    <input type="text" name="mem_retire"  class="form-control" value="0">
                                </div>

                                <div class="input-field" hidden>
                                    <label>관리자</label>
                                    <input type="text" name="mem_admin"  class="form-control" value="2">


                                </div>
                                <button id = "btnregister" class="sumbit" type="submit">
                                    <span class="btnText">회원가입 완료</span>
                                </button>




                            </div>
                        </div>
                    </div>
                </form>

            </div><!--container  -->
        </div><!-- body -->

            <!-- footer -->
            <jsp:include page="/WEB-INF/views/modules/footer.jsp" />
            <!-- /.footer -->

            <!-- Control Sidebar -->
            <jsp:include page="/WEB-INF/views/modules/control-sidebar.jsp" />
            <!-- /.control-sidebar -->

            <!-- script -->

            <jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
            <script type="text/javascript">

                $(function (){

                    // $( '#mem_com_code').change( function(event) {
                    $( '#mem_com_code').on('change',function (event){

                        const mem_com_code = $(this).val();
                        const url = "dept_list?mem_com_code=" + mem_com_code;

                        $.ajax({
                            "url" : url,
                            // "url" : "company_list?mem_com_code=" + mem_com_code,
                            "method" : "get",
                            // "data" : data,
                            "success": function (data, status, xhr){
                                $('#mem_dept_no').empty();
                                $('#mem_dept_no').append('<option value="" selected disabled="disabled">부서 선택 </option>');
                                $.each(data, function (idx, member){
                                    $('#mem_dept_no').append('<option value="' + member.dept_id_no + '">' + member.dept_name + '</option>');
                                });
                            },
                            "error":function (xhr, status, data){
                                alert('실패');
                            }
                        });

                        const url2 = "role_list?mem_com_code=" + mem_com_code;

                        $.ajax({
                            "url" :url2,
                            "method" : "get",
                            "success":function (data, status, xhr){
                                $('#mem_position_no').empty();
                                $('#mem_position_no').append('<option value="" selected disabled="disabled">직급 선택</option>');
                                $.each(data, function (idx, member){
                                    $('#mem_position_no').append('<option value="' + member.role_id_no + '">' + member.role_name + '</option>');
                                });
                            },
                            "error":function (xhr,status,data){
                                alert('실패');
                            }
                        });

                    });
                    //  option 값이 변화함에 따라 값이 변함
                    //     $('select[name=mem_com_code]').on('change', function (event){
                    //         mem_com_code = $(this).val();
                    //         comp_name = $('select-company [value=' + mem_dept_no + ']').text();
                    //     });







                    //부서 입력하기
                    $('#btnregister').on('click',function(){
                        alert('회원가입 완료! 관리자 승인이 될 때까지 기다려주세요');
                    });


                });

            </script>


</body>
</html>