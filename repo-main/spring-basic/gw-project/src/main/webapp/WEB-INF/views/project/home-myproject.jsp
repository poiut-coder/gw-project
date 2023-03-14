<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="card bg-lightblue">
    <div class="card-header border-0">
        <h2 class="card-title">My Projects Recent Summary</h2>
        <div class="card-tools">

            <a href="/gw-project/project/myproject" class="btn btn-tool btn-sm">
                <i class="fas fa-bars"></i>&nbsp;&nbsp;More Project
            </a>
        </div>
    </div>
    <div class="card-body table-responsive p-0">
        <table class="table table-striped table-valign-middle">
            <thead>
            <tr>
                <th>Number</th>
                <th>Project</th>
                <th>Leader</th>
                <th>Client</th>
                <th>EndDate</th>
            </tr>
            </thead>
            <tbody>

            <c:forEach var="projects" items="${ projects }">
                <c:set var="sum" value="${ sum + 1 }"></c:set>
                <tr>
                    <td>
                        #${ sum }
                    </td>
                    <td>
                        <a id="proTitle${ projects.sche_id_no }" href="project/detail?projectNo=${ projects.sche_id_no }">${ projects.sche_title }</a>
                    </td>
                    <td>
                        <c:forEach var="memberdetails" items="${ memberdetails }">
                            <c:if test="${ memberdetails.mem_detail_id_no eq projects.sche_leader }">
                                <c:forEach var="member" items="${ members }">
                                    <c:if test="${ member.mem_id_no eq memberdetails.mem_detail_id_no }">
                                        <a id="memberContacts${ member.mem_dept_no }" href="contact/contacts_by_dept?deptNo=${ member.mem_dept_no }">${ memberdetails.mem_detail_name }</a>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                            ${ projects.sche_client }
                    </td>
                    <td>
                            ${ projects.sche_end_date }
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
</div>