<%@ include file="headerhtml.jsp" %>
<%@page import="java.util.Date"%>
<%!

Statement st, st1,st2;
int limit;
Connection conn;
%>

<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
System.out.println("the connection string is :- "+MM_dbConn_STRING+" MM_dbConn_USERNAME"+MM_dbConn_USERNAME);

ResultSet rst1=null,rst2=null,rst3=null,rst4=null;
String sql = "",sql1 = "",unitid = "",vehregno = "",transporter = "",Defaultdate = "",DefaultTime = "",reason = "",stamp1 = "",stamp = "",thedate = "",thedate1 = "";

int count=0;
try{
	st=conn.createStatement();
	st1=conn.createStatement();
	st2 = conn.createStatement();
	thedate=request.getParameter("data");
	thedate1=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate));
	//thedate2 = request.getParameter("data1");
//	thedate3=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(thedate2));
	stamp = request.getParameter("stamp");
	unitid = request.getParameter("unitid");
	
	String reason_selected = request.getParameter("reason");
	
	System.out.println("the selected reason is XXX:- "+reason_selected);
	
	if((reason_selected == null) || (reason_selected.equalsIgnoreCase("null")))
	{
		reason_selected="ALL";
	}
	
	System.out.println("the selected reason is YYY:- "+reason_selected);
	
	%>
	
	<form name="unitform" action="" method="get" >
		<table border="0" width="100%" align="center">
			<tr bgcolor="#2696B8">
			<th  class="hed" bgcolor="#2696B8" align="center"><font color="white" size="2"><b>MIS Level 1 Report  of Rejected <%if(stamp.equalsIgnoreCase("stamp")){%> stamps<%}else {%> <%=stamp %>  stamps<%} %> for date <%=thedate1 %></b></font>
			</th>
			</tr>
			<tr>
		<td  class="hed" align="center">
		<div align="right">
		<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date()) %>
		<a href="excelMISLevel2.jsp?data=<%=thedate%>&unitid=<%=unitid %>&stamp=<%=stamp%>&reason=<%=reason_selected%>"  title="Export to Excel">
		<img src="../images/excel.jpg" width="15px" height="15px" style="border-style: none"></a>
		
		</div> 
		</td>
		</table>
		<div align="left">
		<table>
		<tr>
		<td>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<b>Reason:</b> 
		<select style="width: 300px; font: normal 11px Arial, Helvetica, sans-serif; color: #000000; border-color: activeborder;" name="reason" id="reason" size="1"  value="<%=reason_selected%>">
