<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<%@ include file="headerhtml.jsp" %>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>
<%@page import="java.util.*" %>
<%@ page import="java.sql.PreparedStatement"  %>
    <%@ page import="java.sql.Connection" %>
    <%@ page import="java.sql.DriverManager" %>
    

<html> 
<head>    
<style>

</style>

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
	                        title: 'Active FleetView Users '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'pdf',
	                        orientation: 'landscape',
	                        pageSize: 'LEGAL',
	                        title: 'Active FleetView Users '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Active FleetView Users '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Active FleetView Users '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Active FleetView Users '+$("#data").val()+'-'+$("#data1").val(),
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
 function chk()
 {

 	
 	
 	var chkf="";
 	var chkt="";
 	var objFromDate = document.getElementById("data").value;
 	
 	
 	var fdate=objFromDate.split("-");
 	if(fdate[1]=="Jan")
 	{
 		chkf="01";
 	}
 	if(fdate[1]=="Feb")
 	{
 		chkf="02";
 	}
 	if(fdate[1]=="Mar")
 	{
 		chkf="03";
 	}
 	if(fdate[1]=="Apr")
 	{
 		chkf="04";
 	}
 	if(fdate[1]=="May")
 	{
 		chkf="05";
 	}
 	if(fdate[1]=="Jun")
 	{
 		chkf="06";
 	}
 	if(fdate[1]=="Jul")
 	{
 		chkf="07";
 	}
 	if(fdate[1]=="Aug")
 	{
 		chkf="08";
 	}
 	if(fdate[1]=="Sep")
 	{
 		chkf="09";
 	}
 	if(fdate[1]=="Oct")
 	{
 		chkf="10";
 	}
 	if(fdate[1]=="Nov")
 	{
 		chkf="11";
 	}
 	if(fdate[1]=="Dec")
 	{
 		chkf="12";
 	}
 	var objFromDate1=""+fdate[2]+"-"+chkf+"-"+fdate[0]+"";
     var objToDate = document.getElementById("data1").value;
     var tdate=objToDate.split("-");
     if(tdate[1]=="Jan")
 	{
     	chkt="01";
 	}
 	if(tdate[1]=="Feb")
 	{
 		chkt="02";
 	}
 	if(tdate[1]=="Mar")
 	{
 		chkt="03";
 	}
 	if(tdate[1]=="Apr")
 	{
 		chkt="04";
 	}
 	if(tdate[1]=="May")
 	{
 		chkt="05";
 	}
 	if(tdate[1]=="Jun")
 	{
 		chkt="06";
 	}
 	if(tdate[1]=="Jul")
 	{
 		chkt="07";
 	}
 	if(tdate[1]=="Aug")
 	{
 		chkt="08";
 	}
 	if(tdate[1]=="Sep")
 	{
 		chkt="09";
 	}
 	if(tdate[1]=="Oct")
 	{
 		chkt="10";
 	}
 	if(tdate[1]=="Nov")
 	{
 		chkt="11";
 	}
 	if(tdate[1]=="Dec")
 	{
 		chkt="12";
 	}
     var objToDate1=""+tdate[2]+"-"+chkt+"-"+tdate[0]+"";
    // alert("Entry from date > "+objFromDate1+" Todate > "+objToDate1);
      
     var date1 = new Date(objFromDate1);
     var date2 = new Date(objToDate1);
     
     //alert("from > "+date1+" Todate > "+date2);
     
     var date3 = new Date();
     var date4 = date3.getMonth() + "-" + date3.getDay() + "-" + date3.getYear();
     var currentDate = new Date(date4);
      
         if(date1 > date2)
         {
             alert("From Date Should be Less Than To Date");
             return false; 
         }
//          else if(date1 > currentDate)
//          {
//              alert("From Date should be less than current date");
//              return false; 
//          }
//          else if(date2 > currentDate) 
//          {
//              alert("To Date should be less than current date");
//              return false; 
//          }

         return true;
 	
 }
 
</script>


</head>


<%

