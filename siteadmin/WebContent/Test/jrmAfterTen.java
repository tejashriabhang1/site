import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.Format;
import java.text.SimpleDateFormat;

public class jrmAfterTen
{
	public jrmAfterTen()
	{
	}
	public static void main(String args[])
	{
		jrmAfterTen j=new jrmAfterTen();
		Connection con=null;
		Statement stmt=null;
		ResultSet rs=null;
		String tm="", ctm="", th="", cth="", send_d="", send_c="";
		String u_id="", jrm_cnt="";
		
		try{PREMIUM 
			Class.forName("org.gjt.mm.mysql.Driver");
	    	con=DriverManager.getConnection("jdbc:mysql://103.241.181.36/db_gps","site","1@s2te");
			}
			catch(Exception e)
			{
				System.out.println("Exception in Connection"+e);
			}
		try
	    {
		/*	//get current time ,to calculate difference 
    		java.util.Date d12=new java.util.Date();  	
    		Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
    		String now1= frt2.format(d12);
    		cth=now1.substring(12,14);
    		ctm=now1.substring(15,17);*/
			
	    	stmt=con.createStatement();
	    	String sql1="select * from t_jrmSendMsg";
	    	rs=stmt.executeQuery(sql1);
	    	while(rs.next())
	    	{
	    		/*
	    		send_d=rs.getString("Date_Time");
	    		// cal diff
	    		th=send_d.substring(12,14);
	    		tm=send_d.substring(15,17);
	    		*/
	    		u_id=rs.getString("Unit ID");
	    		jrm_cnt=rs.getString("Root_count");
	    		try{
		        	String sms="";
		        	sms="#JRM:"+jrm_cnt+"";
		    		sms=URLEncoder.encode(sms);
		            System.out.println("now in send function"+sms);
		            String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=transwld&sign=FleetView&to=9595889312&message="+sms+"&gateway=premium";
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
	    	}
	    	
	    	
	    }
	    catch(Exception e){}
	}
}