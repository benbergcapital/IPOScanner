/**
 * 
 */
function xmlParser_PnL(xml)
	{
	var data = new google.visualization.DataTable();var data = new google.visualization.DataTable();
	data.addColumn('string', 'Realised PnL');
    data.addColumn('string', 'Unrealised PnL');
    data.addColumn('string', 'Position');

 var RPnL, UPnL, Position;
      
  
    $(xml).find("Data").each(function () {
    	RPnL = $(this).find("RPnL").text();
    	UPnL = $(this).find("UPnL").text();
    	Position = $(this).find("Position").text();
        data.addRow([RPnL, UPnL, Position]);
    });
      
    var table = new google.visualization.Table(document.getElementById('table_pnl'));
    table.draw(data, {showRowNumber: true});
  }

  function xmlParser_Orders(xml)
	{
	var data = new google.visualization.DataTable();var data = new google.visualization.DataTable();
	data.addColumn('string', 'CreateTime');
    data.addColumn('string', 'Quantity');
    data.addColumn('string', 'Price');
    data.addColumn('string', 'Order Type');
    data.addColumn('string', 'Status');
    data.addColumn('string', 'RSI');
 var CreateTime, Quantity, Price,OrderType,Status,RSI
      
  
    $(xml).find("Data").each(function () {
    	CreateTime = $(this).find("CreateTime").text();
    	Quantity = $(this).find("Quantity").text();
    	Price = $(this).find("Price").text();
    	OrderType = $(this).find("OrderType").text();
    	Status = $(this).find("Status").text();
    	RSI = $(this).find("RSI").text();
        data.addRow([CreateTime, Quantity, Price,OrderType,Status,RSI]);
    });
      
    var table = new google.visualization.Table(document.getElementById('table_orders'));
    table.draw(data, {showRowNumber: true});
  }


  function xmlParser_Rsi(xml)
	{
	var data = new google.visualization.DataTable();var data = new google.visualization.DataTable();
	data.addColumn('string', 'Time');
  data.addColumn('string', 'Current RSI');

var Time, CurrentRSI, Price,OrderType,Status,RSI
    

  $(xml).find("Data").each(function () {
	  Time = $(this).find("Time").text();
	  CurrentRSI = $(this).find("CurrentRSI").text();
  
      data.addRow([Time, CurrentRSI]);
  });
    
  var table = new google.visualization.Table(document.getElementById('table_rsi'));
  table.draw(data, {showRowNumber: true});
}
