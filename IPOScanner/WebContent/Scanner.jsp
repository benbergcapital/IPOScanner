<%@page import="java.util.List"%>
<%@page import="com.benberg.scanner.Cache"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Benberg Mobile</title>
<script language="javascript" type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="highstock.js"></script>
<script src="http://code.highcharts.com/stock/modules/exporting.js"></script>
<script src="json2.js"></script>

 	<link href="css/metro-bootstrap.css" rel="stylesheet">
    <link href="css/metro-bootstrap-responsive.css" rel="stylesheet">
    <link href="css/iconFont.css" rel="stylesheet">
    <link href="css/docs.css" rel="stylesheet">
    <link href="js/prettify/prettify.css" rel="stylesheet">
	<link href="css/sidebar.css" rel="stylesheet">
 <!-- Tabbed content  -->
 	<script src="tabcontent.js" type="text/javascript"></script>
    <link href="tabcontent.css" rel="stylesheet" type="text/css" />


    <!-- Load JavaScript Libraries -->
       <script language="javascript" type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script src="js/jquery/jquery.min.js"></script>
    <script src="js/jquery/jquery.widget.min.js"></script>
    <script src="js/jquery/jquery.mousewheel.js"></script>
    <script src="js/prettify/prettify.js"></script>

    <!-- Metro UI CSS JavaScript plugins -->
    <script src="js/load-metro.js"></script>

    <!-- Local JavaScript -->
    <script src="js/docs.js"></script>
    <script src="js/github.info.js"></script>


<script>
window.onload = onLoad;
function onLoad()
{
	
	
	 $('.subtitle').toggleClass('off');
}


function NewChartRequest()
{
	var Ticker = document.getElementById('tickerInput').value;
	 $('#ticker').html(Ticker); 
	 GlobalTicker=Ticker;
	GetData(Ticker,"CHART_2_DAY_AO","chart_2_day");
	GetData(Ticker,"CHART_5_DAY","chart_5_day");
	GetData(Ticker,"CHART_DAILY","chart_daily");
	GetNews(Ticker);
	document.getElementById('subtitle').style.visibility="visible";	
}



function GetNews(Ticker)
{
	var dataString ={"Ticker":Ticker};
   	
	
	$.ajax({
	    type: "POST",
	    url: "NewsRequest.do",
	    data: dataString,
	    success: function(response) {
	    
	    	$('#news').html(response);
	    	
	    	
	    }
	});
	
	
	
}


function GetData(Ticker,RequestType,ChartId)
{
GlobalTicker=Ticker;



    	var dataString ={"Ticker":Ticker,"RequestType":RequestType};
        var max = 0;
    	$('#'+ChartId).html("Loading...");
    	
    	
    	
    	$.ajax({
    	    type: "POST",
    	    url: "MarketDataRequest.do",
    	    data: dataString,
    	    success: function(jsonData) {
    	    
    	 if(jsonData.indexOf("Error")>-1)
    	 {
    		 $('#'+ChartId).html("");
    		return;
    	 }
        	    	
    	    	
    	  var data = JSON.parse("["+jsonData+"]");

    	  var ohlc = [],
    		volume = [],
    			dataLength = data.length;
    			
    		for (i = 0; i < dataLength; i++) {
    			ohlc.push([
    				data[i][0], // the date
    				data[i][1], // open
    				data[i][2], // high
    				data[i][3], // low
    				data[i][4] // close
    			]);
    			

    		}
    		LastTime = data[dataLength-1][0];
    
    	
			 chart = new Highcharts.Chart({
				 chart: {
			            renderTo: ChartId,
			            type: 'StockChart'
			        },
			        title:{
			            text:''
			        },
    	//		rangeSelector: {
    	 //           enabled: false
    	  //      },
    	        legend: {
    	            enabled: false
    	        },               
                xAxis: {
                    type: 'datetime',
                    ordinal: true

                },
               navigator : {
                    enabled : true
                },
                navigation: {
                    buttonOptions: {
                        enabled: false
                    }
                },
                labels:
                {
                  enabled: false
                },
                scrollbar : {
                    enabled : false
                },
               
                series : [{
                    type: 'candlestick',
                    data : ohlc,
                    pointInterval: 1000 * 3600,
                    tooltip: {
                        valueDecimals: 2
                    }
                }]
    		});
    		
    		
    		
    	    }
    	});
    
    		
}
//Function so that when pressing eter the GO button is clicked
$(document).ready(function(){
    $('#tickerInput').keypress(function(e){
      if(e.keyCode==13)
      $('#tickerInputButton').click();
    });
});	
</script>
<style>

#table{
	width:1200px;
	height:50px;
}
#column{
	width:600px;
}

#tickerInput{
	width:103px;
}
.subtitle{
	font-weight: bold;
}
table{
	height: 500px;
}

</style>

</head>
<body>
<header class="bg-dark" data-load="header.html"></header>
<div id="wrapper">
<div class="metro place-left" id="left">
   
     <nav class="sidebar light">
       <ul>
            <li class="stick bg-red"><a href="IpoTracker.jsp"><i class="icon-home"></i>IPO Tracker</a></li>
           <li class="stick bg-red"><a href="Watchlist.jsp"><i class="icon-cog"></i>Watchlist</a></li>
          <li class="active"><a href="Scanner.jsp"><i class="icon-cog"></i>Scanner</a></li>
	   </ul>
     </nav>
	
	
<table>
<tr valign="top">
<td>
<input type="text" id="tickerInput" name="ticker">
</td>
<td>
<button id="tickerInputButton" onclick="NewChartRequest()">Go</button>
</td>
</tr>
</table>


 </div>
<div class="main" id="right">



<b>
<div id="ticker">
</div>
</b>
<div id="section">
<table id="table">
<tr>
<td id="column">
<div class="subtitle">2 Days, 5 Minute Chart</div>
<div id="chart_2_day"></div>
</td>
<td id="column">
<div class="subtitle">5 Days, 15 Minute Chart</div>
<div id="chart_5_day"></div>
</td>
</tr>
<tr>
<td id="column">
<div class="subtitle">Daily Chart</div>
<div id="chart_daily"></div>
</td>
<td valign="top">
<div class="subtitle">News</div>
<div id="news"></div>
</td>
</tr>
</table>
 </div>


</div>
</div>


</body>
</html>