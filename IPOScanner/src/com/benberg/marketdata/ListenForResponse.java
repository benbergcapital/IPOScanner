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
		
		 //Send Request		 
		
		  MarketDataRequester MDR = new MarketDataRequester();
		  MDR = MarketDataRequester.getInstance();
	
		    MDR.SendMarketDataRequest(new NewMarketDataRequest(Ticker, CorrelationId,TimeFrame));
	

		   NewMarketDataRequest _message =MDR.WaitForData(null);
		   
		   
			 //     System.out.println(" [x] Received '" + _message. + "'");
			     
			//      NewMarketDataRequest _message = fromBytes( delivery.getBody());
			    //  if (_message.GetCorrelationId().equals(CorrelationId))
			    //  {
			    	  //Correct response, Lets process
			    	  System.out.println("Correlaation id match : "+CorrelationId);
			    	  System.out.println("Ticker : "+_message.GetTicker());
			    	  System.out.println("Data : "+_message.GetMarketDataJson());
			    	  return _message.GetMarketDataJson();
			    	  
			     // }
			      //TODO Leave message on queue for another process.
			    	      
		   
		    } 
		   
		    catch (Exception e) {
		    	System.out.println(e.toString());
		    }
		return null;
		    
		
	}
	/*
	private void  SendMarketDataRequest(String Ticker,Channel channel,String q_MarketDataIn,String CorrelationId) throws IOException
	{
		//create object
		NewMarketDataRequest _message = new NewMarketDataRequest(Ticker,CorrelationId);
		channel.basicPublish("", q_MarketDataIn, null, _message.toBytes());
		    System.out.println(" [x] Sent to queue :"+q_MarketDataIn);
		
		
	}
	
	*/
	
	
}
