<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach var="comment" items="${comments}">
	<!-- comment-list -->
	<div id="comment-view-area-${comment.comIdNo}" class="card-comment">
		<div>
		<c:if test="${ comment.depth > 0 }">
			<img src="/gw-project/resources/image/re.gif" style="margin-left: ${ comment.depth > 1 ? (comment.depth-1) * 25 : 0 }px">
		</c:if>
		</div>
		<!-- /comment-text -->
		<div class="comment-text">
			<c:choose>
				<c:when test="${typeIdNo eq 1}">
					<span class="username">${comment.comWriter2}
					<span class="text-muted float-right">${comment.comDateFormForJsp}</span>
					</span>
				</c:when>
				<c:otherwise>
					<span class="username">익명${comment.comIdNo}
					<span class="text-muted float-right">${comment.comDateFormForJsp}</span>
					</span>
				</c:otherwise>
			</c:choose>
			
			<input type="hidden" name="comIdNo" value="${comment.comIdNo}" />
			<input id="comment-rewritepw" type="hidden" name="comPasswd" value="${comment.comPasswd}" />
			${comment.comContent}
		</div>
		<div class="text-muted float-right">
			<c:choose>
				<c:when test="${boardNotice.typeIdNo eq 1}">
					<c:if test="${not empty loginuser and ((loginuser.mem_id_no eq comment.comWriter) or adminuser eq 1)}">
						<a class="edit-comment" data-comment-no="${comment.comIdNo}"
							href="javascript:">수정</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a class="delete-comment" data-comment-no="${comment.comIdNo}"
							href="javascript:">삭제</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				</c:when>
				<c:otherwise>
					<a class="edit-comment" data-comment-no="${comment.comIdNo}"
							href="javascript:">수정</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="delete-comment" data-comment-no="${comment.comIdNo}"
							href="javascript:">삭제</a>&nbsp;&nbsp;&nbsp;&nbsp;
				</c:otherwise>
			</c:choose>
			<a class="recomment-link" data-comment-no="${comment.comIdNo}" href="#">댓글쓰기</a>
		</div>
		<!-- /.comment-text -->
	</div>
	<!-- /.comment-list -->
	
	<!-- comment-edit -->
	<div id="comment-edit-area-${comment.comIdNo}" class="card-comment" style="display:none">
		<!-- comment-text -->
		<div class="comment-text">
			<c:choose>
				<c:when test="${boardNotice.typeIdNo eq 1}">
					<span class="username">${comment.comWriter2}
					<span class="text-muted float-right">${comment.comDateFormForJsp}</span>
					</span>
				</c:when>
				<c:otherwise>
					<span class="username">익명${comment.comIdNo}
					<span class="text-muted float-right">${comment.comDateFormForJsp}</span>
					</span>
				</c:otherwise>
			</c:choose>
			<form>
				<input type="hidden" name="comIdNo" value="${comment.comIdNo}" />
				<input type="hidden" name="comPasswd" />
				<textarea name="comContent" style="width:850px;" maxlength="200">${comment.comContent}</textarea>
			</form>
		</div>

		<div class="text-muted float-right">
			<a class="update-comment" data-comment-no="${comment.comIdNo}" href="javascript:">등록</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="cancel-edit-comment" data-comment-no="${comment.comIdNo}" href="javascript:">취소</a>
		</div>
		<!-- /.comment-text -->
	</div>
	<!-- /.comment-edit -->
</c:forEach>