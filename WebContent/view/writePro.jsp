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
<% request.setCharacterEncoding("EUC-KR"); %>

<jsp:useBean id="article" class="board.BoardDataBean" >
<!-- 리플랙션이 되서 자동으로 property 들어감  -->
	<jsp:setProperty name="article" property="*"/>
</jsp:useBean>
<% System.out.println(article); %>
<%
	String boardid=request.getParameter("boardid");
	if(boardid==null) 
		boardid="1";
	String pageNum=request.getParameter("pageNum");
	if(pageNum==null||pageNum=="")
		pageNum="1";
%>
<%
	BoardDBBean dbPro=BoardDBBean.getInstance(); //인스턴스 가져옴
	
	article.setIp(request.getRemoteAddr());
	//ip주소 form 에서 안넘어 오기 때문에 request로 받아줌
	dbPro.insertArticle(article);
	//db에 데이터 삽입하는 부분
	response.sendRedirect("list.jsp?pageNum="+pageNum+"&boardid="+boardid);
	
%>

</body>
</html>