package com.benberg.scanner;

import java.io.IOException;
import java.io.PrintWriter;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


@WebServlet("/NewsRequest")
public class NewsScraper extends HttpServlet{

	  public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException, ServletException{

		  String Ticker = request.getParameter("Ticker");
		  	
		
		  
		  
		  PrintWriter out = response.getWriter();
    	
		  
		  
		  out.println(  YahooNewsScraper(Ticker));
		 
	
}
	


	
	
	public void FinvizNewsScraper() {
	
		  Connection conn = Jsoup.connect("http://finviz.com/quote.ashx?t=CMCM");
		  conn.timeout(12000);
	  
	    Document doc;
		try {
			doc = conn.get();
	
	    Elements table = doc.select("table[class = fullview-news-outer]"); // a with href
		
		Elements rows = table.select("tr");
		//List<NewsStruct> 
	    for (Element tr: rows) {
	    	
	    	
	    	String relHref = tr.select("a").attr("href");
	    	Elements tds = tr.select("td");
	    	String news = tr.text();
	    	
	    //	 for (Element td: tds) {
	    //		 System.out.println(td.text());
	    //		 
	    //	 }
           
           
        }
		
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public String YahooNewsScraper(String ticker) {
		
		  Connection conn = Jsoup.connect("http://finance.yahoo.com/q?s="+ticker);
		  conn.timeout(12000);
	  
	    Document doc;
		try {
			doc = conn.get();
		Element link = doc.getElementById("yfi_headlines");
		Elements links = link.getElementsByTag("li");
		String response="<br>";
		
				for (Element s : links) {
					
			//		Elements ff = s.select("a[href]");
			        
			//        Elements imports = ff.select("link[href]");
					
					
			//		System.out.println(ff.select("href") );
					System.out.println(s.text());
					
					
					response+=s.text()+"<br>";			  
					  
					  
					}
	  
         return response;
         
      
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
}
