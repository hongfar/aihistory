<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<% //引用命名空间，并设置该页面的类型为图片类型 %>
<%@ page contentType="image/jpeg" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*" %>
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
	out.clear();//这句针对resin服务器，如果是tomacat可以不要这句
	String sRand = "";
	//response.setHeader("Pragma","No-cache");
	//response.setHeader("Cache-Control","no-cache");
	//response.setDateHeader("Expires", 0);
	int width=120, height=40;
	//设置图片的宽度、高度和图片类型。
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
		String rand=String.valueOf(random.nextInt(10));
		sRand+=rand;
		g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
		g.drawString(rand,26*i+12,32);
	}
	// 将认证码存入SESSION
	session.setAttribute("rand",sRand);
	//释放资源，输出图片
	g.dispose();
	ImageIO.write(image, "JPEG", response.getOutputStream());
%>
 