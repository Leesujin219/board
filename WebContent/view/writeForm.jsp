<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"></head>
<html>
<head>
<title>게시판</title>
</head>
<%	
	int num=0,ref=0,re_step=0,re_level=0;
	//boardid 어떤 게시판인지 구분되어 form에서 값이 넘어가야함
	String boardid=request.getParameter("boardid");
	if(boardid==null) 
		boardid="1";
	if(request.getParameter("num")!=null){
		//답글을 작성할 때
		num=Integer.parseInt(request.getParameter("num"));
		ref=Integer.parseInt(request.getParameter("ref"));
		re_step=Integer.parseInt(request.getParameter("re_step"));
		re_level=Integer.parseInt(request.getParameter("re_level"));

	}	


%>
<p class="w3-left"  style="padding-left:30px;"></p>
<div class="w3-container">
<center><b>글쓰기</b>
<br>
	<form method="post" name="writeform" action="<%=request.getContextPath()%>/view/writePro.jsp" >
	<!-- writePro에 hidden으로 넘겨줄 값들 -->
	<input type="hidden" name="boardid" value="<%=boardid %>">	
	<input type="hidden" name="num" value="<%=num%>">	
	<input type="hidden" name="ref" value="<%=ref%>">	
	<input type="hidden" name="re_level" value="<%=re_level%>">	
	<input type="hidden" name="re_step" value="<%=re_step%>">	
	
	<table class="w3-table-all"  style="width:70%;" >
	   <tr>
	    <td align="right" colspan="2" >
		    <a href="list.jsp"> 글목록</a> 
	   </td>
	   </tr>
	   <tr>
	    <td  width="70"   align="center">이 름</td>
	    <td  width="330">
	       <input type="text" size="10" maxlength="10" name="writer"></td>
	  </tr>
	  <tr>
	    <td  width="70"   align="center" >제 목
	    </td>
	    <td width="330">
	 
	 	<% if(request.getParameter("num")==null) {
	 		//num==null인 경우는 새 글이라는 뜻
	 	%>
	 		<input type="text" size="40" maxlength="50" name="subject">

	 	<%}else{	//답글일 경우에는 제목 앞에 [답글]이라는 단어를 넣어주는 것
	 		%>
	 		<input type="text" size="40" maxlength="50" name="subject" value="[답글]">
	 		
	 		<%
	 	}
	 	%>
	   
	   </td>
	  </tr>
	  <tr>
	    <td  width="70"   align="center">Email</td>
	    <td  width="330">
	       <input type="text" size="40" maxlength="30" name="email" ></td>
	  </tr>
	  <tr>
	    <td  width="70"   align="center" >내 용</td>
	    <td  width="330" >
	     <textarea name="content" rows="13" cols="40"></textarea> </td>
	  </tr>
	  <tr>
	    <td  width="70"   align="center" >비밀번호</td>
	    <td  width="330" >
	     <input type="password" size="8" maxlength="12" name="passwd"> 
		 </td>
	  </tr>
	<tr>      
	 <td colspan=2  align="center"> 
	  <input type="submit" value="글쓰기" >  
	  <input type="reset" value="다시작성">
	  <input type="button" value="목록보기" OnClick="window.location='list.jsp'">
	</td></tr></table>    
	     
</form>
</center></div>  




</body>
</html>      