<!--		<option value="ALL" selected="selected">All</option>-->
		<option value="<%=reason_selected%>" selected="selected"><%=reason_selected%></option>
		<option value="ALL">All</option>
		<% 
		
			String str_cnt= "select distinct(reason) as Reason from  db_gps.t_osrejected order by reason";
			if(stamp.equalsIgnoreCase("stamp"))
			{
				str_cnt = "select distinct(problem) as Reason from db_gps.t_invaliddata order by reason";
				System.out.println("inside if of select box and stamp=stamp");
			}
		
		
				int count1 =0;
				ResultSet rst = st2.executeQuery(str_cnt);
		 			
			while(rst.next())
			{
		 	count1++;
		 	%>
			<option value="<%=rst.getString("Reason")%>" selected="selected"><%=rst.getString("Reason")%></option>
	  <%}
	
		System.out.println("the count 1 is :- "+count1);
	%>	
	</select>
	</td>
	<td>
	<input type="hidden" name="unitid" id="unitid" value="<%=unitid%>"></input>
	<input type="hidden" name="data" id="data" value="<%=thedate%>"></input>
	<input type="hidden" name="stamp" id="stamp" value="<%=stamp%>"></input>
	<input type="submit" name="submit" value="submit" class="stats">
	
	</td>
	</tr>
	</table>
	</div>
	
	</form>	
	
	
	<% 
	
		
		
		System.out.println("the stamp is :- "+stamp);
	
	%>
		
	<% 
		if((reason_selected!=null) && (!(reason_selected.equals("null"))) && (!(reason_selected.equalsIgnoreCase("all"))) )
		{ 
			System.out.println("inside the if statement ");
		
		 %>
		
		
		<table  border="0"  class="sortable" align="center" width="100%">
		<tr>
		<%
		if(stamp.equalsIgnoreCase("stamp"))
		{
		%>
		 	<td class="hed" align="center" style="width: 5px;">Sr.No.</td>
			<td class="hed" align="center" style="width: 40px;">UnitID</td>
			<td class="hed" align="center" style="width: 70px;">VehRegNo</td>
			<td class="hed" align="center" style="width: 40px;">Date </td>
			<td class="hed" align="center" style="width: 40px;">Time </td>
			<td class="hed" align="center" style="width: 150px;">Transporter</td>
			<td class="hed" align="center" style="width: 200px;">Stamp</td>
			<td class="hed" align="center" style="width: 150px;">Reason</td>
		
		<%
		}
		else
		{
			%>
		<td class="hed" align="center" style="width: 3px;">Sr.No.</td>
		<td class="hed" align="center" style="width: 30px;">UnitID</td>
		<td class="hed" align="center" style="width: 70px;">VehRegNo</td>
		<td class="hed" align="center" style="width: 30px;">Date </td>
		<td class="hed" align="center" style="width: 30px;">Time </td>
		<td class="hed" align="center" style="width: 150px;">Transporter</td>
		<td class="hed" align="center" style="width: 30px;">Stamp</td>
		<td class="hed" align="center" style="width: 150px;">Reason</td>
		<td class="hed" align="center" style="width: 30px;"><%if(stamp.equalsIgnoreCase("AC") || stamp.equalsIgnoreCase("DC")){%>From Speed<%}else{%>Speed<%} %></td>
		<td class="hed" align="center" style="width: 30px;"><%if(stamp.equalsIgnoreCase("AC") || stamp.equalsIgnoreCase("DC")){%>To Speed<%}else if(stamp.equalsIgnoreCase("OS")){%>Duration<%}else{%>Distance<%}%></td>
		<td class="hed" align="center" style="width: 30px;">Latitude</td>
		<td class="hed" align="center" style="width: 30px;">Longitude</td>
		<%
		if(stamp.equalsIgnoreCase("OS"))
		{
			%>
			<td class="hed" align="center" style="width: 30px;">RouteID</td>
			<td class="hed" align="center" style="width: 30px;">Zone</td>
			<%
		}
		%>
		<td class="hed" align="center" style="width: 50px;">Program</td>
			<%
		}
		%>
		</tr>
		<%
		if(stamp.equalsIgnoreCase("AC"))
		{
			sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('AC1','AC1D','ACDuplicate')  and unitid = '"+unitid+"' and reason like '%"+reason_selected+"%' order by TheDatetime";
		}
		else
		if(stamp.equalsIgnoreCase("DC"))
		{
			sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('DC1','DC1D','DCDuplicate') and unitid = '"+unitid+"' and reason like '%"+reason_selected+"%' order by TheDatetime ";
		}
		else
			if(stamp.equalsIgnoreCase("OS"))
			{
				sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('OS3','OS3D','OSDuplicate','OSIgnore') and unitid = '"+unitid+"' and reason like '%"+reason_selected+"%' order by TheDatetime";
			}
			else
				if(stamp.equalsIgnoreCase("SI"))
				{
					sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('SI1') and unitid = '"+unitid+"' and reason like '%"+reason_selected+"%' order by TheDatetime ";
				}
				else
					if(stamp.equalsIgnoreCase("stamp"))
					{
						sql = "select * from db_gps.t_invaliddata where storeddate = '"+thedate+"'   and unitid = '"+unitid+"' and problem like '%"+reason_selected+"%' order by storeddate,storedtime ";
					}
		System.out.println("the sql is :- "+sql);
		ResultSet rs = st.executeQuery(sql);
		while(rs.next())
		{
			count++;
			if(stamp.equalsIgnoreCase("stamp"))
			{
				 sql1 = "select * from db_gps.t_vehicledetails where unitid = '"+rs.getString("unitid")+"' ";
				ResultSet rs1 = st1.executeQuery(sql1);
				if(rs1.next())
				{
					unitid = rs.getString("unitid");
					vehregno = rs1.getString("vehicleregnumber");
					Defaultdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("storeddate")))  ;
					DefaultTime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("storedTime")))  ;
					transporter = rs1.getString("OwnerName");
					reason = rs.getString("Problem");
					stamp1 = rs.getString("Stamp");
				}
				else
				{
					unitid = rs.getString("unitid");
					vehregno = "-";
					Defaultdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("storeddate")))  ;
					DefaultTime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("storedTime")))  ;
					transporter ="-";
					reason = rs.getString("Problem");
					stamp1 = rs.getString("Stamp");
				}
				
				%>
				<tr>
				<td class="bodyText" align="right" ><div align="right"><%=count %></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=unitid%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=vehregno%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=Defaultdate%></div></td>
				<td class="bodyText" align="right" "><div align="right"><%=DefaultTime%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=transporter%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=stamp1%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=reason%></div></td>
				</tr>
				<%
			}
			else
			{
				unitid = rs.getString("unitid");
				vehregno = rs.getString("VehRegNo");
				Defaultdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TheDatetime")))  ;
				DefaultTime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TheDatetime")))  ;
				transporter = rs.getString("Transporter");
				reason = rs.getString("Reason");
				reason = reason.replace("<overSpeedDurationInSecs"," Less Than overSpeedDurationInSecs");
				stamp1 = rs.getString("Stamp");
			//	System.out.println("reason  "+reason);
				
				%>
				<tr>
				<td class="bodyText" align="right" ><div align="right"><%=count %></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=unitid%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=vehregno%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=Defaultdate%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=DefaultTime%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=transporter%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=stamp1%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=reason%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Speed")%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Duration")%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Latitude")%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Longitude")%></div></td>
				<%
				if(stamp.equalsIgnoreCase("OS"))
				{
					%>
					<td class="bodyText" align="right" ><div align="right"><%=rs.getString("RouteID")%></div></td>
					<td class="bodyText" align="left" ><div align="left"><%=rs.getString("Zone")%></div></td>
					<%
				}
				%>
				<td class="bodyText" align="left" ><div align="left"><%=rs.getString("ProgramName")%></div></td>
				</tr>
				<%
			}
			
			
		}
		%>
		
		</table>
