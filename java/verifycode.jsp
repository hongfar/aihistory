<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<% //���������ռ䣬�����ø�ҳ�������ΪͼƬ���� %>
<%@ page contentType="image/jpeg" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*" %>
<%!
	//���������������ɫ��bc�������fc��
	Color getRandColor(int fc,int bc)
	{
		Random random = new Random();
		if(fc>255) fc=255;
		if(bc>255) bc=255;
		//���������������Ȼ�����һ����ɫ
		int r=fc+random.nextInt(bc-fc);
		int g=fc+random.nextInt(bc-fc);
		int b=fc+random.nextInt(bc-fc);
		return new Color(r,g,b);
	}
%>
<%
	out.clear();//������resin�������������tomacat���Բ�Ҫ���
	String sRand = "";
	//response.setHeader("Pragma","No-cache");
	//response.setHeader("Cache-Control","no-cache");
	//response.setDateHeader("Expires", 0);
	int width=120, height=40;
	//����ͼƬ�Ŀ�ȡ��߶Ⱥ�ͼƬ���͡�
	BufferedImage image = new BufferedImage(width, height,BufferedImage.TYPE_INT_BGR);
	Graphics g = image.getGraphics();
	Random random = new Random();
	//���û��ʵ���ɫ
	g.setColor(getRandColor(200,250));
	//��һ�����α߿�
	g.fillRect(0, 0, width, height);
	//���û��ʵ�����
	g.setFont(new Font("Times New Roman",Font.PLAIN,36));
	g.setColor(getRandColor(160,200));
	//��������
	for (int i=0;i<155;i++)
	{
		int x = random.nextInt(width);
		int y = random.nextInt(height);
		int xl = random.nextInt(12);
		int yl = random.nextInt(12);
		g.drawLine(x,y,x+xl,y+yl);
	}


	//�����ֻ���ͼƬ��
	for (int i=0;i<4;i++){
		String rand=String.valueOf(random.nextInt(10));
		sRand+=rand;
		g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
		g.drawString(rand,26*i+12,32);
	}
	// ����֤�����SESSION
	session.setAttribute("rand",sRand);
	//�ͷ���Դ�����ͼƬ
	g.dispose();
	ImageIO.write(image, "JPEG", response.getOutputStream());
%>
 