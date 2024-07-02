<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <style>
   table {
     border-spacing:0px; /* 셀과 셀 간격 == cellspacing */
   }
   table td {
     border-bottom:1px solid black;
     padding:5px;
     height:35px;
   }
   table tr:first-child td {
     border-top:2px solid black;
     border-bottom:2px solid black;
   }
   table tr:last-child td {
     border-bottom:2px solid black;
   }
   a {
      text-decoration:none;
      color:black;
   }
   a:hover {
      text-decoration:underline;
      color:green;
   }
   #btn {
      color:black;
      text-decoration:none;
      border:1px solid green;
      padding:4px 20px; /* 상하 좌우 */
      
   }
 
   </style>
</head>
<body> <!-- list.jsp -->

<%@page import="board.Board" %> 
<%@page import="java.sql.ResultSet" %>
  
<%
    // board테이블에 있는 레코드를 가져와서 출력
    
    // DB연결
    Board board=new Board();
	ResultSet rs=board.list(request);
	
	int pstart=Integer.parseInt(request.getAttribute("pstart").toString());
	int pend=Integer.parseInt(request.getAttribute("pend").toString());
	int pager=Integer.parseInt(request.getAttribute("page").toString());
	int chong=Integer.parseInt(request.getAttribute("chong").toString());
	
	//out.print(pstart+" "+pend);
	
%>
    <table width="800" align="center">
      <caption> <h3> 게시판 </h3></caption>
      <tr>
        <td> 작성자 </td>
        <td> 제 목 </td>
        <td> 조회수 </td>
        <td> 작성일 </td>
      </tr>
<%    
    // 출력
    while(rs.next())
    {
%>    
      <tr>
        <td> <%=rs.getString("name")%> </td>
        <td> <a href="readnum.jsp?id=<%=rs.getInt("id")%>"> <%=rs.getString("title")%> </a> </td>
        <td> <%=rs.getString("readnum")%> </td>
        <td> <%=rs.getString("writeday")%> </td>
      </tr>
<%
    }
%>	
     <tr>
       <td colspan="4" align="right">
          <a href="write.jsp" id="btn"> 글쓰기 </a>
       </td>
     </tr>
     <tr>
     	<td colspan="4" align="center">
     	
     	

     	
     	
<%

	


	//선택된 값이 5보다 작을 때
	//1~9까지 출력되게 하고 chong값이 출력되게 하라


	//선택된 값이 5보다 크면
	//1이 출력되고 chong이 출력되고 앞으로 4개씩 출력되게 하라

	//선택된 값의 앞뒤로 4개씩만 출력되게 하는 법
	
	
	
			String imsi="";
			if(pager<6){
			
				for(int i=pstart; i<pend; i++){
					imsi="";
					if(pager==i)
					{
						imsi="style='color:red'";
					}
			%>			
						<a href="list2.jsp?page=<%=i%>"  <%=imsi%>><%=i%></a>						
			<%			
					}
					imsi="";
					if(pager==chong)
					{
						imsi="style='color:red'";
					}
					
			%>
					...<a href="list2.jsp?page=<%=chong%>" <%=imsi%>><%=chong%></a>
					
			<% 		
							
				}else if(pager>=6 && pager<=chong-4){
						imsi="";
						if(pager==1)
						{
							imsi="style='color:red'";
						}
						
			%>
						<a href="list2.jsp?page=1" <%=imsi%>>1</a>...	
			<% 	
				for(int i=pager-4; i<=pager+4; i++){
						imsi="";
						if(pager==i)
						{
							imsi="style='color:red'";
						}
			%>		
				
						<a href="list2.jsp?page=<%=i%>"<%=imsi%>><%=i%></a>
					
			<% 		
				}
						imsi="";
						if(pager==chong)
						{
							imsi="style='color:red'";
						}
						
			%>
					...<a href="list2.jsp?page=<%=chong%>" <%=imsi%>><%=chong%></a>
			
			<%		
				}else{
					imsi="";
					if(pager==1)
					{
						imsi="style='color:red'";
					}
					
					%>
					<a href="list2.jsp?page=1" <%=imsi%>>1</a>...	
		
			
			<%		
					for(int i=pager-4; i<=chong; i++){
		
						imsi="";
						if(pager==i)
						{
							imsi="style='color:red'";
						}
			%>		
				
						<a href="list2.jsp?page=<%=i%>"<%=imsi%>><%=i%></a>
					
				
			<% 			
					}
					
			
						imsi="";
						if(pager==chong)
						{
							imsi="style='color:red'";
						}
						
			%>
					...<a href="list2.jsp?page=<%=chong%>" <%=imsi%>><%=chong%></a>
					
					
						
			<% 		
				}
			%>
     	</td>
     </tr>
   </table>
<%
	board.allClose();
%>
</body>
</html>














