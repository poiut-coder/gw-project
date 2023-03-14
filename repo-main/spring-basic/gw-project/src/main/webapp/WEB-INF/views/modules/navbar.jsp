<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 	 
   
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <!-- 홈화면에서 네비바를 통한 사이드바 축소 확대 기능 구현 필요 -->
      <!-- <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li> -->
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/home2" class="nav-link">Home</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/attendance/list" class="nav-link">Attendance</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/project/list" class="nav-link">Project</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/todo/list.action" class="nav-link">ToDo</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/mail/mail-list.action" class="nav-link">Mail</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/memo/memo-all-list.action" class="nav-link">Memo</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/approval/receive" class="nav-link">Approval</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/board/notice" class="nav-link">Notice</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/board/unknown" class="nav-link">Blind</a>
      </li>
      <li class="nav-item d-none d-sm-inline-block">
        <a href="/gw-project/contact/contacts" class="nav-link">Contacts</a>
      </li>
   <!--  </ul>

    Right navbar links
    <ul class="navbar-nav ml-auto"> -->

      <!-- Notifications Dropdown Menu -->
      <li class="nav-item dropdown">
        <a class="nav-link" data-toggle="dropdown" href="#">
          <i class="far fa-bell"></i>
          <span class="badge badge-warning navbar-badge">${ allAlert }</span>
        </a>
        <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
        <c:if test="${ receiveAlert != 0 }">
        	<div class="dropdown-divider"></div>
          <a href="/gw-project/approval/receive" class="dropdown-item">
            <i class="fas fa-bell mr-2 text-warning"></i> ${ receiveAlert } 개의 결재 요청
          </a>
        </c:if>
         <c:if test="${ sendAlert != 0 }">
         <div class="dropdown-divider"></div>
          <a href="/gw-project/approval/send" class="dropdown-item">
            <i class="fas fa-bell mr-2 text-warning"></i> ${ sendAlert } 개의 기안 결과 변동
          </a>
         </c:if>
         <c:if test="${ projectAlert != 0 }">
         <div class="dropdown-divider"></div>
          <a href="/gw-project/project/myproject" class="dropdown-item">
            <i class="fas fa-bell mr-2 text-warning"></i> ${ projectAlert } 개의 프로젝트 변동
          </a>
         </c:if>
        </div>
        </li>
    </ul>
  </nav>
  <!-- /.navbar -->