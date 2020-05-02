<%@ include file="headerhtml.jsp" %>
<html>
<head>
<script language="javascript">
function validate()
{
	var techname=document.createidsform.techname.value;
	var mobno=document.createidsform.mobno.value;
	var location=document.createidsform.location.value;
	var techuname=document.createidsform.techuname.value;
	var mailto=document.createidsform.mailto.value;
	var contractid=document.createidsform.contractid.value;

	var exp=/^[a-zA-z]$/;
	
	var re=/^[A-Za-z0-9]+/;
	//var re=/^[0-9]*$/;
	if(contractid==""){
		alert("Enter Value For Contractor Id");
		return false;
	}else{
	if(!re.test(contractid))
	{
	alert("Enter Proper Value For Contractor Id");
	return false;
	}
}
	/* if(techname=="")
	{
		alert("Please Enter Technician Name");
		return false;
	}	
	else{
		
		
		 if(!/^[a-zA-Z\s]*$/g.test(techname))
		{
		 alert("Enter only characters in techname field");
		 return false; 
		} 
		
		
	}	 */
	/* if(techuname=="")
	{
		alert("Please Enter Tecnician User Name");
		return false;
	} */
	/* else{
		
		
		if(!/^[a-zA-Z\s]*$/g.test(techuname))
		{
		 alert("Enter only characters in techuname field");
		 return false; 
		}
	}	 */
	if(mobno=="")
	{
		alert("Please Enter Mobile Number");
		return false;
	} 
	else{
	if(isNaN(mobno))
	{
	  alert("Mobile number contain numbers only and 10-15 digits");
	  
	  return false;
	  
	}
 else
	{
	if((mobno.length<10 || mobno.length>15))
		{
		alert("Mobile number contains only 10 to 15 numbers ");
		  return false;
		}
	} 
	}
	/* if(location=="")
	{
		alert("Please Enter Location Name");
		return false;
	} */
	 if(location=="")
		{
			alert("Please Enter Location Name");
			return false;
		}
		else{
		
		
			if(!/^[a-zA-Z\s&]*$/g.test(location))
			{
			 alert("Enter only characters in location field");
			 return false; 
			}
		}	
		
	
	if(mailto=="")
	{
		alert("Please Enter Valid Email-Id");
		return false;
	}
	
}

</script>
</head>

<body>
<%
String tid=request.getParameter("tid");
String techname=request.getParameter("techname");
System.out.println("techname Tech Name :- "+techname);
String username=request.getParameter("techuname");
System.out.println("User Tech Name :- "+username);
String mobno=request.getParameter("mobno");
String emailid=request.getParameter("emailid");
String ContractorId=request.getParameter("ContractorId");

String location=request.getParameter("Location").replace("...","&");

%>

<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Edit Technician Data</b></i></font></td></tr>
<tr><td align="center">

<form name="createidsform" action="insert_edittech.jsp" onsubmit="return validate();">

	<table border="0" width="60%">
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Tech Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="techname" value="<%=request.getParameter("techname") %>"  readonly/> </td>
			 </td>
		</tr>
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Tech User Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="techuname" value="<%=username %>"  readonly/> </td>
			 </td>
		</tr>
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Mob No: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="mobno" value="<%=mobno%>" /> </td>
			 </td>
		</tr>
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Location: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="location" value="<%=location %>" /> </td>
			 </td>
		</tr>	
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Email: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="email" name="mailto" value="<%=emailid%>" multiple /> </td>
			 </td>
		</tr>	
		
			<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> ContractorID: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="contractid" value="<%=ContractorId %>" /> </td>
			 </td>
		</tr>
		<tr>
			<td colspan="2" align="center" bgcolor="#f5f5f5"> <input type="submit" name="submit" value="Update" class="formElement" /> </td>
		</tr>
	</table>
	<input type="hidden" name="tid" id="tid" value="<%=tid%>" />
</form>
</td></tr>
</table>
</body>
</html>
<%@ include file="footerhtml.jsp" %>