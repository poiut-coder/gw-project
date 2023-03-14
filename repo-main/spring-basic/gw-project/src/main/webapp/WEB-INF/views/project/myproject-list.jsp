<%@ page language="java" 
		 contentType="text/html; charset=EUC-KR"
    	 pageEncoding="EUC-KR"%>
    	 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
    
 

    <section class="content-header">
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-6">
            <h1>My Project</h1>
          </div>
          <div class="col-sm-6 d-none d-sm-block">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/gw-project/">Home</a></li>
              <li class="breadcrumb-item active"><a href="/gw-project/project/list">List</a></li>
            </ol>
          </div>
        </div>
      </div>
    </section>
    <hr>


    <section class="content pb-3">

	  
	  <!-- 반복문으로 일단은 프로젝트 전체 가져오기 -->
	  <!-- 프로젝트 상태에 따라서 div class 변환 -->
	  <!-- 프로젝트 상태에 따라서 div class 변환 -->
	  <!-- 프로젝트 상태에 따라서 div class 변환 -->
	  <!-- 프로젝트 상태에 따라서 div class 변환 -->
	  <!-- 프로젝트 상태창의 예시 -->
	  
      <div class="container-fluid">
       
      <c:set var="i" value="0"></c:set>
      <c:set var="j" value="4"></c:set>
      
      <table>
      
      	<c:forEach var="projects" items="${ projects }">
	  <input type="hidden" id="estimated_budget_number${ projects.sche_id_no }" value="${ projects.sche_estimated_budget }">
	  <input type="hidden" id="spent_budget_number${ projects.sche_id_no }" value="${ projects.sche_spent_budget }">
	  <input type="hidden" name="sche_mem_id_no" value="${ loginuser.mem_id_no }">
	  
      	<c:if test="${ i%j == 0 }">
      	<Tr style="padding-bottom: 40px">
      	</c:if>
      	
      		<td style="padding-left: 40px"><div class="card card-row card-secondary">
         
         <c:choose>
         <c:when test="${ loginuser.mem_id_no eq projects.sche_leader or loginuser.mem_id_no eq projects.sche_writer }">
         	<div class="card-header bg-info">
            <h3 class="card-title">
              #${ projects.sche_id_no }&nbsp; <a href="#" id="myproject_detail${ projects.sche_id_no }" data-sche_id_no="${ projects.sche_id_no }">${ projects.sche_title }</a>
            </h3>
          	</div>
         </c:when>
         <c:otherwise>
         	<div class="card-header">
            <h3 class="card-title">
              #${ projects.sche_id_no }&nbsp; <a href="#" id="myproject_detail${ projects.sche_id_no }" data-sche_id_no="${ projects.sche_id_no }">${ projects.sche_title }</a>
            </h3>
          	</div>
         </c:otherwise>
         </c:choose>
          
          <div class="card-body" id="card-body">
            <div class="card card-light card-outline">
              <div class="card-header">
                <h3 class="card-title"><span>About Project</span></h3>
                <br>
                <div class="card-tools">
                  <h5 class="card-title">RegDate&nbsp;:&nbsp;#${ projects.sche_reg_date }</h5>
                </div>
              </div>
              <div class="card-body">
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Status&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</a>&nbsp;&nbsp;<a id="myproject_status${ projects.sche_id_no }">${ projects.sche_status }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>시작일자&nbsp;:&nbsp;</a>&nbsp;&nbsp;<a id="myproject_start${ projects.sche_id_no }">${ projects.sche_start_date }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>종료일자&nbsp;:&nbsp;</a>&nbsp;&nbsp;<a id="myproject_end${ projects.sche_id_no }">${ projects.sche_end_date }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>예상기간&nbsp;:&nbsp;</a>&nbsp;&nbsp;<a id="myproject_duration${ projects.sche_id_no }">${ projects.sche_estimated_duration }&nbsp;개월</a>
                </div>
              </div>
            </div>
            
            <div class="card card-light card-outline">
              <div class="card-header">
                <h3 class="card-title"><span>Team Info</span></h3>
                <c:forEach var="members" items="${ members }">
                <c:if test="${ members.mem_id_no eq projects.sche_leader }">
                	<div style="text-align: right">
                	<a id="myproject_link_contacts" href="#" data-mem_dept_no="${ members.mem_dept_no }">&nbsp;&nbsp;&nbsp;담당부서</a>
                	</div>
                </c:if>
                </c:forEach>
                <div class="card-tools">
                </div>
              </div>
              <div class="card-body">
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>작성자&nbsp;:&nbsp;</a><a id="myproject_writer${ projects.sche_id_no }">
                  <c:forEach var="member" items="${ memberdetail }">
                  <c:if test="${ projects.sche_writer == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                  </c:forEach>
                  </a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>담당자&nbsp;:&nbsp;</a><a id="myproject_leader${ projects.sche_id_no }">
					<c:forEach var="member" items="${ memberdetail }">
                    <c:if test="${ projects.sche_leader == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                    </c:forEach>
				  </a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>팀원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</a><a id="myproject_team${ projects.sche_id_no }">
                  	<c:forEach var="member" items="${ memberdetail }">
                    <c:if test="${ projects.sche_team == member.mem_detail_id_no }">${ member.mem_detail_name }</c:if>
                    </c:forEach>
                  </a>
                </div>
              </div>
            </div>
            
            
            <div class="card card-light card-outline">
              <div class="card-header">
                <h5 class="card-title">Client Info</h5>
                <div class="card-tools">
                  <a href="#" class="btn btn-tool btn-link"></a>
                  <a href="#" class="btn btn-tool"></a>
                </div>
              </div>
              <div class="card-body">
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Name&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;</a><a id="sche_client${ projects.sche_id_no }">${ projects.sche_client }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Phone&nbsp;:&nbsp;&nbsp;&nbsp;</a><a id="sche_client_phone${ projects.sche_id_no }">${ projects.sche_client_phone }</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Email&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;</a><a id="sche_client_email${ projects.sche_id_no }">${ projects.sche_client_email }</a>
                </div>
              </div>
            </div>
             <div class="card card-light card-outline">
              <div class="card-header">
                <h5 class="card-title">Budget Info</h5>
                <div class="card-tools">
                  <a href="#" class="btn btn-tool btn-link"></a>
                  <a href="#" class="btn btn-tool"></a>
                </div>
              </div>
              <div class="card-body">
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Budget&nbsp;:&nbsp;</a><a id="sche_estimated_budget${ projects.sche_id_no }">${ projects.estimated_budget }&nbsp;백만원</a>
                </div>
                <div class="custom-control custom-checkbox">
                  <i class="fas fa-dot-circle"></i>&nbsp;<a>Cost&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;</a><a id="sche_spent_budget${ projects.sche_id_no }">${ projects.spent_budget }&nbsp;백만원</a>
                </div>
              </div>
            </div>
            
            <hr>
            
            <button id="myproject_detail_button${ projects.sche_id_no }" type="button" class="btn btn-block btn-primary btn-xs" data-toggle="modal" data-target="#modal-primary" data-sche_id_no="${ projects.sche_id_no }">
            <i class="fas fa-folder"></i>&nbsp;Detail
            </button>
            
            <c:set var="loginuser.mem_id_no" value="${ loginuser.mem_id_no }"></c:set>

            	<button id="myproject_success_button${ projects.sche_id_no }" type="button" class="btn btn-block bg-gradient-success btn-xs" data-toggle="modal" data-target="#modal-success" data-sche_id_no="${ projects.sche_id_no }" data-sche_writer="${ projects.sche_writer }" data-sche_leader="${ projects.sche_leader }">
           		<i class="fas fa-pencil-alt"></i>&nbsp;Success
          		</button>
            	<button id="btn_myproject_delete_button${ projects.sche_id_no }" type="button" class="btn btn-block btn-danger btn-xs" data-toggle="modal" data-target="#modal-danger" data-sche_id_no="${ projects.sche_id_no }" data-sche_writer="${ projects.sche_writer }" data-sche_leader="${ projects.sche_leader }">
            	<i class="fas fa-trash"></i>&nbsp;Delete
            	</button>
            
            </div>
            
            </div>
            <hr></td>
      		
      	<c:if test="${ i%j == j-1 }">
      	</Tr>
      	</c:if>
      	<c:set var="i" value="${ i+1 }"></c:set>
      </c:forEach> 
      
      </table>
      
        </div>
        
     </section>
     
    
  
     
