package com.benberg.marketdata;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;

import com.benberg.struct.NewMarketDataRequest;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.QueueingConsumer;
import java.util.UUID;

public class ListenForResponse extends Thread{

	
	public String SendNewMarketDataRequest(String Ticker,String TimeFrame)
	{
		 try {
				
		  String CorrelationId= UUID.randomUUID().toString();
					
		  MarketDataRequester MDR = new MarketDataRequester();
		  MDR = MarketDataRequester.getInstance();
	
		  NewMarketDataRequest _message = MDR.SendMarketDataRequest(new NewMarketDataRequest(Ticker, CorrelationId,TimeFrame));
	  
		 
    	  System.out.println("Ticker : "+_message.GetTicker());
    	  System.out.println("Data : "+_message.GetMarketDataJson());
		 
    	
    		  return _message.GetMarketDataJson();
    
    		 
		
		   
		    } 
		   
		    catch (Exception e) {
		    	System.out.println(e.toString());
		    	
		    	 return "NoData";	
		    }
		
		    
		
	}

	

	
	
}
