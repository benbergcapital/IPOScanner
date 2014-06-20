package com.benberg.scanner;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.benberg.marketdata.ListenForResponse;
import com.benberg.struct.WatchlistStruct;

public class Watchlist {


	 ResultSet rs = null;
	 Connection con = null;
	 Statement st = null;

	 public Watchlist()
	 {
		 try{
		   String url = "jdbc:mysql://localhost:3306/benberg";
		   String user = "root";
		   String password = "root";
		
		   Class.forName("com.mysql.jdbc.Driver");
		 con = DriverManager.getConnection(url, user, password);
		 }
		 catch (Exception e)
		 {
			 
		 }
		 
	 }

	public List<WatchlistStruct> GetWatchlist()
	{
		List<WatchlistStruct> result = new ArrayList<WatchlistStruct>();
		try{

		 PreparedStatement pst = null;
		 pst = con.prepareStatement("SELECT * FROM WATCHLIST");
		 rs = pst.executeQuery();
		
			while (rs.next())
			{
				result.add(new WatchlistStruct(rs.getString(1),rs.getString(2)));
		
			}
		return result;
		
		}
		catch (Exception e)
		{
		System.out.println(e.toString());
		}
		
		
		return null;
		
		
		
		
		
		
		
	}

}
