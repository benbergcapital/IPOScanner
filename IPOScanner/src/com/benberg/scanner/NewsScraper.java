package com.benberg.scanner;

import java.io.IOException;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class NewsScraper {

	/**
	 * @param args
	 */
	public NewsScraper() {
	
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

}
