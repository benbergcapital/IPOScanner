package com.benberg.scanner;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class PreCache extends HttpServlet{
	
	
	/*
	@Override
	  public void contextDestroyed(ServletContextEvent arg0) {
	    //Notification that the servlet context is about to be shut down.   
	  }

	  @Override
	  public void contextInitialized(ServletContextEvent arg0) {
	  }
	  */
	  
	public void init() throws ServletException
    {
	//  Watchlist w = new Watchlist();
	  
	//  w.GetWatchlist();
	  
		  System.out.println("Running startup cache");
		  NasdaqIPOWorker N = new NasdaqIPOWorker();
		  
		 Calendar cal = Calendar.getInstance();
	
		 
		 int month = cal.get(Calendar.MONTH);
		 List<String> _Tickers = new ArrayList<String>();
		 Map<Integer,List<String>> _ListOfAllTickers = new HashMap<Integer,List<String>>();
		 for (int i=0;i<=month;i++)
		 {
			_Tickers =  N.getListOfTickers(i);
			
			_ListOfAllTickers.put(i,_Tickers);
					
			 
		 }
		 	 
		 Cache c = new Cache();
		 c=Cache.getInstance();
		 c.setTickerList(_ListOfAllTickers);	
		
		
	  }
	  
	  
	  
	  
}
