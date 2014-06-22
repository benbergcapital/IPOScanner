package com.benberg.scanner;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;


@WebServlet("/AddToWatchlist")
public class AddTickerToWatchlist extends HttpServlet{
	
	
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException, ServletException
	{
		PrintWriter out = response.getWriter();
		
	
		try{
			String Ticker = request.getParameter("Ticker");
			String Month = request.getParameter("Month");
			 Cache c = new Cache();
			c=Cache.getInstance();	
			c.SaveWatchlist(Ticker, Month+"-Ipo"); //escape single quotation
			 out.println("Added "+Ticker);
			}
		catch(Exception e)
			{
			e.printStackTrace();
			 out.println("Error occured during Save");
			}
		}
		
		 
	  
}
	
	
	
	




