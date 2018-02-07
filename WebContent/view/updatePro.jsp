<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("euc-kr"); %>
<%
	String pageNum=request.getParameter("pageNum");
	//pageNum < 글 목록 보기를 위해 넘어옴 
	if(pageNum==null||pageNum==""){
		pageNum="1";
	}
%>

<jsp:useBean id="article" class="board.BoardDataBean" >
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<% System.out.println(article); %>
<!-- 콘솔에 찍는 용도의 sysout -->
<%	
	BoardDBBean dbPro=BoardDBBean.getInstance(); //인스턴스 가져옴
	int chk=dbPro.updateArticle(article);
%>
<%
	if(chk==1){
	%>
		<meta http-equiv="Refresh" content="0;url=list.jsp?pageNum=<%=pageNum%> ">  
		<!--데이터 업데이트 후 list 페이지로 이동 -->
	<%	
	}else{
		%>
		<script>
		alert("비밀번호가 맞지 않습니다.")
		history.go(-1); /* 전페이지로 이동. updateForm.jsp 페이지에서 멈추어 있는 것 */
		</script>
		<%
	}
%>
</body>
</html>