<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<li class="nav-item active">
<span class ="nav-link" style="font-weight: bold;"><i class="far fa-calendar-alt text-info"></i> 년월 : ${ year }년&nbsp;${ month }월</span>
</li>
<li class="nav-item active">
<span class ="nav-link" style="font-weight: bold;"><i class="far fa-user text-info"></i> 출근 : ${ attd }</span>
</li>
<li class="nav-item active">
<span class ="nav-link" style="font-weight: bold;"><i class="far fa-clock text-info"></i> 지각 : ${ late } </span>
</li>
<li class="nav-item active">
<span class ="nav-link" style="font-weight: bold;"><i class="fas fa-plane text-info"></i> 휴가 : 0 </span>
</li>