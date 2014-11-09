package com.benberg.marketdata;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.benberg.scanner.Cache;
import com.benberg.scanner.MarketDataRequestCache;
import com.benberg.struct.NewMarketDataRequest;
import com.benberg.struct.RequestType;
import com.rabbitmq.client.AMQP.BasicProperties;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.ConsumerCancelledException;
import com.rabbitmq.client.QueueingConsumer;
import com.rabbitmq.client.ShutdownSignalException;

public class MarketDataRequester {

	 private static MarketDataRequester instance = null;
	 String q_MarketDataIn= "q_mdm_in";
	 String q_WebIn = "q_web_in";
	 ConnectionFactory factory;
	 Connection connection;
	 Channel channel;
	 QueueingConsumer consumer;
	 private String replyQueueName;
	 private String requestQueueName = "rpc_queue";
	 private Runnable r_ListenThread;
	 private Thread thread;
	 private MarketDataRequestCache MDRC;
	 public static MarketDataRequester getInstance() {
	      if(instance == null) {
	         instance = new MarketDataRequester();
	      }
	      return instance;
	   }
	
	 public void Connect()
	 {
		 try{
		 factory = new ConnectionFactory();
		    factory.setHost("localhost");
		    factory.setUsername("Admin"); 
			factory.setPassword("Admin"); 
		    
		    connection = factory.newConnection();
		    channel = connection.createChannel();
		    replyQueueName = channel.queueDeclare().getQueue(); 
		//    channel = connection.createChannel();
		//    channel.queueDeclare(q_WebIn, false, false, false, null);
		 //   channel.queueDeclare(q_MarketDataIn, false, false, false, null);
		    
		     consumer = new QueueingConsumer(channel);
		  //  channel.basicConsume(q_WebIn, true, consumer);
		     channel.basicConsume(replyQueueName, true, consumer);
		     
		     //Create Listen Thread description
		     
		     r_ListenThread = new Runnable() {
		         public void run() {
		            ListenForResponsesThread();
		         }
		     };
		     
		     MDRC = new MarketDataRequestCache();
		     MDRC.getInstance();
		     
		     
		 }
		 catch(Exception e)
		 {
			 System.out.println(e.toString());
		 }
		 
		 
		 
	 }
	private void ListenForResponse()
	 {
		if (thread ==null)
		{
				thread = new Thread(r_ListenThread);
				thread.start();
		}
		if (!thread.isAlive())
		{
			thread = new Thread(r_ListenThread);
			thread.start();
		}
		
		else
			System.out.println("Thread already running");
		
		
		
	 }
	 protected void ListenForResponsesThread() 
	 {
		try{ 
			while(true)
			{
				System.out.println("Listening for messages");
				 QueueingConsumer.Delivery delivery = consumer.nextDelivery(100000);
				 System.out.println(delivery);
				 if (delivery == null)
					 break;
				 String CorrId = delivery.getProperties().getCorrelationId();
				 if (CorrId!= null) 
				   	{
					 
					 System.out.println("Message received for :  "+CorrId);
					 MDRC.AddNewResponse(CorrId, fromBytes( delivery.getBody()));
					 
				   	}
				 else
				 {
					 System.out.println("error for CorrId :  "+delivery.getProperties().getCorrelationId()); 
				 }
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		System.out.println("Listen thread timed out");
			  
	}

	public String SendMarketDataRequest(NewMarketDataRequest _message)
	 {
		 try{

			 String CorrId = _message.GetCorrelationId();

			
			 
			 
			    BasicProperties props = new BasicProperties
			                                .Builder()
			                                .correlationId(CorrId)
			                                .replyTo(replyQueueName)
			                                .build();
			    channel.basicPublish("", requestQueueName, props, _message.toBytes());
			    System.out.println("Sent new request for "+_message.GetTicker()+" : "+_message.GetCorrelationId());
			    ListenForResponse();
			    
			int timeout =0;
			while(!MDRC.HasResponded(CorrId) && timeout < 50)
			{
				Thread.sleep(100);
				timeout++;
			}
			if (timeout==50)
				return " Error : No response from trading was received within the timeout period.";
			
			NewMarketDataRequest recv = MDRC.GetResponse(CorrId);
			System.out.println("Ticker : "+recv.GetTicker());
	    	System.out.println("Data : "+recv.GetMessage());
	    	    	
			//add ticker to map
	    	Cache.getInstance().addTickerToMobileFrequentList(recv.GetTicker());
			return recv.GetMessage();
						        
			   
		 }
		 catch (Exception e)
		 {
			 e.printStackTrace();
			 return null;
		 }
		
		
	 }

private void SendRequest(String CorrId)
{
	
	
}
	

		
	 public NewMarketDataRequest WaitForData(String Correlation_Id)
	 {
		 
		  try 
		  {
			  System.out.println(" [*] Waiting for messages on queue "+q_WebIn);
			QueueingConsumer.Delivery delivery = consumer.nextDelivery(10000);
			
			
			   
		  } 
		 catch (Exception e) 
		 {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return null;
		 
		 
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
