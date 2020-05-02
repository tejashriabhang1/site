<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="conn.jsp" %>
<html>
<head>
<script language="javascript">
 function Redirect()
 {
	 alert("Record Updated Successfully");
	 window.location="deactivatetech.jsp";
 }
 function Redirect1()
 {
	 alert("Record Not Updated Successfully");
	 window.location="deactivatetech.jsp";
 }
</script>
</head>
<body>

<%
try
{ int i,j;
Statement stmt1=null;
Statement stmt2=null;
Statement stmt3=null;
Class.forName(MM_dbConn_DRIVER);
Connection conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
stmt1 = conn1.createStatement();
stmt2 = conn1.createStatement();
stmt3 = conn1.createStatement();
String tid=request.getParameter("tid");
String techname=request.getParameter("techname");
String username=request.getParameter("techuname");
String mobno=request.getParameter("mobno");
String location=request.getParameter("location");
String mail=request.getParameter("mailto");
String ContractorId=request.getParameter("contractid");

String available="";
String pass="";
String entryby=session.getAttribute("username").toString();
System.out.println("parameters are"+tid+""+techname+""+username);

String sql="update db_CustomerComplaints.t_techlist SET TechName='"+techname+"',techuname='"+username+"',Location='"+location+"',MobNo='"+mobno+"',EmailId='"+mail+"',ContractorId='"+ContractorId+"' where TID='"+tid+"' And TechName='"+techname+"'";
System.out.println("=========Update Query For TechList========"+sql);
i=stmt1.executeUpdate(sql);
String sql1="select Available,pass from db_CustomerComplaints.t_techlist where TID='"+tid+"'";
System.out.println("======select query for getting Available And pass"+sql1);
ResultSet RS1=stmt2.executeQuery(sql1);
if(RS1.next())
{
	 available=RS1.getString("Available");
	 pass=RS1.getString("pass");
}
String sql2="insert into db_CustomerComplaints.t_techlistHistory(TID,TechName,TechUname,Location,MobNo,EmailId,ContractorId,Available,pass,insertDate,EntryBy)values('"+tid+"','"+techname+"','"+username+"','"+location+"','"+mobno+"','"+mail+"','"+ContractorId+"','"+available+"','"+pass+"',curdate(),'"+entryby+"')";
System.out.println("=======Insert into History table========== "+sql2);
j=stmt3.executeUpdate(sql2);
  if(i!=0 && j!=0)
{
	out.println("<script> Redirect() </script>");
}
else{out.println("<script> Redirect1() </script>");
	
}  
//out.println("<script> Redirect() </script>");
//response.sendRedirect("deactivatetech.jsp");

}
catch(Exception e)
{
	//response.sendRedirect("deactivatetech.jsp");
	e.printStackTrace();
	//out.println("<script> Redirect1() </script>");
	
}


%>






</body>
</html>