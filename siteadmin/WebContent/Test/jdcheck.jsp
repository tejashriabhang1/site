<%@ include file="headerhtml.jsp" %> 
<html>
<head>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script> 


  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
 <!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- Export Options Links of DataTables -->

<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script> 
<script src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>
 
<script type="text/javascript">
 $(document).ready(function() {
	    $('#example').DataTable( {
	    	"pagingType": "full_numbers",
	    	
	        dom: 'Blfrtip',
	        
	        buttons: [
	        	
	        	{
	        		extend: 'collection',
	        		
	        		text: 'Export',
	        		buttons: [
	        			{
	                        extend: 'excel',
	                        title: 'CheckJD', 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'CheckJD', 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'CheckJD', 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'CheckJD', 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'CheckJD', 
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	     
	    
	    
	    
	    	
	    } );
	} );

</script>
<script type="text/javascript">
function validate()
{ 
	try
	{
	if(document.getElementById("data").value=="") 
	{
		alert("Please Select The from date.");
		return false;
	}
	if(document.getElementById("data1").value =="")
  	{
		alert("please select To Date");
		return false;
  	}  		

	if(document.getElementById("unitid").value=="") 
	{
		alert("Please Enter the Unit ID.");
		return false;
	}
	
	
	return datevalidate();
	return true;
	}
	catch(e)
	{
		alert(e);
	}
}
</script>
</head>
<%!

Statement st, st1;
int limit;
Connection conn;
%>
<%
ResultSet rst1=null,rst2=null,rst3=null,rst4=null;
String sql="", unitid="",thedate="",thedate1="",thedate2="",thedate3="",thedate4="" ,vehcode="",OwnerName="",VehicleRegNumber="",defaultDate="",defaultDate1="",calstatus="";

int count=0;
try{
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=conn.createStatement();
	st1=conn.createStatement();
	defaultDate= new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	if(!(null==request.getQueryString()))
	{
		defaultDate=request.getParameter("data");
	}
	
	defaultDate1= new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
	if(!(null==request.getQueryString()))
	{
		defaultDate1=request.getParameter("data2");
	}
	%>
	
<%@page import="java.util.Date"%><table border="0" width="100%" align="center" class="sortable">
	<form name="jdcheck" action="" method="get">
	<tr><td colspan="8" align="center" class="sorttable_nosort"><b>Please select the date and enter the Unit id to check its JD stamp data.</b> </td></tr>
	<tr>
	<td bgcolor="#F5F5F5">
	<input type="text" id="data" name="data" value="<%=defaultDate %>"  size="12" readonly/>
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
	
	<td bgcolor="#F5F5F5">
	<input type="text" id="data2" name="data2" value="<%=defaultDate1 %>"  size="12" readonly/>
	</td><td bgcolor="#F5F5F5">
  	<input type="button" name="The Date1" value="To Date" id="trigger1">
	<script type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "data2",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger1"       // ID of the button
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
	<input type="radio" name="limit" value="All" > ALl
	</td>
	<td bgcolor="#F5F5F5">
	<input type="submit" name="submit" value="submit" class="stats">
	</td>
	</tr>
	</form>
	<tr>
	<td colspan="13">
	<%
	if(!(null==request.getQueryString()))
	{
		unitid=request.getParameter("unitid");
		thedate=request.getParameter("data");
		thedate1=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate));
		thedate4=request.getParameter("data2");
		thedate3=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(thedate4));
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
		<th colspan="16" class="hed" bgcolor="#2696B8" align="center"><font color="white" size="1"><b>The Data of unit <%=unitid %> on <%=thedate %></b></font>
<%-- 		<div align="right"><a href="excelcheckprocessedunitdata.jsp?data=<%=thedate %>&unitid=<%=unitid %>&limit=<%=limit %>"  title="Export to Excel"><img src="../images/excel.jpg" width="15px" height="15px"></a></div> </th>
 --%>		</tr>
		
		<%
		boolean flag=false;
		sql="select * from t_vehicledetails where Unitid='"+unitid+"'";
		rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			flag=true;
			vehcode=rst1.getString("VehicleCode");
			OwnerName=rst1.getString("OwnerName");
			VehicleRegNumber=rst1.getString("VehicleRegNumber");
			sql="Select count(*) from t_fuelleveldata1 where vehregno like '"+VehicleRegNumber+"'";//checking if calibrated
			rst2=st1.executeQuery(sql);
			if(rst2.next())
			{
				calstatus = "Calibrated";
				count=rst2.getInt(1);
			}
			else
			{
				calstatus = "Not Calibrated";
			}
			%>
			<tr>
			<td colspan="16" class="hed" align="center">
			<table width="100%">
			<tr>
			<td class="hed" colspan="4" align="center">Vehicle No</td>
			<td class="hed" colspan="4" align="center">Vehicle Code</td>
			<td class="hed" colspan="4" align="center">Transporter</td>
			<td class="hed" colspan="3" align="center">Calibrated</td>
			</tr>
			<tr>
			<td colspan="4"><%=VehicleRegNumber %></td>
			<td colspan="4"><%=vehcode %></td>
			<td colspan="4"><%=OwnerName %></td>
			<td colspan="3"><%=calstatus %></td>
			</tr>
			</table>
			</td>
			</tr>
		<%}
		else
		{%>
		<tr>
			<td colspan="16" class="hed" align="center">
			<table width="100%">
			<tr>
			<td class="hed" colspan="4" align="center">Vehicle No</td>
			<td class="hed" colspan="4" align="center">Vehicle Code</td>
			<td class="hed" colspan="4" align="center">Transporter</td>
			<td class="hed" colspan="3" align="center">Calibrated</td>
			</tr>
			<tr>
			<td colspan="4">NA</td>
			<td colspan="4">NA</td>
			<td colspan="4">NA</td>
			<td colspan="3">NA</td>
			</tr>
			</table>
			</td>
			</tr>
		<%	
		}
		%>
		
		<tr>
		<td colspan="16">
		<table id="example"  border="0" width="100%" class="sortable" >
		<tr bgcolor="red" height="20">
		<td class="hed" align="center">Sr.</td>
		<td class="hed" align="center">StoredTime</td>
		<td class="hed" align="center">Stamp</td>
		<td class="hed" align="center">Location </td>
		<td class="hed" align="center">Speed</td>
		<td class="hed" align="center">Data Valid</td>
		<td class="hed" align="center">Fuel Level</td>
		<td class="hed" align="center">Distance</td>
		<td class="hed" align="center">Unit Distance</td>
		<td class="hed" align="center">Latitude</td>
		<td class="hed" align="center">Longitude</td>
		<td class="hed" align="center">Sen 1</td>
		<td class="hed" align="center">Sen 2</td>
		<td class="hed" align="center">Sen 3</td>
		<td class="hed" align="center">Calibration Ltr. Value</td>
		<td class="hed" align="center">Calibration Ltr. Default Value</td>
		</tr>
		<%
		System.out.print("hello world");
		if(flag)
		{
			sql="select * from t_veh"+vehcode+" where TheFieldDataDate>='"+thedate1+"' and TheFieldDataDate<='"+thedate3+"' and TheFiledTextFileName='JD' order by TheFieldDataTime desc "+limit;
		//	out.println(sql);
		}
		else
		{
			sql="select * from t_veh0 where TheFieldDataDate>='"+thedate1+"' and TheFieldDataDate<='"+thedate3+"' and TheFiledTextFileName='JD' and unitid='"+unitid+"' order by TheFieldDataTime desc "+limit;
		//	out.println(sql);
		}
		ResultSet rst=st1.executeQuery(sql);
		System.out.println(sql);
		int i=1;
		while(rst.next())
		{
			String caliberationval="0",defaultCaliberationval="0"; 
			int sen3=0;
			try{
			
				sen3=rst.getInt("Sen3");
			
			}catch(Exception e){ sen3=0;}
			if(calstatus.equalsIgnoreCase("Calibrated"))
			{
				if(sen3==0)
				{
					caliberationval="0";
					defaultCaliberationval="0";
				}
				else if(count<=20 && count>0)
				{
					sql="select Ltr from t_fuelleveldatanew where vehregno= 'Default' and voltage <='"+sen3+"' order by voltage desc limit 1";
					System.out.println(sql);
					rst3=st.executeQuery(sql);
					if(rst3.next())
					{
						defaultCaliberationval=rst3.getString("Ltr");
					}
					
					sql="select Ltr from t_fuelleveldatanew where vehregno= '"+VehicleRegNumber+"' and voltage <='"+sen3+"' order by voltage desc limit 1";
					System.out.println(sql);
					rst3=st.executeQuery(sql);
					if(rst3.next())
					{
						caliberationval=rst3.getString("Ltr");
					}
				}
				else
				{
					defaultCaliberationval="0";
					sql="select Ltr from t_fuelleveldatanew where vehregno= '"+VehicleRegNumber+"' and voltage <='"+sen3+"' order by voltage desc limit 1";
					System.out.println(sql);
					rst3=st.executeQuery(sql);
					if(rst3.next())
					{
						caliberationval=rst3.getString("Ltr");
					}
				}
			}
			else
			{
				caliberationval="N/A";
				defaultCaliberationval="N/A";
			}
			
		%>
			<tr>
			<td class="bodyText" align="center"><%=i %></td>
			<td class="bodyText" align="center"><%=rst.getTime("TheFieldDataTime") %></td>
			<td class="bodyText" align="left"><%=rst.getString("TheFiledTextFileName") %></td>
			<td class="bodyText" align="right"><%=rst.getString("TheFieldSubject") %></td>
			<td class="bodyText" align="left"><%=rst.getString("Speed") %></td>
			<td class="bodyText" align="left"><%=rst.getString("DataValid") %></td>
			<td class="bodyText" align="left"><%=rst.getString("FuelLevel") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Distance") %></td>
			<td class="bodyText" align="center"><%=rst.getString("CDistance") %></td>
			<td class="bodyText" align="center"><%=rst.getString("LatinDec") %></td>
			<td class="bodyText" align="center"><%=rst.getString("LonginDec") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Sen1") %></td>
			<td class="bodyText" align="center"><%=rst.getString("Sen2") %></td>
			<td class="bodyText" align="center"><%=sen3 %></td>
			<td class="bodyText" align="center"><%=caliberationval %></td>
			<td class="bodyText" align="center"><%=defaultCaliberationval %></td>
			</tr>
		<%
		i++;
		}
		%>
		  </table>
		  </td>
		  </tr>
		  </table>
		<%
	}%>
	</td>
	</tr>
	</table>
	<%
	
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
</body>
</html>
<%@ include file="footerhtml.jsp" %>