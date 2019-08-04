<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<% //引用命名空间，并设置该页面的类型为图片类型 %>
<%@ page contentType="text/html" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*,org.apache.commons.io.IOUtils,java.io.*,javax.imageio.stream.ImageOutputStream" %>
<%!
	//利用随机数产生颜色（bc必须大于fc）
	Color getRandColor(int fc,int bc)
	{
		Random random = new Random();
		if(fc>255) fc=255;
		if(bc>255) bc=255;
		//产生三个随机数，然后定义出一种颜色
		int r=fc+random.nextInt(bc-fc);
		int g=fc+random.nextInt(bc-fc);
		int b=fc+random.nextInt(bc-fc);
		return new Color(r,g,b);
	}
%>
<%
out.println("生成图片!");


String[] sArray = new String [4];

for(int k0=0;k0<=9;k0++)
{ 
	sArray[0] = "" + k0;
	for(int k1=0;k1<=9;k1++)
	{
		sArray[1] = "" + k1;
		for(int k2=0;k2<=9;k2++)
		{
			sArray[2] = "" + k2;
			for(int k3=0;k3<=9;k3++)
			{
				sArray[3] = "" + k3; 
				createImage(sArray);
			}
		}
	}
} 



%>

<%!
	public void createImage(String[] sArray)
	{
		try
		{
			int width=120, height=40;
			//设置图片的宽度、高度和图片类型。
			String sRand = "";
			BufferedImage image = new BufferedImage(width, height,BufferedImage.TYPE_INT_BGR);
			Graphics g = image.getGraphics();
			Random random = new Random();
			//设置画笔的颜色
			g.setColor(getRandColor(200,250));
			//画一个矩形边框
			g.fillRect(0, 0, width, height);
			//设置画笔的字体
			g.setFont(new Font("Times New Roman",Font.PLAIN,36));
			g.setColor(getRandColor(160,200));
			//画干扰线
			for (int i=0;i<155;i++)
			{
				int x = random.nextInt(width);
				int y = random.nextInt(height);
				int xl = random.nextInt(12);
				int yl = random.nextInt(12);
				g.drawLine(x,y,x+xl,y+yl);
			}
			//将文字画入图片内
			for (int i=0;i<4;i++){
				String rand = sArray[i];
				sRand += rand;
				g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
				g.drawString(rand,26*i+12,32);
			} 
			//释放资源，输出图片
			g.dispose(); 
			System.out.println(sRand);
			saveImgFile(image,sRand);
		}
		catch(Exception ex)
		{
			System.out.println(ex);
		} 
	}
	public void saveImgFile(BufferedImage image,String name)
	{
		try
		{
			ByteArrayOutputStream bs = new ByteArrayOutputStream(); 
			ImageOutputStream imOut = ImageIO.createImageOutputStream(bs); 
			ImageIO.write(image, "jpg", imOut); 
			InputStream inputStream = new ByteArrayInputStream(bs.toByteArray());

			OutputStream outStream = new FileOutputStream("C:\\temp\\"+name+".jpg");
			IOUtils.copy(inputStream, outStream);
			inputStream.close();
			outStream.close();
		}
		catch(Exception ex)
		{
			System.out.println(ex);
		}
	}
%>