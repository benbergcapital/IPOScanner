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
@WebServlet("/MarketDataRequest")
public class MarketData extends HttpServlet{
	
	  public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException, ServletException{

		  String Ticker = request.getParameter("Ticker");
		  PrintWriter out = response.getWriter();
		  
		 ListenForResponse L = new ListenForResponse();
		 String result= L.SendNewMarketDataRequest(Ticker);
				  
		  out.println(result);
	  
}
	
	
	
	
}
