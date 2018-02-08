<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%	//content에서 num과 pageNum넘겨줌
	int num=Integer.parseInt(request.getParameter("num"));
	String pageNum=request.getParameter("pageNum");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"></head>
</head>
<body>
<p class="w3-left" style="padding-left:30px;"></p>
<center>
	<div class="w3-container">
		<b>글삭제</b><br>
		<form method="POST" name="delForm" action="deletePro.jsp?pageNum=<%=pageNum %>"
			onsubmit="return deleteSave()">
		<table class="table-bordered" width="360">
			<tr height="30">
				<td align=center><b>비밀번호를 입력해 주세요.</b></td>
			</tr>
			<tr height="30">
				<td align=center>비밀번호 : 
				<input type="password" name="passwd" size="8" maxlength="12">
				<input type="hidden" name="num" value="<%=num %>">
				<!-- hidden값으로 num을 넘겨줌(어떤 게시글을 지워야할지 조건넣을때 필요) -->
				</td>
			</tr>
			<tr height="30">
				<td align=center><input type="submit" value="글삭제">
				<input type="button" value="글목록" 
					onclick="document.location.href='list.jsp?pageNum=<%=pageNum %>'">
				</td>
			</tr>
		</table>
		</form>
	<!-- 주소에 num넘어갔다해도 form으로 받아서 넘겨줘야함 -->
	</center>
</div>
</body>
</html>