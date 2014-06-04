<%@page import="com.benberg.scanner.main"%>
<%@page import="com.benberg.scanner.TabWorkerClass"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <title>Tabbed Content</title>
    <script src="tabcontent.js" type="text/javascript"></script>
    <link href="tabcontent.css" rel="stylesheet" type="text/css" />
</head>
<body>
   <ul class="tabs" data-persist="true">
   
   <%
   int CurrentMonth = TabWorkerClass.GetCurrentMonth();
   
   for (int i=0;i<=CurrentMonth;i++)
   {
	  String name = TabWorkerClass.GetMonthName(i);
	
	  out.println("<li class><a href=\"#view"+i+"\">"+name+"</a></li>");
	 
	}
     
  %>
  <li class><a href="#viewupcoming">UpcomingIpos</a></li>
  
   </ul>
        <div class="tabcontents">
        
         <%
         for (int i=0;i<=CurrentMonth;i++)
         {
      	  String name = TabWorkerClass.GetMonthName(i);
      	  out.println("<div id=\"view"+i+"\">");
     	  out.println("<a href=\""+TabWorkerClass.GetUrl(i)+"\">Nasdaq IPOs for"+name+"</a><br>");
      	  out.println(com.benberg.scanner.main.getCharts(i));
      	  out.println("</div>"); 
         }
           
        %>
     <div id="viewupcoming">
       <%
       out.println(com.benberg.scanner.main.getUpcomingCharts);
     
 	    %>
     
     
     </div>
    </div>
</body>
</html>
