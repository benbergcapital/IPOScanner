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

<script>
var chart;
var GlobalTicker;
window.onload = onLoad;
function onLoad()
{
//	document.getElementById('id_duration_daily').style.visibility="hidden";		
//	document.getElementById('id_duration_2day').style.visibility="hidden";		
	document.getElementById('buttons').style.visibility="hidden";	
	setInterval(function(){GetQuote (GlobalTicker,"QUOTE",true)}, 3000);
}


function GetQuote(Ticker,RequestType,Refresh)
{
	if (Ticker==null)
		return;
	
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
    	    
    	  
    	   
    	    //if refreshing the quote, we dont want to remove the last quote if there was no data returned this time..
    	    //Instead make the quote grey.
    	    
    	    	
    	    
    	    	
    	   if(quote.indexOf("Error")>-1)
    	   	{
    	    	  if (Refresh==true)
    	    		  $('#quote').css('color', 'grey');	
    	    	return;
    	   	}
    	    
    	   $('#quote').html(quote); 
    	   if(quote.indexOf("-")>-1)//Stock is down
    	    	$('#quote').css('color', 'red');
    	   else
    	    	$('#quote').css('color', 'green');
    	    
    	    
    	    
    	   document.getElementById('buttons').style.visibility="visible";			
    	    }});
}

function GetData(Ticker,RequestType)
{
GlobalTicker=Ticker;



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
	  GetData(ticker,"CHART_1_MIN");  
	  GetQuote(ticker,"QUOTE",false);
 }
function ResetPage()
{
	  $('#quote').html(""); 	
	  $('#chart').html(""); 	
	  document.getElementById('buttons').style.visibility="hidden";			
}
function ChangeDuration(duration)
{
	GetData(GlobalTicker,duration);  

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
#duration{
	text-align:right;
	float: right;
}
#quotetable{
	width:712px;
}
#button{
	width: 100px;

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
 <%  
 
 			  List<String> tickers = Cache.getInstance().getListOfFrequentTickers();
              for (int i = 0; i < tickers.size(); i++) {  
                 			
                
              out.println( "<button id=\"button\" onclick=\"ReloadChart('"+tickers.get(i)+ "')\">"+tickers.get(i)+"</button><br>" );  
                              
   
              } 
  %>  
</td>

<td id="right">
<table id="quotetable">
<tr>
<td>
<div id="quote"></div>
</td>
<td>
<div id="buttons">
<div id="duration"><button id="id_duration_daily" onclick="ChangeDuration('CHART_DAILY')">Daily</button></div>
<div id="duration"><button id="id_duration_2day" onclick="ChangeDuration('CHART_2_DAY_AO')">5 Min</button></div>
<div id="duration"><button id="id_duration_2day" onclick="ChangeDuration('CHART_1_MIN')">1 Min</button></div>
</div>
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