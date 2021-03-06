<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script language="javascript" type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script src="http://code.highcharts.com/stock/highstock.js"></script>
<script src="http://code.highcharts.com/stock/modules/exporting.js"></script>
<script src="/json2.js"></script>

<script>

$(function() {
	// var Stock = "<%= request.getParameter("name") %>";
	var Stock ="GPRO";
	GetData(Stock,"3Day1Min","chart1");
	GetData(Stock,"1Yr1D","chart2");
	
});

//window.setInterval(function(){
//	GetData(GlobalTicker,"3Day1Min","chart1");
//	}, 10000);
	var GlobalTicker ="TWTR";
	var LastTime="";
function GetData(Ticker,Timeframe,chart)
	{
	GlobalTicker=Ticker;
	//var test = "[1182124800000,17.61,17.88,17.51,17.87,227971779],[1182211200000,17.81,17.86,17.56,17.67,236173490],[1182297600000,17.70,17.81,17.36,17.36,224570395]";
	
	    	var dataString ={"Ticker":Ticker,"Timeframe":Timeframe,"RealTime":"false", "RequestType":"DAY"};
	        var max = 0;
	    	$('#'+chart).html("Loading...");
	    	
	    	$.ajax({
	    	    type: "POST",
	    	    url: "MarketDataRequest.do",
	    	    data: dataString,
	    	    success: function(jsonData) {
	    	    	
	    	    	
	    	    	var data = JSON.parse("["+jsonData+"]");
	    	    //	alert(data);   	
	    	    	
	
	//	var data = [[1182124800000,17.61,17.88,17.51,17.87,227971779],
	//	[1182211200000,17.81,17.86,17.56,17.67,236173490],
	//	[1182297600000,17.70,17.81,17.36,17.36,224570395],
	//	[1182384000000,17.39,17.76,17.25,17.70,216921131]];
		
		
		
		
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
		LastTime = data[dataLength-1][0];
		alert(LastTime);
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
			chart : {
				events : {
					 load: function() {

	                        // set up the updating of the chart each second
	                        var series = this.series[0];
	                        setInterval(function() {
	                            
	                          
	                         
	                      //      series.addPoint([
	                      //      x,
	                      //      Math.random()*100,
	                      ////      Math.random()*100,
	                      //      Math.random()*100,
	                      ///      Math.random()*100
	                      //      ], true, true);
	                      dataString ={"Ticker":Ticker,"Timeframe":Timeframe,"RealTime":"True","LastTime":LastTime};
	                        	$.ajax({
			    	   					 type: "POST",
							    	    url: "MarketDataRequest.do",
							    	    data: dataString,
							    	    success: function(RealTimeDelta) {
	    	    	
							    	    	for (i = 0; i < RealTimeDelta.length; i++) {
							    	    		
							    	    		series.addPoint([
													data[i][0], // the date
													data[i][1], // open
													data[i][2], // high
													data[i][3], // low
													data[i][4] // close          
							    	    		       ],true,true);          
							    	    		
	    	   										 }
							    	    	LastTime = RealTimeDelta[RealTimeDelta.length-1][0];
	                        	}
	                        
	                        	});
	                        
	                        
	                        }, 10000);
	                    }
					
				}
			},
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
		    	},
		        series:{
	                dataLabels: {
	                    enabled: true,
	                    formatter: function() {
	                        if(this.x > max){
	                            max = this.x;
	                        }
	                        return null;
	                    }
	                } 
	            }
		    },
		    yAxis: [{
		        labels: {
		    		align: 'right',
		    		x: -3
		    	},
		        title: {
		            text: '$'
		        },
		        height: '100%',
		        lineWidth: 2
		    }],
		    global: [{
		        useUTC: true
		    }],
		    series: [{
		        type: 'candlestick',
		        name: Ticker,
		        data: ohlc,
		     
		 
		    }]
		});
		
	    	    }
	    	    
	    	});
	    	  $('#report').html(max)
	}
		
function choose(TimeFrame){
   
    	GetData(GlobalTicker,TimeFrame);
   
}	


</script>
<style type="text/css">
body{
margin: 0px;
width:100%;
}

</style>
</head>
<body>
<div  style="width:100%;" >
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
<div id="report"></div>
</body>
</html>