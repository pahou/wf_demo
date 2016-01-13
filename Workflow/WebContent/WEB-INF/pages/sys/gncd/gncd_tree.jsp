<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--  <% String contextPath = request.getContextPath();%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<title>功能菜单</title>
<%@include file="/js/common.jsp"%>
<style>
</style>
</head>

<body class="easyui-layout">
	<span id='menu'></span>
	<div id="userLeft" region="west" title="" split="true"	style="width: 200px;">
	<ul id="tt"></ul>  
	</div>
	<div id="userRight" region="center" title="" split="true">
	<span id="form"> </span>
		<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveTree('tt','gncdOperate')" disabled = true>保存</a>
			<!-- 1为角色ID现在写死可以通过事件触发的，也可以是当前用户的ID或者点击修改是保存的一个参数 ，可以是JSON也可以是值，看后台需要什么来传值-->
	</div>
	<script type="text/javascript">
	
		function setTreeParam() {

			//(1) 定义请求参数json,这里是根据后台的参数自由设置的
			var queryParam = {};
			queryParam.jsId = 1;

			//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
			var treeParamJson = {};
			treeParamJson.treename = "tt"; // 这里是tree名称 ，对应
			treeParamJson.rqstparam = queryParam;

			//(3) 公共 js要用的，定义数组 格式为 ： [{"treename":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
			var treeRqstJson = [];
			treeRqstJson.push(treeParamJson);

			//(4) 最终例子形如 ：[{"treename":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
			return treeRqstJson;
		}
		function setFormParam() {

		}

		function getTextBy() {
			var treeText = {};
			treeText.tt="mc";
			return treeText;
		}
		
		function getSortField() {
			var sortField = {};
			sortField.tt="bh";
			return sortField;
		}
		
		function getRecursionField() {
			var recursionField = {};
			recursionField.tt="sjgnId";
			return recursionField;
		}
		
		function getOperateaction() {
			var recursionField = {};
			recursionField.tt="../function/functionOperate";
			return recursionField;
		}
		
		function getFormId() {
			return 'ff';
		}
		
		function getButtonId() {
			return 'btn';
		}
		
		$(function() {

			noInput(); //初始状态下不允许输入

			$('#lb').combobox({
				url : '../../combox_data.json', //目录受保护，置于WebRoot下
				valueField : 'id',
				textField : 'text',
				width : 400
			});
		});
	</script>
</body>
</html>