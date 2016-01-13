<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>开启流程</title>
<%@include file="/js/common.jsp"%><!-- 必须引入commo -->
<script type="text/javascript"
	src="<%=basePath%>/js/activiti_operate.js"></script>
<script>
</head>
<script>
	
</script>
<body id="cc" class="easyui-layout">
	<div region="center">
		<table id="processGrid"></table>
	</div>
	<script>
	var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
		function setGridParam() {
		}
		function setFormParam() {
		}

		$(function() {
		});
	</script>
</body>
</html>