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
 function GetData()
 {
	var Ticker = "AAPL";

	     	var dataString ={"Ticker":Ticker,"RequestType":"AUTOTRADER"};
	     	
	     	$('#chart1').html("Loading...");
	    // 	var high =0;
	 	//	var low=9999;
	 		
	     	$.ajax({
	     	    type: "POST",
	     	    url: "MarketDataRequest.do",
	     	    data: dataString,
	     	    success: function(jsonData) {
	     	    	
	     //	    	alert("{"+jsonData+"}");
	     	    	
	  if (jsonData.indexOf("NoRSIData") ==-1)
	     	{    		
	     	    	alert("here");
	     	    	var data = JSON.parse("["+jsonData+"]");

	 	
	 	
	 	// split the data set into ohlc and volume
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

	 	// set the allowed units for data grouping
	 	var groupingUnits = [[
	 		'day',                         // unit name
	 		[1]                             // allowed multiples
	 	], [
	 		'day',
	 		[1, 2, 3, 4, 6]
	 	]];

	 	// create the chart
	 	$('#'+chart).highcharts('StockChart', {
	 	    
	 	    rangeSelector: {
	 			inputEnabled: $('#container').width() > 480,
	 	        selected: 1
	 	    },

	 	    title: {
	 	        text: Ticker+' ('+Timeframe+')'
	 	    },
	 	    plotOptions: {
	 	    	candlestick: {
	 	    		color: 'red',
	 	    		upColor: 'green'
	 	    	}
	 	    },
	 	  
	 	    rangeSelector : {
	             selected : 100
	         },
	 	    yAxis: [
	 	            
	 	            {
	 	        labels: {
	 	    		align: 'right',
	 	    		x: -3
	 	    	},
	 	        title: {
	 	            text: 'USD'
	 	        },
	 	        height: '100%',
	 	        lineWidth: 2,
	 	 //       min: low, max : high
	 	    }],
	 	    global: [{
	 	        useUTC: true
	 	    }],
	 	    tooltip: {
	 	        crosshairs: [true,true],
	         enabledIndicators: true
	 	    },
	 	    series: [{
	 	        type: 'candlestick',
	 	        name: Ticker,
	 	        id: 'primary',
	 	        data: ohlc     
	 	 
	 	    }],
	 	    indicators: [{
	             id: 'primary',
	             type: 'sma',
	             params: {
	                 period: 9,
	             },
	             styles: {
	                 strokeWidth: 0.1,
	                 stroke: 'black',
	                 dashstyle: 'solid'
	             }
	         },{
	         id: 'primary',
	         type: 'sma',
	         params: {
	             period: 21,
	         },
	         styles: {
	             strokeWidth: 0.1,
	             stroke: 'yellow',
	             dashstyle: 'solid'
	         }
	    	 },{
	          id: 'primary',
	          type: 'sma',
	          params: {
	              period: 50,
	          },
	          styles: {
	              strokeWidth: 1,
	              stroke: 'lightblue',
	              dashstyle: 'solid'
	          }
	     	 }]  
	 	    
	 	    
	 	    
	 	});

	 	
	     	    }
	  else
		  $('#chart1').html("RSI calculation failed for "+Ticker);
	     	    
	     	    
	     	    }
	     	    
	     	});
	     	
	
	 	
	     	
	 }
 
 
 
 
 
 
 </script>
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

	<title>Insert title here</title>
</head>
<body>
<header class="bg-dark" data-load="header.html"></header>
<div id="wrapper">
<div class="metro place-left" id="left">
   
     <nav class="sidebar light">
       <ul>
            <li class="stick bg-red"><a href="IpoTracker.jsp"><i class="icon-home"></i>IPO Tracker</a></li>
           <li class="stick bg-red"><a href="Watchlist.jsp"><i class="icon-cog"></i>Watchlist</a></li>
           <li class="active"><a href="IpoTracker.jsp"><i class="icon-home"></i>Auto Trader</a></li>
	   </ul>
     </nav>
	
	


 </div>
<div class="main" id="right">

<button onclick="GetData()">New</button>
<div id="chart1" ></div>

</div>
</div>

</body>
</html>