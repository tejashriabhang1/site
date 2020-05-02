package com;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.*;

public class GenerateKML {

                static Connection conn1=null;
                //static Connection conn2=null;
                static Connection conn3=null;
                static Connection conn4=null;
                static Statement st=null;
                static Statement st1=null;
                static Statement st2=null;
                static Statement st3=null;
                static Statement st4=null;
                static Statement st5=null;
                static Statement taxi1=null;
                static Statement taxi2=null;
                static Statement stinsert=null;
                static Date today=new Date();   
                static Format frt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                static Format frt1=new SimpleDateFormat("yyyy-MM-dd");
                static Format frt2=new SimpleDateFormat("HH:mm:ss");    
                
                
                public static void GetConnection()
                {
                        try
                        {
                                Class.forName("org.gjt.mm.mysql.Driver");
                                conn1= DriverManager.getConnection("jdbc:mysql://103.241.181.36/db_gps","ujjain","u@1jn");
                              //  conn2= DriverManager.getConnection("jdbc:mysql://103.241.181.36/db_gpsExceptions","ujjain","u@1jn");
                               conn3= DriverManager.getConnection("jdbc:mysql://103.241.181.36/db_avlalldata","ujjain","u@1jn");
                              // conn4= DriverManager.getConnection("jdbc:mysql://103.241.181.36/test","ujjain","u@1jn");
                               // stinsert=conn4.createStatement();
                                st=conn1.createStatement();
                                st1=conn1.createStatement();
                                st2=conn1.createStatement();
                                st3=conn1.createStatement();
                                st4=conn1.createStatement();
                                st5=conn1.createStatement();
                                System.out.println("In Open Connection");                               
                        }catch (Exception e) {
                                System.out.print("GetConnection Exception ---->"+e);    
                        }
                }
                public static void CloseConnection() {
                        try{
                               // stinsert.close();
                                st.close();
                                st1.close();
                                st2.close();
                                st3.close();
                                st4.close();
                                st5.close();
                                conn1.close();
                                //conn2.close();
                                conn3.close();
                                conn4.close();
                                System.out.println("In Colose Connection");
                                }catch (Exception e) {
                                System.out.print("CloseConnection Exception---->"+e);
                        }
                        
                }
        public Boolean gettripdetails(String trip,String directory,String startloc,String endloc,String user){
        
        	  boolean flag=false;
                GetConnection();
                try {
                	
                	  
                        int i=1;
                        String sql="";
                      Date dt=new Date();
                      String datetime=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(dt);
                        StringTokenizer str=new StringTokenizer(trip,",");
                        
                       // String sql="select * from t_kmltrip where status='1' order by startpalce,endplace";
                       // ResultSet tripRst=st.executeQuery(sql);
                        //while(tripRst.next())
                      //  {
                        while(str.hasMoreTokens())
                        {
                                String tripid=null,vehid=null,startDate=null,endDate=null,endTime=null,startTime=null,color=null;
                                //int tripDistance=0;
                                tripid=str.nextToken().trim();
                               
                                //--------- if duplicate record not found then only generate
                               
                                HashMap<String, String> coordinateMap = null;
                                HashMap<String, String> coordinateMapStart = null;
                                HashMap<String, String> coordinateMapEnd = null;
                                List<HashMap<String, String>> coordinateList = null;
                                 String sql2="select * from t_completedjourney where tripid='"+tripid+"' order by KmTravelled desc ";
                               
                                 System.out.println(sql2);
                                 ResultSet comJourRst=st1.executeQuery(sql2);
                                if(comJourRst.next())
                                {
                                vehid=comJourRst.getString("vehid");
                                startDate=comJourRst.getString("StartDate");
                                endDate=comJourRst.getString("EndDate");
                                endTime=comJourRst.getString("EndTime");
                                startTime=comJourRst.getString("StartTime");
                                }
                                System.out.print(vehid);
                                if(!(startDate!=null && startDate.trim().length()<=10))
                                {
                                        startDate=startDate+" "+startTime;
                                }
                                
                                if(!(endDate!=null && endDate.trim().length()<=10))
                                {
                                        endDate=endDate+" "+endTime;
                                }
                        
                                coordinateList=new ArrayList<HashMap<String, String>>();
                                Double startdist=0.0,enddist=0.0;
                                if(vehid!=null)
                                {
                                String sql10 = "SELECT Distance,LatinDec,LonginDec,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehid+" where concat(TheFieldDataDate,' ',TheFieldDataTime) between '"+ startDate+"' and  '"+endDate+"' and LatinDec>0 order by TheFieldDataDate asc,TheFieldDataTime asc limit 1";
                               System.out.println(sql10);
                                ResultSet rs11 = st1.executeQuery(sql10);
                                System.out.println("query executed");
                                if(rs11.next())
                                {
                                	 System.out.println("data available");
                                	startdist=rs11.getDouble("Distance");
                                	 String de="";
                                	 de= rs11.getString("TheFieldSubject")+"  Trip ID is "+tripid;
                                	 System.out.println("de---->"+de);
                                        coordinateMapStart =  new java.util.HashMap<String, String>();
                                        coordinateMapStart.put("name",rs11.getString("TheFieldSubject"));
                                        coordinateMapStart.put("desc",de);
                                        coordinateMapStart.put("lat",rs11.getString("LatinDec")); 
                                        coordinateMapStart.put("longi",rs11.getString("LonginDec"));  
                                  
                                }
                                
                                
                                sql10 = "SELECT LatinDec,LonginDec,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehid+" where concat(TheFieldDataDate,' ',TheFieldDataTime) between '"+ startDate+"' and  '"+endDate+"' and LatinDec>0 order by TheFieldDataDate desc,TheFieldDataTime desc";
                                //out.println("sql10="+sql10);
                                System.out.println(sql10);
                                ResultSet rs10 = st1.executeQuery(sql10);
                                while(rs10.next())
                                {
                                        //System.out.println("=====In side getMapDetails== rst.nxt()==");
                                	// String de="";
                                	// de= rs11.getString("TheFieldSubject")+"  Trip ID is "+tripid;
                                	// System.out.println("de---->"+de);
                                	System.out.println(rs10.getString("LonginDec"));
                                		coordinateMap =  new java.util.HashMap<String, String>();
                                        coordinateMap.put("name",rs10.getString("TheFieldSubject"));
                                        coordinateMap.put("desc",rs10.getString("TheFieldSubject"));
                                        coordinateMap.put("lat",rs10.getString("LatinDec")); 
                                        coordinateMap.put("longi",rs10.getString("LonginDec"));
                                        coordinateList.add(coordinateMap);
                                      
                                        //System.out.println("\ncoordinateString===>>"+coordinateString);
                                }
                                
                                sql10 = "SELECT Distance,LatinDec,LonginDec,TheFieldSubject,TheFieldDataDate,TheFieldDataTime  FROM t_veh"+ vehid+" where concat(TheFieldDataDate,' ',TheFieldDataTime) between '"+ startDate+"' and  '"+endDate+"' and LatinDec>0 order by TheFieldDataDate desc,TheFieldDataTime desc limit 1";
                                //out.println("sql10="+sql10);
                                System.out.println(sql10);
                                ResultSet rs12 = st1.executeQuery(sql10);
                                if(rs12.next())
                                {    enddist=rs12.getDouble("Distance");
                                		String de="";
                           	 			de= rs12.getString("TheFieldSubject")+"  Trip ID is "+tripid;   
                           	 		 System.out.println("de---->"+de);
                           	 			coordinateMapEnd =  new java.util.HashMap<String, String>();
                                        coordinateMapEnd.put("name",rs12.getString("TheFieldSubject"));
                                        coordinateMapEnd.put("desc",de);
                                        coordinateMapEnd.put("lat",rs12.getString("LatinDec")); 
                                        coordinateMapEnd.put("longi",rs12.getString("LonginDec"));   
                                       
                                }
                                
                               Double dist=enddist-startdist;
                                
                                String dirctory=directory+tripid+".kml";
                                //String dirctory="/home/manoj/KML/"+tripid+".kml";
                                if(i==0)
                                        color="5f7800F0"; //pink
                                else if (i==1)
                                        color="5f14780A"; // green
                                else if (i==2)
                                        color="5f14F014"; // blue
                                else if (i==3)
                                	 color="5f14F0FF";
                                else if (i==4)
                               	 color="5f7814B4"; 
                                else if (i==5)
                               	 color="5f143CB4"; //brown
                                else if (i==6)
                               	 color="5f004614"; //dark green
                                else if (i==7)
                               	 color="5fFF78F0"; //pink
                                else if (i==8)
                               	 color="5fF0FA14"; //blue
                                else if (i==9)
                               	 color="5f1478AA";
                                else if (i==10)
                               	 color="5f781E78";
                                else 
                                {
                                        color="5fF07814";       //dark bule
                                        i=0;
                                }
                                System.out.println(sql10);
                               
                                 flag=generateKMLFORLINE(coordinateList,dirctory,coordinateMapStart,coordinateMapEnd,color);
                                
                                 
                                 
                                if(flag)
                                {
                                	
                                	 boolean got=false;
                                     String que="Select * from t_kmltrip where tripid='"+tripid+"'";
                                     System.out.println(que);
                                     ResultSet rst=st4.executeQuery(que);
                                     if(rst.next())
                                     {
                                                 	got=true;
                                     }
                               	if(got==false)
                               	{
                                sql="Insert into t_kmltrip(tripid,startpalce,endplace,Distance,status,kmlfilename,Datetime,EntBy,color) values('"+tripid+"','"+startloc+"','"+endloc+"','"+dist+"','1','"+tripid+".kml','"+datetime+"','"+user+"','"+color+"')";
                                System.out.println(sql);
                               
                                st2.executeUpdate(sql);
                               
                                }
                               	else
                               	{
                               		sql="Update t_kmltrip set tripid='"+tripid+"', startpalce='"+startloc+"',endplace='"+endloc+"',Distance='"+dist+"',status='1',kmlfilename='"+tripid+".kml',Datetime='"+datetime+"',EntBy='"+user+"',color='"+color+"' where tripid='"+tripid+"'";
                               	 System.out.println(sql);st3.executeUpdate(sql);
                               	
                               	}
                                }
                                System.out.println(sql);
                                String sql1="Insert into t_kmltriphistory(tripid,startpalce,endplace,Distance,status,kmlfilename,Datetime,EntBy,color) values('"+tripid+"','"+startloc+"','"+endloc+"','"+dist+"','1','"+tripid+".kml','"+datetime+"','"+user+"','"+color+"')";
                                System.out.println(sql1);  st4.executeUpdate(sql1);
                               
                                i++;
                                }//if
                                
                        }
                      
                } catch (Exception e) {
                        System.out.println("print ex"+e);
                        
                }
                CloseConnection();
                return flag;
        }

        
        public static boolean generateKML(List<HashMap<String, String>> coordinatesList ,String fileName)
        {
                
                //generate the KML as well as the markers for the kml file
                boolean flag=false;
                System.out.println(":::GEN KML CALLED::::");
                String outputString ="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"+
                                                         "<kml xmlns=\"http://www.opengis.net/kml/2.2\">\n" +
                                "   <Document>";
                
                String name = "";
                String description="";
                String coordinates = "";
                for (Iterator<HashMap<String, String>> iterator = coordinatesList.iterator(); iterator.hasNext();)
                {
                        HashMap<String,String>  coordinateMap = (HashMap<String, String>) iterator.next();
                        
                        //this is for creating line item
                        coordinates+= coordinateMap.get("longi")+ "," + coordinateMap.get("lat")+",0 ";
                        
                        name = (String)coordinateMap.get("name");
                        description = (String)coordinateMap.get("desc");
                        
                        
                        // Creating Point item
                        outputString +="<Placemark>\n" +
                                "<name>"+name+"</name>\n"+
                                "<description>"+description+"</description>\n";
                                outputString +="<Point>\n"+
                                                                        "<coordinates>"+coordinateMap.get("longi")+ "," + coordinateMap.get("lat")+"</coordinates>\n"+
                                                                "</Point>\n"+
                                                        "</Placemark>\n";
                }
                
                // Creating LineString
                outputString +="<Placemark>\n" +
                "<name>"+name+"</name>\n"+
                "<description>"+description+"</description>\n";
                outputString +="<LineString>\n"+
                                                                "<coordinates>"+coordinates+"</coordinates>\n"+
                                                        "</LineString>\n"+
                                                "</Placemark>\n";
                
                outputString +="</Document>\n"+
                                                "</kml>\n";

                System.out.println("Generated KML file :::\n"+outputString);
                try
                {
                        File f=new File(fileName);
                        FileOutputStream fop=new FileOutputStream(f);
                        fop.write(outputString.getBytes());
                        fop.close();
                        flag=true;
                }
                catch(Exception e)
                {
                        e.printStackTrace();
                }
                return flag;

        }

