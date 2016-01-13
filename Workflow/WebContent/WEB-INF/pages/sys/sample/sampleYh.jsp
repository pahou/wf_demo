<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%@include file="/js/common.jsp"%>


<script>


var opt = '<s:property value="opt"/>';
var load = 0;
$(function() {
	loadSelectRoot("yhwhtree");
	fixrownum('usergrid');
});
function getLinkage() {			//树和列表的联动
	//gridreload('usergrid',{hql:\"yhlist\",bmid:"+id+"})
	gridreload('usergrid',{hql:"yhlist",bmid:id});
/* 	var linkageparam = [];
	var usergrid = {};
	usergrid.yhwhtree="gridreload('usergrid',{hql:\"yhlist\",bmid:"+id+"})";
	linkageparam.push(usergrid);
	return linkageparam; */
}

function setTreeParam() {
	
}

function setGridParam(){
	//(1) 定义请求参数json,这里是根据后台的参数自由设置的
	var queryParam = {};
	queryParam.hql = "yhlist";
	
	//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
	var girdParamJson = {};
	girdParamJson.gridname = "usergrid";
	girdParamJson.rqstparam = queryParam;
	
	//(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
	var gridRqstJson = [];
	gridRqstJson.push(girdParamJson);
	
	//(4) 最终例子形如 ：[{"gridname":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
	return gridRqstJson; 
}

function setFormParam(){
	
}

		
</script>
<body  class="easyui-layout" style="width:100%;height:100%;" fit="true"  oncontextmenu="return false" onselectstart="return false">	
	<div region="west" split="true"  title="" style="width: 250px;">
		<ul id="yhwhtree"></ul>
	</div>
	
	<div id="userRight" region="center" split="true" title="" >
	  <div id="cc" class="easyui-layout" fit="true">
	      <div region="north" split="true" title="" style="height:150px;">
	          <fieldset class="fieldset_nav">
			      <legend>用户维护查询</legend>
		               <span id="form"> </span>
		      </fieldset>
	      </div>
	      <div  region="center" split="true" title="" >
		      <table id="usergrid"></table>
	     </div>
	   </div>
	</div>
</body>
</html>
