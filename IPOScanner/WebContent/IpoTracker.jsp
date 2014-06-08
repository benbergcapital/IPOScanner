<%@page import="com.benberg.scanner.main"%>
<%@page import="com.benberg.scanner.TabWorkerClass"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="product" content="Metro UI CSS Framework">
    <meta name="description" content="Simple responsive css framework">
    <meta name="author" content="Sergey S. Pimenov, Ukraine, Kiev">

    <link href="css/metro-bootstrap.css" rel="stylesheet">
    <link href="css/metro-bootstrap-responsive.css" rel="stylesheet">
    <link href="css/iconFont.css" rel="stylesheet">
    <link href="css/docs.css" rel="stylesheet">
    <link href="js/prettify/prettify.css" rel="stylesheet">

 <!-- Tabbed content  -->
 	<script src="tabcontent.js" type="text/javascript"></script>
    <link href="tabcontent.css" rel="stylesheet" type="text/css" />


    <!-- Load JavaScript Libraries -->
    <script src="js/jquery/jquery.min.js"></script>
    <script src="js/jquery/jquery.widget.min.js"></script>
    <script src="js/jquery/jquery.mousewheel.js"></script>
    <script src="js/prettify/prettify.js"></script>

    <!-- Metro UI CSS JavaScript plugins -->
    <script src="js/load-metro.js"></script>

    <!-- Local JavaScript -->
    <script src="js/docs.js"></script>
    <script src="js/github.info.js"></script>
<style>
#wrapper {
    width: 100%;
    height:100%;
}
#left {
    width: 200px;
    
    float:left; /* add this */
   
}
#right {
  margin-left: 220px;
}
</style>

    <title>Metro UI CSS : Metro Bootstrap CSS Library</title>
</head>
<body>
<header class="bg-dark" data-load="header.html"></header>
<div id="wrapper">
<div class="metro place-left" id="left">
   
     <nav class="sidebar light">
       <ul>
            <li class="active"><a href="IpoTracker.jsp"><i class="icon-home"></i>IPO Tracker</a></li>
           <li class="stick bg-red"><a href="Watchlist.jsp"><i class="icon-cog"></i>Watchlist</a></li>
          
	   </ul>
     </nav>
	
	


 </div>
<div class="main" id="right">

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
       out.println(com.benberg.scanner.main.getUpcoming());
     
 	    %>
     
	</div>
	
	
 	</div>
 </div>
 </div>

</body>
</html>