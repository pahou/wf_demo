<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ include file="/js/common.jsp"%>
<script type="text/javascript" src="<%=contextPath %>/js/video.js"></script>
<link rel="stylesheet" href="<%=contextPath %>/css/upload.css">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<title>video.jsp</title>
</head>
<body style="allowfullscreen="true" webkitallowfullscreen="true" mozallowfullscreen="true" ">
	<a href="javascript:void(0);" class="easyui-linkbutton" id="startUploadVeo"  plain="true" iconCls="icon-edit" onClick="startUploadVeo('upload');">开始上传</a>
	<a href="javascript:void(0);" class="easyui-menubutton" menu="#veoedit" plain="true" iconCls="icon-edit" >编辑</a>
	<div id="veoedit" style="width:150px;">
		<div id="veo_del" iconCls="icon-remove" onClick="veoEdit()">删除视频</div>
	</div>
<!-- 上传框 -->
<div id="upload"></div>
</body>
</html>