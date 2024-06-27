<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>


//게시판 선택한 갯수만큼 출력되게 하기 위해서 select on change하면 submit하게 함
function chg()
{
 
   var form=document.getElementById("pkc");
   form.submit();
}







</script>

<!-- 페이징 태그의 a 링크 클릭 여부에 따라서 색상이 변하는 것만 스타일 바꿈 나머지는 게시판 기본 -->
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
    

	//DB연결
	Class.forName("com.mysql.jdbc.Driver"); // 라이브러리를 찾아라
    String db="jdbc:mysql://localhost:3306/second";
    Connection conn=DriverManager.getConnection(db,"root","1234");
	
    
 	//검색시에 파라미터로 한글이 들어오는 것을 인코딩
    request.setCharacterEncoding("utf-8");
 	
 	//검색form의 들어온 검색 컬럼, 검색 텍스트
 	String searchfield=request.getParameter("searchfield");
 	String searchText=request.getParameter("searchText");
    
    
    //searchText가 없을 때 기본페이지가 페이징 방식으로 노출 
    if(searchText==null){
    	  //paranumber변수는 게시판 노출 갯수 selection으로 들어오는 변수
    	  String paranumber = request.getParameter("number");
    	  
    	   if (paranumber == null) {
    		   //값이 없으면 5개씩 노출을 기본으로
    	       paranumber = "5";
    	   }
    	   out.print("paranumber"+paranumber);
    	   
    	   int paranumint=Integer.parseInt(paranumber);
    	   out.print(paranumint);
    	    
    	    
    	    //페이지를 위한 부분
    	    int pager;
    	    if(request.getParameter("pager")==null)
    	    {
    	       pager=1;
    	    }else{
    	       pager=Integer.parseInt(request.getParameter("pager"));
    	    }
    	    
    	    
    	  	//sql에 넣을 첫 인덱스를 구하는 변수
    	    int index=(pager-1)*paranumint;
    	    
    	  	//게시판 아래 부분은 1....10 출력 부분 pstart,pend활용
    	    int pstart,pend;
    	    int p=pager/10;
    	     if(pager%10==0){
    	        p=p-1;
    	     }
    	    pstart=p*10+1;
    	    pend=pstart+9;
    	    
    	    //총 페이지를 구해 마지막 부분은 10페이지가 전부 출력되지 않게 함.
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
    	    
    	    

    	    
    	    //게시판 리스트 인쇄 부분
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
    	      <form id="pkc" name="pkc" method="post" action="list4.jsp">
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
    	   
    	   <%-- <%= "5".equals(paranumber) ? "selected" : "" %> --%>
    	   
    	   <a href="list4.jsp?pager=<%=pstart-1%>&number=<%=request.getParameter("number")==null ? "5": request.getParameter("number")%>"><<</a>   
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
    	      <a href="list4.jsp?pager=<%=pager-1%>&number=<%=request.getParameter("number")==null ? "5": request.getParameter("number")%>"><</a>
    	      
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
    	         <a href="list4.jsp?pager=<%=i%>&number=<%=request.getParameter("number")==null ? "5": request.getParameter("number")%>" <%=imsi%> class="link"><%=i%></a>   
    	      <%   
    	      }
    	      %>
    	      <%
    	      if(pager !=chong){
    	      %>
    	         <a href="list4.jsp?pager=<%=pager+1%>&number=<%=request.getParameter("number")==null ? "5": request.getParameter("number")%>">></a>
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
    	         <a href="list4.jsp?pager=<%=pend+1%>&number=<%=request.getParameter("number")==null ? "5": request.getParameter("number")%>">>></a>
    	      <% 
    	      }else{
    	      %>
    	         >>
    	      
    	      <%   
    	      }
    	      %>
    	      </td>
    	   </tr>
    	      <tr>
    	         <form name="search" method="post"  action="list4.jsp">
    	            <td>
    	            </td>
    	            <td colspan="2" align="center">
    	               <select name="searchfield">
    	                  <option value=0>작성자</option>
    	                  <option value=1>제목</option>
    	                  <option value=2>제목+작성자</option>
    	               </select>
    	               <input type="text" placeholder="검색어 입력" name="searchText" maxlength="100">
    	               <input type="submit" value="검색">
    	            </td>
    	            <td>
    	            </td>
    	         </form>
    	   </tr>
    	 </table>
    	 

    	 <%
    	    rs.close();
    	    pstmt.close();
    	    conn.close();
    	 %>
    	          
    	
    	
