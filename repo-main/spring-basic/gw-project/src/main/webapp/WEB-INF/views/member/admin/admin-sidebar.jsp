<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Main Sidebar Container -->
<aside class="main-sidebar sidebar-dark-primary elevation-4" style="background-color: cadetblue;">
  <!-- Brand Logo -->
  <a href="/gw-project/" class="brand-link">
    <img src="/gw-project/resources/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8;">
    <span class="brand-text font-weight-light">GROUP WARE</span>
  </a>


  <!-- Sidebar -->
  <div class="sidebar">
    <!-- Sidebar user panel (optional) -->
    <%--   오류잡기   --%>
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
      <div class="image">
        <img src="/gw-project/resources/dist/img/mem_default.png" class="img-circle elevation-2" alt="User Image">
      </div>
      <div class="info">

<%--        <c:choose>--%>
<%--          <c:when test="${empty adminuser}">--%>
<%--            <a href="/gw-project/member/login" class="d-block">로그인</a>--%>
<%--          </c:when>--%>
<%--          <c:otherwise>--%>
<%--            <a style = "color: white;">--%>
<%--                ${ loginuser.memberDetail.mem_detail_name } 관리자님--%>
<%--            </a>--%>
<%--            <a href="/gw-project/member/logout.action">로그아웃</a>--%>
<%--          </c:otherwise>--%>
<%--        </c:choose>--%>

  <p style="color: white">관리자님 환영합니다</p>


  <a href="/gw-project/member/logout.action">로그아웃</a>

      </div>
    </div>

    <!-- Sidebar Menu -->
    <nav class="mt-2">
      <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        <!-- Add icons to the links using the .nav-icon class
             with font-awesome or any other icon font library -->
        <li class="nav-header">MAIN</li>
        <li class="nav-item menu-open">
          <a href="/gw-project/member/admin/admin-home" class="nav-link">
            <i class="nav-icon fas fa-tachometer-alt"></i>
            <p>
              관리자 메인페이지
            </p>
          </a>
        </li>
        <li class="nav-item menu-open">
          <a href="/gw-project/member/admin/member-list" class="nav-link">
            <i class="nav-icon fas fa-tachometer-alt"></i>
            <p>
              회원리스트(관리자)
            </p>
          </a>
        </li>
        <li class="nav-item menu-open">
          <a href="/gw-project/member/admin/retire-member-list" class="nav-link">
            <i class="nav-icon fas fa-tachometer-alt"></i>
            <p>
              탈퇴회원리스트(관리자)
            </p>
          </a>
        </li>
        <li class="nav-item menu-open">
          <a href="/gw-project/member/register" class="nav-link">
            &nbsp;<i class="fas fa-user"></i>
            <p>
              &nbsp;&nbsp;회원가입
              <i class="fas fa-angle-left right"></i>
            </p>
          </a>
        </li>
        </li>


        <li class="nav-header">FUNCTIONS</li>


        <li class="nav-item">
          <%-- <a href="/gw-project/member-modify.action" class="nav-link">--%>
          <a href="/gw-project/member/register2" class="nav-link">
            &nbsp;&nbsp;<i class="fas fa-registered"></i>
            <p>
              &nbsp;&nbsp;Register
            </p>
          </a>
        </li>

		<li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-columns"></i>
              <p>
                Board
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="/gw-project/board/notice" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>공지사항</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="/gw-project/board/unknown" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>익명게시판</p>
                </a>
              </li>
            </ul>
          </li>

      </ul>
    </nav>
    <!-- /.sidebar-menu -->
  </div>
  <!-- /.sidebar -->
</aside>

<jsp:include page="/WEB-INF/views/modules/common-js.jsp" />
<script>
  $(function() {
    $('.nav-treeview .fa-circle').before('&nbsp;&nbsp;&nbsp;');
  })
</script>