 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%--  <% String contextPath = request.getContextPath();%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<title>功能菜单</title>
<%@include file="/js/icon.jsp"%>
<script>
var load = 0;

$(function() {
	loadSelectRoot("tt");
	hiddenElement("ff", new Array("gnLj_div","anFf_div"));
	 $('#lb').combobox({
			onSelect: function(param){
				if(param.id==0){
					hiddenElement("ff", new Array("gnLj_div","anFf_div"));
				}else if(param.id==1){
					hiddenElement("ff", new Array("gnLj_div","anFf_div"));
				}else if(param.id==2){
					hiddenElement("ff", new Array("anFf_div"));
					showElement("ff", new Array("gnLj_div"));
				}else if(param.id==3){
					showElement("ff", new Array("anFf_div"));
					hiddenElement("ff", new Array("gnLj_div"));
				}else if(param.id==4){
					showElement("ff", new Array("anFf_div"));
					hiddenElement("ff", new Array("gnLj_div"));
				}else if(param.id==5){
					hiddenElement("ff", new Array("gnLj_div","anFf_div"));
				}
			}
		}); 

	});
	 $.extend($.fn.form.defaults, {
		onLoadSuccess : function(data) {
			if(data.lb==0){
				hiddenElement("ff", new Array("gnLj_div","anFf_div"));
			}else if(data.lb==1){
	 			hiddenElement("ff", new Array("gnLj_div","anFf_div"));
			}else if(data.lb==2){
				hiddenElement("ff", new Array("anFf_div"));
				showElement("ff", new Array("gnLj_div"));
			}else if(data.lb==3){
				showElement("ff", new Array("anFf_div"));
				hiddenElement("ff", new Array("gnLj_div"));
			}else if(data.lb==4){
				showElement("ff", new Array("anFf_div"));
				hiddenElement("ff", new Array("gnLj_div"));
			}else if(data.lb==5){
				hiddenElement("ff", new Array("gnLj_div","anFf_div"));
			}
		}
	});  
	</script>
</head>
<style>

</style>
<body class="easyui-layout" oncontextmenu="return false" onselectstart="return false"><!--  oncontextmenu="return false" onselectstart="return false"页面右击禁用 -->
	<span id='menu'></span>
	<div id="userLeft" region="west" title="" style="width: 200px;">
		<ul id="tt"></ul>
	</div>
	<div id="userRight" region="center" title="" style="overflow: hidden;">
			<div class="toolbar">
			     <a id="btn" href="#" class="easyui-linkbutton" plain="true" data-options="iconCls:'icon-save'" onclick="saveTree('tt','gncdOperate')" disabled=true>保存</a>
		     </div>
			<span id="form">  </span>
		<div class="clear_nav"></div>
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

		function getLinkage() {
			findnodedata("ff", id, "gncdOperate");
		}

		function getButtonId() {
			return 'btn';
		}
	</script>
</body>
</html>