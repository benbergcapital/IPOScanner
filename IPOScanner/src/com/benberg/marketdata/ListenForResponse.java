package com.benberg.marketdata;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;

import com.benberg.struct.NewMarketDataRequest;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.QueueingConsumer;
import java.util.UUID;

public class ListenForResponse extends Thread{

	
	public String SendNewMarketDataRequest(String Ticker)
	{
		 try {
		
		
		String CorrelationId= UUID.randomUUID().toString();
		
		 //Send Request		 
		
		  MarketDataRequester MDR = new MarketDataRequester();
		  MDR = MarketDataRequester.getInstance();
		  MDR.Connect();
		  Channel channel = MDR.channel;
		  String q_MarketDataIn =MDR.q_MarketDataIn;
		 String q_WebIn = MDR.q_WebIn;
			SendMarketDataRequest(Ticker,channel,q_MarketDataIn,CorrelationId);
		
			// TODO Auto-generated catch block
			
		
		  
		  
		   System.out.println(" [*] Waiting for messages on queue "+q_WebIn);
		    
		    QueueingConsumer consumer = new QueueingConsumer(channel);
		    channel.basicConsume(q_WebIn, true, consumer);
		    
			    while (true) {
			      QueueingConsumer.Delivery delivery = consumer.nextDelivery();
			     String message = new String(delivery.getBody());
			      
			      System.out.println(" [x] Received '" + message + "'");
			     
			      NewMarketDataRequest _message = fromBytes( delivery.getBody());
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
		   
		    } 
		   
		    catch (Exception e) {
		    	System.out.println(e.toString());
		    }
		return null;
		    
		
	}
	private void  SendMarketDataRequest(String Ticker,Channel channel,String q_MarketDataIn,String CorrelationId) throws IOException
	{
		//create object
		NewMarketDataRequest _message = new NewMarketDataRequest(Ticker,CorrelationId);
		channel.basicPublish("", q_MarketDataIn, null, _message.toBytes());
		    System.out.println(" [x] Sent to queue :"+q_MarketDataIn);
		
		
	}
	public  NewMarketDataRequest fromBytes(byte[] body) {
		NewMarketDataRequest obj = null;
	    try {
	        ByteArrayInputStream bis = new ByteArrayInputStream (body);
	        ObjectInputStream ois = new ObjectInputStream (bis);
	        obj = (NewMarketDataRequest)ois.readObject();
	        ois.close();
	        bis.close();
	    }
	    catch (IOException e) {
	        e.printStackTrace();
	    }
	    catch (ClassNotFoundException ex) {
	        ex.printStackTrace();
	    }
	    return obj;     
	}
	
	
	
}
