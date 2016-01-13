<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="org.apache.struts2.ServletActionContext,java.util.*,com.gdth.util.Constants,com.gdth.sys.entity.TXtYh,java.net.URLEncoder"%>
<%@include file="/js/common.jsp"%><!-- 必须引入commo -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>已办事宜</title>
</head>
<body>
	<div id="diagram" class="easyui-panel" fit="true" title="abc">
		
	</div>
	<div  id="cc" class="easyui-layout" fit="true">
	<div id="qf_div" region="north" split="true" style="height: 168px;">
		<!-- <fieldset class="fieldset_nav">
			<legend>查询</legend> -->
		<span id="queryform"></span>
		<!-- </fieldset> -->
	</div>
	<div id="grid_div" region="center" split="true">
		<span id="taskGrid"></span>
	</div>
	</div>
	<script type="text/javascript"
		src="<%=basePath%>/js/activiti_operate.js"></script>
	<script>
		var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
		//使用了什么控件必须写一个相关的setParam方法
		function setGridParam() {
			var queryObject = new Object();
			queryObject.userId = '<s:property value="userId"/>';
			queryObject.systemName = '<s:property value="systemName"/>';
			queryObject.ccbh = '<s:property value="ccbh"/>';
			
			//(1) 定义请求参数json,这里是根据后台的参数自由设置的
			var queryParam = {};
			queryParam.queryObject = JSON.stringify(queryObject);
			
			//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
			var girdParamJson = {};
			girdParamJson.gridname = "taskGrid";
			girdParamJson.rqstparam = queryParam;
			
			//(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
			var gridRqstJson = [];
			gridRqstJson.push(girdParamJson);
			
			//(4) 最终例子形如 ：[{"gridname":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
			return gridRqstJson; 
		}
		function setFormParam() {
		}

		$(function() {
			$('#diagram').parent().hide();
			loadComboData();
			$('#processKey').combobox({    
			    url:'processList!processCombo.do?systemName=<s:property value="systemName"/>'   
			});  
			//设置combo(日期，下拉框..)不可键盘输入
			$('.combo input').attr('readonly','readonly');
		});
	</script>
</body>
</html>