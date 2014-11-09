package com.benberg.scanner;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.benberg.struct.NasdaqIpoTickers;
import com.benberg.struct.WatchlistStruct;

public class Cache {
	
	 private static Cache instance = null;
	 private Map<Integer,List<String>> _ListOfAllTickers;
	 private List<NasdaqIpoTickers> _ListOfUpcomingTickers;
	 private List<String> _ListOfFrequentTickers = new ArrayList();
	 
	 private Watchlist _watchlist;
	   protected Cache() {
		   _ListOfAllTickers = new HashMap<Integer,List<String>>();
	   }
	   public static Cache getInstance() {
	      if(instance == null) {
	         instance = new Cache();
	      }
	      return instance;
	   }
	
	   //**For Mobile Chart frequent ticker list
	   public void addTickerToMobileFrequentList(String Ticker)
	   {
		   if (_ListOfFrequentTickers.contains(Ticker.toUpperCase()))
		   		return;
		   
			   //Increment array values;
			   for (int i=0;i<Math.min(_ListOfFrequentTickers.size(),10)-1;i++)
			   {
				   	_ListOfFrequentTickers.add(i+1, _ListOfFrequentTickers.get(i));
	   			}
			   _ListOfFrequentTickers.add(0, Ticker.toUpperCase()); 
			
				   
	   }
	   public List<String> getListOfFrequentTickers()
	   {
		return _ListOfFrequentTickers;
				
		   
	   }
	   
	   
	   
	   //**
	   
	   
	   public void setTickerList(Map<Integer,List<String>> Tickers)
	   {
		   instance._ListOfAllTickers = Tickers;
	   }
	   public List<String> getTickerList(int month)
	   {
		  
		   return instance._ListOfAllTickers.get(month);
	   }
	   
	   
	  
	   public void SetUpcomingTickers(List<NasdaqIpoTickers> Tickers)
	   {
	   this._ListOfUpcomingTickers = Tickers;
	   }
	   
	   public List<NasdaqIpoTickers> getUpcomingTickers()
	   {
		return this._ListOfUpcomingTickers;   
	   }
	   public void ConnectToDatabase()
	   {
		   _watchlist = new Watchlist();
	   }
	   public List<WatchlistStruct> getWatchlist()
	   {
		  return _watchlist.GetWatchlist();
	   }
	   
	   public boolean DeleteWatchlist()
	   {
		String delete = "Delete from watchlist";  
		return _watchlist.insert(delete);
		 
	   }
	   
	public void SaveWatchlist(String ticker, String value) {
		
		
		String insert = "insert into watchlist values ('"+ticker+"','"+value+"')";
		
	
		_watchlist.insert(insert);
		
		// TODO Auto-generated method stub
		
	}
	   
}
