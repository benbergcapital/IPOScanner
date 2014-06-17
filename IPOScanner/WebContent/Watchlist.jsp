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

	document.getElementById("charts").innerHTML = "<iframe src=\"\Chart.jsp?name="+Ticker+"\"></iframe>";
	
}

function NewTicker()
{
var Ticker = document.getElementById('entry').value;
Watchlist_click(Ticker);
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
	  
	  $('.watchlisttable').on('click', 'td', function() { // td not tr
  var ticker = $(this).closest('tr').find('td:eq(0)').text();
	//  alert(ticker);
	if (ticker && typeof ticker != "undefined")
		{
	  Watchlist_click(ticker);
		}
});
	  
	  
	 	  
	  
	  
	});
	// Note: currently only works for row without '.alt' css class assigned (ie. empty)
	// 
function myFunction()
{
	
var table = document.getElementById("watchlisttable");
var row = table.insertRow(-1);
var div1 = document.createElement('div');
var div2 = document.createElement('div');
div1.innerHTML = "";
div2.innerHTML = "";

div1.contentEditable = true;
div2.contentEditable = true;
var cell1 = row.insertCell(0);
cell1.appendChild(div1);
var cell2 = row.insertCell(1);
cell2.appendChild(div2);
row.className =  "watchlist";

var createClickHandler = 
    function(row) 
    {
        return function() { 
        	document.getElementById("charts").innerHTML = "<iframe src=\"\Chart.jsp?name="+Ticker+"\"></iframe>";
                         };
    }

row.onclick = createClickHandler(row);



}
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


#wrapper {
    width: 100%;
    height:100%
    
}
#menu {
    width: 200px;
    float:left; /* add this */
   
}
#content
{
width: 100%;
height:100%

}
#watchlist {
  padding-left: 10px;
	float:left
}
#charts{
 padding-left: 10px;
  margin-left: 400px;
height:100%

}
iframe {height:100%;width:100%}
</style>

    <title>Tickers</title>
</head>
<body>
<header class="bg-dark" data-load="header.html"></header>
<div id="wrapper">

<div class="metro place-left" id="menu">

 
   
     
     <nav class="sidebar light">
       <ul>
            <li class=""><a href="IpoTracker.jsp"><i class="icon-home"></i>IPO Tracker</a></li>
           <li class="active"><a href="Watchlist.jsp"><i class="icon-cog"></i>Watchlist</a></li>
          
	   </ul>
     </nav>
	
	

 </div>
<div id="content" >


<div id="watchlist">
<input type="text" id="entry" value="FSLR" style="width:50px;">
<button onclick="NewTicker()" style="width:40px;">Go</button>
<button onclick="myFunction()">New</button>
<!-- <input id="clickMe" type="button" value="save" onclick="Save_Watchlist();" /> -->
<table border="0" id="watchlisttable" class="watchlisttable">
<th>Ticker</th><th>Notes</th>

 
    <%   out.println(com.benberg.scanner.main.GetWatchlist());%>
     
 	    

</table>
</div>


 <div id="charts"></div>
 
</div>
</div>

</body>
</html>