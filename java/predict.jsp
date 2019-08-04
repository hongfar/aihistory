<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="application/json;charset=UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileUploadBase" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="net.coobird.thumbnailator.*" %>
<%@ page import="net.sf.json.*,java.awt.image.BufferedImage,javax.imageio.ImageIO" %> 
<%!
public String predict(String name)
{	
	String sTemp = "0";
	try
	{
		String exe = "python";
		String command = "C:\\Users\\Administrator\\Desktop\\eclipse\\workspace\\tensorflowTest\\src\\verifycode\\test.py";
		String num1 = name;
		String num2 = name;
		System.out.println("num1:"+num1);
		String[] cmdArr = new String[] {exe,command,num1,num2};
		Process process = Runtime.getRuntime().exec(cmdArr);
		InputStream is = process.getInputStream();
		DataInputStream dis = new DataInputStream(is);
		String str = "";
		while ((str = dis.readLine()) != null) 
		{
			sTemp = str; 
			System.out.println(sTemp);
		}
		dis.close();
		process.waitFor();  
	}
	catch(Exception ex)
	{
		System.out.println(ex);
	}
	
	return sTemp;
}
%> 
<%
	System.out.println("----------------------------");
	String predictValue = "0";
    String uploadFileName = "";		//上传的文件名
	String fieldName = "";			//表单字段元素的name属性值 
	//请求信息中的内容是否是multipart类型
	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	//上传文件的存储路径（服务器文件系统上的绝对文件路径）
	String uploadFilePath = "c:\\tensorflow\\temp\\";
	//创建临时文件目录路径
	File tempPatchFile=new File("c:\\tensorflow\\temp\\");
	if(!tempPatchFile.exists())  //判断文件或目录是否存在
		tempPatchFile.mkdirs();   //创建指定的目录，包括所有必需但不存在的父目录
	if (isMultipart) { 
		DiskFileItemFactory factory=new DiskFileItemFactory();
		//设置缓冲区大小4kb
		factory.setSizeThreshold(4096);   
		//设置上传文件用到临时文件存放路径
		factory.setRepository(tempPatchFile);   
		ServletFileUpload upload = new ServletFileUpload(factory);
		//设置单个文件的最大限制
		upload.setSizeMax(1024*1024);   
		try 
		{
			//解析form表单中所有文件
			List<FileItem> items = upload.parseRequest(request);
			Iterator<FileItem> iter = items.iterator(); 
			while (iter.hasNext()) {   //依次处理每个文件
				FileItem item = (FileItem) iter.next(); 
				

				if (!item.isFormField()){  //文件表单字段
					String fileName = item.getName();
					//通过Arrays类的asList()方法创建固定长度的集合
					List<String> filType=Arrays.asList("gif","bmp","jpg","png");
					String ext=fileName.substring(fileName.lastIndexOf(".")+1);
					if(!filType.contains(ext))  //判断文件类型是否在允许范围内
							System.out.print("上传失败，文件类型只能是gif、bmp、jpg");
					else{
						if (fileName != null && !fileName.equals("")) {
							File fullFile = new File(item.getName());
							File saveFile = new File(uploadFilePath, System.currentTimeMillis()+fullFile.getName());
							item.write(saveFile);
							uploadFileName = uploadFilePath + saveFile.getName(); 

							//压缩图片(begin)
							BufferedImage image = ImageIO.read(saveFile);
							int nWidth = image.getWidth();
							int nHeight = image.getHeight();

							if(nWidth!=120||nHeight!=40)
							{
								String newUploadFileName = uploadFilePath + "new" + saveFile.getName(); 
								Thumbnails.of(uploadFileName).size(120,40).toFile(newUploadFileName);
								uploadFileName = newUploadFileName;
							}
							//压缩图片(end)
 
							predictValue = predict(uploadFileName);
						}        
					}
				}
			}
		}catch(FileUploadBase.SizeLimitExceededException ex){
			System.out.print("上传失败，文件太大，单个文件的最大限制是："+upload.getSizeMax()+"bytes!");    
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	else
	{
		System.out.println("isMultipart:"+isMultipart);
	} 
	out.clear();
%> 
<% 
	JSONObject obj=new JSONObject();
    obj.put("verifycode",""+predictValue); 
    out.print(obj);
    out.flush(); 
%> 