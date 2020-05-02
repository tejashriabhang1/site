package com;
import com.jcraft.jsch.*;
import java.io.*;

import sun.net.ftp.FtpClient;

class ScpFrom
{
	public static void main(String args[])
	{
		try
		{
					
			JSch jsch = new JSch();
		    Session session = null;
		    try {
		        session = jsch.getSession("dota", "ftp.mobileeye.in");
		        
		        java.util.Properties config = new java.util.Properties(); 
	        	config.put("StrictHostKeyChecking", "no");
	        	session.setConfig(config);
		        
		        session.setPassword("ku45ma23");
		        session.connect();

		        Channel channel = session.openChannel("sftp");
		        ChannelSftp sftpChannel = (ChannelSftp) channel;
		        sftpChannel.connect();
		        
		        System.out.println("==========getting===============");
		        try{
		        	System.out.println("=====got====");
		        sftpChannel.put("/home/javaprg/newjar/DotaCheck.txt", "/home/dota", ChannelSftp.OVERWRITE);
		        System.out.println("========File Copied============");
		        }
		        catch (Exception e) 
		        {
					System.out.println("Exception------->>"+e);
				}
		        sftpChannel.disconnect();
		        System.out.println("============File Uploaded=================");
		        sftpChannel.exit();
		        session.disconnect();
		        System.out.println("============File Uploaded=================");
		        
		    } catch (JSchException e) {
		        e.printStackTrace(); 
		    }
		}
		catch(Exception e)
		{
			System.out.print("Session Exception--------->>"+e);
		}
	}
}