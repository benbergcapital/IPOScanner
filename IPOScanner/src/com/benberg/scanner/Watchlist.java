package com.benberg.scanner;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Watchlist {


	 ResultSet rs = null;
	 Connection con = null;
	 Statement st = null;


	public String GetWatchlist()
	{
		try{

		   String url = "jdbc:mysql://ben512.no-ip.org:3306/watchlist";
		   String user = "root";
		   String password = "root";
		
		   Class.forName("com.mysql.jdbc.Driver");
		 con = DriverManager.getConnection(url, user, password);
		 PreparedStatement pst = null;
		 pst = con.prepareStatement("SELECT * FROM WATCHLIST");
		 rs = pst.executeQuery();
		
			while (rs.next())
			{
			System.out.println(rs.getString(1));
			}
		
		
		}
		catch (Exception e)
		{
		System.out.println(e.toString());
		}
		
		
		return null;
		
		
		
		
		
		
		
	}

}
