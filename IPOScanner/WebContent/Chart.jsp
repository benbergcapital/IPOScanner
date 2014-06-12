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

<script>
$(function() {
	$.getJSON('http://www.highcharts.com/samples/data/jsonp.php?a=e&filename=aapl-ohlc.json&callback=?', function(data) {
alert(data);
		// create the chart
		$('#container').highcharts('StockChart', {
			

			rangeSelector : {
				inputEnabled: $('#container').width() > 480,
				selected : 1
			},

			title : {
				text : 'AAPL Stock Price'
			},

			series : [{
				type : 'candlestick',
				name : 'AAPL Stock Price',
				data : data,
				dataGrouping : {
					units : [
						['week', // unit name
						[1] // allowed multiples
					], [
						'month', 
						[1, 2, 3, 4, 6]]
					]
				}
			}]
		});
	});
});

</script>
</head>
<body>

<p>Click me away!</p>
<div id="container" style="height: 400px; min-width: 310px"></div>
</body>
</html>