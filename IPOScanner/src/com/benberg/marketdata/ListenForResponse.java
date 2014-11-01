package com.benberg.marketdata;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;

import com.benberg.struct.NewMarketDataRequest;
import com.benberg.struct.RequestType;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.QueueingConsumer;
import java.util.UUID;

public class ListenForResponse extends Thread{

	
	public String SendNewMarketDataRequest(String Ticker,String TimeFrame,boolean RealTime,long LastTime,RequestType req)
	{
		 try {
				
		  String CorrelationId= UUID.randomUUID().toString();
					
		  MarketDataRequester MDR = new MarketDataRequester();
		  MDR = MarketDataRequester.getInstance();
		  NewMarketDataRequest _recv =   new NewMarketDataRequest(RealTime,Ticker, CorrelationId,TimeFrame,req);
		  NewMarketDataRequest _message = MDR.SendMarketDataRequest(_recv);
	  
		 
    	  System.out.println("Ticker : "+_message.GetTicker());
    	  System.out.println("Data : "+_message.GetMarketDataJson());
		 
    	
    		  return _message.GetMarketDataJson();
    
    		 
		
		   
		    } 
		   
		    catch (Exception e) {
		    	System.out.println(e.toString());
		    	
		    	 return "NoData";	
		    }
		
	}


	public String SendNewMarketDataRequest(String Ticker,RequestType req)
	{
		 try {
				
		  String CorrelationId= UUID.randomUUID().toString();
					
		  MarketDataRequester MDR = new MarketDataRequester();
		  MDR = MarketDataRequester.getInstance();
		  NewMarketDataRequest _send =   new NewMarketDataRequest(Ticker,CorrelationId,req);
		  NewMarketDataRequest _recv = MDR.SendMarketDataRequest(_send);
	  
		 
    	  System.out.println("Ticker : "+_recv.GetTicker());
    	  System.out.println("Data : "+_recv.GetMarketDataJson());
		 
    	
    		  return _recv.GetMarketDataJson();
    
    		 
		
		   
		    } 
		   
		    catch (Exception e) {
		    	System.out.println(e.toString());
		    	
		    	 return "NoData";	
		    }
		
	}
	
	
	
	public String SendNewAutoTraderMarketDataRequest(String ticker) {
		// TODO Auto-generated method stub
		return null;
	}

	public String SendNewAutoTraderWebRequest(String ticker, RequestType enumval) {
		// TODO Auto-generated method stub
		  String CorrelationId= UUID.randomUUID().toString();
			
		  MarketDataRequester MDR = new MarketDataRequester();
		  MDR = MarketDataRequester.getInstance();

		  NewMarketDataRequest _message = MDR.SendMarketDataRequest(new NewMarketDataRequest(ticker,enumval));
		
		  System.out.println("Ticker : "+_message.GetTicker());
    	  System.out.println("Data : "+_message.GetMarketDataJson());
		
    	  //to xml
    	  
    	  
		
		return null;
	}

	
	
}
