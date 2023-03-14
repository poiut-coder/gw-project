<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
시작 날짜
<select name="startYear" id="selectedYear" onchange="showDayByMonth()">
	<c:forEach var="i" begin="2022" end="2040">  
										<c:choose>
			<c:when test="${i== 2022 }">
				<!-- 현재 년도 선택  -->
				<option value=${i } selected>${i}년</option> 																	 
											</c:when>
			<c:otherwise>
				<option value=${i}>${i}년</option> 
											</c:otherwise>
		</c:choose>
	</c:forEach>
</select>
<select name="startMonth" id="selectedMonth" onchange="showDayByMonth()">
	<c:forEach var="i" begin="1" end="12"> 
										<c:choose>
			<c:when test="${i== 1 }">
				<option value=${i } selected>${i}월</option> 																	 
											</c:when>
			<c:otherwise>
				<option value=${i}>${i}월</option> 
											</c:otherwise>
		</c:choose>
	</c:forEach>
</select>
<select name="startDay" id="selectedDay">
	<c:forEach var="i" begin="1" end="31">  
										<c:choose>
			<c:when test="${i== 1  }">
				<option value=${i } selected>${i}일</option> 																	 
											</c:when>
			<c:otherwise>
				<option value=${i}>${i}일</option> 
											</c:otherwise>
		</c:choose>
	</c:forEach>
</select>
~ 완료 날짜
<select name="completeYear" id="selectedcompleteYear"
	onchange="showcompleteDayByMonth()">
	<c:forEach var="i" begin="2022" end="2040">  
										<c:choose>
			<c:when test="${i== nowYear }">
				<!-- 현재 년도 선택  -->
				<option value=${i } selected>${i}년</option> 																	 
											</c:when>
			<c:otherwise>
				<option value=${i}>${i}년</option> 
											</c:otherwise>
		</c:choose>
	</c:forEach>
</select>
<select name="completeMonth" id="selectedcompleteMonth"
	onchange="showcompleteDayByMonth()">
	<c:forEach var="i" begin="1" end="12">
		<c:choose>
			<c:when test="${i== nowMonth  }">
				<option value=${i } selected>${i}월</option> 																	 
											</c:when>
			<c:otherwise>
				<option value=${i}>${i}월</option> 
											</c:otherwise>
		</c:choose>
	</c:forEach>
</select>
<select name="completeDay" id="selectedcompleteDay">
	<c:forEach var="i" begin="1" end="31">  
										<c:choose>
			<c:when test="${i== nowDay  }">
				<option value=${i } selected>${i}일</option> 																	 
											</c:when>
			<c:otherwise>
				<option value=${i}>${i}일</option> 
											</c:otherwise>
		</c:choose>
	</c:forEach>
</select>