        public static boolean generateKMLFORLINE(List<HashMap<String, String>> coordinatesList ,String fileName,HashMap<String, String> startMarker,HashMap<String, String> endMarker,String color)
        {
                boolean flag=false;
                //to generate only the KML File with start and end marker
                //System.out.println(":::GEN KML CALLED::::");
                String outputString ="<?xml version='1.0' encoding='utf-8'?><kml xmlns='http://earth.google.com/kml/2.0'>" +
                                "<Folder><name>Shapefile Converter Generated File</name><open>1</open>\n"+
                                "<Placemark>\n"+
                                "<name> </name>\n"+
                                "<Style>\n"
                                + "<LineStyle><color>"+color+"</color><width>3</width>" +
                                                "</LineStyle></Style>";



                
                String name = "";
                String description="";
                String coordinates = "";
                // Creating LineString
                System.out.println("step1");
                for (Iterator<HashMap<String, String>> iterator = coordinatesList.iterator(); iterator.hasNext();)
                {
                        HashMap<String,String>  coordinateMap = iterator.next();
                        
                        //this is for creating line item
                        coordinates+= coordinateMap.get("longi")+ "," + coordinateMap.get("lat")+",0 ";
                                
                }
                System.out.println("&&&&&&&&&=="+coordinates);
                outputString +="<LineString>\n"+
                                                                "<coordinates>"+coordinates+"</coordinates>\n"+
                                                        "</LineString>\n"+
                                                "</Placemark>\n";
                System.out.println("step3");
                
                System.out.println(startMarker);
                coordinates+= startMarker.get("longi")+ "," + startMarker.get("lat")+",0 ";
                
                                
                System.out.println("step4");
                
                // Creating Point item
                                //start point
                name=startMarker.get("name");
                name=name.replaceAll("&", " ");
                name=name.replaceAll("-", " ");
                System.out.println("step5");
                description=startMarker.get("desc");
                System.out.println("step4"+description);
                description=description.replaceAll("&", " ");
                description=description.replaceAll("-", " ");
                System.out.println("step6");
                outputString +="<Placemark>\n" +
                        "<name>"+name+"</name>\n"+
                        "<description>"+description+"</description>\n";
                        outputString +="<Point>\n"+
                                                                "<coordinates>"+startMarker.get("longi")+ "," + startMarker.get("lat")+"</coordinates>\n"+
                                                        "</Point>\n"+
                                                "</Placemark>\n";
                        
                        //end point
                        name=endMarker.get("name");
                        name=name.replaceAll("&", " ");
                        name=name.replaceAll("-", " ");
                        description=endMarker.get("desc");
                        description=description.replaceAll("&", " ");
                        description=description.replaceAll("-", " ");
                        
                        outputString +="<Placemark>\n" +
                        "<name>"+name+"</name>\n"+
                        "<description>"+description+"</description>\n" +
                        		 "<Style id='starticonsty'>"+
                                                "<IconStyle id='start'>"+
                                                "<Icon>"+
                                                "<href>http://www.myfleetview.com/hpcl/images/mm_20_red.png</href>"+
                                                "</Icon>"+
                                                "</IconStyle>"+
                                                "</Style>"+
                        "<styleUrl>#starticonsty</styleUrl>";
                        outputString +="<Point>\n"+
                                                                "<coordinates>"+endMarker.get("longi")+ "," + endMarker.get("lat")+"</coordinates>\n"+
                                                        "</Point>\n"+
                                                "</Placemark>\n";
                        
                outputString +="</Folder>\n"+
                                                "</kml>\n";
                
                

               // System.out.println("Generated KML file :::\n"+outputString);
                try
                {
                        File f=new File(fileName);
                        System.out.println(f);
                        FileOutputStream fop=new FileOutputStream(f);
                        fop.write(outputString.getBytes());
                        fop.close();
                        flag=true;
                }
                catch(Exception e)
                {
                        e.printStackTrace();
                }
                return flag;

        }

