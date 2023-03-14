<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <div class="card bg-gradient-info">
              <div class="card-header border-0">

                <h3 class="card-title">
                  <i class="fas fa-user"></i>
                  Attendance
                </h3>
                <!-- tools card -->
                <div class="card-tools">
                  <!-- button with a dropdown -->
                  <div class="btn-group">
                  
                  <button type="button" class="recomment-link btn btn-sm btn-primary" id="attd_on">
                  출근
                  </button>
                  <button type="button" class="recomment-link btn btn-sm btn-success" id="attd_off">
                  퇴근
                  </button>
                  
                  </div>
                </div>
                <!-- /. tools -->
              </div>
              <!-- /.card-header -->
              <div class="card-body pt-0">
              <ul>
                <li class="nav-item active">
                <span class ="nav-link" style="font-weight: bold;"><i class="far fa-calendar-alt"></i> 날짜 : <fmt:formatDate value="${ today }" pattern="yyyy-MM-dd"/></span>
                </li>
                <li class="nav-item active">
                <span class ="nav-link" style="font-weight: bold;"><i class="far fa-clock"></i> 출근 : <c:if test="${ not empty at}"><fmt:formatDate value="${at.attd_on}" pattern="HH:mm"/></c:if> </span>
                </li>
                <li class="nav-item active">
                <span class ="nav-link" style="font-weight: bold;"><i class="fas fa-sign-out-alt"></i> 퇴근 : <c:if test="${ not empty at.attd_off}"><fmt:formatDate value="${at.attd_off}" pattern="HH:mm"/></c:if> </span>
                </li>
              </ul>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
	                <!-- /.card-body -->