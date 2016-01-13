<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.util.List"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>imageUpload.jsp</title>
<%@ include file="/js/common.jsp"%><!-- 必须引入commo -->
<script type="text/javascript" src="<%=contextPath %>/js/upload.js"></script>
<link rel="stylesheet" href="<%=contextPath %>/css/upload.css">
</head>
<body>
	<div id="maskLayer">
		<div id="fade" class="black_overlay"></div>
		<div id="MyDiv" class="white_content">
			<div style="text-align: right; cursor: default; height: 40px;">
				<span style="font-size: 16px;"
					onclick="CloseMaskLayer('MyDiv','fade')">关闭</span>
			</div>
		</div>
	</div>
<!-- 图片上传 --start-->
<a href="javascript:void(0);" class="easyui-linkbutton" id="startUpload"  plain="true" iconCls="icon-edit" onClick="startUploadImg('uploader');">开始上传</a>
<a href="javascript:void(0);" class="easyui-menubutton" menu="#btedit" plain="true" iconCls="icon-edit" >编辑</a>
<div id="btedit" style="width:150px;">
	<div id="img_del" iconCls="icon-remove" onClick="imgEdit()">删除图片</div>
</div>
<!-- 上传框 -->
<div id="uploader"></div>
<!-- 图片上传 --end-->
</body>
</html>