<%  //searchText가 있을 때	
    }else{
    	//searchfield가 작성자0이고 searchText.trim()이 not null일 때
    	if(searchfield.equals("0")&&searchText!=""){
    		
    		
    		
    		
    		
    		String searchTextWC = "%" + searchText + "%";
    		String sql1="select * from pageboard where name like ?";
    		PreparedStatement pstmt1=conn.prepareStatement(sql1);
    		pstmt1.setString(1,searchTextWC);
    		ResultSet rs1=pstmt1.executeQuery();
    		
%>    		
    		
    	<table align="center" width="700">
    		 </tr>
    	      <tr>
    	        <td> 작성자 </td>
    	        <td> 제 목 </td>
    	        <td> 조회수 </td>
    	        <td> 작성일 </td>
    	      </tr>
    	    
    	<%       
    	    while(rs1.next()){
    	       
    	%>     
    	   <tr>
    	      <td> <%=rs1.getString("name")%> </td>
    	        <td> <%=rs1.getString("title")%> </td>
    	        <td> <%=rs1.getString("readnum")%> </td>
    	        <td> <%=rs1.getString("writeday")%> </td>
    	   
    	   </tr>
    	<%        
    	    }
    	%>   
    	    <tr>
    	       <td colspan="4" align="right">
    	          <a href="list4.jsp"></a>
    	       </td>
    	    </tr>
    		
    		
    		
    		
    </table>			
    		
    		
    		
    		
    		
    		
    		
    	
<% 
		//searchText가 1제목이고 검색되는 단어가 있을 때
    	}else if(searchfield.equals("1")&&searchText!=""){
    		
   		
    		
    		
    		
    		String searchTextWC = "%" + searchText + "%";
    		String sql2="select * from pageboard where title like ?";
    		PreparedStatement pstmt2=conn.prepareStatement(sql2);
    		pstmt2.setString(1,searchTextWC);
    		ResultSet rs2=pstmt2.executeQuery();
    		
%>    		
    		
    	<table align="center" width="700">
    		 </tr>
    	      <tr>
    	        <td> 작성자 </td>
    	        <td> 제 목 </td>
    	        <td> 조회수 </td>
    	        <td> 작성일 </td>
    	      </tr>
    	    
    	<%       
    	    while(rs2.next()){
    	       
    	%>     
    	   <tr>
    	      <td> <%=rs2.getString("name")%> </td>
    	        <td> <%=rs2.getString("title")%> </td>
    	        <td> <%=rs2.getString("readnum")%> </td>
    	        <td> <%=rs2.getString("writeday")%> </td>
    	   
    	   </tr>
    	<%        
    	    }
    	%>   
    	    <tr>
    	       <td colspan="4" align="right">
    	          <a href="list4.jsp"></a>
    	       </td>
    	    </tr>
    		
    		
    		
    		
    </table>			
    		
    		
    		
    		
    		
    		
    		
    	
    		
    		
    		
    		
<% 
    		//서치 텍스트가 2이고 검색되는 단어가 있을때
    	}else if(searchfield.equals("2")&&searchText!=""){
    		
   		
    		
    		
    		
    		String searchTextWC = "%" + searchText + "%";
    		String sql3="select * from pageboard where title like ? or name like ?";
    		PreparedStatement pstmt3=conn.prepareStatement(sql3);
    		pstmt3.setString(1,searchTextWC);
    		pstmt3.setString(2,searchTextWC);
    		ResultSet rs3=pstmt3.executeQuery();
    		
%>    		
    		
	    	<table align="center" width="700">
	    		 </tr>
	    	      <tr>
	    	        <td> 작성자 </td>
	    	        <td> 제 목 </td>
	    	        <td> 조회수 </td>
	    	        <td> 작성일 </td>
	    	      </tr>
	    	    
	    	<%       
	    	    while(rs3.next()){
	    	       
	    	%>     
	    	   <tr>
	    	      <td> <%=rs3.getString("name")%> </td>
	    	        <td> <%=rs3.getString("title")%> </td>
	    	        <td> <%=rs3.getString("readnum")%> </td>
	    	        <td> <%=rs3.getString("writeday")%> </td>
	    	   
	    	   </tr>
	    	<%        
	    	    }
	    	%>   
	    	    <tr>
	    	       <td colspan="4" align="right">
	    	          <a href="list4.jsp"></a>
	    	       </td>
	    	    </tr>
	    </table>			
    		
<%    		
    	}else{
    		//예외 처리를 일단 list첫페이지로 아니면 전체 목록 로직을 반복해도 됨.
    		response.sendRedirect("list4.jsp");
    	}
  

    	
    	
    }


%>

<!-- 추가하고 싶은 기능 

1.검색한 후에도 밑에 검색기능 노출되어 다시 검색했을 때 새로운 검색 나오게
2.검색에도 페이징과 게시글 수 적용
3.부트스트랩 적용 -->

    
    

</body>
</html>