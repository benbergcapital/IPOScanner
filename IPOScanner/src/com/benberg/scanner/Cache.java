package com.benberg.scanner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.benberg.struct.NasdaqIpoTickers;
import com.benberg.struct.WatchlistStruct;

public class Cache {
	
	 private static Cache instance = null;
	 private Map<Integer,List<String>> _ListOfAllTickers;
	 private List<NasdaqIpoTickers> _ListOfUpcomingTickers;
	 private String Test="";
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
	   
}
