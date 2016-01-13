<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>sample1_edit</title>
</head>
<%@include file="/js/common.jsp"%><!-- 必须引入commo -->
<script>
$(function() {
	//第一个参数是需要绑定方法的按钮ID
	//第二个参数是调用的actionname
	//第三个参数是从表id，格式要Array，没有从表也可以是null
	//第四个参数是从表entity，格式要Array，没有从表也可以是null
	//第五个参数是保存成功后跳转的链接
	//第六个参数是主表ID
	savebtnByFormId("btn", "sampleOperate1", new Array("yhgrid"), new Array("TXtYh"), "sample1!toList.do", "bmform");
});
var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
//使用了什么控件必须写一个相关的setParam方法
function setGridParam() {
	//(1) 定义请求参数json,这里是根据后台的参数自由设置的
	var queryParam = {};
	queryParam.id = id;//id是在跳转的时候传递的主表ID
	
	//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个grid而定
	var girdParamJson = {};
	girdParamJson.gridname = "yhgrid";
	girdParamJson.rqstparam = queryParam;
	
	// (3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
	var gridRqstJson = [];
	gridRqstJson.push(girdParamJson);
	
	//(4) 最终例子形如 ：[{"gridname":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
	return gridRqstJson;
}

function setFormParam(){
}
</script>
<body class="easyui-layout">
	<div id="usernorth" region="north" style="height: 140px; background:#f8f8f8;">
	<div class="toolbar">
			         <a  href="#" class="easyui-linkbutton" plain="true" iconCls="icon-save"  id="btn" >保存</a>
			         <a  href="#" class="easyui-linkbutton" plain="true" iconCls="icon-back" onClick="javascript:history.back(-1);">取消</a>
	</div>
		<span id="form"> </span>
	</div>
	<div id="userRight" region="center">
				<table id="yhgrid"></table>
	</div>
</body>
</html>