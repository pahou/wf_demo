<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/js/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>print.jsp</title>

<link rel="stylesheet" href="<%=contextPath%>/css/print-preview.css" type="text/css" media="screen"></link>
<script src="<%=contextPath%>/js/jquery.print-preview.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	function print(){
		$('a.print').printPreview();
	}
	
</script> 
</head>
<body>
<a href="javascript:void(0);" class="easyui-linkbutton print"  plain="true" iconCls="icon-edit" onClick="print();">打印</a>
	<div id="aside">
		<h2>Test for print preview</h2>
		<div>
			<img src="<%=contextPath%>/images/feature-2.jpg" />
		</div>
		<h2>Test for print preview</h2>
		<h2>Test for print preview</h2>
		<h2>Test for print preview</h2>
	</div>
</body>
</html>