<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sample1</title>
</head>
<%@include file="/js/common.jsp"%><!-- 必须引入commo -->
<script>
var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
//使用了什么控件必须写一个相关的setParam方法
function setGridParam() {
	
}
function setFormParam(){
}
</script>
<body class="easyui-layout">
	<div id="usernorth" region="north" style="height: 140px; background:#f8f8f8;">
		<span id="queryform"> </span>
	</div>
	<div id="userRight" region="center">
				<table id="bmgrid"></table>
	</div>
</body>
</html>