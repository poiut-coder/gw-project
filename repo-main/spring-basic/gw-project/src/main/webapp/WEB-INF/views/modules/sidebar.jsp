<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<aside class="main-sidebar sidebar-dark-primary elevation-4">
	<!-- Brand Logo -->
	<a href="/gw-project/home2" class="brand-link"> <img
			src="/gw-project/resources/dist/img/AdminLTELogo.png"
			alt="AdminLTE Logo" class="brand-image img-circle elevation-3"
			style="opacity: .8"> <span class="brand-text font-weight-light">GROUP
			WARE</span>
	</a>

	<!-- Sidebar -->
	<div class="sidebar">
		<!-- Sidebar user panel (optional) -->
		<div class="user-panel mt-3 pb-3 mb-3 d-flex">
			<div class="image">
				<img src="/gw-project/resources/dist/img/mem_default.png"
					 class="img-circle elevation-2" alt="User Image">
			</div>
			<div class="info">
				<%--        <c:choose>--%>
				<%--        <c:when test="${empty loginuser}">--%>
				<%--        	<a href="/gw-project/member/login" class="d-block">로그인</a>--%>
				<%--        </c:when>--%>
				<%--            <c:otherwise>--%>
				<%--                <a style = "color: white;">--%>
				<%--                        ${ loginuser.memberDetail.mem_detail_name } 님--%>
				<%--                </a>--%>
				<%--                <a href="/gw-project/member/logout.action">로그아웃</a>--%>
				<%--            </c:otherwise>--%>
				<%--        </c:choose>--%>

				<a style="color: white;"> ${ loginuser.memberDetail.mem_detail_name }
				</a> &nbsp;&nbsp; <br> <a href="/gw-project/member/logout.action">LogOut</a>

			</div>
		</div>

		<!-- SidebarSearch Form -->
		<div class="form-inline">
			<div class="input-group" data-widget="sidebar-search">
				<input class="form-control form-control-sidebar" type="search"
					   placeholder="Search" aria-label="Search">
				<div class="input-group-append">
					<button class="btn btn-sidebar">
						<i class="fas fa-search fa-fw"></i>
					</button>
				</div>
			</div>
		</div>

		<!-- Sidebar Menu -->
		<nav class="mt-2">
			<ul class="nav nav-pills nav-sidebar flex-column"
				data-widget="treeview" role="menu" data-accordion="false">
				<!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
				<li class="nav-header">MAIN</li>
				<li class="nav-item menu-open"><a href="/gw-project/home2"
												  class="nav-link active" data-widget="Dashboard"> <i
						class="nav-icon fas fa-tachometer-alt"></i>
					<p>Dashboard</p>
				</a></li>

				<li class="nav-item"><a
						href="/gw-project/member/member-modify?mem_id_no=${ loginuser.mem_id_no }"
						class="nav-link" data-widget="Modify Profile"> &nbsp;<i
						class="fas fa-user"></i>
					<p>
						&nbsp;&nbsp;&nbsp;&nbsp;Modify Profile <i class="fas fa-angle-left right"></i>
					</p>
				</a></li>

				<li class="nav-item"><a href="/gw-project/attendance/list"
										class="nav-link" data-widget="Attendance"> &nbsp;<i
						class="fas fa-user-plus"></i>
					<p>&nbsp;&nbsp;Attendance</p>
				</a></li>

				<li class="nav-header">FUNCTIONS</li>



				<li class="nav-item"><a href="#" class="nav-link"> <i
						class="nav-icon far fa-envelope"></i>
					<p>
						Mail <i class="fas fa-angle-left right"></i>
					</p>
				</a>
					<ul class="nav nav-treeview">
						<li class="nav-item"><a
								href="/gw-project/mail/mail-write.action" class="nav-link"
								data-widget="Write Mail"> <i class="far fa-circle nav-icon"></i>
							<p>Write Mail</p>
						</a></li>

						<li class="nav-item"><a
								href="/gw-project/mail/mail-list.action" class="nav-link"
								data-widget="Mail Box"> <i class="far fa-circle nav-icon"></i>
							<p>Mail Box</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/mail/mail-received-list.action"
								class="nav-link" data-widget="Received Mail"> <i
								class="far fa-circle nav-icon"></i> <p>Received Mail</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/mail/mail-send-list.action" class="nav-link"
								data-widget="Sent Mail"> <i class="far fa-circle nav-icon"></i>
							<p>Sent Mail</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/mail/mail-draft-list.action" class="nav-link"
								data-widget="Temporary Box"> <i
								class="far fa-circle nav-icon"></i> <p>Temporary Box</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/mail/mail-my-list.action" class="nav-link"
								data-widget="Mail Box Write To Me"> <i
								class="far fa-circle nav-icon"></i> <p>Mail Box Write To Me</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/mail/mail-deleted.action" class="nav-link"
								data-widget="Recycle Bin"> <i class="far fa-circle nav-icon"></i>
							<p>Recycle Bin</p>
						</a></li>
					</ul></li>

				<li class="nav-item"><a href="#" class="nav-link">
					&nbsp;&nbsp;<i class="far fa-sticky-note"></i>
					<p>
						&nbsp;&nbsp;&nbsp;Memo <i class="fas fa-angle-left right"></i>
					</p>
				</a>
					<ul class="nav nav-treeview">
						<li class="nav-item"><a
								href="/gw-project/memo/memo-write.action" class="nav-link"
								data-widget="Write Memo"> <i class="far fa-circle nav-icon"></i>
							<p>Write Memo</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/memo/memo-all-list.action" class="nav-link"
								data-widget="Memo Box"> <i class="far fa-circle nav-icon"></i>
							<p>Memo Box</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/memo/memo-received-list.action"
								class="nav-link" data-widget="Received Memo"> <i
								class="far fa-circle nav-icon"></i><p> Received Memo</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/memo/memo-send-list.action" class="nav-link"
								data-widget="Sent Memo"> <i class="far fa-circle nav-icon"></i>
							<p>Sent Memo</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/memo/memo-my-list.action" class="nav-link"
								data-widget="Memo Box Write To Me"> <i
								class="far fa-circle nav-icon"></i> <p>Memo Box Write To Me</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/memo/memo-deleted-list.action" class="nav-link"
								data-widget="Recycle Bin"> <i class="far fa-circle nav-icon"></i>
							<p>	Recycle Bin</p>
						</a></li>
					</ul></li>

				<li class="nav-item"><a href="#" class="nav-link"> &nbsp;<i
						class="fas fa-project-diagram"></i>
					<p>
						&nbsp;&nbsp;Project Schedule <i class="fas fa-angle-left right"></i>
					</p>
				</a>

					<ul class="nav nav-treeview">
						<li class="nav-item"><a href="/gw-project/project/myproject"
												class="nav-link" data-widget="My Project"> <i
								class="far fa-circle nav-icon"></i>
							<p>My Project</p>
						</a></li>
						<li class="nav-item"><a href="/gw-project/project/list"
												class="nav-link" data-widget="Project List"> <i
								class="far fa-circle nav-icon"></i>
							<p>Project List</p>
						</a></li>
						<li class="nav-item"><a href="/gw-project/project/write"
												class="nav-link" data-widget="Project Add"> <i
								class="far fa-circle nav-icon"></i>
							<p>Project Add</p>
						</a></li>
					</ul></li>

				<li class="nav-item"><a href="#" class="nav-link"> <i
						class="nav-icon far fa-calendar-alt"></i>
					<p>
						ToDo <i class="fas fa-angle-left right"></i>
					</p>
				</a>
					<ul class="nav nav-treeview">
						<li class="nav-item"><a href="/gw-project/todo/list.action"
												class="nav-link" data-widget="Todo List"> <i
								class="far fa-circle nav-icon"></i>
							<p>Todo List</p>
						</a></li>
						<li class="nav-item"><a
								href="/gw-project/todo/calendar.action" class="nav-link"
								data-widget="Calender"> <i class="far fa-circle nav-icon"></i>
							<p>Calender</p>
						</a></li>
					</ul></li>


				<li class="nav-item"><a href="#" class="nav-link"> <i
						class="nav-icon fas fa-copy"></i>
					<p>
						Approval <i class="right fas fa-angle-left"></i>
					</p>
				</a>
					<ul class="nav nav-treeview">
						<li class="nav-item"><a href="/gw-project/approval/receive"
												class="nav-link" data-widget="Received Approval"> <i
								class="far fa-circle nav-icon"></i>
							<p>Received Approval</p>
						</a></li>
						<li class="nav-item"><a href="/gw-project/approval/send"
												class="nav-link" data-widget="Sent Approval"> <i
								class="far fa-circle nav-icon"></i>
							<p>Sent Approval</p>
						</a></li>
						<li class="nav-item"><a href="/gw-project/approval/manage"
												class="nav-link" data-widget="Approval Management"> <i
								class="far fa-circle nav-icon"></i>
							<p>Approval Management</p>
						</a></li>
						<li class="nav-item"><a href="/gw-project/approval/write"
												class="nav-link" data-widget="Write Document"> <i
								class="far fa-circle nav-icon"></i>
							<p>Write Document</p>
						</a></li>
					</ul></li>


				<li class="nav-item"><a href="#" class="nav-link"> <i
						class="nav-icon fas fa-columns"></i>
					<p>
						Board <i class="fas fa-angle-left right"></i>
					</p>
				</a>
					<ul class="nav nav-treeview">
						<li class="nav-item"><a href="/gw-project/board/notice"
												class="nav-link" data-widget="Notice"> <i
								class="far fa-circle nav-icon"></i>
							<p>Notice</p>
						</a></li>
						<li class="nav-item"><a href="/gw-project/board/unknown"
												class="nav-link" data-widget="Blind"> <i
								class="far fa-circle nav-icon"></i>
							<p>Blind</p>
						</a></li>
					</ul></li>

				<li class="nav-item"><a href="/gw-project/contact/contacts"
										class="nav-link" data-widget="Contacts"> &nbsp;&nbsp;<i
						class="fas fa-id-card"></i>
					<p>&nbsp;&nbsp;Contacts</p>
				</a></li>

				<li class="nav-header">COMPANY</li>
				<li class="nav-item"><a href="/gw-project/organization/list"
										class="nav-link" data-widget="Organization"> &nbsp;<i
						class="fas fa-sitemap"></i>
					<p>&nbsp;&nbsp;Organization</p>
				</a></li>
				<li class="nav-item"><a href="#" class="nav-link"
										data-widget="ADMINISTRATOR"> &nbsp;<i class="fas fa-user-cog"></i>
					<p>&nbsp;&nbsp;ADMINISTRATOR</p>
				</a></li>
			</ul>
		</nav>
		<!-- /.sidebar-menu -->
	</div>
	<!-- /.sidebar -->
</aside>