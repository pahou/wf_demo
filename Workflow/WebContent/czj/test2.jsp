
<%@ page contentType="application/msword;charset=gb2312" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body >
<%
File f=new File("E:/开发环境搭建.doc");
FileInputStream fin=new FileInputStream(f);
OutputStream output=response.getOutputStream();
byte[] buf=new byte[1024];
int r=0;
response.setContentType("application/msword;charset=GB2312");
while((r=fin.read(buf,0,buf.length))!=-1)
{
output.write(buf,0,r);//response.getOutputStream()
}
fin.close();
output.close();
%>

</body>
</html>