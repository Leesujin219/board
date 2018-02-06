<%@page import="board.BoardDataBean"%>
<%@page import="board.BoardDBBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	String boardid=request.getParameter("boardid");
	if(boardid==null) 
		boardid="1";
%>
<%
	int pageSize=5;
	//�� �������� ������ �� ����
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum=request.getParameter("pageNum");
	//������ ��ȣ
	if(pageNum==null||pageNum==""){
		pageNum="1";
		//ó���� ���ö��� 1���� �� (�Ѿ���� pageNum�� ���� ������)
	}
	int currentPage=Integer.parseInt(pageNum);
	int startRow=(currentPage-1)*pageSize+1;
	//db���� ������ �������� ��(currentPage�� ����Ǵ� ���� ����)
	int endRow=currentPage*pageSize;
	//db���� ������ �������� ������ �� (currentPage�� ����Ǵ� ���� �Ʒ� ��)
	int count=0;
	int number=0;
	List articleList=null;
	//���� list�� �޾���
	BoardDBBean dbPro=BoardDBBean.getInstance();
	//DBBean�� ������ ��ü instance�� �ּ� ��
	count=dbPro.getArticleCount(boardid); 
	//�� �Խñ� ����
	if(count>0){
		articleList=dbPro.getArticles(startRow,endRow,boardid);
	}
	number=count-(currentPage-1)*pageSize;
	//������ �� �� ���� �ֽű��� �� ��ȣ(current)
%>
	<p class="w3-left" style="padding-left:30px;">
	</p>
	<div class="w3-container">
		<span class="w3-center w3-large">
			<h3><%=boardid %>(��ü �� : <%=count %>)
			</h3>
		</span>
		<p class="w3-right w3-padding-right-large">
			<a href="writeForm.jsp">�۾���</a>
		</p>
		<%
			if(count==0){
		%>
			<table class="table-boarded" width="700">
				<tr class="w3-grey">
					<td align="center">�Խ��ǿ� ����� ���� �����ϴ�.</td>
				</tr>
			</table>
		
		<%	}else{ %>
		<table class="w3-table-all" width="700">
			<tr class="w3-grey">
			<td align="center" width="50">��ȣ</td>
			<td align="center" width="250">����</td>
			<td align="center" width="100">�ۼ���</td>
			<td align="center" width="150">�ۼ���</td>
			<td align="center" width="50">��ȸ</td>
			<td align="center" width="100">IP</td>
			</tr>
		<%
		for(int i=0;i<articleList.size();i++){
			BoardDataBean article=(BoardDataBean)articleList.get(i); 
			//for�� ���鼭 list���� �� �� ������  %>
			<tr height="30">
			<td align="center" width="50"><%=number--%></td>
			<!-- �� ��ȣ ǥ�� -->
			<td width="250">
			<% 	//��� �κ�	*ref >���� �׷� , re_level >��� �� �Խù��� +1, re_step >����Ʈ ����
				//��> ��۸�� ����
				int wid=0;
				if(article.getRe_level()>0){
					wid=5*(article.getRe_level());//re_level 0�̸� 0��
			%>
				<img src="images/level.gif width=<%=wid%>" height="16">
			<%
				}
			%><a href= "content.jsp?num=<%=article.getNum() %>&pageNum=<%=currentPage %>">
			<%-- �� ���� Ŭ�� �� ���뺸��� �Ѿ --%>
			<%=article.getSubject() %></a>
			<%
				 if(article.getReadcount()>=20){
					//��ȸ���� 20���� Ŭ �� 
					%>
					<img src="image/hot.gif" border="0" height="16">
					<%} %></td>
					<td align="center" width="100"><%=article.getWriter() %></td>
					<!-- �۾��� ��� -->
					<td align="center" width="150">
            	    <%=sdf.format(article.getReg_date()) %></td>
            		<!-- �۾� ��¥ ��� -->	    
					<td align="center" width="50"><%=article.getReadcount() %></td>
 					<!-- ��ȸ�� ��� -->
					<td align="center" width="100"><%=article.getIp() %></td>
					<!-- ip ��� -->
					</tr>
					<%
				}//for �ݺ��� ����. articleList size��ŭ �� ��µ�
			%></table><%
		}
	%>
	</div>
<!-- �Խñ� ��� ������ �ϴ��� ������ �̵� �κ� [1][2][3]  -->
	<div class="w3-center">
	<% int bottomLine=3;
		//����Ǵ� �ϴ� ������ �� 
		if(count>0){	//count<��ü�� ����
			int pageCount=count/pageSize+(count%pageSize==0?0:1);
			//pageSize<�� �������� ������ �� ����
			//pageCount<�� �������� ����

			int startPage=1+(currentPage-1)/bottomLine*bottomLine;
			//1,4,7.. 
			int endPage=startPage+bottomLine-1;
			//3,6,9...
			if(endPage>pageCount)
				endPage=pageCount;
			//startPage�� ���� endPage�� ��ü �������� ���� ũ�� endPage=pageCount�� ��������
			if(startPage>bottomLine){
				//[����] <- ǥ�õǴ� ����
				%>
					<a href="list.jsp?pageNum=<%=startPage-bottomLine %>">[����]</a>				
					<!-- [����] ������ 4,5,6 �̸� > 1,2,3 ���� �̵��� -->
					<!-- ������ ��ȣ�� pageNum(String)���� �Ѱ���>CurrentPage�� ��-->
				<%}%>
				<% for(int i=startPage;i<=endPage;i++)
					{ 
					// �ϴ� [1][2][3] ����Ʈ
					%>
					<a href="list.jsp?pageNum=<%=i %>">
					<!-- pageNum�ѱ� -->
					<%	//���� �������� ��� ������ ��Ʈ
						if(i!=currentPage)
							out.print("["+i+"]");
						else out.print("<font color='red'>["+i+"]</font>");						
					%>
					</a>			
				<%}
				if(endPage<pageCount){%>
					<a href="list.jsp?pageNum=<%=startPage+bottomLine%>">[����]</a>
				<%					
				}
					
				
			}
		
		%>
	
	
</div>
</body>
</html>