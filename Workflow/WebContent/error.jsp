<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	import="org.apache.struts2.ServletActionContext,java.util.*"%>
<%
	String path = request.getContextPath();
	Map<String, Object> sessionMap = ServletActionContext.getContext()
	.getSession();
	String error = "跳转业务系统异常，即将关闭页面";
	if(sessionMap.containsKey("error")){
		error = (String) sessionMap.get("error");
	}
	System.out
	.println("================================================================");
	System.out.println("==================error信息：：：：" + error);
	System.out
	.println("================================================================");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/js/easyui1.3.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=path%>/js/easyui1.3.4/themes/icon.css">

<script type="text/javascript" src="<%=path%>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/js/easyui1.3.4/jquery.easyui.min.js"></script>
<script type="text/javascript">
	$(function() {
		//在页面右下角显示信息提示
		$.messager.show({
			title : '系统提示',
			msg : '<%=error%>',
			showType : 'slide'
		});
		setTimeout("custom_close();", 3000);

	});

	//父窗口跳转回登陆页面
	function toPrev() {
		var p = window;
		if (p != p.parent) {
			p = p.parent;
		}
		p.history.back(-1);
	}

	function custom_close() {
		if (confirm("您确定要关闭本页吗？")) {
			window.close();
		} else {
		}
	}
</script>
<title>错误页面</title>
</head>
<body>
</body>
</html>
