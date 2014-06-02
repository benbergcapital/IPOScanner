package com.benberg.scanner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cache {
	
	 private static Cache instance = null;
	 private Map<Integer,List<String>> _ListOfAllTickers;
	 private String Test="";
	 
	   protected Cache() {
		   _ListOfAllTickers = new HashMap<Integer,List<String>>();
	   }
	   public static Cache getInstance() {
	      if(instance == null) {
	         instance = new Cache();
	      }
	      return instance;
	   }
	
	   public void setTickerList(Map<Integer,List<String>> Tickers)
	   {
		   instance._ListOfAllTickers = Tickers;
	   }
	   public List<String> getTickerList(int month)
	   {
		  
		   return instance._ListOfAllTickers.get(month);
	   }
	   
	   
	   public void SetTest(String value)
	   {
		   instance.Test = value;
		   
	   }
	   public String getTest()
	   {
		   return instance.Test;
	   }
	   
	   
}
