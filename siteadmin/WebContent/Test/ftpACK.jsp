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
	                        title: 'FTPACKDATA', 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'FTPACKDATA', 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'FTPACKDATA', 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'FTPACKDATA', 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'FTPACKDATA', 
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
function SearchCrit(ind)
{ 
	if(ind=="1")
	{
		document.getElementById("unitid").disabled=true;
		document.getElementById("flag").value="flase";
	}
	else
	{
		document.getElementById("unitid").disabled=false;
		document.getElementById("flag").value="true";
 	}
}
</script>

</head>
<body>
<%!
Connection conn;
%>
<%
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement st1=null;
String sql=null,message=null;
int limit=0;
try{
	String fromdate="",todate="",thedate="",thedate1="";
	String fromdate1="",todate1="";
	st1=conn.createStatement();
	if(!(null==request.getParameter("data")))
	{
		fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data")));
		todate=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));	
	fromdate1=request.getParameter("data");
	todate1=request.getParameter("data1");
	message="The data from "+fromdate1+" to "+todate1;
	}
	else
	{
	fromdate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	todate=fromdate;
	fromdate1=new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	todate1=fromdate1;
	message="";	 
	//out.print(todate);
	}
	%>
	<table border="20" width="100%" align="center" class="sortable">
	<form name="unitform" action="" method="get">
	<tr><td colspan="8" align="center" class="sorttable_nosort"><b>Please select the search option to see the FTP data.</b> </td></tr>
	<tr>
	<td align="right">
			  <input type="text" id="data" name="data" value="<%=fromdate1 %>" size="15"  readonly/>
  			</td>
  			<td align="left">
				<input type="button" name="From Date" value="From Date" id="trigger"  >
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
			<td align="right">
			  	<input type="text" id="data1" name="data1"  value="<%=todate1 %>"   size="15" readonly/></td><td align="left">
  			  	<input type="button" name="To Date" value="To Date" id="trigger1"  >
				<script type="text/javascript">
  				Calendar.setup(
    			{
      			inputField  : "data1",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "trigger1"       // ID of the button
    			}
  				);
				</script>
			</td>
	<td bgcolor="#F5F5F5">
	<input type="submit" name="submit" value="submit" class="stats">
	</td>
	</tr>
	</form>
	

	<table border="2px" width="100%" bgcolor="blue" align="center">
							<tr>
								<td>
									<table border="0" width="100%">
										<tr>
											<td align="center"><font color="black" size="3">The
													Data From  <%=fromdate1%> to <%=todate1%></font></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>

      <table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">  
      <thead>
      <tr>

<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">SrNo</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Stored Date Time</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">File Date Time</th>

<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">File Name </th>
<th style="font-size: 12px ; background: #1582AB;  color:white; face:san-serif;">Unit ID</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">WMSN</th>
</tr>
</thead>
<tbody>

<%
		sql="select * from t_ftpacknowledge where StoredDateTime between '"+fromdate+" 00:00:00' and '"+todate+" 23:59:59' order by StoredDateTime desc";
		System.out.println(sql);
		ResultSet rst=st1.executeQuery(sql);
		int i=1;
		while(rst.next())
		{
		%>
			<tr>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right">
			<% 
			try{
			%>
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("StoredDateTime"))) %>
			<% }catch(Exception e){out.print("-");} %>
			</td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right">
			<% try{%>
			<%=new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rst.getString("Filedatetime"))) %>
			<% }catch(Exception e){out.print("-");} %>
			</td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst.getString("FileName") %></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst.getString("UnitID") %></td>
			<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst.getString("WMSN") %></td>
			
			
			</tr>
		<%
		i++;
		}
	
		%>
		
		 </tbody>
</table>
		 
	
	<%

}catch(Exception e)
{
	out.print("Exceptions ----->"+e);
}
finally
{
	try{
		try{
			conn.close();
			
			}catch(Exception ee)
			{
				
			}
	
	}catch(Exception ee)
	{
		out.print("Exception-->"+ee);
	}
}
%>

</body>
</html>
<%@ include file="footerhtml.jsp" %>