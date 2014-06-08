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

<script type="text/javascript">
document.querySelector('table').onclick = highlight;

function Watchlist_click(Ticker)
{
	alert(Ticker);
	
}

function highlight(e){
      e = e || event;
      var from = findrow(e.target || e.srcElement)
         ,highlighted = /highlighted/i.test((from||{}).className);
    if (from) {
        var rows = from.parentNode.querySelectorAll('tr');
        for (var i=0;i<rows.length;i+=1){
            rows[i].className = '';
        }
        from.className = !highlighted ? 'highlighted' : '';
    }
}
    
function findrow(el){
      if (/tr/i.test(el.tagName))
        return el;
      var elx;
      while (elx = el.parentNode) {
        if (/tr/i.test(elx.tagName)) {
            return elx;
        }
      }
      return null;
}

</script>

<style>
tr.highlighted td {
 background: #FF3333;
 color: #FFF000;
}

tr {cursor: pointer;}


</style>

    <title>Metro UI CSS : Metro Bootstrap CSS Library</title>
</head>
<body>
<div class="metro place-left">
<header class="bg-dark" data-load="header.html"></header>
<table>
<tr>
<td valign="top" >

    
   
     
     <nav class="sidebar light">
       <ul>
            <li class=""><a href="IpoTracker.jsp"><i class="icon-home"></i>IPO Tracker</a></li>
           <li class="active"><a href="Watchlist.jsp"><i class="icon-cog"></i>Watchlist</a></li>
          
	   </ul>
     </nav>
	
	

</td>
<td>
<div class="main">
<table>

 <%
       out.println(com.benberg.scanner.main.GetWatchlist());
     
 	    %>


</table>


</div>
 </td>
 </tr>
 </table>
 </div>
</body>
</html>