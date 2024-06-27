<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function chg()
{
   //대분류에 맞는 중분류 option태그를 만든다.
   //alert(document.pkc.dae.value);
   var form=document.getElementById("pkc");
   form.submit();
}
</script>
<style>
  a.link { 
      text-decoration:none;
      display:inline-block;
      height:30px;
      line-height:30px;
      text-align:center;
      
   }  
   a {
      text-decoration:none;
      color:black;
   }
</style>
</head>
<body>
<%@page import="java.sql.*" %>  
<%
    // board테이블에 있는 레코드를 가져와서 출력
    
    // DB연결
    
    Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
    String db="jdbc:mysql://localhost:3306/second";
    Connection conn=DriverManager.getConnection(db,"root","1234");
    
  
   String paranumber = request.getParameter("number");
   if (paranumber == null) {
       paranumber = "5";
   }
   out.print("paranumber"+paranumber);
   
   int paranumint=Integer.parseInt(paranumber);
    out.print(paranumint);
    
    int pager;
    if(request.getParameter("pager")==null)
    {
       pager=1;
    }else{
       pager=Integer.parseInt(request.getParameter("pager"));
    }
    
    int index=(pager-1)*paranumint;//sql에 넣을 출력되는 값
    
    int pstart,pend;
    int p=pager/10;
     if(pager%10==0){
        p=p-1;
     }
    pstart=p*10+1;
    pend=pstart+9;
    out.print("pstart"+pstart);
    out.print("pend"+pend);
    String sql2="select ceil(count(*)/?) as chong from pageboard";
    PreparedStatement pstmt2=conn.prepareStatement(sql2);
    pstmt2.setInt(1,paranumint);
    ResultSet rs2=pstmt2.executeQuery();
    rs2.next();
    int chong=rs2.getInt("chong");
    if(chong<pend)
    {
       pend=chong;
    }
    
    String sql="select * from pageboard order by id desc limit ?,?";
    PreparedStatement pstmt=conn.prepareStatement(sql);
    pstmt.setInt(1,index);
    pstmt.setInt(2,paranumint);
    ResultSet rs=pstmt.executeQuery();
%>


   <table width="800" align="center">
   <caption> <h3> 게시판 </h3></caption>
   <tr>
   <td colspan="4" align="left">
      <form id="pkc" name="pkc" method="post" action="list3.jsp">
      <select id="number" name="number" onchange="chg()">
         <option value="5" <%= "5".equals(paranumber) ? "selected" : "" %>>게시글 5개씩</option>
         <option value="10"<%= "10".equals(paranumber) ? "selected" : "" %> >게시글 10개씩</option>
         <option value="20"<%= "20".equals(paranumber) ? "selected" : "" %>>게시글 20개씩</option>
      </select>

   </td>
   </tr>
      <tr>
        <td> 작성자 </td>
        <td> 제 목 </td>
        <td> 조회수 </td>
        <td> 작성일 </td>
      </tr>
    
<%       
    while(rs.next()){
       
%>     
   <tr>
      <td> <%=rs.getString("name")%> </td>
        <td> <%=rs.getString("title")%> </td>
        <td> <%=rs.getString("readnum")%> </td>
        <td> <%=rs.getString("writeday")%> </td>
   
   </tr>
<%        
    }
%>   
    <tr>
       <td colspan="4" align="right">
          <a href="write.jsp" id="btn">글쓰기</a>
       </td>
    </tr>
   
   <tr>
   <td colspan="4" align="center">
   
   <%
   if(pstart != 1){
   %>   
   <a href="list3.jsp?pager=<%=pstart-1%>&number=<%=request.getParameter("number")%>"><<</a>   
   <% 
   }else{
   %>
      <<
      
   <%    
   }      
   %>
   
   
   <%
   if(pager != 1){
   %>
      <a href="list3.jsp?pager=<%=pager-1%>&number=<%=request.getParameter("number")%>"><</a>
      
   <%    
   }else{
   %>   
      <
   <%    
   }
   %>   
      <% 
      for(int i=pstart; i<=pend; i++){
         String imsi="";
         if(pager==i){
            imsi="style='color:red;border:1 px solid black;'";   
         }
      %>
         <a href="list3.jsp?pager=<%=i%>&number=<%=request.getParameter("number")%>" <%=imsi%> class="link"><%=i%></a>   
      <%   
      }
      %>
      <%
      if(pager !=chong){
      %>
         <a href="list3.jsp?pager=<%=pager+1%>&number=<%=request.getParameter("number")%>">></a>
      <% 
      }else{
      %>
         >
      <%   
      }
      %>
      <%
      if(pend !=chong){
      %>
         <a href="list3.jsp?pager=<%=pend+1%>&number=<%=request.getParameter("number")%>">>></a>
      <% 
      }else{
      %>
         >>
      
      <%   
      }
      %>
      </td>
   </tr>

</table>  
 
 <%
    rs.close();
    pstmt.close();
    conn.close();
 %>
          
    
    

</body>
</html>