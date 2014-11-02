package com.benberg.scanner;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.benberg.marketdata.ListenForResponse;
import com.benberg.marketdata.MarketDataRequester;
import com.benberg.struct.RequestType;

@WebServlet("/MarketDataRequest")
public class MarketData extends HttpServlet{
	
	  public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException, ServletException{

		  String Ticker = request.getParameter("Ticker");
		  String Req = request.getParameter("RequestType");
		  
		
		  RequestType requestType = Req==null ? null: RequestType.valueOf(Req);
		  
		  PrintWriter out = response.getWriter();
    	  ListenForResponse L = new ListenForResponse();
    	  String result;
    	  String TimeFrame;
    	  boolean RealTime=false;
    	  long LastTime;
    	  
		  switch (requestType) {
		     case AUTOTRADER: 
		    	 	result= L.SendNewMarketDataRequest(Ticker,null,false,0, requestType);
	    	 		out.println(result);
		    	 	break;
		     case REALTIMEREQUEST: 
		    	 	TimeFrame = request.getParameter("Timeframe");
		    	 	RealTime = true;;
		    	 	LastTime =Long.parseLong(request.getParameter("LastTime"));
		    	 	result= L.SendNewMarketDataRequest(Ticker,TimeFrame,RealTime,LastTime, requestType);
		    	 	out.println(result);
		    	 break;
		     case CHART_DAY: 
		    	 //	LastTime =Long.parseLong(request.getParameter("LastTime"));
		    	 	result= L.SendNewMarketDataRequest(Ticker,requestType);
		    	 	out.println(result);
		    	 break;
		     case QUOTE: 
		    	 //	LastTime =Long.parseLong(request.getParameter("LastTime"));
		    	 	result= L.SendNewMarketDataRequest(Ticker,requestType);
		    	 	out.println(result);
		    	 break;	 
		    	
	    	 default:
	    	   	 	result= L.SendNewMarketDataRequest(Ticker,requestType);
		    	 	out.println(result);
		    	 break;
		    	 
		    //	 String TimeFrame = request.getParameter("Timeframe");
			//	  String RealTime = request.getParameter("RealTime");
		    	

		  }
		
		  
	/*	  String TimeFrame = request.getParameter("Timeframe");
		  String RealTime = request.getParameter("RealTime");
		  long _LastTime = 0;
		  boolean _RealTime;
		if(RealTime.equals("True"))
		{
				 _RealTime = true;
		  _LastTime =Long.parseLong(request.getParameter("LastTime"));
		}
		  else
			  	_RealTime = false;
		  PrintWriter out = response.getWriter();
		  
		 ListenForResponse L = new ListenForResponse();
		 String result= L.SendNewMarketDataRequest(Ticker,TimeFrame,_RealTime,_LastTime);
				  
		
		 
		
		 
		 
		  out.println(result);
	  */
}
	
	
	
	
}