        public void generatecustomKML(String fileName)
        {
                //to find out the nearest location and ploting the markers on the map
                GetConnection();
                java.util.HashMap<String, String> coordinateMap = null;
                List<HashMap<String, String>> coordinateList = new ArrayList<HashMap<String, String>>();
                 
                try {
                        String sql="select * from t_klmdata group by lat,lon order by rid";
                        ResultSet rs10=st.executeQuery(sql);
                        while(rs10.next())
                                {
                                String location=null,lat=null,lon=null;
                                lat=rs10.getString("Lat");
                                lon=rs10.getString("Lon");
                                String sql3="SELECT city,lat,lon,((ACOS(SIN('"+rs10.getString("Lat")+"' * PI() / 180) * SIN(lat * PI() / 180) + COS('"+rs10.getString("Lat")+"' * PI() / 180) * COS(lat * PI() / 180) * COS(('"+rs10.getString("Lon")+"' - lon) * PI() / 180)) * 180 / PI()) * 60 * 1.1515) AS distance FROM t_citylatlong order by  distance ASC limit 1";
                                System.out.println(sql3);
                                ResultSet rs4=st1.executeQuery(sql3);
                                if(rs4.next())
                                {       
                                        location =rs4.getString("city");
                                }
                                
                                coordinateMap =  new java.util.HashMap<String, String>();
                                coordinateMap.put("name",location);
                                coordinateMap.put("desc", location);
                                coordinateMap.put("lat",lat); 
                                coordinateMap.put("longi",lon);                         
                                coordinateList.add(coordinateMap);
                                
                                }
                        System.out.println(":::GEN KML CALLED::::");
                        String outputString ="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"+
                                                                 "<kml xmlns=\"http://www.opengis.net/kml/2.2\">\n" +
                                        "   <Document>";
                        
                        String name = "";
                        String description="";
                        String coordinates = "";
                        for (Iterator<HashMap<String, String>> iterator = coordinateList.iterator(); iterator.hasNext();)
                        {
                        HashMap<String,String>  coordinateMap1 = iterator.next();
                                
                                //this is for creating line item
                                coordinates+= coordinateMap1.get("longi")+ "," + coordinateMap1.get("lat")+",0 ";
                                
                                name = (String)coordinateMap1.get("name");
                                description = (String)coordinateMap1.get("desc");
                                
                                
                                // Creating Point item
                                outputString +="<Placemark>\n" +
                                        "<name>"+name+"</name>\n"+
                                        "<description>"+description+"</description>\n";
                                        outputString +="<Point>\n"+
                                                                                "<coordinates>"+coordinateMap1.get("longi")+ "," + coordinateMap1.get("lat")+"</coordinates>\n"+
                                                                        "</Point>\n"+
                                                                "</Placemark>\n";
                        }
                        
                        
                        
                        outputString +="</Document>\n"+
                                                        "</kml>\n";

                        System.out.println("Generated KML file :::\n"+outputString);
                        try
                        {
                                File f=new File(fileName);
                                FileOutputStream fop=new FileOutputStream(f);
                                fop.write(outputString.getBytes());
                                fop.close();
                        }
                        catch(Exception e)
                        {
                                e.printStackTrace();
                        }
                        
                } catch (Exception e) {
                        
                        System.out.println(e);
                }
                
              //  CloseConnection();
        }
}
