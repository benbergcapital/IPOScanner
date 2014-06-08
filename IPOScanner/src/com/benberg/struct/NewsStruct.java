package com.benberg.struct;

public class NewsStruct {

	private String Date;
	private String Title;
	
	public NewsStruct(String date, String title)
	{
		this.Date = date;
		this.Title = title;
	}

	public String GetDate()
	{
		return Date;
	}
}
