   <%@ include file="headerhtml.jsp" %>
<%--      <%@ include file="conn.jsp" %> 
  <link href="../css/css.css" rel="StyleSheet" type="text/css">
<style type="text/css">@import url(../jscalendar-1.0/calendar-win2k-1.css);</style>
<script type="text/javascript" src="../jscalendar-1.0/calendar.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/lang/calendar-en.js"></script>
<script type="text/javascript" src="../js/sorttable.js"></script>
<script type="text/javascript" src="../jscalendar-1.0/calendar-setup.js"></script>  
 --%> 
<%!

Statement st, st1;
String sql, unitid,thedate,thedate1,thedate2;
int limit;
Connection conn,conn1;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING	,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try{
	st=conn.createStatement();
	st1=conn.createStatement();
	%>
	
<%@page import="java.util.Date"%><table border="0" width="100%" align="center" class="sortable">
	<form name="unitform" action="" method="get">
	<tr><td colspan="8" align="center" class="sorttable_nosort"><b>Please select the date and enter the Unit id to check its data.</b> </td></tr>
	<tr>
	<td bgcolor="#F5F5F5">
	<input type="text" id="data" name="data" value=""  size="12" readonly/>
	</td><td bgcolor="#F5F5F5">
  	<input type="button" name="The Date" value="From Date" id="trigger">
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script>
	</td>
	<td bgcolor="#F5F5F5">Unit ID :</td>
	<td bgcolor="#F5F5F5">
	<input type="text" name="unitid" id="unitid" class="stats"></input> 
	</td>
	<td bgcolor="#F5F5F5">Limit : </td>
	<td bgcolor="#F5F5F5">
	<input type="radio" name="limit" value="xx" checked> <input type="text" name="lim" value="10" size="5" class="stats"> </input><br>
<input type="radio" name="limit" value="All" > ALL
	</td>
	<td bgcolor="#F5F5F5">
	<input type="submit" name="submit" value="submit" class="stats">
	</td>
	</tr>
	</form>
	<tr>
	<td colspan="7">
	<%
	if(!(null==request.getQueryString()))
	{
		unitid=request.getParameter("unitid");
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		Date date1=new SimpleDateFormat("yyy-MM-dd").parse(thedate1);
		Date change= new SimpleDateFormat("yyyy-MM-dd").parse("2010-03-02");
		
		long startdate=date1.getTime();
		long changedate=change.getTime();
		long diff=startdate-changedate;
		thedate2=thedate1.replace("-","_");
		
		
		
		String lim1=request.getParameter("limit");
		String limit;
		if(lim1.equals("xx"))
		{
			limit=" limit "+request.getParameter("lim");
		}
		else
		{
			limit="";
		}
		//out.print(thedate+"  "+thedate1+"  "+thedate2);
		%>
		<table border="0" width="100%" align="center">
		<tr bgcolor="#2696B8">
		<th colspan="8" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b>The Data of unit <%=unitid %> on <%=thedate %></b></font>
		<div align="right"><a href="excelsmtpunitdata.jsp?data=<%=thedate %>&unitid=<%=unitid %>&limit=<%=limit %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		
		<%
		
		sql="select * from smartgrid.t_jpgsnapsmartgrid where unitid='"+unitid+"' order by concat(snapdate,snaptime) desc limit 1";
		
		ResultSet rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			System.out.println("QRY : "+sql);
			%>
		<tr >
		<td colspan="8" class="hed" align="center">The current location of unit <%=unitid %> is  <B><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("snapdate"))+" "+rst1.getString("snaptime") +"   "+rst1.getString("LocName")%></B></td>
		</tr>
			<%
		}
		%>
		<tr>
		<td colspan="8">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
	<!-- 	
		<td class="hed" align="center">LocId</td>
		<td class="hed" align="center">LocName</td>
	 -->
	 <td class="hed" align="center">UnitId</td>
	 	<!-- <td class="hed" align="center">VehicleCode</td> -->
		<td class="hed" align="center">VehicleRegNumber</td>
	 	
		<td class="hed" align="center">  SnapDate  </td>
		<td class="hed" align="center">SnapTime</td>
		<!-- <td class="hed" align="center">RawFileName</td> -->
		<td class="hed" align="center">JpgFileName</td>
		<td class="hed" align="center">StoredDate</td>
		<!-- <td class="hed" align="center">ImgCategory</td> -->
		<td class="hed" align="center">CameraPos</td>
		<!-- <td class="hed" align="center">SnapDateTime</td> -->
		
		</tr>
		<%
		
		
		/* 	sql="SELECT * FROM t_sgimages"+thedate2+"  where Unitid='"+unitid+"'  UNION select * from t_sgimages"+thedate2+"Processed where Unitid='"+unitid+"'  UNION select * from t_sgimages"+thedate2+"_bulk where Unitid='"+unitid+"' order by storedtime desc "+limit; */
			sql="SELECT * FROM smartgrid.t_jpgsnapsmartgrid  where Unitid='"+unitid+"' order by srNo desc "+limit;
		
			System.out.println("sql is :- "+sql);
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		
		while(rst.next())
		{
			//System.out.println("sql is :- "+sql);
		%>
			<tr>
			
			<td  class="bodyText" align="right"><div align="right"><%=i %></div></td>
			<td  class="bodyText" align="right""><div align="right"><%=rst.getString("unitid") %></div></td>
			
			<td  class="bodyText" align="left""><div align="left"><%=rst.getString("vehicleregnumber") %></div></td>
			<td  class="bodyText" align="right""><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("snapdate")))%></div></td>
			<td  class="bodyText" align="right""><div align="right"><%=rst.getTime("snaptime") %></div></td>
			<%-- <td  align="left"><%=rst.getString("rawfilename") %></td> --%>
			<td  class="bodyText" align="left""><div align="left"><%=rst.getString("jpgfilename") %></div></td>
			<%
				String storeDateTime=rst.getString("jpgfiledatetime");
			storeDateTime=storeDateTime.substring(11, 19);
			
			%>
			<%-- <td  align="left"><%=rst.getString("jpgfiledatetime") %></td> --%>
			<%-- <td  align="left"><%=storeDateTime %></td> --%>
			 <td class="bodyText" align="right""><div align="right"><%=new SimpleDateFormat("dd-MMM-yyyy "+storeDateTime).format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("jpgfiledatetime")))%></div></td>
			<%-- <td  align="center"><%=rst.getString("Imgcategory") %></td> --%>
			<td  class="bodyText" align="left""><div align="left"><%=rst.getString("camerapos") %></div></td>
			<%-- <td  align="center"><%=new SimpleDateFormat("dd-MMM-yyyy HH:MM:SS").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("snapdatetime")))%></td>
			 --%>
			
			</tr>
		<%
		i++;
		}%>
		
		
		  </table>
	  
		
		  </td></tr></table>
		  
		<%
	}%>
	</td>
	</tr>
	</table>
	<%
	
}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
	e.printStackTrace();
}
finally
{
	try{
	conn.close();
	//conn1.close();
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
		ee.printStackTrace();
	}
}
%>

