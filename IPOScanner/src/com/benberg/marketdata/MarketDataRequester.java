package com.benberg.marketdata;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.benberg.struct.NewMarketDataRequest;
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
			factory.setPassword("Typhoon1"); 
		    
		    connection = factory.newConnection();
		    channel = connection.createChannel();
		    channel = connection.createChannel();
		    channel.queueDeclare(q_WebIn, false, false, false, null);
		    channel.queueDeclare(q_MarketDataIn, false, false, false, null);
		    
		     consumer = new QueueingConsumer(channel);
		    channel.basicConsume(q_WebIn, true, consumer);
		    
		 }
		 catch(Exception e)
		 {
			 System.out.println(e.toString());
		 }
		 
		 
		 
	 }
	 
	 public void SendMarketDataRequest(NewMarketDataRequest _message)
	 {
		 try{
		 channel.basicPublish("", q_MarketDataIn, null, _message.toBytes());
		    System.out.println(" [x] Sent to queue :"+q_MarketDataIn);
		 }
		 catch (Exception e)
		 {
			 System.out.println(e.toString());
		 }
	 }
		
	 public NewMarketDataRequest WaitForData(String Correlation_Id)
	 {
		 
		  try 
		  {
			  System.out.println(" [*] Waiting for messages on queue "+q_WebIn);
			QueueingConsumer.Delivery delivery = consumer.nextDelivery();
			return fromBytes( delivery.getBody());
			   
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
