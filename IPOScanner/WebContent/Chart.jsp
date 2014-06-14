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
	
	var dataString ={"Ticker":"TWTR"};
	$.ajax({
	    type: "POST",
	    url: "MarketDataRequest.do",
	    data: dataString,
	    success: function(jsonData) {
	    	alert(jsonData);
	
	
//	var da = "[1402657800000, 30.14],[1402658400000, 34.76],[1402659000000, 34.34],[1402659600000, 33.9]";
  
    //alert(dad);
    alert(jsonData);
	window.chart = new Highcharts.StockChart({
        chart : {
            renderTo : 'container'
        },
        title : {
            text : 'My chart'
        },
        series : [{
            name : 'My Series',
            data : JSON.parse("[" + jsonData + "]")
        }]
    });
	    }});
});

</script>
</head>
<body>

<div id="container" style="height: 500px; min-width: 500px"></div>
</body>
</html>