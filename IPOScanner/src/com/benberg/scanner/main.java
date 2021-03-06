package com.benberg.scanner;
import java.io.*;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import com.benberg.struct.NasdaqIpoTickers;
import com.benberg.struct.WatchlistStruct;
import java.text.DateFormatSymbols;

@WebServlet("/RecentIPOs")
public class main extends HttpServlet{
	@Override
	  public void doGet(HttpServletRequest request,
	                    HttpServletResponse response)
	      throws ServletException, IOException {
		 List<String> _ListOfTickers = new ArrayList<String>();

		Cache c = new Cache();
		c=Cache.getInstance();

		


		String Month = request.getParameter("Month");
		int month=0;
		 if (Month == null)
		 {
			 Calendar cal = Calendar.getInstance();
			 month = cal.get(Calendar.MONTH);
		 }
		 else
		 {
			  month = Integer.valueOf(Month);

		 }


		_ListOfTickers = c.getTickerList(month-1);

			String charts ="";
			  for(String s : _ListOfTickers)
              {
				 charts += "<img src=\"http://stockcharts.com/c-sc/sc?s="+s+"&p=D&b=5&g=0&i=0&r=1401568661849\"><br>"+
				 "<button onclick=\"AddToWatchlist("+s+")\">Add "+s+" to watchlist</button><br>";
              }
			  response.setContentType("text/html");
			    PrintWriter out = response.getWriter();
			  String docType =
				      "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 " +
				      "Transitional//EN\">\n";
				    out.println(docType +
				                "<HTML>\n" +
				                "<HEAD><TITLE></TITLE>" +
				                "</HEAD>\n" +
				                "<BODY>\n" +
				                charts+
				                "</BODY></HTML>");


	      }

	public static String getUpcoming()
	{
		Cache c = new Cache();
		c=Cache.getInstance();
		String response="";
		for(NasdaqIpoTickers N : c.getUpcomingTickers())
		{
			response += N.GetTicker()+ " : "+N.GetName()+"<br>";


		}
		return response;
	}
	public static String NewMarketDataRequest()
	{
		
		return "asdasd";
	}

	public static String getCharts(int Month)
	{ 
		List<String> _ListOfTickers = new ArrayList<String>();
		Cache c = new Cache();
		c=Cache.getInstance();
		_ListOfTickers = c.getTickerList(Month);
		String charts ="";
	
		String monthString = new DateFormatSymbols().getMonths()[Month];
		
		if (_ListOfTickers !=null)
		{
			for(String s : _ListOfTickers)
	        {
				 charts += "<img src=\"http://stockcharts.com/c-sc/sc?s="+s+"&p=D&b=5&g=0&i=0&r=1401568661849\"><br>"+
						 "<button onclick=\"AddToWatchlist('"+s+"-"+monthString+"')\">Add "+s+" to watchlist</button><br>";
	        }
		}

		return charts;
	}
	private List<String> getListOfTickers(int Month)
	{
		try{
		List<String> _Tickers = new ArrayList<String>();
		WebDriver driver = new HtmlUnitDriver();
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		String url = "http://www.nasdaq.com/markets/ipos/activity.aspx?tab=pricings&month=2014-"+Month;
		System.out.println("Using Nasdaq list : "+url);
		 driver.get(url);

		 boolean limit=true;
		 int i =0;
		 while(limit)
		 {
			 WebElement webElement = getWebElement(driver,i); 

			 if (webElement != null)
			 {

			 System.out.println(webElement.getText());
			 _Tickers.add(webElement.getText());
			 i++;
			 }
			 else
			 {
				 limit =false;

			 }
		 }

		return _Tickers;
		}
		catch (Exception e)
		{
			return null;
		}



	}

	public static String GetWatchlist() throws UnsupportedEncodingException
	{
		Cache c = new Cache();
		c=Cache.getInstance();
		String result="";
		for(WatchlistStruct s : c.getWatchlist())
	       {
	//		result += "<tr class=\"watchlist \" onClick=\"Watchlist_click('"+s.GetTicker()+"')\" contenteditable=\"true\">"+
			result += "<tr class=\"watchlist \" contenteditable=\"true\">"+
			"<td>"+
				s.GetTicker()+
				"</td>"+
				"<td>"+
				URLDecoder.decode(s.GetNotes(),"UTF-8" )+
				"</td>"+
				"</tr>";
	       }
		return result;

	}

	public  WebElement getWebElement(WebDriver driver,int i) {
     WebElement myDynamicElement = null;
     try {
         myDynamicElement = (new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id("two_column_main_content_rptPricing_symbol_"+i)));
         return myDynamicElement;
     } catch (Exception ex) {
         return null;
     }
 }







}