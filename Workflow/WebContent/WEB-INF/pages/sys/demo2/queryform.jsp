<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<title>编辑用户信息</title>
<%@include file="/js/common.jsp"%>

<script>
	var opt = '<s:property value="opt"/>';
	var modifySub;
	$(function() {
		savebtn("btn", "tablemainoperate", "#ff input[name]", new Array(
		"tablefollow"), new Array("TableFollow"), "queryform!toList.do");
	});
	 function setFormParam(){
		//(1) 定义请求参数json,这里是根据后台的参数自由设置的
		var queryParam = {};
		queryParam.id = id;
		//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
		var formParamJson = {};
		formParamJson.formname = "ff";
		formParamJson.rqstparam = queryParam;
		
		
		//(3) 公共 js要用的，定义数组 格式为 ： [{"formname":"form名","rqstparam":{"XXX":value,"YYY":value,.....}}]
		var formRqstJson = [];
		formRqstJson.push(formParamJson);
		
		//(4) 最终例子形如 ：[{"gridname":"tt","restparam":{"jsId":1,"jsId2":2}}]
		//alert(JSON.stringify(treeRqstJson)); 
		return formRqstJson;
	}
	function setGridParam(){
		//(1) 定义请求参数json,这里是根据后台的参数自由设置的
		var queryParam = {};
		queryParam.masterId = id;
		
		//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
		var girdParamJson = {};
		girdParamJson.gridname = "queryform";
		girdParamJson.rqstparam = queryParam;
		
		
		//(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
		var gridRqstJson = [];
		gridRqstJson.push(girdParamJson);
		
		//(4) 最终例子形如 ：[{"gridname":"tt","restparam":{"jsId":1,"jsId2":2}}]
		//alert(JSON.stringify(treeRqstJson)); 
		return gridRqstJson;
	}
</script>
</head>
<body class="easyui-layout">
	<div id="usernorth" region="north" style="height: 140px; background:#f8f8f8;">
		
		<span id="form"> </span>
	</div>

	<!-- <div id="_dd" class="easyui-dialog" title="" icon="">
	<span id="s_dialog"> </span>
	</div> -->

	<div id="userRight" region="center">
				<table id="queryform"></table>
	</div>
</body>
</html>