package com.benberg.scanner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.benberg.struct.NasdaqIpoTickers;
import com.benberg.struct.NewMarketDataRequest;

public class MarketDataRequestCache {
	 private static MarketDataRequestCache instance = null;
	Map<String,NewMarketDataRequest> _ResponseMap = new HashMap<String, NewMarketDataRequest>();
	
	public MarketDataRequestCache()
	{
		
	}
	
	public static MarketDataRequestCache getInstance() 
	{
		      if(instance == null) {
		         instance = new MarketDataRequestCache();
		      }
		      return instance;
	 }
		
	public void AddNewResponse(String CorrId, NewMarketDataRequest Response)
	{
		_ResponseMap.put(CorrId,Response);
	}
	
	public NewMarketDataRequest GetResponse(String CorrId)
	{
		NewMarketDataRequest response = _ResponseMap.get(CorrId);
		return response;
	}

	public boolean HasResponded(String corrId) {

		if (_ResponseMap.containsKey(corrId))
			return true;		
		return false;
	}
	
	
	
		
	}

