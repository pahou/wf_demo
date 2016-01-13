<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
</head>
<%@include file="/js/common.jsp"%>
<style>
.tabs li{width:84px;}
.tabs li a.tabs-inner {width:65px; padding: 0 10px 0 4px;}
.tabs li.tabs-selected a.tabs-inner{width:65px;}
</style>

<script>
var opt = '<s:property value="opt"/>';
var oldzh;
var modifySub;
	 $.extend($.fn.form.defaults, {
		onLoadSuccess : function(data) {
			loadTree('functiontree',{yhid:$("#id").val(),bmid:$("#bmid").val(),hqlid:"yhidfindgn"});
			checkTree('gxfwtree', id, 'yhwhoperate');
			checkCascadeTree('dlsqtree', id, '../function/functionOperate');
			oldzh = $("#zh").val();
		}
	}); 
$(function() {
	//设置combo不可键盘输入
	 $('.combo input').attr('readonly','readonly');
	fixrownum('bmjs');
	fixrownum('yyjs');
	fixrownum('wyjs');
	//alert(11);
	if(opt=="add"){
		$('#wyjs').datagrid({
			url:"../role/roleList!list.do"
		});
		$('#bmjs').datagrid({
			url:"../role/roleList!list.do"
		});
	}else{
		$('#zh').validatebox("disableValidation");
	}
	
	$('#can li').click(
		function() { //模块内容切换
			$(this).parent().find('li').removeClass('cur');
			$(this).addClass('cur');
			var index = $(this).parent().find('li').index(this); //获取当前元素的索引值  
			$(this).parents('#menu').find('#main').find('.fogo ')
					.removeClass('on').eq(index).addClass('on');
	});
	//点击树的时候，把部门ID设到bmid
	$("#bmmc").combotree({
		onClick: function(node){
			$('#bmid').val(node.id);
			gridreload('bmjs',{hqlid:"bmidfindjs",bmid:node.id});
			loadTree('functiontree','{yhid:"'+$("#id").val()+'",bmid:"'+node.id+'",hqlid:"yhidfindgn"}');
		}
	});
});

function setFormParam(){
	
	 //(1) 定义请求参数json,这里是根据后台的参数自由设置的
	var queryParam = {};
	queryParam.id = "";
	
	//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个form而定
	var formParamJson = {};
	formParamJson.formname = "ff";
	formParamJson.rqstparam = queryParam;
	
	
	//(3) 公共 js要用的，定义数组 格式为 ： [{"formname":"表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
	var formRqstJson = [];
	formRqstJson.push(formParamJson);
	
	//(4) 最终例子形如 ：[{"gridname":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
	return formRqstJson;	
	 
	
}

function setTreeParam() {
	var queryParam = {};
	queryParam.yhid = id;
	queryParam.hqlid = "yhidfindgxfw";
	
	var dlsqparams = {};
	dlsqparams.hqlid = "loginyhgn";
	
	var treeParamJson = {};
	treeParamJson.treename = "gxfwtree";
	treeParamJson.rqstparam = queryParam;
	
	var treeParamJson2 = {};
	treeParamJson2.treename = "dlsqtree";
	treeParamJson2.rqstparam = dlsqparams;
	
	var treeRqstJson = [];
	treeRqstJson.push(treeParamJson);
	treeRqstJson.push(treeParamJson2);
	
	return treeRqstJson;
}

function setGridParam(){
	//(1) 定义请求参数json,这里是根据后台的参数自由设置的
	var queryParambmjs = {};
	queryParambmjs.hqlid = "yhidfindbmjs";
	queryParambmjs.yhid = id;
	
	var queryParamyyjs = {};
	queryParamyyjs.hqlid = "yhidfindjs";
	queryParamyyjs.yhid = id;
	
	var queryParamwyjs = {};
	queryParamwyjs.hqlid = "yhidfindnotjs";
	queryParamwyjs.yhid = id;
	
	//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
	var girdParamJson = {};
	girdParamJson.gridname = "yyjs";
	girdParamJson.rqstparam = queryParamyyjs;
	
	var girdParamJson1 = {};
	girdParamJson1.gridname = "wyjs";
	girdParamJson1.rqstparam = queryParamwyjs;
	
	var girdParamJson2 = {};
	girdParamJson2.gridname = "bmjs";
	girdParamJson2.rqstparam = queryParambmjs;
	
	
	// (3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
	var gridRqstJson = [];
	gridRqstJson.push(girdParamJson);
	gridRqstJson.push(girdParamJson1);
	gridRqstJson.push(girdParamJson2);
	
	//(4) 最终例子形如 ：[{"gridname":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
	return gridRqstJson;
}
function saveUser(){
	var newzh = $("#zh").val();
	if(newzh == oldzh){
		$('#zh').validatebox("disableValidation");
	}else{
		$('#zh').validatebox("enableValidation");
	}
	if($('#ff').form("validate")){
		var gxfwcheckid = gettreeCheck("gxfwtree");//得到勾选的Id数组
		var formGridJson = saveJSONForMat();//form的json数据
		//grid修改后的数据
		//var yyjsJson = getGridChanges("yyjs", "TXtJsBm");
		var dlsqcheckid = gettreeCheck("dlsqtree");//得到勾选的Id数组
		$.ajax({
			type : "POST",
			url : "yhwhoperate!saveUser.do",
			data:'params={"gxfwcheckid":"'+gxfwcheckid +'","dlsqcheckid":"'+dlsqcheckid +'","yyjs":{"addlist":"'+addlist+'","deletelist":"'+deletelist+'"},"savedata":' + JSON.stringify(formGridJson) + '}',
			success : function() {
				$.messager.alert("提示信息","保存成功！","info",function(){
					location.href = "yhwh!toTree.do";
				});
			}
		});
	}else{
		$.messager.alert('提示','信息填写有误');   
		$('#zh').validatebox("disableValidation");
	}
	
}
</script>
<body id="cc" class="easyui-layout" style="width:100%;height:100%;" fit="true">
	<div region="center" split="true" title="">
		<div class="easyui-layout" fit="true">
			<div region="north" title="" split="true" style="height: 170px;">
			<span id="thtoolbar"></span>
<!-- 				<div class="toolbar">
			         <a  href="#" class="easyui-linkbutton" plain="true" iconCls="icon-save"  id="btn" onClick="saveUser()">保存</a>
			         <a  href="#" class="easyui-linkbutton" plain="true" iconCls="icon-back" onClick="javascript:history.back(-1);">取消</a>
		            </div> --> 
				<span id="form"> </span>	
			</div>
			<div region="west" split="true" title="部门已分配角色" style="width: 250px;">
				<table id="bmjs"></table>
			</div>
			<div id="menu" region="east" iconCls="icon-reload" title="" split="true" style="width: 275px;">
				<div id="tt" class="easyui-tabs" style="height:250px;" fit="true">   
                 <div title="用户角色功能" >   
                    <ul id="functiontree"></ul>
                 </div>   
                 <div title="独立授权"  >   
                    <ul id="dlsqtree"></ul>
                 </div>   
                 <div title="管辖范围"  >   
                     <ul id="gxfwtree"></ul> 
                 </div>   
              </div> 


			</div>
			<div region="center" title="">
				<div id="cc" class="easyui-layout" style="width: 100%; height: 100%;"  fit="true">
					<div region="north" title="已分配角色" split="true" style="height: 200px;">
						<table id="yyjs"></table>
					</div>
					<div region="center" title="未分配角色" split="true">
						<table id="wyjs"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
