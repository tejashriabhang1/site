<%@ include file="headerhtml.jsp"%>
<html>
<head>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- Export Options Links of DataTables -->

<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/1.5.1/css/buttons.dataTables.min.css">
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.flash.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script
	src=" https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script>
<script
	src=" https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js "></script>

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
	                        title: 'smtpunitdata', 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize : 'A0',
	                        title: 'smtpunitdata', 
	                    },	
	                    {
	                        extend: 'csv',
	                        title: 'smtpunitdata', 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'smtpunitdata', 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'smtpunitdata', 
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	     
	    
	    
	    
	    	
	    } );
	} );

</script>
<style>
.ScrollStyle
{
    max-height: 600px;
    overflow-y: scroll;
     width: 950px;
    overflow-x: scroll;
}
</style>
</head>
<body>
	<%!

Statement st, st1;
String sql, unitid,thedate,thedate1,thedate2;
int limit;
Connection conn,conn1;
%>
	<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try{
	st=conn.createStatement();
	st1=conn1.createStatement();
	%>

	<%@page import="java.util.Date"%>
	
	<table border="0"	width="100%" align="center" class="sortable">
		<form name="unitform" action="" method="get">
			<tr>
				<td colspan="8" align="center" class="sorttable_nosort"><b>Please
						select the date and enter the Unit id to check its data.</b></td>
			</tr>
			<tr>
				<td bgcolor="#F5F5F5"><input type="text" id="data" name="data"
					value="" size="12" readonly /></td>
				<td bgcolor="#F5F5F5"><input type="button" name="The Date"
					value="From Date" id="trigger"> <script
						type="text/javascript">
  	Calendar.setup(
    {
      inputField  : "data",         // ID of the input field
      ifFormat    : "%d-%b-%Y",     // the date format
      button      : "trigger"       // ID of the button
    }
  );
</script></td>
				<td bgcolor="#F5F5F5">Unit ID :</td>
				<td bgcolor="#F5F5F5"><input type="text" name="unitid"
					id="unitid" class="stats"></input></td>
				<td bgcolor="#F5F5F5">Limit :</td>
				<td bgcolor="#F5F5F5"><input type="radio" name="limit"
					value="xx" checked> <input type="text" name="lim"
					value="10" size="5" class="stats"> </input><br> <input
					type="radio" name="limit" value="All"> ALl</td>
				<td bgcolor="#F5F5F5"><input type="submit" name="submit"
					value="submit" class="stats"></td>
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
						<th colspan="8" class="hed" bgcolor="#2696B8" align="center" style="padding-left:450px"><font
							color="white" size="1"><b>The Data of unit <%=unitid %>
									on <%=thedate %></b></font>
							<%-- <div align="right">
								<a
									href="excelsmtpunitdata.jsp?data=<%=thedate %>&unitid=<%=unitid %>&limit=<%=limit %>"
									title="Export to Excel"><img src="../images/excel.jpg"
									width="15px" height="15px"></a>
							</div> --%></th>
					</tr>

					<%
		
		sql="select * from allconnectedunits where unitid='"+unitid+"' order by concat(TheDate,TheTime) desc limit 1";
		ResultSet rst1=st.executeQuery(sql);
		if(rst1.next())
		{
			%>
					<tr>
						<td colspan="8" class="hed" align="center">The current
							location of unit <%=unitid %> is <B><%=new SimpleDateFormat("dd-MMM-yyyy").format(rst1.getDate("TheDate"))+" "+rst1.getString("TheTime") +"   "+rst1.getString("Location")%></B>
						</td>
					</tr>
					<%
		}
		%>
					<tr>
						<td colspan="8">
						<div class="ScrollStyle">
							<table id="example" border="0" width="100%" class="sortable">
								<tr bgcolor="red" height="20">
									<td class="hed" align="center">Sr.</td>
									<td class="hed" align="center">StoredTime</td>
									<td class="hed" align="center">StoredDate</td>
									<td class="hed" align="center">MailDate</td>
									<td class="hed" align="center">MailTime</td>
									<td class="hed" align="center">Vehicle No</td>
									<td class="hed" align="center">Vehicle Code</td>
									<td class="hed" align="center">Transporter</td>
									<td class="hed" align="center">MailBody</td>
									<td class="hed" align="center">Unprocessed Stamps</td>
									<td class="hed" align="center">Unit Type</td>
								</tr>
								<%
		
		
			sql="SELECT * FROM t_mails"+thedate2+"  where Unitid='"+unitid+"'  UNION select * from t_mails"+thedate2+"Processed where Unitid='"+unitid+"'  UNION select * from t_mails"+thedate2+"_bulk where Unitid='"+unitid+"' order by storedtime desc "+limit;
		
		System.out.println("sql is :- "+sql);
		
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
		%>
								<tr>
									<td align="center"><%=i %></td>
									<td align="center"><%=rst.getTime("StoredTime") %></td>
									<td align="center"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("StoredDate")))%></td>
									<td align="center"><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(rst.getString("MailDate"))) %></td>
									<td align="center"><%=rst.getTime("MailTime") %></td>
									<td align="left"><%=rst.getString("VehRegNo") %></td>
									<td align="right"><%=rst.getString("Vehid") %></td>
									<td align="left"><%=rst.getString("Transporter") %></td>
									<td align="left"><%=rst.getString("Body") %></td>
									<td align="left"><%=rst.getString("UnProcessedStamps") %></td>
									<td align="center"><%=rst.getString("MailFrom") %></td>
								</tr>
								</div>
								<%
		i++;
		}
		%>

							</table>
						</td>
					</tr>
				</table> <%
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
	conn1.close();
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>
	<%@ include file="footerhtml.jsp"%>
</body>
</html>
