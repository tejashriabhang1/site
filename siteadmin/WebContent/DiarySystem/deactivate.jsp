<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="conn.jsp" %>
<html>
<body>

<%

Statement stmt1=null;
Statement stmt2=null;
Statement stmt3=null;
Statement stmt4=null;
Statement stmt5=null;
String available="";
String pass="";
Class.forName(MM_dbConn_DRIVER);
Connection conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
stmt1 = conn1.createStatement();
stmt2 = conn1.createStatement();
stmt3 = conn1.createStatement();
stmt4 = conn1.createStatement();
stmt5 = conn1.createStatement();
String entryby=session.getAttribute("username").toString();
String tid=request.getParameter("tid");
String techname=request.getParameter("techname");
String username=request.getParameter("techuname");
String location=request.getParameter("Location").replace("...","&");
String mobno=request.getParameter("mobno");
String mailid=request.getParameter("emailid");
String contractorid=request.getParameter("contractorid");

System.out.println("parameters are"+tid+""+techname+""+username);
String sql="update db_CustomerComplaints.t_techlist SET Available='No' where TID='"+tid+"' And TechName='"+techname+"'";
stmt1.executeUpdate(sql);
String sql2="select * from db_CustomerComplaints.t_admin where UName='"+username+"' AND Active='Yes'";

ResultSet rs=stmt2.executeQuery(sql2);
while(rs.next())
{
     if(username.equalsIgnoreCase(rs.getString("UName")))
    	{
			String sql3="update db_CustomerComplaints.t_admin SET Active='No' where Uname='"+username+"' ";
			stmt3.executeUpdate(sql3);
		}

}
String sql1="select Available,pass from db_CustomerComplaints.t_techlist where TID='"+tid+"'";
System.out.println("======select query for getting Available And pass"+sql1);
ResultSet RS1=stmt4.executeQuery(sql1);
if(RS1.next())
{
	 available=RS1.getString("Available");
	 pass=RS1.getString("pass");
}
String sql4="insert into db_CustomerComplaints.t_techlistHistory(TID,TechName,TechUname,Location,MobNo,EmailId,ContractorId,Available,pass,insertDate,EntryBy)values('"+tid+"','"+techname+"','"+username+"','"+location+"','"+mobno+"','"+mailid+"','"+contractorid+"','"+available+"','"+pass+"',curdate(),'"+entryby+"')";
System.out.println("=======Insert into History table========== "+sql4);
stmt5.executeUpdate(sql4);

response.sendRedirect("deactivatetech.jsp");

%>






</body>
</html>