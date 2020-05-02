<%@ include file="headerhtml.jsp" %>
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
	
	
	if(techname=="")
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
	}	
	if(techuname=="")
	{
		alert("Please Enter Tecnician User Name");
		return false;
	}
else{
		
		
		if(!/^[a-zA-Z\s]*$/g.test(techuname))
		{
		 alert("Enter only characters in techuname field");
		 return false; 
		}
	}	
	 if(mobno=="")
	{
		alert("Please Enter Mobile Number");
		return false;
	} 
	 else{
	if(isNaN(mobno))
		{
		  alert("Mobile number contain numbers only and 15 digits");
		  
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
		alert("Please Enter valid Email-Id");
		return false;
	}
	
}

</script>
<table border="0" align="center" width="100%">
<tr><td align="center"><font color="brown" size="2"><b><i>Add New Technician</b></i></font></td></tr>
<tr><td align="center">

<form name="createidsform" action="insertech.jsp" onsubmit="return validate();">

	<table border="0" width="60%">
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Tech Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="techname"/> </td>
			 </td>
		</tr>
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Tech User Name: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="techuname"/> </td>
			 </td>
		</tr>
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Mob No: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="mobno"/> </td>
			 </td>
		</tr>
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Location: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="location"/> </td>
			 </td>
		</tr>	
	<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> Email: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="email" name="mailto" multiple/> </td>
			 </td>
		</tr>	
		<tr>
		
		<tr>
			<td bgcolor="#f5f5f5"> <font color="maroon"> <B> ContractorID: </B> </font> </td>
			<td bgcolor="#f5f5f5"> <td bgcolor="#f5f5f5"> <input type="text" name="contractid"/> </td>
			 </td>
		</tr>	
		<tr>
			<td colspan="2" align="center" bgcolor="#f5f5f5"> <input type="submit" name="submit" value="Submit" class="formElement" /> </td>
		</tr>
	</table>
</form>
</td></tr>
</table>
<%@ include file="footerhtml.jsp" %>