package com.benberg.marketdata;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.QueueingConsumer;

public class MarketDataRequester {

	 private static MarketDataRequester instance = null;
	 String q_MarketDataIn= "q_mdm_in";
	 String q_WebIn = "q_web_in";
	 ConnectionFactory factory;
	 Connection connection;
	 Channel channel;
	 
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
		    connection = factory.newConnection();
		    channel = connection.createChannel();

		    channel.queueDeclare(q_WebIn, false, false, false, null);
		    channel.queueDeclare(q_MarketDataIn, false, false, false, null);
		 }
		 catch(Exception e)
		 {
			 System.out.println(e.toString());
		 }
		 
		 
		 
	 }
	 
	
		
	
	
}
