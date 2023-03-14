<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html>
<head>
	<meta charset="utf-8" />
</head>
<body>

<div id="pageContainer">

	<div style="padding-top:25px;text-align:center">
		<div id="inputcontent">
			<div id="inputmain">
				<div class="inputsubtitle">이메일 보내기</div>
				<form action="send-mail" method="post">
					<table style='margin: 0 auto' border="1">
						<tr>
							<th>제목</th>
							<td>
								<input type="text" name="title" style="width:580px" />
							</td>
						</tr>
						<tr>
							<th>보내는 사람</th>
							<td>
								<input type="text" name="from" style="width:580px">
							</td>
						</tr>
						<tr>
							<th>받는 사람</th>
							<td>
								<input type="text" name="to" style="width:580px">
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>
								<textarea name="content" style="width:580px" rows="15"></textarea>
							</td>
						</tr>
					</table>
					<div class="buttons">
						<input type="submit" value="메일보내기" style="height:25px" />
						<input type="button" value="취소" style="height:25px"  />
					</div>
				</form>
			</div>
		</div>

	</div>
</div>

</body>
</html>