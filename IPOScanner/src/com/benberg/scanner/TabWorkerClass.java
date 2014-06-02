package com.benberg.scanner;

import java.text.DateFormatSymbols;
import java.util.Calendar;

public class TabWorkerClass {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	public static int GetCurrentMonth()
	{
		Calendar cal = Calendar.getInstance();
	 
		return cal.get(Calendar.MONTH);
				
		
	}
	public static String GetMonthName(int month)
	{
		String monthname = new DateFormatSymbols().getMonths()[month];
		return monthname;
		
	}
	public static String GetUrl(int month)
	{
		month++;
		return "http://www.nasdaq.com/markets/ipos/activity.aspx?tab=pricings&month=2014-"+month;
		
		
	}
}
