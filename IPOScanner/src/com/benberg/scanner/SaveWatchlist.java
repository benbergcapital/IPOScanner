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

	public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException, ServletException
	{
		PrintWriter out = response.getWriter();
		
	
		try{
		
			String _RequestString = request.getParameter("Data");
			String[] _RequestArray = _RequestString.split(";");
			System.out.println(_RequestString);
			 Cache c = new Cache();
			c=Cache.getInstance();	
			
			//check that delete worked. If this didnt we want to stop here
			if(!c.DeleteWatchlist())
			{
				 out.println("Error occured during Save");
				 return;
			}
			//loop over all 
			for(String value : _RequestArray)
			{
				try{
					
						JSONObject jObj = new JSONObject(value); 
						Iterator it = jObj.keys(); //gets all the keys


					    String Ticker = (String) jObj.get("Ticker");
					    String Value= (String) jObj.get("Value");
		    
					    System.out.println(Ticker + " : " +  Value.replace("'","''")); // print the key and value
					    
						c.SaveWatchlist(Ticker, Value.replace("'","''")); //escape single quotation
					}
					catch(Exception e)
					{
					e.printStackTrace();
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



