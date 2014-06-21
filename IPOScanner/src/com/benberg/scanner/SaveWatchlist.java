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

import com.benberg.marketdata.ListenForResponse;

@WebServlet("/SaveWatchlist")
public class SaveWatchlist extends HttpServlet{
	
	
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException, ServletException{
		PrintWriter out = response.getWriter();
		try{
		
			String foo = request.getParameter("Data");
			String[] bar = foo.split(";");
			System.out.println(foo);
			 Cache c = new Cache();
			c=Cache.getInstance();
				
			
			for(String value : bar)
			{
				try{
		JSONObject jObj = new JSONObject(value); 
		Iterator it = jObj.keys(); //gets all the keys

	//	while(it.hasNext())
	//	{
		  //  String Ticker = (String) it.next(); // get key
		    String Ticker = (String) jObj.get("Ticker"); // get value
		    String Value= (String) jObj.get("Value");
		    
		    System.out.println(Ticker + " : " +  Value.replace("'","''")); // print the key and value
		    
		   
			c.SaveWatchlist(Ticker, Value.replace("'","''"));
				}
				catch(Exception e)
				{
					
				}
			
		    
		}
		

		
			 out.println("Saved");
		}
		catch(Exception e)
		{
			e.printStackTrace();
			 out.println("Error occured during Save");
		}
		
		 
	  
}
	
	
	
	
}



