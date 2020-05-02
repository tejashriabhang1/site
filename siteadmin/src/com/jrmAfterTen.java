package com;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;


public class jrmAfterTen
{
	public jrmAfterTen()
	{
		
	}
	public static void main(String args[])
	{
		Connection con=null, con1=null;
		Statement stmt=null, stmt2=null;
		ResultSet rs=null;
		int cnt=0;
		long miliseconds1=0,miliseconds2=0,miliseconds=0,sd=0,md=0,hd=0;
		String u_id="", jrm_cnt="", chk_flg="", mob_no="",check_status="N", sendDate="",dt="";
		System.out.println("b4 conn");
		try{
			Class.forName("org.gjt.mm.mysql.Driver");
			con=DriverManager.getConnection("jdbc:mysql://103.241.181.36/db_gps","fleetview","1@flv");
//	    	con=DriverManager.getConnection("jdbc:mysql://103.241.181.36/db_gps","fleetview","1@flv");
//			con=DriverManager.getConnection("jdbc:mysql://103.241.181.36/db_gps","unit","1@utp");
	    	System.out.println("conn done");
			}
			catch(Exception e)
			{
				System.out.println("Exception in Connection"+e);
			}
		try
	    {
			//get current time ,to calculate difference 
    		SimpleDateFormat sdfDate = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");//dd/MM/yyyy
    		Date now = new Date();
    		String strDate = sdfDate.format(now);
    		System.out.println("Current"+strDate);
    		java.util.Date fd=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").parse(strDate);
    		miliseconds1=fd.getTime();
    		System.out.println("miliseconds1---"+miliseconds1);
			
	    	stmt=con.createStatement();
	    	String sql1="select * from t_jrmSendMsg";
	    	rs=stmt.executeQuery(sql1);
	    	while(rs.next())
	    	{
	    			cnt++;
	    			System.out.println("in2 while"+cnt);
	    			
	    		 	chk_flg=rs.getString("Flag_val");
	      //get time when JRM msg sent	 	
	      sendDate=rs.getString("Date_Time");
	      java.util.Date fd1=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").parse(sendDate);
    	  System.out.println("CON---------"+fd1.toString());
          miliseconds2=fd1.getTime();
          System.out.println("miliseconds2---"+miliseconds2);
          //calculate the difference
          miliseconds=miliseconds1-miliseconds2;
          System.out.println("miliseconds---"+miliseconds);
          sd=miliseconds/1000;
          md=sd/60;
          hd=sd/60/60;
 		  md=(sd/60) - (hd*60);
          System.out.println("---------Min diff----------------"+md);
	     
	    		 	System.out.println("Flag_val"+chk_flg);
	    		 	if(chk_flg.equals("N") && md>5)
	    		 	{
	    		 	mob_no=rs.getString("Mob_No.");
	    		 	u_id=rs.getString("Unit_ID");
	    			jrm_cnt=rs.getString("Root_count");	
	    			dt=rs.getString("Date_Time");
	    		 	try{
		        	String sms="";
		        	sms="#JRM:"+jrm_cnt+"";
		    		sms=URLEncoder.encode(sms);
		            System.out.println("now in send function"+sms);
		            String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=transwld&sign=FleetView&to="+mob_no+"&message="+sms+"&gateway=premium";
		            System.out.println("now in send function"+smsurl);
		            URL url=new URL(smsurl);
		            URLConnection connection = url.openConnection();
		            connection.connect();
		            System.out.println("connected");
		     		BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		            String line;
		            while ((line = in.readLine()) != null )
		            {
		            	System.out.println("in while");
		                System.out.println(line);
		               
		            }
	    			System.out.println("u_id"+u_id+", jrm_cnt"+jrm_cnt);
	   
		           }
		           catch(Exception e)
		           {
		        		System.out.println("Exception ="+e);
		           }
	  
		
		         //  check_status="Y";
		           try{
			    		System.out.println("b4 update");
			    		Class.forName("org.gjt.mm.mysql.Driver");
			    	//	con1=DriverManager.getConnection("jdbc:mysql://103.241.181.36/db_gps","fleetview","1@flv");
			    		con1=DriverManager.getConnection("jdbc:mysql://103.241.181.36/db_gps","fleetview","1@flv");
			    		System.out.println("Conn1 ESTB");
						  stmt2=con1.createStatement();
						  System.out.println("stmt");
						  System.out.println("---unit id----"+u_id);
						  String sql3="update t_jrmSendMsg set Flag_val='Y' where Unit_ID='"+u_id+"' and Date_Time='"+dt+"'";
						  System.out.println(sql3);
				 		  int j=stmt2.executeUpdate(sql3);
				 		 System.out.println("aftr execution"+j);
				 		 
				 		 stmt2.close();
				 		 con1.close();
			    		}
			    		catch (Exception e) 
			    		{
						}
	    	   }
   	//----------------------------------------------------------------------------------------
	    	}
	    /*	if(check_status.equals("Y"))
	    	{
	    		try{
	    		System.out.println("b4 update");
				  stmt2=con.createStatement();
				  System.out.println("stmt");
				  String sql3="update t_jrmSendMsg set Flag_val='Y'";
				  System.out.println(sql3);
		 		  int j=stmt.executeUpdate(sql3);
		 		 System.out.println("aftr execution"+j);
	    		}
	    		catch (Exception e) {
					
				}
	    	}*/
	    
	    	
	    }
	    catch(Exception e)
	    {
	    	System.out.println("Exception"+ e);
	    }
	    
	    try{
	    	
	    	System.out.println("-------b4 Close Conn-------");
	    	    	stmt.close();
	    	  //  	stmt2.close();
	    	  //  	con1.close();
	    	    	con.close();
	    	System.out.println("-------Closed Conn-------");
	    }
	    catch(Exception e){System.out.println("Close Connection Exception----->>>"+e);}
	}
}