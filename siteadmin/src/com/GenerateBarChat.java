package com;

import java.awt.*; 
import java.io.* ;
import org.jfree.chart.* ;
import org.jfree.chart.axis.* ;
import org.jfree.chart.entity.* ;
import org.jfree.chart.plot.* ;
import org.jfree.chart.renderer.BarRenderer3D;
import org.jfree.data.CategoryDataset;

public class GenerateBarChat {

	/**
	 * @param args
	 * @return 
	 */
	public void genrateBarChat(String path,String Title,String ylable,String xlable,CategoryDataset dataset)
	{

       
										
       // final CategoryDataset dataset = DatasetUtilities.createCategoryDataset(
       //         barName, "Match", data);

        JFreeChart chart = null;
        BarRenderer3D renderer3D = null;
        CategoryPlot plot = null;

        
        final CategoryAxis3D categoryAxis = new CategoryAxis3D(ylable);
        final ValueAxis valueAxis = new NumberAxis3D(xlable);
     
        renderer3D = new BarRenderer3D();

        plot = new CategoryPlot(dataset, categoryAxis, valueAxis,renderer3D);
        plot.setOrientation(PlotOrientation.VERTICAL);
        chart = new JFreeChart(Title, JFreeChart.DEFAULT_TITLE_FONT, 
        plot, true);

        chart.setBackgroundPaint(new Color(249, 231, 236));

        try {
            final ChartRenderingInfo info = new ChartRenderingInfo
            (new StandardEntityCollection());
			 File file1=null;
			try {
				
				file1 = new File(path);
			} catch (Exception e) {
				System.out.println(e);
			}
            
            ChartUtilities.saveChartAsPNG(file1, chart, 600, 400, info);
        } catch (Exception e) {
           System.out.println("Print exception"+e);
        }
	}

}
