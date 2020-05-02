<%@page import="com.sun.corba.se.spi.orbutil.fsm.State"%>

<%@ page language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" import="moreservlets.listeners.*" errorPage="" %>
<link href="css/ERP.css" rel="stylesheet" type="text/css"></link>
 <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">@import url(jscalendar-1.0/calendar-blue.css);</style>
<%@ page import = "java.io.FileNotFoundException"%>
<%@ page import = "java.io.FileOutputStream"%>
<%@ page import = " java.io.IOException"%>
<%@ page import="javax.activation.*" %>


<html> 
<head>
<style>

</style>

<%@ include file="header.jsp"%>

<jsp:useBean id="erp" class="com.erp.beans.ERP" scope="page"> 
<title></title>
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
	                        title: 'Attendance Report '+$("#data").val()+'-'+$("#data1").val(), 
	                    },
	                    {
	                        extend: 'csv',
	                        title: 'Attendance Report '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'print',
	                        title: 'Attendance Report '+$("#data").val()+'-'+$("#data1").val(),
	                    },
	                    {
	                        extend: 'copy',
	                        title: 'Attendance Report '+$("#data").val()+'-'+$("#data1").val(),
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


<%!
Connection con1;


%>
<%
Class.forName(DB_Driver);
con1 = DriverManager.getConnection(DB_NAME,DB_USERNAME,DB_PASSWORD);
Statement st1=con1.createStatement();
Statement st=con1.createStatement();
Statement st_user_id=con1.createStatement();
Statement st12=con1.createStatement();
Statement st13=con1.createStatement();
%>
<% 


String selected=request.getParameter("status");

System.out.println("--------"+selected);

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



String name=session.getAttribute("EmpName").toString();
String Sesrole1=session.getAttribute("role").toString();
String sessiondept=session.getAttribute("department").toString();
String dept = session.getAttribute("department").toString();



String selected1=request.getParameter("dept");

System.out.println(" selected1 department  :-  "+selected1);

if(selected1==null && departmentNew!=null)
{
	selected1=departmentNew;
}
%>












<body>
<form name="custreport" id="custreport" method="post">
<div class="form" align="center" style="font-size: 13px;">
<br></br><br>
<font face="san-serif" color="black" size="4"><b>Attendance Report</b></font><br></br>
</div>

<div class="form" style="margin-left: 24%;">
	<table border="0" width=800 align="center">
		
	
	
		<tr align="left">
		
		<td align="center"><font face="Arial" color="black" size="2"><b>Department</b></font></td>
<td>
		<div >
		
		      
		      
		      
		      <select class="element select medium" id="dept" name="dept" style="width: 100px; height: 29px; font-size: 12px;color: black; ">
         <%--   <option ><%=cmp %></option>  --%>
            
            
            
        <%if(Bt==null || Bt==" " || Bt=="")
        { 
        	departmentNew=request.getParameter("departmentNew");
        if(departmentNew==null)
        {
        	selected1=dept;

        %>
        
        
        
        <% if (Sesrole1.equals("Hr") || Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
            {
            %>
            
            <option value="AllDept">AllDept</option>
            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            <%
            }else
            {
            	%>
                
                <option value="<%=sessiondept%>"><%=sessiondept%></option>
                
                <%
            }
        }
        else
        {
        	if (Sesrole1.equals("Hr") || Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
            {
            %>
            <option value="<%=departmentNew%>"><%=departmentNew%></option>
            <option value="AllDept">AllDept</option>
            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            <%
            }else
            {
            	%>
                
                <option value="<%=sessiondept%>"><%=sessiondept%></option>
                
                <%
            }
        }
        } else
        {
        
          if (Sesrole1.equals("Hr") || Sesrole1.equals("HOD") || Sesrole1.equals("AllAdmin"))
            {
            %> 
              <option value="<%=selected1%>"><%=selected1%></option>
        	<option value="AllDept">AllDept</option>
            <option value="<%=sessiondept%>"><%=sessiondept%></option>
            <%} else{%>     
        
        <option value="<%=sessiondept%>"><%=sessiondept%></option>
           <%} }%> 
           
            
            
            <% 
            String sql1="";
            String department="";
            
            
            if (Sesrole1.equals("Hr"))
            {
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept";
            }
            else 
            	{
            	if (Sesrole1.equals("HOD")){
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and dept!='"+sessiondept+"'  and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept";
            			
        
             }
            else
            {
            	if(Sesrole1.equals("AllAdmin"))
            	{
            	sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"'   and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept ";
            	}
            	else
            	{
            		sql1 = "select distinct(dept) as department from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and dept!='"+sessiondept+"'  and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" order by dept ";
            	}
            }
          }
           
            
            	 
            	 
            	 
            	 
            	 
            	 
            	 
            	
		//System.out.println("*******"+sql1);
		
        ResultSet rsregno = st.executeQuery(sql1);
		while(rsregno.next())
		{
			 
			department=rsregno.getString("department");
		
			 
			 System.out.println("department-->"+department);
			%>
			<option value="<%=department%>"><%=department%></option>
			
	         <%
	         
	         
	    
      }
		%>
           </select>
		      
		</div> 
</td>
						
		
		
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

			<td></td>
			<td></td>
			<td></td>
			
			<td></td>
			<td></td>
			<td></td>

			<td></td>
			<td></td>
			<td></td>
			
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
			<td style="font-size: 11px; face:san-serif; color:black" >&nbsp;&nbsp;<input type="submit" name="button" value="Submit" onclick="return chk()" style="width: 80px;font-size: 12px; height: 29px; color:black"></td>
			
			
			
				
	

	</table>
	</div>
	

<%
dept = session.getAttribute("department").toString();

String sessionname=session.getAttribute("EmpName").toString();
System.out.println(dept);

int cnt=0;
String sql_active=null;
String user_id1 = "";

if (Sesrole1.equals("HOD")||Sesrole1.equals("AllAdmin"))
{
	System.out.println("INSIDE HOD");
	dept = request.getParameter("dept");
	System.out.println("Dep :- "+dept);
	System.out.println("Depart :- "+departmentNew);
	if(dept!=null && dept.equals("AllDept"))
	{
		
      sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where  ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
	}
	
	
	else
	{
		if(dept==null && departmentNew==null){
			
		sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept!='"+dept+"' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
		}
		else
		{
		if(departmentNew==null || dept!=null)
		{
			sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept='"+dept+"' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
		}
		else
		{if(departmentNew.equals("AllDept") || departmentNew.equals("All"))
			{
sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept like '%%' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
			}else
{
			sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept='"+departmentNew+"' and ActiveStatus = 'Yes' and (HODReport='"+session.getAttribute("EmpName").toString()+"' OR EmpName='"+session.getAttribute("EmpName").toString()+"') and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
}
		}
		}
	}
	
}
else
{
	if (Sesrole1.equals("Hr"))
	{
		dept = request.getParameter("dept");
		System.out.println("Depart :- "+dept);
		
	  if (dept!=null && (dept.equals("AllDept") || dept.equals("All")) ) 
		{
		sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where  companymasterid="+session.getAttribute("CompanyMasterID").toString()+" and ActiveStatus = 'Yes' ";
		}
	  else
	  {
		  sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept= '"+dept+"' and ActiveStatus = 'Yes'  and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	  }
	}
	
	

	
}
if(Sesrole1.equals("-"))
{
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where dept ='"+dept+"' and ActiveStatus = 'Yes' and dotprojectid!='-' and EmpName='"+session.getAttribute("EmpName").toString()+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+"";
}

		
if(Sesrole1.equals("AllAdmin") || Sesrole1.equals("Hr") )
	
{
	dept = request.getParameter("dept");
	
	System.out.println("Dep :- "+dept);
	
	if(dept!=null && (dept.equals("All") || dept.equals("AllDept")))
	{
		dept="%%";
		
		sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept like  '"+dept+"'  and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	}
	else
	{
	if(dept!=null)
	{
	sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes' and  dept = '"+dept+"' and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	}
	else
	{
		sql_active = "select EmpCode as user_id from db_GlobalERP.UserMaster where ActiveStatus = 'Yes'  and companymasterid="+session.getAttribute("CompanyMasterID").toString()+" ";
	}
	}
}



System.out.println("The EmpCode Id query is ==>>"+sql_active);

ResultSet rs_active = st_user_id.executeQuery(sql_active);

while(rs_active.next()){
++cnt;
if(cnt == 1)
{
	
		user_id1 = rs_active.getString("user_id");	
	
		user_id1="\'"+user_id1+"\'";
	
}else
{
	
		//user_id1 = user_id1 +","+ rs_active.getString("user_id");	
	
	
		user_id1 = user_id1 +",\'"+rs_active.getString("user_id")+"\'";
}

}

System.out.println("-------->"+user_id1);





















ResultSet rs=null;
Statement stmt=null;
stmt=con1.createStatement();
Statement stmt1=con1.createStatement();
Statement stmt3=con1.createStatement();
Statement stmt4=con1.createStatement();



//dt=dt+" "+"00:00:00";
//dt1=dt1+" "+"23:59:00";
System.out.println(dt);
System.out.println(dt1);

String month="",Year="";

String countday="SELECT DAYNAME('"+dt+"') as DayName1,DAYOFMONTH('"+dt+"') as DayCnt ,MONTHNAME('"+dt+"') as MonthName,YEAR('"+dt+"') as Year";

ResultSet rs12=st12.executeQuery(countday);
if(rs12.next())
{
	month=rs12.getString("MonthName");
	Year=rs12.getString("Year");
}


month=month.substring(0,3);
System.out.println("month is:"+month);
System.out.println("month is:"+Year);

System.out.println(countday);
String role=session.getAttribute("role").toString();

if(role.equals("HOD")||role.equals("AllAdmin"))
{
%>
<a href="AttendanceViewApproval.jsp"><b>View All Approval</b></a>

<% 
}

%>





<table id="example"  class="display"  a style="width:100%"  cellspacing="0" border="1">  
<thead>


<tr>

<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;">SrNo</th>
<th style="font-size:12px ; background: #1582AB;  color:white; face:san-serif;">ID</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Name</th>

<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Comment</th>
<th style="font-size: 12px ; background: #1582AB;  color:white; face:san-serif;">CustomerName</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Date</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">CheckIn</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">CheckOut</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">ActualWorkHrs</th>

<th style="font-size:12px ; background: #1582AB;  color:white;    face:san-serif;">Day</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">DutyIn</th>
 
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">DutyOut </th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">WorkingHours </th> 
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Status</th>

<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">NewStatus</th>
<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;">Comments</th>

<%




if(role.equals("HOD")||role.equals("AllAdmin"))
{
	%>
	<th style="font-size: 12px ;background: #1582AB;  color:white; face:san-serif;"> Action</th>
	
	<% 
}



%>



</tr>
</thead>
<tbody>
<%



String data="select distinct(EmpID) as EmpID from db_leaveapplication.t_leaveadmin a ,db_GlobalERP.UserMaster b  where a.status = 'Yes' and a.EmpId=b.EmpCode and b.ActiveStatus='Yes' and b.companymasterid=100000 and b.EmpCode in ("+user_id1+") "; 

System.out.println("check-------->"+data);
Statement st21=con1.createStatement();
ResultSet rs21=st21.executeQuery(data);
while(rs21.next())
{

String eid=rs21.getString("EmpID");

String Id="",USerName="",Name="",Comments="",CustomerName="",Date="",CheckIn="",CheckOut="",ActualWorkHrs="",Day="",DutyOut="",DutyIn="",WorkingHours="",Status="";
String data12="select distinct(ContractorId) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"ContractMasterNew where Status='Active' and ContractorId='"+eid+"' ";
ResultSet rsData=st13.executeQuery(data12);
if(rsData.next())
{
String attendance="select EmpID as ID,EmpName as USerName,Name,EntryComments as Comments,CustomerName,DATE_FORMAT(checkDate,'%d-%b-%Y') as Date,min(checkTime) as CheckIn,max(checkTime) as CheckOut,TIME_FORMAT(TIMEDIFF(max(checkTime),min(checkTime)),'%T') as ActualWorkHrs,DAYNAME(checkDate) as Day,TIME_FORMAT(LEAST(max(checkTime),TOut),'%T') as DutyOut,TIME_FORMAT(GREATEST(min(checkTime),TIn),'%T')as DutyIn,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as WorkingHours,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as Status,'"+month+"' as Month ,'"+Year+"' as Year  from db_leaveapplication.t_checkinout where EmpID in (select EmpID from db_leaveapplication.t_leaveadmin where status = 'Yes' and TypeValue like '%%' and EmpID='"+eid+"') and checkDate >='"+dt+"' and checkDate <='"+dt1+"' group by checkDate ,EmpID ";

//System.out.println("Query used"+attendance);

 
 Statement stmt2=con1.createStatement();
ResultSet rsdata=stmt1.executeQuery(attendance);
int i=1;

String token_int[]=null;
String dt4="";
double hrs_cal=0.00,min_cal=0.00,tot_sec1=0.00,sec_cal=0.00;
while(rsdata.next())
{
	try{
	Id=rsdata.getString("Id");
	USerName=rsdata.getString("USerName");
	Name=rsdata.getString("Name");
	Comments=rsdata.getString("Comments");
	
	
	CustomerName=rsdata.getString("CustomerName");
	Date=rsdata.getString("Date");
	CheckIn=rsdata.getString("CheckIn");
	CheckOut=rsdata.getString("CheckOut");
	ActualWorkHrs=rsdata.getString("ActualWorkHrs");
	Day=rsdata.getString("Day");
	DutyIn=rsdata.getString("DutyIn");
	DutyOut=rsdata.getString("DutyOut");
	WorkingHours=rsdata.getString("WorkingHours");
	Status=rsdata.getString("Status");
	
	
	
	dt4= new SimpleDateFormat("yyyy-MM-dd")
	        .format(new SimpleDateFormat("dd-MMM-yyyy")
	                .parse(Date));
	
	
	
	if(Comments==null)
	{
		Comments="-";
	}
	}
	catch(Exception e)
	{
		System.out.print(e);
	}
	
	//double WorkingHours=Double.parseDouble(WorkingHours1);
	
	 token_int=WorkingHours.split(":");
							
							
						
							
							hrs_cal=Double.parseDouble(token_int[0]);
							min_cal=Double.parseDouble(token_int[1]);
							sec_cal=Double.parseDouble(token_int[2]);
							hrs_cal=hrs_cal * 60 *60;
							min_cal=min_cal * 60;
	
							tot_sec1=hrs_cal+min_cal+sec_cal;
							
							
							//System.out.println("Date:"+Date);
							//System.out.println("hrs:"+hrs_cal);
							//System.out.println("min:"+min_cal);
							//System.out.println("sec:"+sec_cal);
	int secondMax=0,Max=0,Min=0;						
		
	String maxd="select max(MaxSec) as SecondMax,Min(MaxSec) as minSec from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"workingHoursStatusMaster where MaxSec NOT in (Select Max(MaxSec) from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"workingHoursStatusMaster)";
	ResultSet rsd=stmt2.executeQuery(maxd);
	if(rsd.next())
	{
		secondMax=rsd.getInt("SecondMax");
		Min=rsd.getInt("minSec");
		
		//System.out.println(Min);
		//System.out.println(secondMax);
		
	}
	
	
	String max="select Max(MaxSec) as MaxSec from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"workingHoursStatusMaster ";
	
		ResultSet rsd1=stmt3.executeQuery(max);
		if(rsd1.next())
		{
			Max=rsd1.getInt("MaxSec");
			//System.out.println(Max);
			
		}
		
		String checkdate="select EmpID as ID,EmpName as USerName,Name,EntryComments as Comments,CustomerName,DATE_FORMAT(checkDate,'%d-%b-%Y') as Date,min(checkTime) as CheckIn,max(checkTime) as CheckOut,TIME_FORMAT(TIMEDIFF(max(checkTime),min(checkTime)),'%T') as ActualWorkHrs,DAYNAME(checkDate) as Day,TIME_FORMAT(LEAST(max(checkTime),TOut),'%T') as DutyOut,TIME_FORMAT(GREATEST(min(checkTime),TIn),'%T')as DutyIn,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as WorkingHours,TIME_FORMAT(TIMEDIFF(LEAST(max(checkTime),TOut),GREATEST(min(checkTime),TIn)),'%T') as Status,'"+month+"' as Month ,'"+Year+"' as Year  from db_leaveapplication.t_checkinout where EmpID in (select EmpID from db_leaveapplication.t_leaveadmin where status = 'Yes' and TypeValue like '%%' and EmpID='"+eid+"') and checkDate >='"+dt4+"' and checkDate <='2018-07-16'  group by checkDate ,EmpID "; 
		ResultSet rschk=stmt4.executeQuery(checkdate);			
		
		//System.out.println("Query to check "+checkdate);
		
					if(rschk.next())
						{			
						 //System.out.println("Before 16");
						if(tot_sec1>=30600)
						{
							Status="Present";
							
						}else if(tot_sec1>=29700 && tot_sec1<30600)
						{
							Status="Late";
							
						}else if(tot_sec1>=16200 && tot_sec1<28800)
							//else if(tot_sec>=16200 && tot_sec<28800)
						{
							Status="Half Day";
							
						}else if(tot_sec1< 16200)
						{
							Status="Absent";
							
						}
						
						
						
						
						
						
						}
						else
						{
							
							 //System.out.println("After 16");
	

							if(tot_sec1>=Max)
							{
								Status="Present";
							}
							else if(tot_sec1>=secondMax && tot_sec1<Max)
							{
								Status="Late";
							}
							else if(tot_sec1>=Min && tot_sec1<secondMax)
							{
								Status="HalfDay";
							}
							else if(tot_sec1<Min)
							{
								Status="Absent";
							}
							
							
							
						}	
							
%>
<tr>
	
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=i%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=Id%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Name%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Comments%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=CustomerName%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=Date%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=CheckIn%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=CheckOut%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=ActualWorkHrs%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Day%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=DutyIn%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=DutyOut%></td>
	<td style="font-size: 11px; face:san-serif; color:black" align="right"><%=WorkingHours%></td>






	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=Status %></td>
	
	<%
	String new_Status="",comments="";
	String updatedstatus="select * from db_GlobalERP."+session.getAttribute("CompanyMasterID").toString()+"AttendanceStatusMaster where Date='"+Date+"' and ID='"+Id+"' and Month='"+month+"' and Year='"+Year+"'";
	ResultSet rsStatus=st13.executeQuery(updatedstatus);
	if(rsStatus.next())
	{
		new_Status=rsStatus.getString("NewStatus");
		comments=rsStatus.getString("Comments");
	}
	
	else
	{
		new_Status="-";
		comments="-";
	}
	%>
	<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=new_Status%></td>
		<td style="font-size: 11px; face:san-serif; color:black" align="left"><%=comments%></td>


<%

if(role.equals("HOD")||role.equals("AllAdmin"))
{


System.out.println("DATE IS---->>"+ Date);
	if(!(Status.equals("Late")||Status.equals("Present")) && (!sessionname.equals(Name)))		
	 { 
		%>
		<td style="font-size: 11px; face:san-serif; color:black" align="right">
	
	<a data-toggle="modal" href="#myModal" onclick="senddata('<%=Id %>','<%=Date %>','<%=Status %>','<%=Name %>','<%=new_Status %>','<%=dt %>','<%=dt1%>','<%=selected1%>')" style="color:green;" ><b>Approve</b></a>
	
	<%-- <a href="AttendanceAction.jsp?action=Reject&id=<%=Id %>&Date=<%=Date%>" onclick="" style="color:red" >Reject</a><br> --%>
	<% 
	
	
	%>
	
</td>
		<%
	}
	else
	{
		%>
		<td>-</td>
		<% 
	}
	
	
}
%>

	
<%
i++;
}
}
else
{
	
}
}
%>
</tbody>
</table>


</form>






<script>

function senddata(id,data,status,Name,new_status,chkdt,chkdt1,departmentNew)
{
	//alert("departmentNew "+departmentNew);
	
	document.getElementById("chkdt").value = chkdt;
	
	//alert("chkdt "+chkdt);
	
	document.getElementById("chkdt1").value = chkdt1;
	
	document.getElementById("departmentNew").value = departmentNew;
	//alert(departmentNew);
	
	
	
	document.getElementById("ename").value = Name;
	document.getElementById("eid").value = id;
	
	document.getElementById("date").value = data;
	
	if(new_status=='-')
		{
		document.getElementById("status").value = status;
	document.getElementById("status1").value = status;
	}
	else
		{
		document.getElementById("status").value = status;
		document.getElementById("status1").value = new_status;
		}
	
	//window.location="AttendanceReport.jsp";
}


</script>





   <script>
function approve()
{
	
	var Ename=document.getElementById("ename").value;
	var Eid=document.getElementById("eid").value;
	var Status=document.getElementById("status").value;
	var Date=document.getElementById("date").value;
	
	//alert(Date);
	var checkDate=document.getElementById("chkdt").value;
	
	var checkDate1=document.getElementById("chkdt1").value;
//	alert(checkDate1);

	var departmentNew=document.getElementById("departmentNew").value;
//alert(departmentNew);
    var comments=document.getElementById("mycomments").value;
	
	//alert(comments);
	if(comments=="")
		{
		alert("Please Enter Comments");
		return false;
		}
	
	
	var statusnew=document.getElementById("status1").value;
	//alert(statusnew);
	
	
	//alert(Ename);
	//alert(Eid);
	//alert(Status);
	//alert(Date);
	//alert(checkDate);
	//alert(checkDate1);
	
	var action="Approve";
	location.assign("AttendanceAction.jsp?id="+Eid+"&action="+action+"&Name="+Ename+"&preStatus="+Status+"&newStatus="+statusnew+"&date="+Date+"&comment="+comments+"&checkDate="+checkDate+"&checkDate1="+checkDate1+"&departmentNew="+departmentNew+"");
}


</script>





<div class="container">

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
        
        
        
          <h4 class="modal-title" style=" background-color: #1582AB;color: white; font-size: 16px; face:san-serif;"><div align="center"><b>Approve Action</b></div></h4>
          	<br>
          	
          	Emp Id:<input type="text" id="eid" name="eid" readonly="readonly" style="border: none; width: 44%; font-weight:bold;" >
          	Name:<input type="text" id="ename" name="ename" readonly="readonly" style="border: none; width: 28%;font-weight:bold;" >
            
          <br>
         
           Date:<input type="text" id="date" name="date" readonly="readonly" style="border: none; width: 46.5%;font-weight:bold;" >
            ActualStatus:<input type="text" id="status" name="status" readonly="readonly" style="border: none; width: 28%;font-weight:bold;" >
            <input type="hidden" id="chkdt" name="chkdt" value=""/>
            <input type="hidden" id="chkdt1" name="chkdt1" value=""/>
            <input type="hidden" id="departmentNew" name="departmentNew" value=""/>
        </div>
        <div class="modal-body">
        <div align="center">
        
        <div id="show" class="headerlay" style="background-color: #ffffff; margin-left: 4px;">
        
 
        
<div class="container-fluid">
 



 
 <div class="row">
    
   <div class="col-sm-7"> 
        ChangeStatus:
    </div>
    
     <div class="col-sm-5">
     	<select name="status1" id="status1" required="required">
     	<option value="Present">Present</option>
     	<option value="Absent">Absent</option>
     	<option value="HalfDay">HalfDay</option>
     	<option value="Late">Late</option>
     	
     
     	</select>
    </div>
    
   
 
  </div>
  
	
  
  <br>

  
     
  
  
   <div class="row">
 
   
   <div class="col-sm-7">
        Comments:
    </div>
    
     <div class="col-sm-5">
     	<textarea id="mycomments" name="mycomments" rows="5" cols="15" required="required"></textarea><br></br>
    </div>
    
  
   
    
  </div>
  
  
 
 
 </div>
 </div>
 </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="button" class="btn btn-default" data-dismiss="modal" onclick="return approve();">Submit</button>
          
        </div>
      </div>
      
    </div>
  </div>
  </div>
  
</div>








</jsp:useBean>


</body>
<%@ include file="footer_new.jsp"%>
</html>
