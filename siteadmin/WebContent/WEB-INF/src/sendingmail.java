import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;
import javax.activation.*;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Authenticator;
    
import java.util.*; 
import java.net.*;
import java.sql.*;
import java.text.*;

public class sendingmail extends HttpServlet
{
    public void service(HttpServletRequest request, HttpServletResponse response) throws IOException
    {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        //HttpSession session = request.getSession(true);
 
        //out.println("My name is Azhar G Bhat");

        String email=request.getParameter("UserName");
        String password=request.getParameter("Password");
        try
        {
              Properties props = new Properties();
              String host="smtp.transworld-compressor.com";
              String protocol="smtp";
              String user="a_bhat@transworld-compressor.com"; 
              String pass="gulzar123";
              props.put("mail.smtp.starttls.enable","true");
              props.put("mail.smtp.auth", "true");
              props.put("mail.smtp.user", "user");
              props.put("mail.smtp.password", "pass");  
              props.put("mail.store.protocol", protocol);
              props.put("mail.smtps.host", host);
              java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
              Session session = Session.getDefaultInstance(props, null);
               // Construct the message
               Message msg = new MimeMessage(session);
               msg.setSubject("User Name And Password for FleetView");
               Address add1=new InternetAddress(email,"");
               msg.addRecipient(Message.RecipientType.TO,add1);
               Address fromAddress=new InternetAddress("a_bhat@transworld-compressor.com","Transworld"); // in second "", it is short name
               msg.setFrom(fromAddress);
               msg.setContent("Hello Sir/Mam,\n\n\t Your User Name and Password for www.myfleetview.com is as follows, \n User Name :-"+email+" \n Password :- "+password+" \n\n Note :- Please Change your password After first login. \n\n\n\t Thanks and Regards, \n\t Transworld Team" ,"text/plain"); 
               // Send the message
               Transport t = session.getTransport("smtps");
               try
               {
                    t.connect(host, user, pass);
                    t.sendMessage(msg, msg.getAllRecipients());
                    //out.print("Your message has been sent");
               } 
               catch(Exception e)
               {
                   System.out.print("Exception----->"+e);
               } 
               finally 
               {
                   t.close();
               } 
          
               Transport.send(msg);

               //response.sendRedirect("mainpage.jsp?inserted=yes&ordrrno="+ordrrno);
               //return;  

       }
        catch(Exception e)
        {
              //out.println("Sorry, your mail cannot be sent due to Congestion");
              response.sendRedirect("mainpage.jsp");
              return; 
 
        }
    }  
}

