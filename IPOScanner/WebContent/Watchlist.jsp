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
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript">

function Watchlist_click(Ticker)
{
	//alert(Ticker);

	
}

function Save_Watchlist()
{
var json="";
	
var table = document.getElementById('watchlisttable');
//var mytablebody = myTable.getElementsByTagName("tbody")[0];
//var trs = mytablebody.getElementsByTagName('td');
 for (var i=1;i < table.rows.length;i++){
json += "{"+table.rows[i].cells[0].innerText+";"+table.rows[i].cells[1].innerText+"}";

 }

}






$(document).ready(function(){
	  $("tr").click(function() {
		 
	    $(this).closest("tr").siblings().removeClass("highlighted");
	    $(this).toggleClass("highlighted");
	  })
	});
	// Note: currently only works for row without '.alt' css class assigned (ie. empty)
	// 

</script>

<style>

table{
	border:1px solid #C1DAD7;

}


th {
    font: bold 11px "Trebuchet MS", Verdana, Arial, Helvetica,
        sans-serif;
    color: Black;
    background: lightgrey;
   
    letter-spacing: 2px;
    text-transform: uppercase;
    text-align: left;
    padding: 6px 6px 6px 12px;
   	cursor: pointer;
}

tr {
    background: #fff;
    color: #1ba1e2;
}



.highlighted {
    color: white;
    background-color: #1ba1e2;
}



td {
    border-right: 1px solid #C1DAD7;
    border-bottom: 1px solid #C1DAD7;
    padding: 6px 6px 6px 12px;
}
tr {cursor: pointer;}

main {
float:right;
}
#wrapper {
    width: 100%;
    
}
#left {
    width: 200px;
    float:left; /* add this */
   
}
#right {
  padding-left: 10px;
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
            <li class=""><a href="IpoTracker.jsp"><i class="icon-home"></i>IPO Tracker</a></li>
           <li class="active"><a href="Watchlist.jsp"><i class="icon-cog"></i>Watchlist</a></li>
          
	   </ul>
     </nav>
	
	

 </div>
<div class="main" id="right" >
<input id="clickMe" type="button" value="clickme" onclick="Save_Watchlist();" />
<table border="0" id="watchlisttable">
<th>Ticker</th><th>Notes</th>

 
    <%   out.println(com.benberg.scanner.main.GetWatchlist());%>
     
 	    

</table>


</div>
 
</div>
</body>
</html>