<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ include file="headerhtml.jsp" %>
<html>
<head>
<script language="javascript">
 function Redirect()
 {
	 var a=document.getElementById("avail").value;
	 /* alert(" a :- "+a); */
	 alert("Already Exist With Availability  "+a+" ");
	 
	 window.location="addtechnician.jsp";
 }
 function Redirect1()
 {
	 alert("Technician Added Successfully");
	 window.location="addtechnician.jsp";
 }
</script>
</head>
<body>



<%!
Connection conn1;
%>
<% 	
try {

	Class.forName(MM_dbConn_DRIVER);
	conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1 = conn1.createStatement();
Statement stmt2 = conn1.createStatement();
String available="";
ResultSet rs2=null,rs3=null;
String sql1="", sql2="",sql3="", sql4=""; 
int i=0;//Added by veena
int maxid=0,maxid1=0;
String name=request.getParameter("techname");
String tuname=request.getParameter("techuname");
String mobno=request.getParameter("mobno");
String location=request.getParameter("location");
String mailid=request.getParameter("mailto");
String contractid=request.getParameter("contractid");

		java.util.Date d = new java.util.Date();
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String s=formatter.format(d);
			
sql2="select max(TID) as maxid from t_techlist";
rs2=stmt1.executeQuery(sql2);
if(rs2.next())
{
	maxid=rs2.getInt("maxid");
}
	maxid=maxid+1;
	
sql3="select max(ID) as maxid1 from t_admin";
rs3=stmt2.executeQuery(sql3);
if(rs3.next())
{
	maxid1=rs3.getInt("maxid1");
}
	maxid1=maxid1+1;
	
String sqltech="select TechName,Available from t_techlist where TechName='"+name+"' and techuname='"+tuname+"'";	
ResultSet rsuser=stmt1.executeQuery(sqltech);
if(rsuser.next())
{    available=rsuser.getString("Available");
       

 %>
 <input type="hidden" name="avail" id="avail" value=<%=available %> / >
 <%   
 	out.println("<script> Redirect() </script>");
    
    
	//response.sendRedirect("addtechnician.jsp?inserted=Already Exist");
}
else
{
sql1="insert into db_CustomerComplaints.t_techlist (TID,TechName,techuname,pass,Available,Location,MobNo,EmailId,ContractorId) values ('"+maxid+"','"+name+"', '"+tuname+"', 'transworld', 'Yes', '"+location+"','"+mobno+"','"+mailid+"','"+contractid+"')";
System.out.println("==========Query for techlist============="+sql1);
i=stmt1.executeUpdate(sql1);
sql4="insert into t_admin (id,Name,UName,pass,URole,UserType) values ('"+maxid1+"','"+name+"', '"+tuname+"', 'transworld', 'tech', 'tech') ";
System.out.println("=============Query for admin=================="+sql4);
stmt2.executeUpdate(sql4);
}
if(i!=0)
{
	out.println("<script> Redirect1() </script>");
	//response.sendRedirect("addtechnician.jsp?inserted=successfull");
}
return;

} catch(Exception e) { out.println("Exception----->"+e); }finally{conn1.close();}
%>


<%@ include file="footerhtml.jsp" %>
</body>
</html>