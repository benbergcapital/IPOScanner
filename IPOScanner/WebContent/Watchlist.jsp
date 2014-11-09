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
    
    
    
    <script language="javascript" type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script src="http://code.highcharts.com/stock/highstock.js"></script>
	<script src="http://code.highcharts.com/stock/modules/exporting.js"></script>
	<script type="text/javascript" src="indicators.js"></script>
	<script type="text/javascript" src="sma.js"></script>
	<script type="text/javascript" src="ema.js"></script>
	<script type="text/javascript" src="atr.js"></script>
	<script type="text/javascript" src="rsi.js"></script>
	<script type="text/javascript" src="demo.js"></script>

    

    <!-- Metro UI CSS JavaScript plugins -->
    <script src="js/load-metro.js"></script>

    <!-- Local JavaScript -->
    <script src="js/docs.js"></script>
    <script src="js/github.info.js"></script>
<script type="text/javascript">

function Watchlist_click(Ticker)
{
//	document.getElementById("charts").innerHTML = "<iframe src=\"\Chart.jsp?name="+Ticker+"\"></iframe>";
GetData(Ticker,"3Day1Min","chart1");
GetData(Ticker,"1Yr1D","chart2");
}

function NewTicker()
{

var Ticker = document.getElementById('entry').value;
alert(Ticker);
Watchlist_click(Ticker);
}
function SaveWatchlist()
{
var json="";
	
var table = document.getElementById('watchlisttable');
//var mytablebody = myTable.getElementsByTagName("tbody")[0];
//var trs = mytablebody.getElementsByTagName('td');
 for (var i=1;i < table.rows.length;i++){
	 if(i!=1)
		 json+=";";
	var value = table.rows[i].cells[1].innerText;	 
		 if (value=="")
			 var value = "_";
json += "{Ticker:"+table.rows[i].cells[0].innerText+", Value:"+value"}";

 }
alert(json);
 var dataString ={"Data":json};
	alert(dataString);
 $.ajax({
	    type: "POST",
	    url: "SaveWatchlist.do",
	    data: dataString,
	    success: function(response) {
 
alert(response);
		}
 });

}




$(document).ready(function(){
	  $("tr").click(function() {
		 
	    $(this).closest("tr").siblings().removeClass("highlighted");
	    $(this).toggleClass("highlighted");
	  })
	  
	  $('.watchlisttable').on('click', 'td:first-child', function() { // td not tr
  var ticker = $(this).closest('tr').find('td:eq(0)').text();
	//  alert(ticker);
	if (ticker && typeof ticker != "undefined")
		{
	  Watchlist_click(ticker);
		}
});
	  
	  
	 	  
	  
	  
	});
function NewRow()
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

//var createClickHandler = 
 //   function(row) 
  //  {
   //     return function() { 
        //	document.getElementById("charts").innerHTML = "<iframe src=\"\Chart.jsp?name="+Ticker+"\"></iframe>";
   //     alert("this function");	
    //    GetData(Ticker,"3Day1Min","chart1");
       // 	GetData(Ticker,"1Yr1D","chart2");            
        
  //      };
   // }

//row.onclick = createClickHandler(row);



}


function GetData(Ticker,Timeframe,chart)
{
GlobalTicker=Ticker;

    	var dataString ={"Ticker":Ticker,"Timeframe":Timeframe};
    	
    	$('#'+chart).html("Loading...");
    	var high =0;
		var low=9999;
		
    	$.ajax({
    	    type: "POST",
    	    url: "MarketDataRequest.do",
    	    data: dataString,
    	    success: function(jsonData) {
    	    	
    	    	
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
		if (data[i][2] > high)
			high = data[i][2];
		if (data[i][3]< low)
			low = data[i][3];

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
	//alert(low);
//	alert(high);
	//alert(chart);
//	var chartdes = $('chart1').highcharts();
//	alert(yAxis.getExtremes());
//	   var yAxis = chartdes.get('my_y');
//	   yAxis.setExtremes(low,high);
	
    	    }
    	    
    	    
    	    
    	    
    	    
    	});
    	
   // 	var chart = $('#'+chart).highcharts();
	//    var yAxis = chart.get('my_y');
	//    yAxis.setExtremes(low,high);
	
    	
}




</script>

<style>

#watchlisttable{
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
	margin-left: 15px;
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
 padding-left: 0px;
  margin-left: 470px;
  margin-right: 20px;
height:100%

}
input.button-add {
    background-image: url(/images/buttons/add.png); /* 16px x 16px */
    background-color: transparent; /* make the button transparent */
    background-repeat: no-repeat;  /* make the background image appear only once */
    background-position: 0px 0px;  /* equivalent to 'top left' */
    border: none;           /* assuming we don't want any borders */
    cursor: pointer;        /* make the cursor like hovering over an <a> element */
    height: 16px;           /* make this the size of your image */
    padding-left: 16px;     /* make text start to the right of the image */
    vertical-align: middle; /* align the text vertically centered */
}
iframe {height:100%;width:100%}
table { table-layout: fixed }
tr:first-child td { white-space: nowrap }

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
<button onclick="NewRow()">New</button>
<button onclick="SaveWatchlist()">Save</button>
<!-- <input id="clickMe" type="button" value="save" onclick="Save_Watchlist();" /> -->
<table border="0" id="watchlisttable" class="watchlisttable" style="width:230px;">
<col width="80">
  <col width="150">
<th>Ticker</th><th>Notes</th>

 
    <%   out.println(com.benberg.scanner.main.GetWatchlist());%>
     
 	    

</table>
</div>


 <div id="charts">
 <table rules="all" id="table1" width="95%">
<tr>
<td >
<div id="chart1" ></div>
</td>
</tr>
<tr>
<td>
<div id="chart2" ></div>
</td>
</tr>
</table>
 
 </div>
 
</div>
</div>

</body>
</html>