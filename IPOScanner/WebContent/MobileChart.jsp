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

<script>
var chart;
var GlobalTicker;
window.onload = onLoad;
function onLoad()
{
document.getElementById('id_duration').style.visibility="hidden";
}


function GetQuote(Ticker,RequestType)
{
GlobalTicker=Ticker;

//var test = "[1182124800000,17.61,17.88,17.51,17.87,227971779],[1182211200000,17.81,17.86,17.56,17.67,236173490],[1182297600000,17.70,17.81,17.36,17.36,224570395]";

    	var dataString ={"Ticker":Ticker,"RequestType":RequestType};
        var max = 0;
    	
    	$.ajax({
    	    type: "POST",
    	    url: "MarketDataRequest.do",
    	    data: dataString,
    	    success: function(quote) {
    	    //	alert(quote);
    	    	$('#quote').html(quote); 
    	    	
    	    if(quote.indexOf("Error")>-1)
    	    	return;
    	    else if(quote.indexOf("-")>-1)//Stock is down
    	    	$('#quote').css('color', 'red');
    	    else
    	    	$('#quote').css('color', 'green');
    	    	
    	    document.getElementById('id_duration').style.visibility="visible";	
    	    }});
}
    	    	
function GetData(Ticker,RequestType)
{
GlobalTicker=Ticker;

//var test = "[1182124800000,17.61,17.88,17.51,17.87,227971779],[1182211200000,17.81,17.86,17.56,17.67,236173490],[1182297600000,17.70,17.81,17.36,17.36,224570395]";

    	var dataString ={"Ticker":Ticker,"RequestType":RequestType};
        var max = 0;
    	$('#chart').html("Loading...");
    	
    	
    	
    	$.ajax({
    	    type: "POST",
    	    url: "MarketDataRequest.do",
    	    data: dataString,
    	    success: function(jsonData) {
    	    
    	 if(jsonData.indexOf("Error")>-1)
    	 {
    		$('#chart').html("");
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
    	//	alert(dataLength);
    		// set the allowed units for data grouping
    		  		
    		
    		//$('#chart').highcharts('StockChart', {
			 chart = new Highcharts.Chart({
				 chart: {
			            renderTo: 'chart',
			            type: 'StockChart'
			        },
			        title:{
			            text:''
			        },
    			rangeSelector: {
    	            enabled: false
    	        },
    	        legend: {
    	            enabled: false
    	        },               
                xAxis: {
                    type: 'datetime',
                    ordinal: true

                },
                navigator : {
                    enabled : false
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
function NewChartRequest()
{
	ResetPage();
	var ticker = document.getElementById('id_ticker').value;
	ReloadChart(ticker);

}
function ReloadChart(ticker)
{
	  ResetPage();
	  GetData(ticker,"CHART_DAY");  
	  GetQuote(ticker,"QUOTE");
 }
function ResetPage()
{
	  $('#quote').html(""); 	
	  $('#chart').html(""); 	
	  document.getElementById('id_duration').style.visibility="hidden";		
	
}
function ChangeDuration()
{

	GetData(GlobalTicker,"CHART_2_DAY");  
	
	
}

$(document).ready(function(){
    $('#id_ticker').keypress(function(e){
      if(e.keyCode==13)
      $('#id_ticker_go').click();
    });
});	
</script>
<style>
#section {
   padding:5px;
   width:832px;
}
#left{
	width:120px;
	vertical-align: text-top;
}
#right{
	vertical-align: text-top;
}
#chart{
	width: 712px;
}
#quote{
	padding-left: 15px;
	text-align:left;
}
#Duration{
	text-align:right;

}
#quotetable{
	width:712px;
}
</style>


</head>
<body>
<div id="section">
<table>
<tr>

<td id="left">
<table>
<tr>
<td>
<input type="text" id="id_ticker" name="ticker">
</td>
<td>
<button id="id_ticker_go" onclick="NewChartRequest()">Go</button>
</td>
</tr>
</table>

<button onclick="ReloadChart('GPRO')">GPRO</button><br>
<button onclick="ReloadChart('AAPL')">AAPL</button><br>
<button onclick="ReloadChart('FSLR')">FSLR</button><br>
<button onclick="myFunction()">EBAY</button>
</td>

<td id="right">
<table id="quotetable">
<tr>
<td>
<div id="quote"></div>
</td>
<td>
<div id="Duration"><button id="id_duration" onclick="ChangeDuration()">Duration</button></div>
</td>
</tr>
</table>

<div id="chart"></div>


</td>
</tr>
</table>
</div>

</body>
</html>