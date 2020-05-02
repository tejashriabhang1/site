<%@ include file="headerhtml.jsp"%>



<script language="javascript">
function getVehicles(trans)
{
		
var xmlhttp;
if (window.XMLHttpRequest)
  {
  // code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else if (window.ActiveXObject)
  {
  // code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
else
  {
  alert("Your browser does not support XMLHTTP!");
  }
xmlhttp.onreadystatechange=function()
{
if(xmlhttp.readyState==4)
  {
  //alert(xmlhttp.responseText);
  document.getElementById("vehiclediv").innerHTML=xmlhttp.responseText;
  }
}
xmlhttp.open("GET","getVehicles.jsp?UserName="+trans,true);
xmlhttp.send(null);
		
	}
</script>
<%
Connection conn,conn1;
Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
conn1 = DriverManager.getConnection(MM_dbConn_STRING1,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmtvehicle=null,stmtvehcode=null,stmtMails=null;
stmtvehicle=conn.createStatement();
stmtvehcode = conn.createStatement();
String sql="",thedate="",thedate1="",thedate2="", vehcode="",OwnerName="",VehicleRegNumber="";
String datasearch =  request.getParameter("dataser");
	String datenew1="",datenew2="";
	datenew1=datenew2= new SimpleDateFormat("dd-MMM-yyyy").format(new java.util.Date());
	System.out.println("datasearch :- "+datasearch);
	%>

<%@page import="java.util.Date"%>
<form name="dataCheck" action="" onSubmit="return validate()">
<table>
	<tr>
		<td colspan="8" align="center" class="sorttable_nosort"><b>Please
		select the date and enter the Unit id to check its data.</b></td>
	</tr>
	<tr>

		<td bgcolor="#F5F5F5">Unit ID :</td>
		<td bgcolor="#F5F5F5"><textarea name="unitid" id="unitid" class="stats"> </textarea>
		 
				<B> Note: </B> Please separate Unit ID's by comma ',' only &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		
		
		<td>
			<b>Select Criteria </b>&nbsp;&nbsp;&nbsp;&nbsp;
			<select name="dataser" id="dataser">
			<% 
				if(datasearch != null && !datasearch.equalsIgnoreCase("selecr"))
				{
					
					if(datasearch.equalsIgnoreCase("D1"))
					{
						%> <option value="D1" selected>D1-Tx. Delay </option>
						<% 
					}
					else
					{	%>				     
 							<option value="D1" >D1-Tx. Delay </option>
 						<%
					}
					
					if(datasearch.equalsIgnoreCase("D2"))
					{
						%> <option value="D2" selected>D2-Data Load Delay </option>
						<% 
					}
					else
					{	%>				     
 							<option value="D2" >D2-Data Load Delay </option>
 						<%
					}
					
					if(datasearch.equalsIgnoreCase("D3"))
					{
						%> <option value="D3" selected>D3-Processing Delay </option>
						<% 
					}
					else
					{	%>				     
 							<option value="D3" >D3-Processing Delay </option>
 						<%
					}
					
					
					if(datasearch.equalsIgnoreCase("total"))
					{
						%> <option value="total" selected>Total Delay </option>
						<% 
					}
					else
					{	%>				     
 							<option value="total" >Total Delay </option>
 						<%
					}
					
					
				}
				else
				{	
			%>
			<option value="select" selected>select</option>
			<option value="D1">D1-Tx. Delay </option>
			<option value="D2">D2-Data Load Delay </option>
			<option value="D3">D3-Processing Delay </option>
			<option value="total">Total Delay </option>
			</select>
			<%  }%>
		</td>		
		<td><b>From </b>&nbsp;&nbsp;&nbsp;&nbsp; 
			<input type="text" id="data1" name="data1" value="<%=datenew1%>" size="15" readonly />
		</td>
		<td align="left">
			<script type="text/javascript">
	  		Calendar.setup(
	  		  {
	  		    inputField  : "data1",         // ID of the input field
	  		    ifFormat    : "%d-%b-%Y",     // the date format
	   		   button      : "data1"       // ID of the button
	  		  }
	  		);
			</script>
		</td>
		<td><b>To</b> &nbsp;&nbsp;&nbsp;&nbsp; 
			<input type="text"	id="data2" name="data2" value="<%=datenew2%>" size="15" readonly />
		</td>
		<td align="left">
			<script type="text/javascript">
  			Calendar.setup(
    		{
      			inputField  : "data2",         // ID of the input field
      			ifFormat    : "%d-%b-%Y",    // the date format
      			button      : "data2"       // ID of the button
    		}
  			);
			</script>
		</td>
		<td bgcolor="#F5F5F5"><input type="submit" name="submit"
			value="submit" class="stats"></td>
	</tr>
</table>
<%
if(!(null==request.getQueryString()))
{	
	String unitids = request.getParameter("unitid"); 
	//System.out.println(unitids);
%>
	<table width="100%" align="center" class="sortable" border="1">
		<tr>
			<th>Unit Id</th>
			<th>Date</th>
			<th>Expected count of stamps</th>
			<th>received count</th>
			<th>Delay between 0-2</th>
			<th>Delay between 0-15</th>
			<th>Delay between 16-30</th>
			<th>Delay between 31-60</th>
			<th>Delay between 61-120</th>
			<th>Delay greater than 120</th>
		</tr>
<%			

	try{
		Statement stGPS=conn.createStatement(); //gps
		Statement stAVL=conn1.createStatement(); //avlalldata
		String stampDateTime="",stampStoredDateTime="",rawDataMailDateTime="",rawDataStoredDateTime="";
		String unitId="",vehiclecode="",vehregnumber="",transporter="";
		int expectedStCount=0;
		int StInterval=0;
		int SIstampCount=0;
		double per=0.00;
		int days=0;
		int fromdate=0;
		int frommonth=0;
		String fromDateTime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data1")));
		String toDateTime=new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("dd-MMM-yyyy").parse(request.getParameter("data2")));
		fromDateTime = fromDateTime+" 00:00:00";
		toDateTime = toDateTime+" 23:59:59";
		
		
		String a="",b="";
		
		
		
		
		System.out.println("Hii  HK datasearch is :- "+datasearch);
		
		if(datasearch.equalsIgnoreCase("D1"))
		{
		  	System.out.println("in the if block for d1");
			a= "RDataMailDateTime";
			b = "Thefielddatadatetime";
		}
		else if(datasearch.equalsIgnoreCase("D2"))
		{
			a= "RDataStoredTime";
			b="RDataMailDateTime";
		}
		else if(datasearch.equalsIgnoreCase("D3"))
		{
			a= "concat(TheFieldDataStoredDate,' ',TheFieldDataStoredTime)";
			b="RDataStoredTime";
		}
		else if(datasearch.equalsIgnoreCase("total"))
		{
			b= "Thefielddatadatetime";
			//a= "Thefielddatadatetime";
			a="concat(TheFieldDataStoredDate,' ',TheFieldDataStoredTime)";
			//b="concat(TheFieldDataStoredDate,"+" "+",TheFieldDataStoredTime)";
		}
		
		StringTokenizer unitToken = new StringTokenizer(unitids,",");
		while(unitToken.hasMoreTokens()){
			unitId = unitToken.nextToken();
			unitId = unitId.trim();
			per=0.00;
			String sqlvehicledetails = "select * from db_gps.t_vehicledetails where unitid='"+unitId+"'";
			System.out.println("sss sqlvehicledetails :- "+sqlvehicledetails);
			ResultSet rsvehicle = stmtvehicle.executeQuery(sqlvehicledetails);
			if(rsvehicle.next())
			{
				vehiclecode = rsvehicle.getString("vehiclecode");
				vehregnumber = rsvehicle.getString("vehicleregnumber");
				transporter = rsvehicle.getString("ownername");
			}
			else
			{
				vehiclecode = "0";
			}
			
			
			
			String count0_06="0";
			String count0_02="0";
			String count06_11="0";
			String count11_16="0";
			String count16_120="0";
			String countgrt_120="0";
			
			stampDateTime 		  = "";
			stampStoredDateTime   = "";
			rawDataMailDateTime   = "";
			rawDataStoredDateTime = "";
			String From_Month="";
			sql="select TXInterval,StInterval,UnitType from db_gps.t_ftplastdump where UnitID='"+unitId+"'";
			ResultSet rstftp = stmtvehcode.executeQuery(sql);
			if(rstftp.next())
			{
				if(rstftp.getString("StInterval")=="-"||rstftp.getString("StInterval").equalsIgnoreCase("-")||rstftp.getString("StInterval").equalsIgnoreCase("")){
   				 StInterval=0;
   			 }else{
      			  	StInterval = rstftp.getInt("StInterval");
   			 }
			}
			else
			{
				StInterval = 600;
			}
			expectedStCount = (24 * 3600 *10 )/ StInterval ;
			
			
			String From_Date = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime));
			String TO_Date = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateTime));
			String numOfDays = "SELECT TO_DAYS('"+TO_Date+"') - TO_DAYS('"+From_Date+"') as days";
			ResultSet rsNumDays = stmtvehcode.executeQuery(numOfDays);
			int year=0, month=0,day=0;
			if(rsNumDays.next()){
				days = Integer.parseInt(rsNumDays.getString("days"));
				String From_Day = new SimpleDateFormat("dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime));
				From_Month = new SimpleDateFormat("MM").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime));
				String From_year = new SimpleDateFormat("yyyy").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(fromDateTime));
			//	String To_Day = new SimpleDateFormat("dd").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateTime));
			//	String To_Month = new SimpleDateFormat("yyyy-MM").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(toDateTime));
				day = Integer.parseInt(From_Day);
				month = Integer.parseInt(From_Month);
				year = Integer.parseInt(From_year);
			}
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.set(year,month-1,day); // month values are zero based i.e Jan=0,Feb=1, Mar=2... so on
			String yesrtday = dateFormat.format(cal.getTime()); 
			
			cal.add(Calendar.DATE,-1);
			String date=""; 
			for(int cnt=0;cnt<=days;cnt++){
				cal.add(Calendar.DATE,1);
				date = dateFormat.format(cal.getTime());
			
			 if(vehiclecode.equalsIgnoreCase("0"))
			 {
				
			 String sqlVeh="select count(distinct(thefielddatadatetime)) as stampCount from db_gps.t_veh"+vehiclecode+" where TheFiledTextFileName='SI' and unitId = '"+unitId+"' and thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' ";
			 System.out.println("00--sqlVeh---->"+sqlVeh);
			 ResultSet rststamp=stmtvehcode.executeQuery(sqlVeh);
			  if(rststamp.next()){
				  SIstampCount=rststamp.getInt("stampCount");
				  System.out.println("stampcount"+SIstampCount);
			  }
			  
			  
			  String sqlvehcode1 ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+" ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff <=2";
			  System.out.println("--sqlvehcode---->"+sqlvehcode1);
			  ResultSet rsvehcode1 = stmtvehcode.executeQuery(sqlvehcode1);
			  if(rsvehcode1.next())
			  {
				  count0_02= rsvehcode1.getString("count");
				  System.out.println("count0_02 "+count0_02);
			  }
			  
			  
			  
			  
			  //String sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff <=15";
			  String sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+" ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff>2 and a.timediff <=15";
				System.out.println("--sqlvehcode---->"+sqlvehcode);
			  ResultSet rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			  if(rsvehcode.next())
				{
				  count0_06= rsvehcode.getString("count");
				  System.out.println("count0_06 "+count0_06);
				} 
					
			 //sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >15 and a.timediff <=30 ";
			 sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+" ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >15 and a.timediff <=30 ";
			 System.out.println("--count06_11---->"+sqlvehcode);
			 rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				count06_11 = rsvehcode.getString("count");
				System.out.println("--count06_11----> "+count06_11);
			}
			
			//sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime order by thefielddatadatetime) a where  a.timediff >30 and a.timediff <=60";
			sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+") as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime order by thefielddatadatetime) a where  a.timediff >30 and a.timediff <=60";
			System.out.println("--count11_16---->"+sqlvehcode);
			rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				count11_16 = rsvehcode.getString("count");
				System.out.println("--count11_16----> "+count11_16);
			}
			
			//sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >60 and a.timediff <=120";
			sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+" ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >60 and a.timediff <=120";
			System.out.println("--count16_120---->"+sqlvehcode);
			rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				count16_120 = rsvehcode.getString("count");
				System.out.println("--count16_120----> "+count16_120);
			}
			
			//sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff > 120";
			sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+") as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' and unitId = '"+unitId+"' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff > 120";
			System.out.println("--countgrt_120---->"+sqlvehcode);
			rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				countgrt_120 = rsvehcode.getString("count");
				System.out.println("--countgrt_120----> "+countgrt_120);
			}
			
			per=SIstampCount/expectedStCount;
			
		}
		else
		{
			
			String sqlVeh="select count(distinct(thefielddatadatetime)) as stampCount from db_gps.t_veh"+vehiclecode+" where TheFiledTextFileName='SI'  and thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' ";
			 System.out.println("00--sqlVeh---->"+sqlVeh);
			 ResultSet rststamp=stmtvehcode.executeQuery(sqlVeh);
			  if(rststamp.next()){
				  SIstampCount=rststamp.getInt("stampCount");
				  System.out.println("stampcount"+SIstampCount);
			  }
			  
			  //String sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI'  group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff <=15";//original query
			  
			  String sqlvehcode1 ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+" ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI'  group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff <=2";
			  System.out.println("--sqlvehcode---->"+sqlvehcode1);
			  ResultSet rsvehcode1 = stmtvehcode.executeQuery(sqlvehcode1);
			  if(rsvehcode1.next())
			  {
				  count0_02= rsvehcode1.getString("count");
				  System.out.println("count0_02 "+count0_02);
			  }
			  
			  
			  
			  String sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+" ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI'  group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >2 and a.timediff <=15";
			  System.out.println("--sqlvehcode---->"+sqlvehcode);
			  ResultSet rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			  if(rsvehcode.next())
			  {
				  count0_06= rsvehcode.getString("count");
				  System.out.println("count0_06 "+count0_06);
			  } 
					
			 //sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >15 and a.timediff <=30 ";
			 sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+" ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI' group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >15 and a.timediff <=30 ";
			 System.out.println("--count06_11---->"+sqlvehcode);
			 rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				count06_11 = rsvehcode.getString("count");
				System.out.println("--count06_11----> "+count06_11);
			}
			
			//sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI'  group by thefielddatadatetime order by thefielddatadatetime) a where  a.timediff >30 and a.timediff <=60";
			sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+") as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI'  group by thefielddatadatetime order by thefielddatadatetime) a where  a.timediff >30 and a.timediff <=60";
			System.out.println("--count11_16---->"+sqlvehcode);
			rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				count11_16 = rsvehcode.getString("count");
				System.out.println("--count11_16----> "+count11_16);
			}
			
			//sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,`Thefielddatadatetime`,concat(`TheFieldDataStoredDate`,' ',`TheFieldDataStoredTime`) ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI'  group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >60 and a.timediff <=120";
			sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+" ) as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI'  group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff >60 and a.timediff <=120";
			System.out.println("--count16_120---->"+sqlvehcode);
			rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				count16_120 = rsvehcode.getString("count");
				System.out.println("--count16_120----> "+count16_120);
			}
			
			sqlvehcode ="select count(*) as count from (SELECT TIMESTAMPDIFF(MINUTE,"+b+","+a+") as timediff FROM db_gps.t_veh"+vehiclecode+" where thefielddatadatetime between '"+date+" 00:00:00' and '"+date+" 23:59:59' and thefiledtextfilename='SI'  group by thefielddatadatetime  order by thefielddatadatetime) a where  a.timediff > 120"; 
			System.out.println("--countgrt_120---->"+sqlvehcode);
			rsvehcode = stmtvehcode.executeQuery(sqlvehcode);
			if(rsvehcode.next())
			{
				countgrt_120 = rsvehcode.getString("count");
				System.out.println("--countgrt_120----> "+countgrt_120);
			}
			
			per=SIstampCount/expectedStCount;
		
		
		
		
		
		
		
		}
			//System.out.println("per---->"+per);
%>
	<tr>
		<td align="right"><%=unitId%></td>
		<td><%=new SimpleDateFormat("dd-MMM-yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(date))%></td>
		<td align="right"><%=expectedStCount%></td>
		<td align="right"><%=SIstampCount %></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=zerotofifteen');"><%=count0_02%></a></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=zerotofifteen');"><%=count0_06%></a></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=sixteentothirty');"><%=count06_11%></a></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=thirtytosixty');"><%=count11_16 %></a></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=sixtyto120');"><%=count16_120%></a></td>
		<td align="right"><a href="" onclick="javascript:window.open('detailDataDelayCalculation.jsp?fromdate=<%=date%>&ownername=<%=transporter%>&vehregnumber=<%=vehregnumber%>&vehcode=<%=vehiclecode%>&unitid=<%=unitId%>&range=grtr120');"><%=countgrt_120%></a></td>
	</tr>		
<%		
			}
		}// end unitid while
	}
catch(Exception e){
	e.printStackTrace();
}
finally{
	
}
}	
%>
</table>
</form>
