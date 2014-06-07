package com.benberg.struct;

public class WatchlistStruct {

	private String Ticker;
	private String Notes;
	
	public WatchlistStruct(String ticker, String Notes)
	{
		this.Ticker = ticker;
		this.Notes = Notes;
	}
	
	public String GetTicker()
	{
		return Ticker;
	}
	public String GetNotes()
	{
		return Notes;
	}

}
