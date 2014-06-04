package com.benberg.scanner;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.benberg.struct.NasdaqIpoTickers;

public class NasdaqIPOWorker {
	WebDriver driver;
	
	public List<String> getListOfTickers(int Month)
	{
		try{
		List<String> _Tickers = new ArrayList<String>();
		driver = new HtmlUnitDriver();
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		Month++;
		String url = "http://www.nasdaq.com/markets/ipos/activity.aspx?tab=pricings&month=2014-"+Month;
		System.out.println("Using Nasdaq list : "+url);
		 driver.get(url);
		 String html_element = "two_column_main_content_rptPricing_symbol_";
		 boolean limit=true;
		 int i =0;
		 while(limit)
		 {
			 WebElement webElement = getWebElement(driver,html_element,i); 
			 
			 if (webElement != null)
			 {
				
			 System.out.println(webElement.getText());
			 _Tickers.add(webElement.getText());
			 i++;
			 }
			 else
			 	 limit =false;
				
		 	}		
		 return _Tickers;
		 }
		 
		
		
		catch (Exception e)
		{
			return null;
		}
		
		
		
	}
	
	public List<NasdaqIpoTickers> getListOfUpcomingTickers()
	{
		
		List<NasdaqIpoTickers> _Tickers = new ArrayList<NasdaqIpoTickers>();
	
		String url = "http://www.nasdaq.com/markets/ipos/activity.aspx?tab=upcoming";
		System.out.println("Using Nasdaq Upcoming list : "+url);
		 driver.get(url);
		 String html_element_ticker = "two_column_main_content_rptExpected_symbol_";
		 String html_element_name = "two_column_main_content_rptExpected_company_";
				 
		 boolean limit=true;
		 int i =0;
		 WebElement webElement;
		 while(limit)
		 {
			 webElement = getWebElement(driver,html_element_ticker,i); 
			 
			 if (webElement != null)
			 {
			String Ticker =webElement.getText();
			webElement = getWebElement(driver,html_element_name,i); 
			String Name = webElement.getText();
			
			System.out.println(Name+Ticker);
			 
			 
			 _Tickers.add(new NasdaqIpoTickers(Ticker,Name));
			 i++;
			 }
			 else
				 limit =false;
		 }
		
		return _Tickers;
		
		
		
	}
	
	
	public  WebElement getWebElement(WebDriver driver,String element,int i) {
     WebElement myDynamicElement = null;
     try {
         myDynamicElement = (new WebDriverWait(driver, 10)).until(ExpectedConditions.presenceOfElementLocated(By.id(element+i)));
         return myDynamicElement;
     } catch (Exception ex) {
         return null;
     }
	}
}
