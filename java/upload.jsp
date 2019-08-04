<%@ page language="java" import="java.io.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<html>
<head>
    <title>验证码测试</title>
</head>
<body>
<h1>验证码测试</h1>
 
<form action="predict.jsp" method="post" enctype="multipart/form-data">
    选择一个文件:
    <input type="file" name="uploadFile"/>
    <br/><br/>
    <input type="submit" value="测试"/>
</form>
</body>
</html>
