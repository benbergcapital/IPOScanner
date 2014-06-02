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

public class NasdaqIPOWorker {

	
	public List<String> getListOfTickers(int Month)
	{
		try{
		List<String> _Tickers = new ArrayList<String>();
		WebDriver driver = new HtmlUnitDriver();
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
		Month++;
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
