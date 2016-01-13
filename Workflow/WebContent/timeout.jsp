<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/js/easyui1.3.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=path%>/js/easyui1.3.4/themes/icon.css">

<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/easyui1.3.4/jquery.easyui.min.js"></script>
<script type="text/javascript">
$(function(){
	//在页面右下角显示信息提示
	$.messager.show({
		title:'系统提示',
		msg:'登陆已超时，即将跳转至登陆页面',
		showType:'slide'
	});
	setTimeout("toLogin();",3000);
	
});

//父窗口跳转回登陆页面
function toLogin(){
	var p = window;
	if(p!=p.parent){
		p = p.parent;
	}
	p.location.href = 'http://150.84.11.47:8080/zkpt/';
}
</script>
<title>超时跳转</title>
</head>
<body>
	
</body>
</html>