Statement st = null;
Statement st1 = null;
Statement st2 = null;
System.out.println("===========connection created=============");


		Connection conn = null;
		
		String MM_dbConn_DRIVER = "org.gjt.mm.mysql.Driver";
		String MM_dbConn_USERNAME = "fleetview";
		String MM_dbConn_PASSWORD = "1@flv";
		String MM_dbConn_GPS = "jdbc:mysql://173.234.153.82";            

		Class.forName(MM_dbConn_DRIVER);
		conn = DriverManager.getConnection(MM_dbConn_GPS,MM_dbConn_USERNAME, MM_dbConn_PASSWORD);
		st=conn.createStatement();
		st1=conn.createStatement();
		st2=conn.createStatement();	
		
		ResultSet rsPagination = null;
	    ResultSet rsRowCnt = null;
	    
	    PreparedStatement psPagination=null;
	    PreparedStatement psRowCnt=null;
	    

		System.out.println("===========connection created=============");
		String datex1, datex2, data1, data2;
		String departmentNew="";
		String ddx = request.getQueryString();

		if (ddx == null) {
			
			System.out.println(" In First If  " );
			
			datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
					.format(new java.util.Date());
			
				
			data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
					.format(new java.util.Date());

			Calendar c = Calendar.getInstance();   // this takes current date
		    c.set(Calendar.DAY_OF_MONTH, 1);
		    System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
		    datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());


		} else {
			
			System.out.println(" In First Else  " );
			
			
			String fromdate=request.getParameter("chkdate");
			String todate=request.getParameter("chkdate1");
			
			System.out.println(" In First Else chkdate  "+fromdate );
			
			System.out.println(" In First Else  chkdate 1"+todate );
			
			
			if(fromdate!=null && todate!=null)
			{
				
				data1 = fromdate;
		data2 = todate;




		datex1 = fromdate;
		datex2 = todate;

				
			}else
			{
				
			
			data1 = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy")
							.parse(request.getParameter("data")));
			data2 = new SimpleDateFormat("yyyy-MM-dd")
					.format(new SimpleDateFormat("dd-MMM-yyyy")
							.parse(request.getParameter("data1")));
			
			
			

			datex1 = request.getParameter("data");
			datex2 = request.getParameter("data1");
			}
		}

		String Bt=request.getParameter("button");
		System.out.println(" Button :- " +Bt);

		if(Bt==null || Bt==" " || Bt=="")
		{
			
			String fromdate=request.getParameter("chkdate");
			String todate=request.getParameter("chkdate1");
			
		    System.out.println(" In Button Null   "+fromdate );
			
			System.out.println(" In Button Null   chkdate 1"+todate );
			
			
			if(fromdate!=null && todate!=null)
			{
			
				datex1 =new SimpleDateFormat("dd-MMM-yyyy")
				.format(new SimpleDateFormat("yyyy-MM-dd")
				.parse(fromdate));
				
				datex2 = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new SimpleDateFormat("yyyy-MM-dd")
				.parse(todate));
				
			data1 =  fromdate;
			
			data2 = todate;

			departmentNew=request.getParameter("departmentNew");

			}
			else
			{
				datex1 = datex2 = new SimpleDateFormat("dd-MMM-yyyy")
				.format(new java.util.Date());
			data1 = data2 = new SimpleDateFormat("yyyy-MM-dd")
				.format(new java.util.Date());

			Calendar c = Calendar.getInstance();   // this takes current date
			c.set(Calendar.DAY_OF_MONTH, 1);
			System.out.println(" current date "+new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime())); 
			datex1=new SimpleDateFormat("dd-MMM-yyyy").format(c.getTime());
					}
		}
		else
		{
			data1 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("data")));
		data2 = new SimpleDateFormat("yyyy-MM-dd")
			.format(new SimpleDateFormat("dd-MMM-yyyy")
					.parse(request.getParameter("data1")));




		datex1 = request.getParameter("data");
		datex2 = request.getParameter("data1");
		}

		System.out.println(" datex1 "+datex1+" datex2 "+datex2);


		String dt = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
		.parse(datex1));

		String dt1 = new SimpleDateFormat("yyyy-MM-dd")
		.format(new SimpleDateFormat("dd-MMM-yyyy")
		.parse(datex2));

		System.out.println(" dt :-  "+dt+" dt1 :-  "+dt1);

		int counter=0;	
%>
<body>
<form name="custreport" id="custreport" method="post">
<div class="form" align="center" style="font-size: 13px;">
<font face="san-serif" color="black" size="4"><b>Active FleetView Users</b></font><br></br>
</div>


