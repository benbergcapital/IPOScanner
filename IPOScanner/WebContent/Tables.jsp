<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script language="javascript" type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script language="javascript" type="text/javascript" src="js/XmlParser.js"></script>
<script type='text/javascript' src='https://www.google.com/jsapi'></script>
<script type='text/javascript'>
google.load('visualization', '1', {packages:['table']});
google.setOnLoadCallback(drawTable_PnL);
function drawTable_PnL() {
	 var dataString ={"Data":"PnL"};
	  $.ajax({
	        type: "GET",
	        url: "samplexml.xml",
	        data: dataString,
	        dataType: "xml",
	        success: xmlParser_PnL
	    });
	  
}
function drawTable_Orders() {
	var dataString ={"Data":"Orders"};
	  $.ajax({
	        type: "GET",
	        url: "samplexml.xml",
	        data: dataString,
	        dataType: "xml",
	        success: xmlParser_Orders
	    });
	  
}
function drawTable_Rsi() {
	var dataString ={"Data":"Rsi"};
	  $.ajax({
	        type: "GET",
	        url: "samplexml.xml",
	        data: dataString,
	        dataType: "xml",
	        success: xmlParser_Rsi
	    });
	  
}
</script>
<title>Insert title here</title>
</head>
<body>

<h3>TWTR</h3>
PnL table
Realised PnL,Unrealised PnL,Position,
 <div id='table_pnl' style="width:300px;"></div>
Orders
//Time,Quantity, Price, order type , Status,RSI at Time
 <div id='table_orders' style="width:300px;"></div>
Rsi Data
RSI,Previous RSI, RSI Range
 <div id='table_rsi' style="width:300px;"></div>





</body>
</html>