<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.BufferedReader" import="java.io.InputStreamReader" import="java.net.URL"
    import="java.net.URLEncoder" import="java.net.URLConnection" import="java.sql.Connection" import="java.sql.DriverManager"
    import="java.sql.ResultSet" import="java.sql.Statement" import="java.text.Format" import="java.text.SimpleDateFormat" 
    %>
    
    
    <%@ page import ="java.io.IOException" %>
<%@ page import ="java.io.PrintStream" %>
<%@ page import ="java.net.HttpURLConnection" %>
<%@ page import ="java.net.URL" %>
<%@ page import ="java.net.URLEncoder" %>

<%@ include file="conn.jsp" %>
<%
String u_id=request.getParameter("uid");
String os1=request.getParameter("os1");
String os2=request.getParameter("os2");
String os3=request.getParameter("os3");
String mob="";
String uname=session.getAttribute("username").toString();
String msg_type="OS Limit Msg";
java.util.Date d12=new java.util.Date();  	
Format frt2=new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
String now1= frt2.format(d12);
String vehreg="-",OwnerName="-";
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//-----------------------------------------
/*
String nwfrmtdte=new SimpleDateFormat("yyyy-MM-dd ").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("calender1")));//format(new java.util.Date());
out.println("--------"+nwfrmtdte);*/
//-----------------------------------------
try
{
Statement stmt=conn.createStatement();
String sql1="select MobNo from t_unitmaster where UnitID='"+u_id+"'";
ResultSet rs=stmt.executeQuery(sql1);
while(rs.next())
{
	mob=rs.getString("MobNo");
}




String sql22="select VehicleRegNumber,OwnerName  from db_gps.t_vehicledetails where UnitID='"+u_id+"'";

ResultSet rs32=stmt.executeQuery(sql22);
System.out.println("sql22===sql22=>"+sql22);

if(rs32.next())
{
	
	
	vehreg=rs32.getString("VehicleRegNumber");
	OwnerName=rs32.getString("OwnerName");
}
System.out.println("OwnerName==>"+vehreg);

System.out.println("OwnerName==>"+OwnerName);




}
catch(Exception e)
{
	out.println("Exception="+e);
}
%>
<%
	String sms="";
	try{
		
		sms="UI"+u_id+"#SET0006:0000,-,-,-,"+os1+","+os2+","+os3+",-";
		sms=URLEncoder.encode(sms);
        System.out.println("now in send function"+sms);
        sms=sms.trim();
        String numbers = mob;    String msgid = null;String smsurl = "";
        
        try
        {
          String sqlsms = "select Url from db_gps.t_TransactionSmsGatewayUrl";
          Statement stmt3 = conn.createStatement();
          ResultSet rst = stmt3.executeQuery(sqlsms);
          System.out.println("sqlsms...  " + sqlsms);
          if (rst.next())
          {
            smsurl = rst.getString("Url");
          }

        }
        catch (Exception e)
        {
          System.out.println("Exception in READING SMS...  " + e);
        }
        System.out.println("smsurl==>" + smsurl);
        System.out.println("NUMBERS NUMBERS ==>" + numbers);
        
        try
        {
          sms = URLEncoder.encode(sms, "UTF-8");
          smsurl = smsurl.replaceAll("\\+", "");
          smsurl = smsurl.replaceAll("numbers", numbers);
          smsurl = smsurl.replaceAll("sms", sms);
          smsurl = smsurl.replaceAll("\"", "");
          smsurl = smsurl.replaceAll(" ", "+");
        }
        catch (Exception e)
        {
          System.out.println("Exception  in  parsing SMS URl==>" + e);
        }

        System.out.println("FINAL  SMS URL==>" + smsurl);
		
        out.println("FINAL  SMS URL==>" + smsurl);
        
        sms = sms.replace("'", " ");
        sms = sms.replace(";", " ");
        sms = sms.replace("&", " ");
        sms = sms.replace("@", " ");
        sms = sms.replace("<>", " ");
        sms = sms.replace("[", " ");
        sms = sms.replace("]", " ");
        sms = URLEncoder.encode(sms, "UTF-8");
        try
        {
          URL url = new URL(smsurl);

          HttpURLConnection urlconnection = (HttpURLConnection)url.openConnection();

          urlconnection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");
          urlconnection.setRequestProperty("Accept", "*/*");

          urlconnection.setRequestMethod("GET");

          urlconnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
          urlconnection.setDoOutput(true);

          urlconnection.connect();
          BufferedReader in = new BufferedReader(new InputStreamReader(urlconnection.getInputStream()));
          String line;
          while ((line = in.readLine()) != null)
          {
            //String line;
            msgid = line;
          }

        }
        catch(Exception e)
        {
        	out.print("SMS Sending Exception --->"+e);
        }
      
      
      
        
        /* 
        String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld&password=vikram&sender=transwld&sign=FleetView&to="+mob+"&message="+sms+"&gateway=regular";
    //	String smsurl="http://india.timessms.com/http-api/receiverall.asp?username=Transworld-INT&password=vikram&sender=Demo&cdmasender=&to="+mob+"&message="+sms+"";
    	
        System.out.println("now in send function"+smsurl);
        URL url=new URL(smsurl);
        URLConnection connection = url.openConnection();
        connection.connect();
 		BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String line;
        while ((line = in.readLine()) != null )
        {
            System.out.println(line);
        } */
         
        Statement stmt1=conn.createStatement();
        
        Statement stmt2=conn.createStatement();
        //  out.println("Unit ID="+u_id+", Mob No.="+mob+",Actual Msg="+sms+",Msg Type="+msg_type+",Sender ID="+uname+",Date_Time="+now1);
         String newmsg="insert into db_gps.t_serveralerts "+ 
  		"(UnitID,Message,MobNo,SentStatus,EntryBy,MsgType,SenderID,VehicleRegNo,Transporter,SMSStatus,FtpCmdStatus) values ("+
  		"  '"+u_id+"','"+sms+"','"+mob+"','No','SiteAdmin-TxmnIntvl','"+msg_type+"','"+uname+"','"+vehreg+"','"+OwnerName+"','SMS','Removed')";
  		System.out.println("sqlSentMessage===newmsg=> "+newmsg);
  		stmt2.executeUpdate(newmsg);
  		System.out.println("sqlSentMessage=RESET QUERY = after of installtiopn =newmsg=>"+newmsg);
        
        
      //  out.println("Unit ID="+u_id+", Mob No.="+mob+",Actual Msg="+sms+",Msg Type="+msg_type+",Sender ID="+uname+",Date_Time="+now1);
        String sql2="insert into t_msgSentDetails(UnitID,MobNo,ActualMsg,MsgType,SenderID,Date_Time) values('"+u_id+"', '"+mob+"','"+sms+"','"+msg_type+"','"+uname+"','"+now1+"')";
        int i=stmt1.executeUpdate(sql2);
        System.out.println("sql2 isss=> "+sql2);
  		
        out.println("Message sent!");         
        %>
        <jsp:forward page="OS_limit.jsp">
        <jsp:param name="flag" value="Y"/>
        </jsp:forward>
        <% 

        
        
        //response.sendRedirect("Reset.jsp");
       
	} catch (Exception e) 
    {
        out.print("SMS Sending Exception --->"+e);
        %>
        <jsp:forward page="OS_limit.jsp">
        <jsp:param name="flag" value="N"/>
        </jsp:forward>
        <%
    }finally{
    	conn.close();
    }
	//	return "done";
	
%>