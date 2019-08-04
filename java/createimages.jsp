<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>
<% //���������ռ䣬�����ø�ҳ�������ΪͼƬ���� %>
<%@ page contentType="text/html" import="java.awt.*,java.awt.image.*,java.util.*,javax.imageio.*,org.apache.commons.io.IOUtils,java.io.*,javax.imageio.stream.ImageOutputStream" %>
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
out.println("����ͼƬ!");


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
			//����ͼƬ�Ŀ�ȡ��߶Ⱥ�ͼƬ���͡�
			String sRand = "";
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
				String rand = sArray[i];
				sRand += rand;
				g.setColor(new Color(20+random.nextInt(110),20+random.nextInt(110),20+random.nextInt(110)));
				g.drawString(rand,26*i+12,32);
			} 
			//�ͷ���Դ�����ͼƬ
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