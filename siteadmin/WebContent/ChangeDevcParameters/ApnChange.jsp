<%@ include file="headerhtml.jsp" %>
<%! 
Statement st,st1;
String sql;
String ss1="";
%>
<%
Connection conn;
Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try
{
	st=conn.createStatement();
	st1=conn.createStatement();
}catch(Exception e)
{
	out.print("Exception---->"+e);
}
%>
<form name="apnform" action="apnSend.jsp" method="post"">
<table border="0" align="center" width="100%">
<tr><td bgcolor="#f5f5f5"" align="center">
<font color="black" size="2">
<b>
Enter the Unit ID for the vehicle and Select the type of SIM Card.
</b>
<br><br>
</font>
</td></tr>
</table>
<table border="0" align="center">
<tr>

<td bgcolor="#f5f5f5"><font size="2">Unit ID :</font></td>
<td bgcolor="#f5f5f5">
<input type="text" name="uid" id="uid" size="15" value="">
<br><br>
</td>
</tr>
<tr bgcolor="#CCCCCC" id="sp">
					<td><font color="maroon" size="2"> SIM Card:</font></td>
					<td><select name="sim" id="sim">
					    <option value="airtelgprs.com">AirTel</option>
						<option value="www">Vodafone</option>
						<option value="internet">Idea</option>
					  </select>
					  </td>
</tr>
<tr>
<td bgcolor="#f5f5f5" colspan="2" align="center"><font size="2"><input type="submit" name="Submit" value="Submit"></font></td>
<br><br><br><br>
</tr>
</table>
</form>
<%
try
{
ss1=request.getParameter("flag");
if(ss1.equals("Y"))
{
%>
<table border="0" width="100%" bgcolor="white">
			<tr>
				<td>
				<div align="center"><font color="red"><b>Message sent successfully!</b></font></div>
				</td>
			</tr>
		</table>
<%
}
if(ss1.equals("N"))
{
	%>
	<table border="0" width="100%" bgcolor="white">
			<tr>
				<td>
				<div align="center"><font color="red"><b>Unable to send message</b></font></div>
				</td>
			</tr>
		</table>
	<%	
}
}
catch(Exception e)
{
	out.println("");
}
finally{
	conn.close();
}
%>

<%@ include file="footerhtml.jsp" %>