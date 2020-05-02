<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
 <%@ include file="headerhtml.jsp" %>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<html>
<head>
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
	                        title: 'Attendance Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Set Default Parameter', 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Set Default Parameter', 
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Set Default Parameter', 
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Set Default Parameter', 
	                    },
	                    
	            				/* 'copy', 'csv', 'excel', 'pdf', 'print' */
	            			]
	        	}
	        ],
	        lengthMenu: [[-1, 10, 25, 50, 100], ["All", 10, 25, 50, 100 ]],
	        
	     
	    
	    
	    
	    	
	    } );
	} );

</script>


</head>
<body>

<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">  
<thead>


<tr>

<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;">SrNo</th>
<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;">Transporter</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">OS Limit</th>

<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">OS Dur.</th>
<th style="font-size: 12px ; background: #1582AB;  color:white; face:san-serif;">RA</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">RD</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">ND From</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">ND To</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Stop Time</th>

<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">CD</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Device Dis.</th>
 
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Action </th>
<%
Statement st,st1;
String sql;
Connection conn;

%>
<%
String MM_dbConn_DRIVER="org.gjt.mm.mysql.Driver";


Class.forName(MM_dbConn_DRIVER);
 String MM_dbConn_STRING="jdbc:mysql://10.0.10.62/db_gps";
String MM_dbConn_USERNAME="site";
String MM_dbConn_PASSWORD="s2te"; 

conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
try{
	st=conn.createStatement();
	st1=conn.createStatement();
	sql="select Distinct(TypeValue) from t_security where TypeOfUser in ('Transporter','Group') order by TypeValue";
	ResultSet rsttrans=st.executeQuery(sql);
	int i=1;
	while(rsttrans.next())
	{
	%>
	<tr>
 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rsttrans.getString("TypeValue")%></td>
	
	
	<%
		sql="select * from t_defaultvals where OwnerName='"+rsttrans.getString("TypeValue")+"'";
		ResultSet rst1=st1.executeQuery(sql);
		if(rst1.next())
		{	
	%>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("overspeedlimit")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("overspeeddurationinsecs")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("accelerationspeedvarlimit")%></td>
	 
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("decelerationspeedvarlimit")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("nightdrivingfromtime")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("nightdrivingtotime")%>/td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("stoppagesgreaterthaninmins")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("continuousrunhrslimit")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("disconnectedperiod")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><a href="javascript: flase" title="click to edit values" onclick="window.open('editdefaultvals.jsp?tran=<%=rsttrans.getString("TypeValue")%>','win1','width=500,height=400,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')"><img src="../images/edit1.jpg" border="0"></a></td></td>
	

	<%
	}
	else
	{
		sql="select * from t_defaultvals where OwnerName='Default'";
		ResultSet rst2=st1.executeQuery(sql);
		if(rst2.next())
		{
		%>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("overspeedlimit")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("overspeeddurationinsecs")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("accelerationspeedvarlimit")%></td>
	 
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("decelerationspeedvarlimit")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("nightdrivingfromtime")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("nightdrivingtotime")%>/td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("stoppagesgreaterthaninmins")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("continuousrunhrslimit")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><%=rst1.getString("disconnectedperiod")%></td>
	 <td style="font-size: 11px; face:san-serif; color:black" align="right"><a href="javascript: flase" title="click to edit values" onclick="window.open('editdefaultvals.jsp?tran=<%=rsttrans.getString("TypeValue")%>','win1','width=500,height=400,location=0,menubar=0,scrollbars=0,status=0,toolbar=0,resizable=0')"><img src="../images/edit1.jpg" border="0"></a></td></td>
	
	 <%
		}
	}	
	%>
	</tr>
	<%
	i++;
	}
}catch(Exception e)
{	
	out.print("Exception----->"+e);
}finally{
	conn.close();
}
%>
</table>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>