<!--		</td>-->
<!--		</tr>-->
<!--		</table>-->
<!--		</form>-->
			
			
		
		
		
		
		
		
		
	  
	  
	  
	  
	  
	  
	  
	  <%}
		else
		{ %>
			
		
		<table  border="0"  class="sortable" align="center" width="100%">
		<tr>
		<%
		if(stamp.equalsIgnoreCase("stamp"))
		{
		%>
		 	<td class="hed" align="center" style="width: 5px;">Sr.No.</td>
			<td class="hed" align="center" style="width: 40px;">UnitID</td>
			<td class="hed" align="center" style="width: 70px;">VehRegNo</td>
			<td class="hed" align="center" style="width: 40px;">Date </td>
			<td class="hed" align="center" style="width: 40px;">Time </td>
			<td class="hed" align="center" style="width: 150px;">Transporter</td>
			<td class="hed" align="center" style="width: 200px;">Stamp</td>
			<td class="hed" align="center" style="width: 150px;">Reason</td>
		
		<%
		}
		else
		{
			%>
		<td class="hed" align="center" style="width: 3px;">Sr.No.</td>
		<td class="hed" align="center" style="width: 30px;">UnitID</td>
		<td class="hed" align="center" style="width: 70px;">VehRegNo</td>
		<td class="hed" align="center" style="width: 30px;">Date </td>
		<td class="hed" align="center" style="width: 30px;">Time </td>
		<td class="hed" align="center" style="width: 150px;">Transporter</td>
		<td class="hed" align="center" style="width: 30px;">Stamp</td>
		<td class="hed" align="center" style="width: 150px;">Reason</td>
		<td class="hed" align="center" style="width: 30px;"><%if(stamp.equalsIgnoreCase("AC") || stamp.equalsIgnoreCase("DC")){%>From Speed<%}else{%>Speed<%} %></td>
		<td class="hed" align="center" style="width: 30px;"><%if(stamp.equalsIgnoreCase("AC") || stamp.equalsIgnoreCase("DC")){%>To Speed<%}else if(stamp.equalsIgnoreCase("OS")){%>Duration<%}else{%>Distance<%}%></td>
		<td class="hed" align="center" style="width: 30px;">Latitude</td>
		<td class="hed" align="center" style="width: 30px;">Longitude</td>
		<%
		if(stamp.equalsIgnoreCase("OS"))
		{
			%>
			<td class="hed" align="center" style="width: 30px;">RouteID</td>
			<td class="hed" align="center" style="width: 30px;">Zone</td>
			<%
		}
		%>
		<td class="hed" align="center" style="width: 50px;">Program</td>
			<%
		}
		%>
		</tr>
		<%
		if(stamp.equalsIgnoreCase("AC"))
		{
			sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('AC1','AC1D','ACDuplicate')  and unitid = '"+unitid+"' order by TheDatetime";
		}
		else
		if(stamp.equalsIgnoreCase("DC"))
		{
			sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('DC1','DC1D','DCDuplicate') and unitid = '"+unitid+"' order by TheDatetime ";
		}
		else
			if(stamp.equalsIgnoreCase("OS"))
			{
				sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('OS3','OS3D','OSDuplicate','OSIgnore') and unitid = '"+unitid+"' order by TheDatetime";
			}
			else
				if(stamp.equalsIgnoreCase("SI"))
				{
					sql = "select * from db_gps.t_osrejected where TheDatetime >= '"+thedate+" 00:00:00'  and  TheDatetime <='"+thedate+" 23:59:59'  and stamp in ('SI1') and unitid = '"+unitid+"' order by TheDatetime ";
				}
				else
					if(stamp.equalsIgnoreCase("stamp"))
					{
						sql = "select * from db_gps.t_invaliddata where storeddate = '"+thedate+"'   and unitid = '"+unitid+"' order by storeddate,storedtime ";
					}
		System.out.println("the sql is :- "+sql);
		ResultSet rs = st.executeQuery(sql);
		while(rs.next())
		{
			count++;
			if(stamp.equalsIgnoreCase("stamp"))
			{
				 sql1 = "select * from db_gps.t_vehicledetails where unitid = '"+rs.getString("unitid")+"' ";
				ResultSet rs1 = st1.executeQuery(sql1);
				if(rs1.next())
				{
					unitid = rs.getString("unitid");
					vehregno = rs1.getString("vehicleregnumber");
					Defaultdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("storeddate")))  ;
					DefaultTime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("storedTime")))  ;
					transporter = rs1.getString("OwnerName");
					reason = rs.getString("Problem");
					stamp1 = rs.getString("Stamp");
				}
				else
				{
					unitid = rs.getString("unitid");
					vehregno = "-";
					Defaultdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("storeddate")))  ;
					DefaultTime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("HH:mm:ss").parse(rs.getString("storedTime")))  ;
					transporter ="-";
					reason = rs.getString("Problem");
					stamp1 = rs.getString("Stamp");
				}
				
				%>
				<tr>
				<td class="bodyText" align="right" ><div align="right"><%=count %></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=unitid%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=vehregno%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=Defaultdate%></div></td>
				<td class="bodyText" align="right" "><div align="right"><%=DefaultTime%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=transporter%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=stamp1%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=reason%></div></td>
				</tr>
				<%
			}
			else
			{
				unitid = rs.getString("unitid");
				vehregno = rs.getString("VehRegNo");
				Defaultdate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TheDatetime")))  ;
				DefaultTime = new SimpleDateFormat("HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString("TheDatetime")))  ;
				transporter = rs.getString("Transporter");
				reason = rs.getString("Reason");
				reason = reason.replace("<overSpeedDurationInSecs"," Less Than overSpeedDurationInSecs");
				stamp1 = rs.getString("Stamp");
			//	System.out.println("reason  "+reason);
				
				%>
				<tr>
				<td class="bodyText" align="right" ><div align="right"><%=count %></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=unitid%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=vehregno%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=Defaultdate%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=DefaultTime%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=transporter%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=stamp1%></div></td>
				<td class="bodyText" align="left" ><div align="left"><%=reason%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Speed")%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Duration")%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Latitude")%></div></td>
				<td class="bodyText" align="right" ><div align="right"><%=rs.getString("Longitude")%></div></td>
				<%
				if(stamp.equalsIgnoreCase("OS"))
				{
					%>
					<td class="bodyText" align="right" ><div align="right"><%=rs.getString("RouteID")%></div></td>
					<td class="bodyText" align="left" ><div align="left"><%=rs.getString("Zone")%></div></td>
					<%
				}
				%>
				<td class="bodyText" align="left" ><div align="left"><%=rs.getString("ProgramName")%></div></td>
				</tr>
				<%
			}
			
			
		}
		%>
		
		</table>
<!--		</td>-->
<!--		</tr>-->
<!--		</table>-->
<!--		</form>-->
		
	<%
	}
}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
}
finally
{
	try{
	conn.close();

	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>
	<%@ include file="footerhtml.jsp" %>