<div class="form" style="margin-left: 24%;">
	<table border="0" width=800 align="center">
		
	
	
		<tr align="left">

						
		
		
			<td align="left"><font face="Arial" color="black" size="2"><b>From
			 </b></font>&nbsp;&nbsp;
			 <input type="text" id="data" height="10px" name="data" value="<%=datex1%>" size="13px" readonly  class="element text medium" style="width: 125px; font-size: 12px; height: 29px; color:black"  /> <script
				type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",     // the date format
			      button      : "data"       // ID of the button
			    }
			  );
			</script></td>
			<td></td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			
			<td></td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
						
			<td align="left"><font face="Arial" color="black" size="2"><b>To
			 </b></font>&nbsp;&nbsp; <input type="text" id="data1" name="data1" value="<%=datex2%>" size="13px" readonly   class="element text medium" style="width: 125px;font-size: 12px; height: 29px; color:black"  /> 
			<script	type="text/javascript">
			  Calendar.setup(
			    {
			      inputField  : "data1",         // ID of the input field
			      ifFormat    : "%d-%b-%Y",    // the date format
			      button      : "data1"       // ID of the button
			    }
			  );
			</script></td>
			
			<td></td>
			<td></td>
			<td></td>

						
						
			<td style="font-size: 11px; face:san-serif; color:black" >&nbsp;&nbsp;<input type="submit" name="button" value="Submit" onclick="return chk()" style="width: 80px;font-size: 12px; height: 29px; color:black"></td>
			
	</table>
	</div>	

<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">  
<thead>


<tr>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Sr No</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">User</th>
<th style="font-size:12px ;background: #1582AB;  color:white;    face:san-serif;">Full Name</th>
<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Type of User</th>
<th style="font-size:12px ; background: #1582AB;  color:white;   face:san-serif;">Type value</th>
<th style="font-size:12px ;background: #1582AB;  color:white;    face:san-serif;">Active Status</th>
<th style="font-size:12px ;background: #1582AB;  color:white;    face:san-serif;">Expiry Date</th>
<th style="font-size:12px ;background: #1582AB;  color:white;    face:san-serif;">Last Accessed Time</th>
<th style="font-size:12px ;background: #1582AB;  color:white;    face:san-serif;">IP</th>





</tr>
</thead>
<tbody>
<%

int count =0;
String sqlPagination = "select * from db_gps.t_security where ActiveStatus = 'Yes' and UpdatedDate>='"+dt+"' and UpdatedDate<='"+dt1+"'";
rsPagination=st.executeQuery(sqlPagination);
System.out.println("The query is :"+sqlPagination);

while(rsPagination.next()) {
	
		String Username=rsPagination.getString("Username");
		String FullName=rsPagination.getString("FullName");
		String TypeofUser=rsPagination.getString("TypeofUser");
		String TypeValue=rsPagination.getString("TypeValue");
		String ActiveStatus=rsPagination.getString("ActiveStatus");
		String ExpiryDate=rsPagination.getString("ExpiryDate");
		
		if(ExpiryDate=="-" || ExpiryDate.equals("-"))
		{
			ExpiryDate = "-";
		}else{
			ExpiryDate = new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(ExpiryDate));
		}

		String laseAccess="-",RecordDate="-",RecordTime="-",frmTime="-",UserIP="-";
		if(Username==null || Username.equals("") || Username=="null")
		{System.out.println("Tnulllllllllll");

		
		}
		else
		{
		String sqlovers ="select * from db_gps.t_loguseractivity where Comments ='"+Username+"'";
		ResultSet rsovers=st1.executeQuery(sqlovers);
		System.out.println("The query is ==>>"+sqlovers);
		if(rsovers.next())
		{
			RecordDate = rsovers.getString("RecordDate");
			RecordTime  = rsovers.getString("RecordTime");
			laseAccess =RecordDate+" "+RecordTime;
			UserIP = rsovers.getString("UserIP");
			
		}//end of if
		
		if(laseAccess=="-" || laseAccess.equals("-")) 
		{
			laseAccess = "-";
		}
		else
		{
			laseAccess = new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(laseAccess));
		}
		
		%>
				
		<tr>
	
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=++count%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Username%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=FullName%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TypeofUser%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=TypeValue%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=ActiveStatus%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=ExpiryDate%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=laseAccess%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=UserIP%></td>
		
		</tr>
		<%
		
		}}//end of while
	

%>
</tbody>
</table>
</form>
</body>
</html>
<%@ include file="footerhtml.jsp" %>