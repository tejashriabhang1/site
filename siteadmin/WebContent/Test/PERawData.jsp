<%@ include file="headerhtml.jsp" %>

<%!
Connection c,conn;
Statement st, st1,stGps,st2;
String sql, unitid,thedate,thedate1,thedate2,sqlProcessed;
int limit;
%>
<%
try{
	Class.forName("org.gjt.mm.mysql.Driver");
	c= DriverManager.getConnection("jdbc:mysql://173.234.153.82/db_rawData","fleetview","1@flv");
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
//	st=c.createStatement();
	st1=c.createStatement();
	st2=c.createStatement();
	stGps=conn.createStatement();
	%>
	
<%@page import="java.util.Date,
 java.util.regex.Matcher,
 java.util.regex.Pattern
"%>
<table border="0" width="100%" align="center" class="sortable">
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
<input type="radio" name="limit" value="All" > All
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
		System.out.println("VALUE of unitid"+unitid);
		thedate=request.getParameter("data");
		System.out.println("VALUE OF THEDATE"+thedate);
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		Date date1=new SimpleDateFormat("yyyy-MM-dd").parse(thedate1);
		Date change= new SimpleDateFormat("yyyy-MM-dd").parse("2010-03-02");
		
		long startdate=date1.getTime();
		long changedate=change.getTime();
		long diff=startdate-changedate;
		thedate2=thedate1.replace("-","_");
		String imei="";
		
		
		String lim1=request.getParameter("limit");
		System.out.println("VALUES OF LIMIT"+lim1);
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
		<div align="right"><a href="excelcheckunitdata.jsp?data=<%=thedate %>&unitid=<%=unitid %>&limit=<%=limit %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
		</tr>
		
		<%
		
		sql="select   * from t_onlinedata where VehicleCode in( select VehicleCode from  t_vehicledetails where unitid='"+unitid+"' ) ";
		System.out.println("sql==>"+sql);
		ResultSet rst1=stGps.executeQuery(sql);
		if(rst1.next())
		{
			%>
		<tr >
		<td colspan="8" class="hed" align="center">The current location of unit <%=unitid %> is  <B><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate"))+" "+rst1.getString("TheTime") +"   "+rst1.getString("Location")%></B></td>
		</tr>
			<%
		}else{
			%>
			<tr >
			<td colspan="8" class="hed" align="center"> Not Configured <B></B></td>
			</tr>
				<%
		}
		
		sql="Select * from t_imeidetails where unitid="+unitid;
		//sql="Select * from t_vehicledetails where unitid="+unitid;
		
		
		ResultSet rsDet= stGps.executeQuery(sql);
		System.out.println("sql==>"+sql);
		if(rsDet.next())
		{
			imei=rsDet.getString("imei");
		}
		else
		{
			//imei=unitid;
			String sqlimeinew = "select * from db_gps.t_unitmaster where unitid='" + unitid + "'";
      	  ResultSet rsunitsqlimei = st2.executeQuery(sqlimeinew);
      	  if (rsunitsqlimei.next()) {
      		  imei=rsunitsqlimei.getString("WMSN");
      	  }
      	  else
      	  {
      		imei=unitid;
      	  }
		}
		System.out.println("imei==>"+imei);
		%>
		<tr>
		<td colspan="8">
		<table  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">Stored Time</td>
		<!-- <td class="hed" align="center">Stamp Date Time</td> -->
		<td class="hed" align="center">MailBody</td>
		<td class="hed" align="center">Status</td>
		</tr>
		<%
		//try typeunit from ftplastdump as per requirement of reshma maner
	//	String sqlUnitTyp = "select * from db_gps.t_unitmaster where unitid='"+unitid+"'";
		 
		//sqlProcessed="SELECT Body,status,storedtime FROM t_ipFM"+thedate2+"  where Unitid='"+imei+"'   order by storedtime desc "+limit;
		sqlProcessed="SELECT Body,status,storedtime FROM t_PE"+thedate2+" where Unitid='"+imei+"'  group by storedtime   order by storedtime desc "+limit;


		System.out.println("sqlProcessed"+sqlProcessed);
		ResultSet rst=st1.executeQuery(sqlProcessed);
		int i=1;
		if(rst.next())
		{
			rst.previous();
		
			while(rst.next())
			{
				/* String regEx = "Timestamp="+"(.*)]";
				Pattern pattern = Pattern.compile(regEx);
				Matcher matcher = pattern.matcher(rst.getString("Body"));
				matcher.find();
				String DateTime = matcher.group(1);

				int a=DateTime.indexOf("]");
				DateTime=DateTime.substring(0,a);
				java.util.Date dt =new java.util.Date();
				dt.setTime(Long.parseLong(DateTime));
				String recordDate=new SimpleDateFormat("yyyy-MM-dd").format(dt);
				String recordTime=new SimpleDateFormat("HH:mm:ss").format(dt);
				System.out.println("Value of stroedtime"+rst.getTime("StoredTime"));
				System.out.println("Value of recorddate"+recordDate);
				System.out.println("Value of recordtime"+recordTime);
				System.out.println("Value of stroedtime"+rst.getTime("StoredTime")); */
				
			%>
				<tr>
				<td  align="center"><%=i %></td>
				<td  align="center"><%=rst.getTime("StoredTime") %></td>
				<%-- <td  align="center"><%=recordDate+" "+recordTime %></td> --%>
				<td  align="left"><%=rst.getString("Body") %></td>
				<td  align="center"><%=rst.getString("Status") %></td>
				</tr>
			<%
			i++;
			}
			 
			
		}else
		{
			sqlProcessed="SELECT Body,status,storedtime FROM t_PE"+thedate2+"   group by storedtime   order by storedtime desc limit 100";
			System.out.println("sqlProcessed"+sqlProcessed);
			ResultSet rs=st2.executeQuery(sqlProcessed);
			int i1=1;
		while(rs.next())
		{
			
			
		%>
			<tr>
			<td  align="center"><%=i1 %></td>
			<td  align="center"><%=rs.getTime("StoredTime") %></td>
			<%-- <td  align="center"><%=recordDate+" "+recordTime %></td> --%>
			<td  align="left"><%=rs.getString("Body") %></td>
			<td  align="center"><%=rs.getString("Status") %></td>
			</tr>
		<%
		i1++;
		}
		}
		%>
		
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
	System.out.println("Exceptions ----->"+e);
}
finally
{
	try{
	c.close();
	conn.close();
	}catch(Exception ee)
	{
		System.out.println("Exception-->"+ee);
	}
}
%>
