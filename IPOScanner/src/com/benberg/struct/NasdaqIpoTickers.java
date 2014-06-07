package com.benberg.struct;

public class NasdaqIpoTickers {

	String Ticker;
	String Name;
	
	
	
	public NasdaqIpoTickers(String Ticker,String Name)
	{
		this.Ticker = Ticker;
		this.Name = Name;
		
	}
	public String GetTicker()
	{
		return Ticker;
	}
	public String GetName()
	{
		return Name;
	}
}
