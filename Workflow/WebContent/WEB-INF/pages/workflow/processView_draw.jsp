<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%-- <%
	String contextPath = request.getContextPath();
%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="content-type" />

<title>Process Diagram</title>

<%@include file="/js/common_for_draw.jsp"%>

<!-- JQuery AutoComplete -->
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/js/processdesigner/jquery-autocomplete/jquery.autocomplete.css" />
<!--<link rel="stylesheet" type="text/css" href="<%=contextPath%>/js/processdesigner/jquery-autocomplete/lib/thickbox.css" />-->

<!-- JSON JS-->
<script src="<%=contextPath%>/js/processdesigner/json2.js"
	type="text/javascript"></script>

<!-- JQuery AutoComplete -->
<script type='text/javascript'
	src='<%=contextPath%>/js/processdesigner/jquery-autocomplete/lib/jquery.bgiframe.min.js'></script>
<script type='text/javascript'
	src='<%=contextPath%>/js/processdesigner/jquery-autocomplete/lib/jquery.ajaxQueue.js'></script>
<!--<script type='text/javascript' src='<%=contextPath%>/js/processdesigner/jquery-autocomplete/lib/thickbox-compressed.js'></script>-->
<script type='text/javascript'
	src='<%=contextPath%>/js/processdesigner/jquery-autocomplete/jquery.autocomplete.min.js'></script>

<!-- framework JS -->
<script src="<%=contextPath%>/js/processdesigner/skin.js"
	type="text/javascript"></script>
<link href="<%=contextPath%>/js/processdesigner/designer/designer.css"
	type="text/css" rel="stylesheet" />

<!-- common, all times required, imports -->
<script
	src='<%=contextPath%>/js/processdesigner/draw2d/wz_jsgraphics.js'></script>
<script src='<%=contextPath%>/js/processdesigner/draw2d/mootools.js'></script>
<script src='<%=contextPath%>/js/processdesigner/draw2d/moocanvas.js'></script>
<script src='<%=contextPath%>/js/processdesigner/draw2d/draw2d.js'></script>


<!-- example specific imports -->
<script src="<%=contextPath%>/js/processdesigner/designer/MyCanvas.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/ResizeImage.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/event/Start.js"></script>
<script src="<%=contextPath%>/js/processdesigner/designer/event/End.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/connection/MyInputPort.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/connection/MyOutputPort.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/connection/DecoratedConnection.js"></script>
<script src="<%=contextPath%>/js/processdesigner/designer/task/Task.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/task/UserTask.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/task/ManualTask.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/task/ServiceTask.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/task/ScriptTask.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/task/MailTask.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/task/ReceiveTask.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/task/BusinessRuleTask.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/task/CallActivity.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/gateway/ExclusiveGateway.js"></script>
<script
	src="<%=contextPath%>/js/processdesigner/designer/gateway/ParallelGateway.js"></script>
<script src="<%=contextPath%>/js/processdesigner/designer/designer.js"></script>
<style>
	.tabs-header,.panel-header{background:#eeeeee;border:1px solid #d3d3d3;}
	.panel-header{border:1px solid #d3d3d3;}
	.tabs li a.tabs-inner{background:#fff;}
	.tabs{border-bottom:1px solid #d3d3d3;}
	.tabs-panels{border:0;}
	.panel-body{border-color:#d3d3d3;}
	.tabs li{border-color:#d3d3d3;}
	
	.userTaskProperties,.lineProperties{display:none;margin-top:10px;}
	.properties,.propertyRow,.propertyValue{}
	.properties,.propertiesOpt{width:100%;height:40px;float:left;}
	.propertyRow{width:25%;float:left;text-align:right;height:40px;line-height:40px;}
	.propertyValue{text-align:center;width:69%;float:left;padding-top:10px;height:30px;}
	.nodeInput{width:200px;height:20px;line-height:20px;}
	.propertiesOpt button{display:none;}
	.configState{z-index:999;background:#d0d0d0;filter:alpha(opacity=99);opacity: 0.99;width:100%;height:100%;position:absolute;text-align:center;}
	.stateMsg{font-size:20px;font-weight:bolder;color:gray;line-height:30px;}
	.processConfig{
		line-height:9px;
		border:1px solid #dddddd;
    	width:88px;
    	height:25px;
    	cursor:pointer;
    	background-color:#0092dc;
    	color:#fff;
    	font-weight:bold;
    	font-size:12px;
	}
	.vctor:hover{cursor:pointer;background-color:#d3d3d3;}
	input,.input_normal{border:1px solid gray;}
	input{padding-left:5px;}
	.proNameSpace{height:66px;width:200px;font-size:12px;font-family:'微软雅黑';line-height:20px;border:1px solid gray;resize:none;}
	.input_empty{border:1px solid red;}
	.task-header{line-height:11px;}
	.tabs-tool{background:none;border:none;}
	.validatebox-text{border:0;}
	.addValue{background:rgba(0, 0, 0, 0) url("<%=contextPath%>/js/processdesigner/jquery-easyui/themes/icons/edit_add_hover.png") no-repeat scroll 0 0;border:0;margin-top:3px;cursor:pointer;filter:alpha(opacity=60);opacity: 0.60;}
	.addValue:hover{background:rgba(0, 0, 0, 0) url("<%=contextPath%>/js/processdesigner/jquery-easyui/themes/icons/edit_add.png") no-repeat scroll 0 0;filter:alpha(opacity=70);opacity: 0.70;}
	.combo{border:1px solid gray;}
</style>
</head>

<%@taglib prefix="s" uri="/struts-tags"%>

<body id="designer" class="easyui-layout">
	<div region="west" iconCls="palette-icon" title="元素"style="width: 150px;">
		<div class="easyui-accordion" fit="true" border="false">
			<!--				<div id="connection" title="Connection" iconCls="palette-menu-icon" class="palette-menu">-->
			<!--					<a href="##" class="easyui-linkbutton" plain="true" iconCls="sequence-flow-icon">SequenceFlow</a><br>-->
			<!--				</div>-->

			<!--	
				<div id="event" title="事件" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="start-event-icon">开始</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="end-event-icon">结束</a><br>
				</div>
				-->
			<div class="hideforload" style="display:none;">
			<a href="##" class="easyui-linkbutton" plain="true"
				iconCls="user-task-icon" wfModel="UserTask">用户任务</a><br/>
			 <a href="##" class="easyui-linkbutton" plain="true"
				iconCls="exclusive-gateway-icon" wfModel="ExclusiveGateway"
				iconImg="<%=contextPath%>/js/processdesigner/designer/icons/type.gateway.exclusive.png">任务判断</a><br/>
			</div>
			<!-- 
				<div id="task" title="任务" iconCls="palette-menu-icon" selected="true" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="user-task-icon" wfModel="UserTask">用户任务</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="manual-task-icon" wfModel="ManualTask">Manual Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="service-task-icon" wfModel="ServiceTask">Service Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="script-task-icon" wfModel="ScriptTask">Script Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="mail-task-icon" wfModel="MailTask">Mail Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="receive-task-icon" wfModel="ReceiveTask">Receive Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="business-rule-task-icon" wfModel="BusinessRuleTask">Business Rule Task</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="subprocess-icon">SubProcess</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="callactivity-icon" wfModel="CallActivity">CallActivity</a><br>
				</div>
					 -->
			<!-- 
				<div id="gateway" title="网关" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="parallel-gateway-icon" wfModel="ParallelGateway" iconImg="<%=contextPath%>/js/processdesigner/designer/icons/type.gateway.parallel.png">ParallelGateway</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="exclusive-gateway-icon" wfModel="ExclusiveGateway" iconImg="<%=contextPath%>/js/processdesigner/designer/icons/type.gateway.exclusive.png">唯一网关</a><br>
				</div>
					-->
			<!-- 
				<div id="boundary-event" title="Boundary event" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="timer-boundary-event-icon">TimerBoundaryEvent</a><br>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="error-boundary-event-icon">ErrorBoundaryEvent</a><br>
				</div>
				 -->
			<!-- <div id="boundary-event" title="Boundary event" iconCls="palette-menu-icon" class="palette-menu">
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="timer-boundary-event-icon" wfModel="">TimerBoundaryEvent</a><br/>
					<a href="##" class="easyui-linkbutton" plain="true" iconCls="error-boundary-event-icon">ErrorBoundaryEvent</a><br/>
				</div> -->
		</div>
	</div>
	<div id="process-panel" region="center" split="true"
		iconCls="process-icon">
			<!-- <div class="configState"><div class="stateMsg">欢迎使用绘制流程图功能<br/>开始之前，先给您的流程起一个名字吧~</div></div> -->
				<div id="process-definition-tab">
					<div id="designer-area" title="流程图设计"
						style="POSITION: absolute; width: 100%; height: 100%; padding: 0; border: none; overflow: auto;">
							<div id="paintarea"
								style="POSITION: absolute; WIDTH: 3000px; HEIGHT: 3000px"></div>
									</div>
								<div id="xml-area" title="参数"
							style="width: 100%; height: 100%; overflow: hidden; overflow-x: hidden; overflow-y: hidden;">
						<textarea id="descriptorarea" rows="38"
					style="width: 100%; height: 100%; padding: 0; border: none;"
				readonly="readonly"></textarea>
			</div>
		</div>
	</div>
	<div id="properties-panel" region="east" iconCls="properties-icon" title="属性" style="width: 350px;">
		<!-- 属性板块 -->
		<div class="easyui-layout" fit="true">
			<div region="north" iconCls="properties-icon" title="" style="height: 150px;">
				<div class="easyui-layout" fit="true">
					<div region="south" iconCls="properties-icon" title="" border="false" style="height: 35px;text-align:center;padding-left:66px;">
						<!-- <button onclick="saveProcessGramConfig();" class="processConfig">写入xml</button> -->
							<div style="display:block; width:0; height:0; overflow:hidden;"><button>IE8防止回车触发后续button</button></div>
							<button onclick="saveProcess();" class="processConfig">保存流程</button>
						<!-- <button onclick="saveProcess();" class="processConfig">发布新版本</button> -->
					<button onclick="javascript:history.go(-1);" class="processConfig" style="margin-left:15px;">返回管理</button>
				</div>
					<div region="center" iconCls="properties-icon" title="" border="false">
						<div class="properties" style="display:none;">
							<div class="propertyRow">流程&nbspkey：</div>
							<div class="propertyValue"><input id="processId" onblur="saveProcessGramConfig();" onkeyup="saveProcessGramConfig();" class="nodeInput"/></div>
						</div>
					<div class="properties">
				<div class="propertyRow">流程名称：</div>
			<div class="propertyValue"><input id="processName" onblur="saveProcessGramConfig();" onkeyup="saveProcessGramConfig();" class="nodeInput"/></div>
				</div>
					<div class="properties">
						<div class="propertyRow">系统类型：</div>
							<div class="propertyValue"><input id="processNameSpace" onblur="saveProcessGramConfig();" onkeyup="saveProcessGramConfig();" class="nodeInput" /></div>
						</div>
					</div>
				</div>
			</div>
			<div region="center" iconCls="properties-icon" title="">
				<div class="userTaskProperties identifyclass">
					<div class="properties" style="display:none;">
						<div class="propertyRow">节点&nbspkey：</div>
							<div class="propertyValue"><input id="nodeId" 
							class="nodeInput"/></div>
								</div>
									<div class="properties">
										<div class="propertyRow">节点名称：</div>
									<div class="propertyValue"><input id="name" 
									onkeypress="saveTaskGeneral(getConfigData());" 
									onkeyup="saveTaskGeneral(getConfigData());" 
									class="nodeInput"/></div>
								</div>
							<div class="properties">
						<div class="propertyRow">节点类型：</div>
					<div class="propertyValue">
				<input id="selfProperty" name="selfProperty" 
				onkeypress="saveTaskGeneral(getConfigData());" 
				onkeyup="checkVal();saveTaskGeneral(getConfigData());" 
				class="nodeInput taskMsg"/>     
			</div>
		</div>
			</div>
				<div class="lineProperties identifyclass">
					<div class="properties" style="display:none;">
						<div class="propertyRow">箭头&nbspkey：</div>
							<div class="propertyValue"><input id="lineId" 
																onblur="saveLineProperties();" 
																onkeyup="saveLineProperties();"
																onkeydown="saveLineProperties();"
																class="nodeInput"/></div>
								</div>
									<div class="properties">
										<div class="propertyRow">箭头名称：</div>
									<div class="propertyValue"><input id="lineExpression" 
									onblur="saveLineProperties();" 
									onkeyup="saveLineProperties();" 
									onkeydown="saveLineProperties();" 
									class="nodeInput"/></div>
								</div>
							<!-- <div class="properties">
						<div class="propertyRow">是否有条件：</div>
					<div class="propertyValue"><input id="isCondition" class="nodeInput"/></div>
				</div> -->
			<div class="forCondition">
		<!-- <div class="properties" style="display:none;">
			<div class="properties vctor">
			<div class="propertyRow">条件类型：</div>
				<div class="propertyValue">
					<input id="conditionType" class="nodeInput easyui-combobox"/>
						</div>
						</div>
							<div style="position:relative;">
								<button class="addValue"></button>
									</div>
										</div> -->
											<!-- <div class="properties" style="display:none;">
										<div class="propertyRow">判断符号：</div>
									<div class="propertyValue"><input id="symbol" class="nodeInput easyui-combobox"/></div>
								</div> -->
							<div class="properties">
						<div class="propertyRow">条件值：</div>
					<div class="propertyValue"><input id="conditionValue"  onblur="saveLineProperties();" onkeyup="saveLineProperties();"  class="nodeInput"/></div>
				</div>
			</div>
		</div>
		
				<!-- <div class="propertiesOpt"><button onclick="saveTaskGeneral(getConfigData());" class="taskConfig">节点配置</button><button onclick="saveLineProperties();" class="lineConfig">线上配置</button><button onclick="saveProcessGramConfig();" class="processConfig">流程配置</button></div> -->
		
			</div>
		</div>
		
	</div>
	<!-- <div id="toolbar-panel" region="north" border="false" style="height:35px;background:#EFEFEF;">
		<div style="background:#EFEFEF;padding:5px;">
			<a href="javascript:history.go(-1);" id="sb1" class="easyui-splitbutton" menu="#edit-menu" iconCls="icon-back">返回</a>
		</div>
	</div> -->
	<!-- toolbar -->
	<!--
	<div id="toolbar-panel" region="north" border="false" style="height:36px;background:#E1F0F2;">
		<div style="background:#E1F0F2;padding:5px;">
			<a href="javascript:void(0)" id="sb1" class="easyui-splitbutton" menu="#edit-menu" iconCls="icon-edit">Edit</a>
			<a href="javascript:void(0)" id="sb2" class="easyui-splitbutton" menu="#mm2" iconCls="icon-ok" onclick="javascript:alert(workflow.toXML())">Ok</a>
			<a href="javascript:void(0)" id="mb2" class="easyui-menubutton" menu="#xml/diagram" onclick="viewXMLOrDiagram()">XML/Diagram</a>
			<a href="javascript:void(0)" id="mb3" class="easyui-menubutton" menu="#mm3" iconCls="icon-help">Help</a>
				<a href="javascript:void(0)" id="ss4" class="easyui-splitbutton" plain="true" iconCls="icon-save" onclick="deploy();">发布</a>
		</div>
<!--
		<div id="edit-menu" style="width:150px;">
		<div iconCls="icon-undo" onclick="undo()">Undo</div>
		<div iconCls="icon-redo" onclick="redo()">Redo</div>
		<div class="menu-sep"></div>
		-->
	<!--		<div onclick="openProcessDef()">Open</div>
		<div iconCls="icon-save" onclick="saveProcessDef()">Save</div>
		<div><a href="#" onclick="exportProcessDef(this)">Export</a></div>
		</div>
		<div id="mm3" style="width:150px;">
			<div>Help</div>
			<div class="menu-sep"></div>
			<div>About</div>
		</div>
	</div>
	-->
	<!-- task context menu -->
	
	<div id="task-context-menu" class="easyui-menu" style="width: 120px;">
		<div id="properties-task-context-menu" iconCls="properties-icon">属性</div>
		<div id="delete-task-context-menu" iconCls="icon-remove">删除</div>
	</div>
	<div id="value-manager-win"><table id="valueManager"></table></div>
	<!-- form configuration window -->
	<!-- <div id="form-win" title="Form Configuration"
		style="width: 750px; height: 500px;"></div>
	listener configuration window
	<div id="listener-win" title="Listener Configuration"style="width: 750px; height: 500px;"></div>
	candidate configuration window
	
	<div id="task-candidate-win" title=""style="width: 750px; height: 500px;"></div> -->
	<script type="text/javascript">
		var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
		
		var workflow;	//= new draw2d.MyCanvas("paintarea");	//含有process对象
		
		var processDefinitionId = '<s:property value="processDefinitionId"/>';
		var deploymentId = '<s:property value="deploymentId"/>';
		//alert(processDefinitionId+"==="+deploymentId);
		var processDefinitionName="";
		var processDefinitionVariables="";
		var _process_def_provided_listeners="";
		var is_open_properties_panel = false;//false
		var task;	// = new draw2d.UserTask(openTaskProperties);	//继承了Task
		var line;
		
		var lineReady = false;	//程序的执行顺序上出现bug，easyui的onselected和插件本身对模型的onDoubleClick事件的触发顺序上使用此布尔值进行区分
		
		var rowNumber = 0;	//生成临时行的id，负向递减
		var editStatus = false;	//是否存在编辑行，新增行和双击编辑行具有原子性
		var editRow = null;	//正在编辑的行索引
		
		var grid = $('#valueManager');	//表格对象
		
		var valueJson = {};	//临时数据表
			valueJson.add = [];  
			valueJson.edit = [];
			valueJson.del = [];
			
		function setGridParam(){
			//(1) 定义请求参数json,这里是根据后台的参数自由设置的
			var queryParam = {};
			queryParam.procKey = "";
			queryParam.pageSize = 15;
			queryParam.pageNumber = 1;

			//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
			var girdParamJson = {};
			girdParamJson.gridname = "valueManager";
			girdParamJson.rqstparam = queryParam;

			//(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
			var gridRqstJson = [];
			gridRqstJson.push(girdParamJson);

			//(4) 最终例子形如 ：[{"gridname":"tt","restparam":{"jsId":1,"jsId2":2}}]
			//alert(JSON.stringify(treeRqstJson)); 
			return gridRqstJson;
		}
		
		$(function(){
			$('.hideforload').show();
			$('#value-manager-win').window({
				width : 500,
				height: 400,
				closed: true,
				title:'流程变量管理',
				minimizable: false,
				maximizable: false,
				collapsible: false,
				closable:true
			});
			/* $('div.userTaskProperties').find('div:even').each(function(i){
				$(this).css('background','#f3f3f3');
			}); */
			//$('#designer').layout('collapse','west');
			_task_obj = $('#task');
			_designer = $('#designer');
			_properties_panel_obj = _designer.layout('panel','east');
			//_designer.layout('collapse','east');
			_properties_panel_obj.panel({
				onOpen:function(){
					is_open_properties_panel = true;
				},
				onClose:function(){
					is_open_properties_panel = false;
				}
			});
			_process_panel_obj = _designer.layout('panel','center');
			
			try{
				_task_context_menu = $('#task-context-menu').menu({});
				//_designer.layout('collapse','east');
				openProcessProperties();
				//$('#paintarea').bind('contextmenu',function(e){
					//alert(e.target.tagName);
				//});
			}catch(e){
				alert(e.message);
			};
			$(window).unload( function () { 
				//window.opener._list_grid_obj.datagrid('reload');
			} );
			
/* 			$('#hasform').combobox({
				width:$('.nodeInput').width(),
				panelHeight:88,
				editable:false,
				valueField:'id',    
			    textField:'text',
			    value:2,
			    data:[{    
			        "id":1,    
			        "text": "申请"   
			    },{    
			        "id":2,    
			        "text": "结束"   
			    },{
			    	"id":3,
			    	"text": "常规",
			    	"selected":true  
			    }],  
			    onSelect:function(record){
			    	saveTaskGeneral(getConfigData());
			    }
			}); */
			$('#symbol').combobox({
				width:$('.nodeInput').width(),
				//panelHeight:88,
				editable:false,
				required:true,
				valueField:'id',    
			    textField:'text',
			    data:[{    
			        "id":'>',    
			        "text":"大于"   
			    },{    
			        "id":'>=',    
			        "text":"大于等于"   
			    },{    
			        "id":'<',    
			        "text":"小于"   
			    },{    
			        "id":'<=',    
			        "text":"小于等于"   
			    },{    
			        "id":'==',    
			        "text":"等于"   
			    },{
			    	"id":'!=',
			    	"text":"不等于"
			    }],
			    onSelect:function(record){
			    	if(lineReady){
						saveLineProperties();
					//$('#conditionValue').focus().blur();
					}
			    }
			});
			$('#conditionType').combobox({
				width:$('.nodeInput').width(),
				//panelHeight:88,
				editable:false,
				required:true,
				url:function(){
					if(processDefinitionId != null && processDefinitionId != '')
						return 'processList!getValueComboData.do?processDefinitionId='+processDefinitionId;
					else return null;
				},
				//mode:'remote',
				valueField:'id',    
			    textField:'text',
			    /* data:[{
			    	"id":'value',
			    	"text":"自定义"
			    },{    
			        "id":'day',    
			        "text":"天数"   
			    },{    
			        "id":'number',    
			        "text":"数量"   
			    },{    
			        "id":'rate',    
			        "text":"比率"   
			    },{    
			        "id":'weight',    
			        "text":"重量"   
			    },{    
			        "id":'age',    
			        "text":"年龄"   
			    }], */
			    onSelect:function(record){
			    	if(lineReady){
			    	//alert(record.text); //record为当前选择的数据
			    	/* if(record.text == "自定义"){
			    		//$('#conditionType').combobox({editable:true});
			    		//$('#conditionType').next('span.combo').find('input:eq(0)').focus();
			    	}else{
			    		if($('#conditionType').combobox('options').editable == true){
			    			$('#conditionType').combobox({editable:false});
			    		}
			    	} */
			    	//这里调用保存操作的方法时，会导致一个错误：重新选择线时会覆盖上一个 
			    	//$('#conditionValue').focus().blur();
			    	saveLineProperties();
			    	}
			    }
			});
			
			//线上配置：是否含有条件
			$('#isCondition').combobox({
				width:$('.nodeInput').width(),
				//panelHeight:88,
				editable:false,
				valueField:'id',    
			    textField:'text',
			    data:[{    
			        "id":1,    
			        "text":"是"   
			    },{    
			        "id":2,    
			        "text":"否"   
			    }],
			    onSelect:function(record){
			    	if(record.text == "是"){
			    		//$('#conditionValue').val(null);
			    		//$('#conditionType').combobox('clear');	//天数,数量,..
						$('#symbol').combobox('clear'); //符号 
						line.isExpression = true;
			    		$('.forCondition').slideDown();
			    	}else{
			    		line.isExpression = false;
			    		$('.forCondition').slideUp();
			    	}
			    	
			    	if(lineReady){
			    		saveLineProperties();
			    	}
			    }
			});
			
			$('#process-definition-tab').tabs({
				fit:true,
				onSelect:function(title){
					if(title==='流程图设计'){
					
					}else if(title==='参数'){
						$('#descriptorarea').val(workflow.toXML());
						/*
						if(document.body.innerText)
							$('#xml-area').get(0).innerText=workflow.toXML();
						else if(document.body.textContent)
							$('#xml-area').get(0).textContent=workflow.toXML();
						*/
					}
				},
				tools:[{
					text:'网格',
					iconCls:'icon-remove',
					handler:function(){
						if($('#paintarea').hasClass('MyCanvas')){
							$('#paintarea').removeClass('MyCanvas');
						}else{
							$('#paintarea').addClass('MyCanvas');
						}
					}
				}/* ,{
					text:'保存流程',
					iconCls:'icon-save',
					handler:function(){
					}
				} */]

			});
			
			$('#process-panel').panel({
				onResize:function(width, height){
					$('#process-definition-tab').tabs('resize',{width:width,height:height});
				}
			});
			
			$('div.stateMsg').css({'margin-top':$('.configState').height()*0.5-30});
			
			$('.vctor').click(function(event){
				if(!$(event.target).is('span')){
				setParam($('#processId').val(),null,null);
				if(processDefinitionId != null && processDefinitionId != '')
					grid.datagrid({url:'processDictionaryList!list.do'});
				grid.datagrid('getPager').pagination({
					onChangePageSize:function(pageSize){
						setParam(null,pageSize,null);
					},
					onSelectPage:function(pageNumber, pageSize){
						setParam(null,null,pageNumber);
					},
					onBeforeRefresh:function(){
					}
				});
				if(!$(this).hasClass('note')){
					$('#value-manager-win').window('open');
					$(this).addClass('note');
					}else{
						$('#value-manager-win').window('close');
						$(this).removeClass('note');
					}
				}
			});
			
		});	
		
		function setParam(procKey,pageSize,pageNumber){
			var tempParam = eval("(" +grid.datagrid('options').queryParams.params+")");
			if(procKey != null)
				tempParam.procKey = procKey;
			if(pageSize != null)
				tempParam.pageSize = pageSize;
			if(pageNumber != null)
				tempParam.pageNumber = pageNumber;
			//alert(JSON.stringify(tempParam));
			grid.datagrid('options').queryParams.params = JSON.stringify(tempParam);
			grid.datagrid('reload');
		}
		
		grid.datagrid({
			rowStyler:function(index,row){   
		        if (row.dicKey == '' || row.dicValue == ''){   
		            return 'background-color:red;';   
		        }   
		    },
			onDblClickRow:function(rowIndex, rowData){
				if(editStatus){
					grid.datagrid('endEdit',editRow);
					if(editRow == 0){
						//如果被取消的这行属于当前新增行
						grid.datagrid('updateRow',{index:0,row:{id:rowNumber}});
					}
				}
				grid.datagrid('beginEdit',rowIndex);
				editRow = rowIndex;
			},
			onAfterEdit:function(rowIndex, rowData, changes){
				//alert(JSON.stringify(rowData)+"=="+JSON.stringify(changes));
				//判断是否为空对象
				function isEmptyObject(obj){
				    for(var n in obj){return false;} 
				    return true; 
				} 
				
				//返回索引号（非负数），否则返回-1
				function isOnlyId(ary,match){
					for(var i=0;i<ary.length;i++){
						if(ary[i].id == match){return i;}
					}
					return -1;
				}
				//alert(isEmptyObject(changes));
				if(rowData.dicKey != '' && rowData.dicValue != '' && !isEmptyObject(changes)){
					//如果编辑完后，存在空字符串
					if(rowData.id > 0){
						//真实行
						//var _changes = changes;
						//_changes.id = rowData.id;
						var tempRow = rowData;
						tempRow.procKey = processDefinitionId;
						var isOnly = isOnlyId(valueJson.edit,rowData.id);	
						valueJson.edit.splice(isOnly,isOnly>=0?1:0,tempRow);	//含有真实id必需具有唯一性
					}else{
						//临时行
						//alert("id:"+rowData.id);
						//关于临时行，先不做保存，在用户确认保存时，再统一地去获取，否则，如果重复修改，又得对于修改于valueJson.add
					}
				}
			},
			onSelect:function(rowIndex, rowData){
				if(rowIndex != editRow){
					grid.datagrid('endEdit',editRow);
					editRow = null;
				}
			}
		});
		
		function addConditionValue(){
			var addNew = {
					dicKey		  :'',
					dicValue	  :'',
					id 			  :0
				};
			var editIndex = grid.datagrid('getRowIndex',0);	//根据id值获取索引号,存在则返回索引，不存在则返回-1
			//alert(editIndex);
			if(editIndex >= 0 && editStatus){
				grid.datagrid('endEdit',editIndex);
				grid.datagrid('selectRow',editIndex);
				var isEdit = grid.datagrid('getSelected');
				if(isEdit){
					grid.datagrid('updateRow',{index:editIndex,row:{id:rowNumber}});
					//valueJson.add.push(idEdit);
				}
			}
			if(editIndex < 0 && editStatus){
				grid.datagrid('endEdit',editRow);
			}
			grid.datagrid('unselectAll');
			grid.datagrid('insertRow',{index:0,row:addNew}).datagrid('beginEdit',0);
			rowNumber--;
			editStatus = true;
			editRow = 0;
		}
		
		function delConditionValue(){
			//alert(JSON.stringify(valueJson));
			var selected = grid.datagrid('getSelected');
			//alert(!selected);
			if(selected){
				var rowIndex = grid.datagrid('getRowIndex',selected);
				if(selected.id <= 0){
					//alert("非真实行号："+rowIndex);
					//var isNew = $.inArray(selected, valueJson.add);
					//if(isNew > 0){valueJson.add.splice(isNew,1);}
					resetId(rowIndex,selected.id);
					rowNumber++;
					if(rowIndex == editRow){
						//如果删除了正在编辑的行！
						editStatus = false;
					}
				}else{
					//alert("id="+selected.id);
					valueJson.del.splice(-1,0,{id:selected.id});
				}
				grid.datagrid('deleteRow',rowIndex);
				//alert(JSON.stringify(valueJson));
			}
		}
		
		function resetId(index,instanceId){	//删除某一项时，重新排版临时行的id值
			//如果删除了正在编辑的项后，会有旧行代替0索引行
			for(var i=index-1,j=instanceId;i>=0;i--){
				if(i == 0 && editStatus){
					//如果是第一行，且正在编辑状态下不对编辑行进行任何修改
				}else{
					grid.datagrid('updateRow',{index:i,row:{id:j--}});
				}
			}
		}
		
		function saveConditionValue(){
			if(editStatus && editRow != null){	//终止所有编辑
				grid.datagrid('endEdit',editRow);
			}
			//获取新增行
			//grid.datagrid('selectAll');
			//var rows = grid.datagrid('getSelections');
			if(processDefinitionId != null && processDefinitionId != ''){
				for(var i=rowNumber,j=0;i<0;i++,j++){
					grid.datagrid('selectRow',j);
					var row = grid.datagrid('getSelected');
					if(row.id <= 0){
						//alert(rows[i].dicKey == '');	//根据定义，单元格的初始值为空字符串，因此，结果不可能为null和undefined
						if(row.dicKey != '' && row.dicValue != ''){
							//确保两个值都不可为空，才可以执行保存
							var tempJson = {dicKey:row.dicKey,dicValue:row.dicValue,procKey:processDefinitionId};
							valueJson.add.splice(-1,0,tempJson);
						}
					}
				}
				//grid.datagrid('unselectAll');
				//alert(JSON.stringify(valueJson));
				$.ajax({
					async:false,
					url:'processDictionaryList!saveValueOperate.do',
					data:'params='+JSON.stringify(valueJson),
					error:function(){
						alert("请求错误...");
					},
					success:function(data){
						//
						$('#conditionType').combobox('reload');
					}	
				});
			}else{
				var combodata = [];
				for(var i=rowNumber,j=0;i<0;i++,j++){
					grid.datagrid('selectRow',j);
					var row = grid.datagrid('getSelected');
					if(row.id <= 0){
						//alert(rows[i].dicKey == '');	//根据定义，单元格的初始值为空字符串，因此，结果不可能为null和undefined
						if(row.dicKey != '' && row.dicValue != ''){
							combodata.push({"id":row.dicKey,"text":row.dicValue});
						}
					}
				}
				//alert(combodata);
				$('#conditionType').combobox('loadData',combodata);
			}
			
			alert("操作成功！");
		}
		
		function addModel(name,x,y,icon){
			var model = null;
			if(icon!=null&&icon!=undefined){
				model = eval("new draw2d."+name+"('"+icon+"')");
			}else{
				model = eval("new draw2d."+name+"(openTaskProperties)");
			}
			//userTask.setContent("DM Approve");
			model.generateId();
			//var id= task.getId();
			//task.id=id;
			//task.setId(id);
			//task.taskId=id;
			//task.taskName=id;
			//var parent = workflow.getBestCompartmentFigure(x,y);
			//workflow.getCommandStack().execute(new draw2d.CommandAdd(workflow,task,x,y,parent));
			workflow.addModel(model,x,y);
		}

		/**
		 * 打开userTask任务属性
		 */
		function openTaskProperties(t){
			if(!is_open_properties_panel)
				_designer.layout('expand','east');
			task=t;
			if(task.type=="draw2d.UserTask"){
				//_properties_panel_obj.panel('refresh','processView!toUserTaskProperties.do');
				$('#nodeId').val(task.taskId);
				$('#name').val(task.taskName);
				$('#selfProperty').val(task.documentation);
				if(task.documentation == "isApplicationTask" || task.documentation == "isEndTask"){
					$('#selfProperty').attr('disabled',true);
				}else{
					$('#selfProperty').removeAttr('disabled');
				}
				$('div.lineProperties').hide();
				$('div.propertiesOpt button').css('display','none');
				$('div.processProperties').hide();//slideUp('slow',function(){
					//$('button.processConfig').css('display','none');
				$('div.userTaskProperties').slideDown('fast',function(){
						$('button.taskConfig').css('display','block');
					});
				//});
			}
			else if(task.type=="draw2d.ManualTask")
				_properties_panel_obj.panel('refresh','manualTaskProperties.html');
			else if(task.type=="draw2d.ServiceTask")
				_properties_panel_obj.panel('refresh','serviceTaskProperties.html');
			else if(task.type=="draw2d.ScriptTask")
				_properties_panel_obj.panel('refresh','scriptTaskProperties.html');
			else if(task.type=="draw2d.ReceiveTask")
				_properties_panel_obj.panel('refresh','receiveTaskProperties.html');
			else if(task.type=="draw2d.MailTask")
				_properties_panel_obj.panel('refresh','mailTaskProperties.html');
			else if(task.type=="draw2d.BusinessRuleTask")
				_properties_panel_obj.panel('refresh','businessRuleTaskProperties.html');
			else if(task.type=="draw2d.CallActivity")
				_properties_panel_obj.panel('refresh','callActivityProperties.html');
		}

		/**
		 * 打开流程属性：
		 */
		function openProcessProperties(){
			if(!is_open_properties_panel)
				_designer.layout('expand','east');
			//_properties_panel_obj.panel('refresh','../designer/processDesigner!toProcessProperties.do?txtGnid='+txtGnid+"&txtGnjc="+txtGnjc);
		}

		//请求流程xml
		function openProcessDef(processDefinitionId){
			$.ajax({
				//url:"../processDesigner/wf/procdef/procdef!getProcessDefXML.action?procdefId="+processDefinitionId,
				url:"processOutput!exportProcess.do?contentType='xml'&deploymentId="+deploymentId,
				type: 'POST',
				//dataType:'xml',
				error:function(XMLHttpRequest, textStatus, errorThrown){
					//console.log(textStatus);
					//$.messager.alert("解析出错！","请求错误!");
					//return "";
					alert(errorThrown+"1");
					//alert(XMLHttpRequest.responseText);
					//var str = XMLHttpRequest.responseText;
					//parseProcessDescriptor(String2XML(str));
				},
				success:function(data){
					//alert(typeof data);	//STRING 
					var _data = toXmlDom(data);
					//alert(typeof _data);	//object
					parseProcessDescriptor(_data);
				}
			});
		}
	
		/**
		 * 打开流程线属性
		 */
		function openFlowProperties(l){
			lineReady = false;
			//alert(id);
			/* if(!is_open_properties_panel)
				_designer.layout('expand','east'); */
			line=l;
				//console.log(line.sourcePort.parentNode.type);
				//line
			function getTypeId(node){
				//node是指节点，将返回该节点的id
				var typeId = null;
				if(node.type=='draw2d.Start'){
					typeId = node.eventId;
				}else if(node.type=='draw2d.End'){
					typeId = node.eventId;
				}else if(node.type=='draw2d.ExclusiveGateway'){
					typeId = node.gatewayId;
				}else if(node.type=='draw2d.ParallelGateway'){
					typeId = node.gatewayId;
				}else{
					typeId = node.taskId;
				}
				return typeId;
			}
				
			$('#lineId').val(line.lineId);
			$('#lineExpression').val(line.lineName);
			$('#conditionValue').val(line.condition);
			//line.condition=$('#condition').val();
			//alert(line.decision);
			if(line.getSource().getParent().type == 'draw2d.ExclusiveGateway'){
				$('.forCondition').show();
			}else{
				$('.forCondition').hide();
			}
			
			lineReady = true;
			
			lineCheck();
			
			$('div.identifyclass').css('display','none');
			
			//$('div.propertiesOpt button').css('display','none');
			
			$('div.lineProperties').slideDown('fast');//css('display','block');
			
			//$('button.lineConfig').css('display','block');
			
			//_properties_panel_obj.panel('refresh','../designer/processDesigner!toFlowProperties.do?txtGnid='+txtGnid+"&txtGnjc="+txtGnjc);
		}
		
		function deleteModel(id){
			var task = workflow.getFigure(id);
			workflow.removeFigure(task);
		}
		function redo(){
			workflow.getCommandStack().redo();
		}
		function undo(){
			workflow.getCommandStack().undo();
		}
		//
		
		function autoSetting(xml){
			var XMLObject = toXmlDom(xml);
			var startArray = ["start","startevent1"];
			var endArray  = ["end","endevent1"];
			$(XMLObject).find('sequenceFlow').each(function(i){
				//alert($(this).attr('targetRef'));
				//alert($.inArray("start",startArray));
				if($.inArray($(this).attr('sourceRef'),startArray) > 0){
					//alert($(this).attr('sourceRef')+"==="+$(this).attr('targetRef'));
					var target = overrideFigures($(this).attr('sourceRef'));
					//alert(target.taskId);
					target.documentation = "isApplicationTask";
				}
				if($.inArray($(this).attr('targetRef'),endArray) > 0){
					//alert($(this).attr('sourceRef')+"==="+$(this).attr('targetRef'));
					var target = overrideFigures($(this).attr('targetRef'));
					//alert(target.taskId);
					target.documentation = "isEndTask";
				}
				/* if($.inArray($(this).attr('sourceRef'),startArray) < 0 && $.inArray($(this).attr('targetRef'),endArray) < 0){
					var target_left  = overrideFigures($(this).attr('sourceRef'));
					if(target_left.type == "draw2d.UserTask")target_left.documentation  = null;
					var target_right = overrideFigures($(this).attr('targetRef'));
					if(target_right.type == "draw2d.UserTask")target_right.documentation = null;
					alert(target_left.type+"=="+target_right.type);
				} */
			});
			//alert("xiaoqiang");
		}
		
		function saveProcessDef(){
			var xml = workflow.toXML();
			//autoSetting(xml);
			//alert(workflow.process.getVariablesJSONObject());
			//alert(workflow.process.getVariablesJSONObject());
			//return;
			//alert(typeof workflow.toXML());
			$.ajax({
				async:false,
				url:"processOutput!upLoadProcessDefinition.do",
				type: 'POST',
				data:"data="+encodeURIComponent(xml),
				dataType:'json',
				error:function(){
					//return "123";
					alert('流程发布失败！');
				},
				success:function(data){
					//alert('流程发布成功！');
					processDefinitionId = $('#processId').val();
					saveConditionValue();
				}	
			});
			
		}
		function exportProcessDef(obj){
			//obj.href="../wf/procdef/procdef!exportProcessDef.action?procdefId="+processDefinitionId+"&processName="+processDefinitionName;
		}

		/**
		 * 发布流程
		 */
		/* function deploy(){
			$.messager.confirm('提示信息', '是否要发布该流程?', function(r){
				if (r){
					$.messager.progress();
					$.ajax({
					   type: "POST",
					   url: "../designer/processDesigner!deploy.do",
					   data: "data="+workflow.toXML()+"&txtGnid="+topenFlowPropertiesxtGnid,
					   success: function(msg){
						   $.messager.progress('close');	
						   //location.href = "../workflow/process/process!toList.do";
						   location.href = "../workflow/process/process!toApply.do";
					   }
					});
				}
			});
		} */
		
		//字符串转化为xml  
		function toXmlDom(source){  
		    var xmlDoc = null;  
		    if (window.ActiveXObject) {  
		        var ARR_ACTIVEX = ["MSXML4.DOMDocument","MSXML3.DOMDocument","MSXML2.DOMDocument","MSXML.DOMDocument","Microsoft.XmlDom"];  
		        var XmlDomflag = false;  
		        for (var i = 0;i < ARR_ACTIVEX.length && !XmlDomflag ;i++) {  
		            try {  
		                var objXML = new ActiveXObject(ARR_ACTIVEX[i]);  
		                xmlDoc = objXML;  
		                XmlDomflag = true;  
		            } catch (e) {  
		            }  
		        }  
		        if (xmlDoc) {    
		            xmlDoc.async = false;  
		            xmlDoc.loadXML(source);  
		        }  
		    }else{  
		   var parser=new DOMParser();  
		   var xmlDoc=parser.parseFromString(source,"text/xml");  
		 }  
		    return xmlDoc;  
		} 
		
		//解析xml，并加载流程图 
		function parseProcessDescriptor(data){
						var descriptor = $(data);
						var definitions = descriptor.find('definitions');
						var process = descriptor.find('process');
						var startEvent = descriptor.find('startEvent');
						var endEvent = descriptor.find('endEvent');
						var userTasks = descriptor.find('userTask');
						//alert(userTasks.length);
						var exclusiveGateway = descriptor.find('exclusiveGateway');
						var parallelGateway = descriptor.find('parallelGateway');
						var lines = descriptor.find('sequenceFlow');
						var shapes = descriptor.find('[nodeName=bpmndi:BPMNShape]');
						var edges = descriptor.find('[nodeName=bpmndi:BPMNEdge]');
						workflow.process.category = definitions.attr('targetNamespace');
						//alert(definitions.attr('targetNamespace'));
						//workflow.process.category="http://activiti.org/bpmn20";
						workflow.process.id=process.attr('id');
						workflow.process.name=process.attr('name');

						$('#processId').val(workflow.process.id);	//页面流程属性设置
						$('#processName').val(workflow.process.name);
						$('#processNameSpace').val(workflow.process.category);
						
						var documentation = trim(descriptor.find('process > documentation').text());
						if(documentation != null && documentation != "")
							workflow.process.documentation=documentation;
						var extentsion = descriptor.find('process > extensionElements');
						if(extentsion != null){
							var listeners = extentsion.find('[nodeName=activiti:executionListener]');
							var taskListeners = extentsion.find('[nodeName=activiti:taskListener]');
							workflow.process.setListeners(parseListeners(listeners,"draw2d.Process.Listener","draw2d.Process.Listener.Field"));
						}
						$.each(processDefinitionVariables,function(i,n){
								var variable = new draw2d.Process.variable();
								variable.name=n.name;
								variable.type=n.type;
								variable.scope=n.scope;
								variable.defaultValue=n.defaultValue;
								variable.remark=n.remark;
								workflow.process.addVariable(variable);
							});
						startEvent.each(function(i){
								var start = new draw2d.Start("<%=contextPath%>/js/processdesigner/designer/icons/type.startevent.none.png");
								start.id=$(this).attr('id');
								start.eventId=$(this).attr('id');
								start.eventName=$(this).attr('name');
								shapes.each(function(i){
									var id = $(this).attr('bpmnElement');
									if(id==start.id){
										var x=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('x'));
										var y=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('y'));
										workflow.addFigure(start,x,y);
										return false;
									}
								});
							});
						endEvent.each(function(i){
								var end = new draw2d.End("<%=contextPath%>/js/processdesigner/designer/icons/type.endevent.none.png");
								end.id=$(this).attr('id');
								end.eventId=$(this).attr('id');
								end.eventName=$(this).attr('name');
								shapes.each(function(i){
									var id = $(this).attr('bpmnElement');
									if(id==end.id){
										var x=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('x'));
										var y=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('y'));
										workflow.addFigure(end,x,y);
										return false;
									}
								});
							});
						
						userTasks.each(function(i){
							var task = new draw2d.UserTask(openTaskProperties);
							
							task.isUseExpression = true;
							var tid = $(this).attr('id');
							var tname = $(this).attr('name');
							var assignee=$(this).attr('activiti:assignee');
							var candidataUsers=$(this).attr('activiti:candidateUsers');
							var candidataGroups=$(this).attr('activiti:candidateGroups');
							var documentation = trim($(this).find('documentation').text());
							//var formKey=$(this).attr('activiti:formKey');
							
							task.taskId = tid;
							task.taskName = tname;
							task.setContent(tname);
							
							if(assignee!=null&&assignee!=""){
								//task.isUseExpression=true;
								task.performerType_assignee="assignee";
								task.assignee = assignee;
							}
							if(candidataUsers!=null&&candidataUsers!=""){
								//task.isUseExpression=true;
								task.performerType_candidateUsers = "candidateUsers";
								task.expression_candidateUsers = candidataUsers;
							}
							if(candidataGroups!=null&&candidataGroups!=""){
								//task.isUseExpression=true;
								task.performerType_candidateGroups = "candidateGroups";
								task.expression_candidateGroups = candidataGroups;
							}
							/* if(formKey!=null&&formKey!=""){
								task.formKey=formKey;
							} */
							if(documentation != null && documentation != "")
								task.documentation = documentation;
							
							var listeners = $(this).find('extensionElements').find('[nodeName=activiti:taskListener]');
							task.setListeners(parseListeners(listeners,"draw2d.Task.Listener","draw2d.Task.Listener.Field"));
							
							/* var performersExpression = $(this).find('potentialOwner').find('resourceAssignmentExpression').find('formalExpression').text();
							if(performersExpression.indexOf('user(')!=-1){
								task.performerType_candidateUsers = "candidateUsers";
							}
							if(performersExpression.indexOf('group(')!=-1){
								task.performerType_candidateGroups = "candidateGroups";
							} 
							
							var performers = performersExpression.split(',');
							$.each(performers,function(i,n){
								var start = 0;
								var end = n.lastIndexOf(')');
								if(n.indexOf('user(')!=-1){
									start = 'user('.length;
									var performer = n.substring(start,end);
									task.addCandidateUser({
											sso:performer
									});
								}else if(n.indexOf('group(')!=-1){
									start = 'group('.length;
									var performer = n.substring(start,end);
									task.addCandidateGroup(performer);
								}
							}); */
							shapes.each(function(i){
								var id = $(this).attr('bpmnElement');
								//alert(task.taskId);
								//此处加载用户任务节点模型，未改动之前的源代码很SB，竟然是id，应该是taskId!
								if(id==task.taskId){
									//alert(task.taskId);
									var x=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('x'));
									var y=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('y'));
									var w=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('width'));
									var h=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('height'));
									workflow.addModel(task,x,y);
									task.setDimension(w,h);
									return false;
								}
							});
							//console.log(task.taskId);
						});
					exclusiveGateway.each(function(i){
							var gateway = new draw2d.ExclusiveGateway("<%=contextPath%>/js/processdesigner/designer/icons/type.gateway.exclusive.png");
							var gtwid = $(this).attr('id');
							var gtwname = $(this).attr('name');
							gateway.id=gtwid;
							gateway.gatewayId=gtwid;
							gateway.gatewayName=gtwname;
							shapes.each(function(i){
								var id = $(this).attr('bpmnElement');
								if(id==gateway.id){
									var x=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('x'));
									var y=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('y'));
									workflow.addModel(gateway,x,y);
									return false;
								}
							});
						});
					parallelGateway.each(function(i){
						var gateway = new draw2d.ExclusiveGateway("<%=contextPath%>/js/processdesigner/designer/icons/type.gateway.parallel.png");
						var gtwid = $(this).attr('id');
						var gtwname = $(this).attr('name');
						gateway.id = gtwid;
						gateway.gatewayId = gtwid;
						gateway.gatewayName = gtwname;
						shapes.each(function(i) {
							var id = $(this).attr('bpmnElement');
							if (id == gateway.id) {
								var x = parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('x'));
								var y = parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('y'));
								var w = parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('width'));
								var h = parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('height'));
								workflow.addModel(gateway, x, y);
								gateway.setDimension(w,h);
								return false;
							}
						});
					});
			lines.each(function(i) {
				var lid = $(this).attr('id');
				var name = $(this).attr('name');
				;
				if (name === undefined) {
					name = "";
				}
				var condition = $.trim($(this).find('conditionExpression').text());	//去首位空格
				//if(condition != null && condition != '') line.isExpression = true;
				var sourceRef = $(this).attr('sourceRef');
				var targetRef = $(this).attr('targetRef');
				//alert(sourceRef+"=="+targetRef);
				
				//alert(allfig.get());
				
				var source = overrideFigures(sourceRef);
				var target = overrideFigures(targetRef);
				
				edges.each(function(i) {
					var eid = $(this).attr('bpmnElement');
					//alert(eid+"==="+lid);
					if (eid == lid) {
						var startPort = null;
						var endPort = null;
						var points = $(this).find('[nodeName=omgdi:waypoint]');
						//console.log(points.length)
						//此处有问题，points数组可能不止2个，还能是3,4个，但最终坐标一定是最后一个
						
						var startX = $(points[0]).attr('x');
						var startY = $(points[0]).attr('y');
						var endX = $(points[points.length-1]).attr('x');
						var endY = $(points[points.length-1]).attr('y');
						//start端口
						var sports = source.getPorts();
						for ( var i = 0; i < sports.getSize(); i++) {
							var s = sports.get(i);
							
							var x = s.getAbsoluteX();
							var y = s.getAbsoluteY(); 
							
							if (isLostTrue(x,startX) && isLostTrue(y,startY)) {	//源码失真，startY从xml中获取到字符串（含浮点数），而通过对象方法获取的值损失浮点数，造成不等！！
								startPort = s;									//isLostTrue方法将忽略失真部分
								break;
							}
						}
						//startPort = sports;
						//end端口
						var tports = target.getPorts();
						for ( var i = 0; i < tports.getSize(); i++) {
							var t = tports.get(i);
							
							var x = t.getAbsoluteX();
							var y = t.getAbsoluteY();
							
							if (isLostTrue(x,endX) && isLostTrue(y,endY)) {	//源码失真，endY从xml中获取到字符串（含浮点数），而通过对象方法获取的值损失浮点数，造成不等！！
								endPort = t;
								break;
							}
						}
						//endPort = tports;
						
						if (startPort != null && endPort != null) {
							var cmd = new draw2d.CommandConnect(workflow,startPort, endPort);	//创建line
							var connection = new draw2d.DecoratedConnection();
							connection.id = lid;
							connection.lineId = lid;
							connection.lineName = name;
							
							if (condition != null && condition != "") {
								connection.isExpression = true;
								//connection.condition = condition;
								var zf = condition.substring(condition.indexOf("{") + 1, condition.indexOf("}"));
								//var hasa = "";
								//var hasb = "";
								/* var jc = "";
								var fh = "";
								var value = "";
								function setJc_Value(ary){
										jc = ary[0];
										value = ary[1];
								}
								if (condition.indexOf("<=") > 0) {
									fh = "<=";
									setJc_Value(condition.split("<=",2));
								} else if (condition.indexOf(">=") > 0) {
									fh = ">=";
									setJc_Value(condition.split(">=",2));
								} else if (condition.indexOf("==") > 0) {
									fh = "==";
									setJc_Value(condition.split("==",2));
								} else if (condition.indexOf(">") > 0) {
									fh = ">";
									setJc_Value(condition.split(">",2));
								} else if (condition.indexOf("<") > 0) {
									fh = "<";
									setJc_Value(condition.split("<",2));
								}
								//alert(jc);
								//alert(fh);
								//alert(value);
								connection.field = jc;
								connection.decision = fh; */
								connection.condition = zf;
								
								connection.setLabel(/* ''+connection.field+connection.decision+ */connection.condition);
							}
							cmd.setConnection(connection);	//设置line属性
							workflow.getCommandStack().execute(cmd);	//画线
						}
						return false;
					}
				});
			});

			if (typeof setHightlight != "undefined") {
				setHightlight();
			}
			
		}
		
		function overrideFigures(id){
			var almo = workflow.getFigures();	//获取画面内所有模型对象
			for ( var i = 0; i < almo.getSize(); i++) {	//根据id遍历查找
				var moObj = almo.get(i);
				if (moObj.id == id || moObj.taskId == id) {	//源代码错误的地方！！！
					return moObj;
					break;
				}
			}
			return null;
		}
		
		//据观察，失真的部分均为0.5，因此，用两数值之差，然后取整
		function isLostTrue(param1,param2){
			if(parseInt(param1-param2) == 0) return true;
				else return false;
		}
		
		function parseListeners(listeners, listenerType, fieldType) {
			var parsedListeners = new draw2d.ArrayList();
			listeners.each(function(i) {
				var listener = eval("new " + listenerType + "()");

				listener.event = $(this).attr('event');
				var expression = $(this).attr('expression');
				var clazz = $(this).attr('class');
				if (expression != null && expression != "") {
					listener.serviceType = 'expression';
					listener.serviceExpression = expression;
				} else if (clazz != null && clazz != "") {
					listener.serviceType = 'javaClass';
					listener.serviceExpression = clazz;
				}
				var fields = $(this).find('[nodeName=activiti:field]');
				fields.each(function(i) {
					var field = eval("new " + fieldType + "()");
					field.name = $(this).attr('name');
					var string = $(this).find('[nodeName=activiti:string]')
							.text();
					var expression = $(this).find(
							'[nodeName=activiti:expression]').text();
					//alert("String="+string.text()+"|"+"expression="+expression.text());
					if (string != null && string != "") {
						field.type = 'string';
						field.value = string;
					} else if (expression != null && expression != "") {
						field.type = 'expression';
						field.value = expression;
					}
					listener.setField(field);
				});
				parsedListeners.add(listener);
			});
			return parsedListeners;
		}
		
		/* 初始化画布场景  */
		function createCanvas(disabled){
			try{
				var startX = 50;
				var startY = (_process_panel_obj.panel('options').height / 2) - 50;
				var distance = _process_panel_obj.panel('options').width - 150;
				//alert(_process_panel_obj.panel('options').width);
				if(_process_panel_obj.panel('options').width >= 1000){
					//屏幕分辨率过大，保持中央视角
					startX = (_process_panel_obj.panel('options').width - 900) / 2;
					distance = 900;
				}
				//alert(startX+"=="+startY+"=="+distance);
				//initCanvas();
				workflow  = new draw2d.MyCanvas("paintarea");
				workflow.scrollArea=document.getElementById("designer-area");
				if(disabled)
					workflow.setDisabled();
				if(typeof processDefinitionId != "undefined" && processDefinitionId != null &&  processDefinitionId != "null" && processDefinitionId != "" && processDefinitionId != "NULL"){
					openProcessDef(processDefinitionId);
				}else{
						var id = "process"+Sequence.create();
						//var id = workflow.getId();
						workflow.process.category='http://activiti.org/bpmn20';
						workflow.process.id= id;
						workflow.process.name=""; 
						//初始状态下，显示流程信息给用户
						$('#processId').val(workflow.process.id);
						$('#processName').val(workflow.process.name).addClass('input_empty');
						$('#processNameSpace').val(workflow.process.category);
						
					// Add the start,end,connector to the canvas
					  var startObj = new draw2d.Start("<%=contextPath%>/js/processdesigner/designer/icons/type.startevent.none.png");
					  //startObj.setId("start");
					  workflow.addFigure(startObj, startX,startY);
					  
					  var endObj   = new draw2d.End("<%=contextPath%>/js/processdesigner/designer/icons/type.endevent.none.png");
					  //endObj.setId("end");
					  workflow.addFigure(endObj,startX + distance,startY);
				} 
			}catch(e){
				alert(e.message);
			}
		}
		
		//文档加载完成后，才开始记载画图控件，否则，控件不可按照用户分辨率来调整画布的初始条件，且节点拖动效果失效，别问为什么，把这层顺序去掉试试就知道了
		//原因是加载顺序的问题，按照原版所给的代码，执行顺序上仍有漏洞，且可读性实在太差，而且大部分资源都是无用的
	
		window.onload = function() {

			createCanvas(false); //载入画图控件，初始化也在这里

			$('.easyui-linkbutton').draggable({
				proxy : function(source) {
					var n = $('<div class="draggable-model-proxy"></div>');
					n.html($(source).html()).appendTo('body');
					return n;
				},
				deltaX : 0,
				deltaY : 0,
				revert : true,
				cursor : 'auto',
				onStartDrag : function() {
					$(this).draggable('options').cursor = 'not-allowed';
				},
				onStopDrag : function() {
					$(this).draggable('options').cursor = 'auto';
				}
			});
			
			$('#paintarea').droppable({
				accept : '.easyui-linkbutton',
				onDragEnter : function(e, source) {
						$(source).draggable('options').cursor = 'auto'; //被拖动的指针样式
					},
				onDragLeave : function(e, source) {
						$(source).draggable('options').cursor = 'not-allowed';
					},
				onDrop : function(e, source) {
						//$(this).append(source)
						//$(this).removeClass('over');
						var wfModel = $(source).attr('wfModel');
						var shape = $(source).attr('iconImg');
						if (wfModel) {
							var x = $(source).draggable('proxy').offset().left;
							var y = $(source).draggable('proxy').offset().top;
							var xOffset = workflow.getAbsoluteX();
							var yOffset = workflow.getAbsoluteY();
							var scrollLeft = workflow.getScrollLeft();
							var scrollTop = workflow.getScrollTop();
							//alert(xOffset+"|"+yOffset+"|"+scrollLeft+"|"+scrollTop);
							//alert(shape);
							addModel(wfModel, x - xOffset + scrollLeft, y - yOffset + scrollTop, shape);
							//add之后选定
						}
					}
			});
		};
		
		//获取用户节点的参数
		function getConfigData(){
			//userTask的参数,约定：在新建usertask模型时，不对id进行配置，使用默认生成的id
			var task_Id = '';
			if($('#nodeId').val() != null && $('#nodeId').val() != ''){
				task_Id = $('#nodeId').val();
			}else{
				task_Id = task.taskId;
			}
			var taskAttributes = {
					taskId:$('#nodeId').val(),
					taskName:$('#name').val(),
					isUseExpression:true,
					assignee:"\${authenticatedUserId}",
					candidateUser:"\${processService.getTaskCatedidates('"+workflow.process.id+"','"+task_Id+"','user')}",
					candidateGroup:"\${processService.getTaskCatedidates('"+workflow.process.id+"','"+task_Id+"','group')}",//{increment:3,size:3,data:[1,2,3]},
					documentation:$('#selfProperty').val() //$('#hasform').combobox('getValue')
			};
			return taskAttributes;
			
		}
		
		
		//userTask节点配置：此方法可以调用task.js里面定义的属性，对选定的用户节点进行配置属性，选定的模型的对象为task，属性较多
		function saveTaskGeneral(options){
			var defaults = {
				taskId:'',		//节点key
				taskName:'',	//节点名称
				isUseExpression:false,	//是否使用表达式设置候选人
				assignee:'',	//设置默认受理对象
				candidateUser:'',	//候选用户表达式，或具体的人
				candidateGroup:'',	//候选角色表达式，或具体角色
				documentation:''	//标记标签
			};
			
			var opts = $.extend({},defaults,options);
			
			task.isUseExpression = opts.isUseExpression;
			
			if(opts.taskId !=null && opts.taskId != ''){
				task.taskId = opts.taskId;
			}
			
			task.taskName = opts.taskName;	//设置userTask的名称
			task.setContent(opts.taskName);
			
			/* 申请即默认受理人，否则置空 */ 
			
			if(opts.documentation != "isApplicationTask" && opts.documentation != "isEndTask"){
				task.documentation = opts.documentation;	//标记标签，形式：<userTask><documentation></documentation></userTask>
			}
			
			//配置候选用户
			if(opts.candidateUser != ''&& opts.candidateUser != null){
				task.performerType_candidateUsers = "candidateUsers";
				if(opts.isUseExpression == false){	//如果不使用表达式
					task.candidateUsers.increment = opts.candidateUser.increment;
					task.candidateUsers.size = opts.candidateUser.size;
					task.candidateUsers.data = opts.candidateUser.data;
				}else{
					//alert(opts.candidateUser);
					task.expression_candidateUsers =  opts.candidateUser;
				}
			}
			//配置候选角色
			if(opts.candidateGroup != ''&& opts.candidateGroup != null){
				task.performerType_candidateGroups = "candidateGroups";
				if(opts.isUseExpression == false){	//如果不使用表达式
					task.candidateGroups.increment = opts.candidateGroup.increment;
					task.candidateGroups.size = opts.candidateGroup.size;
					task.candidateGroups.data = opts.candidateGroup.data;
				}else{
					task.expression_candidateGroups = opts.candidateGroup;
				}
			}
		} 
		
		function checkVal(){
			var selfDoc = $('#selfProperty').val();
			if(selfDoc == "isApplicationTask" || selfDoc == "isEndTask"){
				alert("这么巧...这个字符正在被程序使用，换一个比较好哦~");
				$('#selfProperty').val(selfDoc.split('k',1));
			}
		}

		//流程配置：key和name，并且追加非空验证，workflow.process取得流程对象，这里仅对id和name进行设置
		function saveProcessGramConfig(){
			if($('#processName').val() != null && $('#processName').val() != ''){
				$('#processName').removeClass('input_empty').addClass('input_normal');
			}else $('#processName').addClass('input_empty');
			
			workflow.process.name = $('#processName').val();
			workflow.process.category = $('#processNameSpace').val();
			//$.messager.defaults.ok = "好的";
			//$.messager.alert('','设置完成了，现在可以开始画流程图了~','',function(){$('.configState').fadeOut('slow');});
			//$('#designer').layout('collapse','east');
			/* $('.stateMsg').delay(1000).fadeOut('normal',function(){
				$('.stateMsg').empty().append("设置完成了，现在可以开始画图了~").fadeIn(function(){
					$('.configState').delay(1000).fadeOut('normal',function(){ */
						//$('#designer').layout('expand','west');
						//});
				//});
				//$('.goPaint').bind('click',function(){$('.configState').fadeOut('fast');$('#designer').layout('expand','west');});
				//});
		}
		
		//线上配置，写入XML：双击选定指向箭头后，line就是这条线的对象
		function saveLineProperties(){
			line.lineId=$('#lineId').val();	//设置lineId
			line.lineName=$('#lineExpression').val();	//设置箭头名称
			line.condition=$('#conditionValue').val();
			line.setLabel(line.condition);
			
			lineCheck();
		}
		
		function addToPageTab(tabsId,tabTitle,url){	//追加标签
		 	var title=''+tabTitle;
				if ($('#'+tabsId).tabs('exists', title)){
				$('#'+tabsId).tabs('select', title);//选中并刷新
				var currTab = $('#'+tabsId).tabs('getSelected');
			  //	var url = $(currTab.panel('options').content).attr('src');
				if(url != undefined && currTab.panel('options').title != '参数') {
					$('#'+tabsId).tabs('update',{
						tab:currTab,
						options:{
							content:createFrame(url)
						}
					});
				}
				} else {
				var content = createFrame(url);
				$('#'+tabsId).tabs('add',{
					title:title,
					content:content,
					closable:true
				});
			}
		}
		
		function createFrame(url) {
			var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:99%;"></iframe>';
			return s;
		}
		
		//发布新流程：非空判断+发布方法
		function saveProcess(){
			
			if($('#processName').val() == null || $('#processName').val() == ''){
				$('#processName').addClass('input_empty');
				$.messager.alert('错误提示','流程名称未填写！');
				return null;
			}
			var allModel = workflow.getFigures();
			for ( var i = 0; i < allModel.getSize(); i++) {	//根据id遍历查找
				var subModel = allModel.get(i);
				var EX_port = {IN_port:false,OUT_port:false};	//端口连接检测,都是true即为检验通过
				switch(subModel.type){
				case "draw2d.ExclusiveGateway":
					var allLine = workflow.getLines();
					for(var j=0;j<allLine.getSize();j++){
						var subLine = allLine.get(j);
						if(subLine.getSource().getParent().type == "draw2d.ExclusiveGateway" && subModel.gatewayId == subLine.getSource().getParent().gatewayId){
							EX_port.OUT_port = true;
							if(subLine.condition == null || subLine.condition == ''){
								$.messager.alert('错误提示','任务判断连接着['+subLine.getTarget().getParent().taskName+']任务节点的分支线条件未填写！');
								return false;
							}
						}
						if(subLine.getTarget().getParent().type == "draw2d.ExclusiveGateway"  && subModel.gatewayId == subLine.getTarget().getParent().gatewayId) EX_port.IN_port = true;
					}
					if(EX_port.IN_port && EX_port.OUT_port){}else{
						var str  = EX_port.IN_port  ? '' : '输入';
							str += EX_port.OUT_port ? '' : '输出';
						$.messager.alert('错误提示','任务判断没有'+str+'连接线！');
						return false;
					}
					break;
				case "draw2d.UserTask":
					var allLine = workflow.getLines();
					for(var j=0;j<allLine.getSize();j++){
						var subLine = allLine.get(j);
						if(subLine.getSource().getParent().type == "draw2d.UserTask" && subModel.taskId == subLine.getSource().getParent().taskId) EX_port.OUT_port = true;
						if(subLine.getTarget().getParent().type == "draw2d.UserTask"  && subModel.taskId == subLine.getTarget().getParent().taskId) EX_port.IN_port = true;
					}
					if(EX_port.IN_port&&EX_port.OUT_port){}else{
						var str  = EX_port.IN_port  ? '' : '输入';
							str += EX_port.OUT_port ? '' : '输出';
						$.messager.alert('错误提示','用户任务['+subModel.taskName+']没有'+str+'连接线！');	
						return false;
					}
					break;
				case "draw2d.Start":
					var allLine = workflow.getLines();
					for(var j=0;j<allLine.getSize();j++){
						var subLine = allLine.get(j);
						if(subLine.getSource().getParent().type == "draw2d.Start") EX_port.OUT_port = true;
					}
					if(EX_port.OUT_port){}else{
						$.messager.alert('错误提示','开始节点没有输出连接线！'); 	
						return false;
					}
					break;
				case "draw2d.End":
					var allLine = workflow.getLines();
					for(var j=0;j<allLine.getSize();j++){
						var subLine = allLine.get(j);
						if(subLine.getTarget().getParent().type == "draw2d.End") EX_port.IN_port = true;
					}
					if(EX_port.IN_port){}else{
						$.messager.alert('错误提示','结束节点没有输入连接线！');
						return false;
					}
					break;
				default:
				}
			}
			saveProcessDef();
		}
		
		//关口分支条件的非空检查
		function lineCheck(){
			
			if($('#conditionValue').val() == null || $('#conditionValue').val() == ''){  //条件值
				$('#conditionValue').addClass('input_empty');
			}
			if($('#conditionValue').val() != null && $('#conditionValue').val() != '' && $('#conditionValue').hasClass('input_empty')){  //条件值
					$('#conditionValue').removeClass('input_empty');
			}
		}
		
		function resetFiguresDocumentation(){
			var almo = workflow.getFigures();	//获取画面内所有模型对象
			for ( var i = 0; i < almo.getSize(); i++) {	//根据id遍历查找
				var moObj = almo.get(i);
				if(moObj.type == "draw2d.UserTask"){
					//alert(moObj.taskId);
					if(moObj.documentation == "isApplicationTask" || moObj.documentation == "isEndTask"){
						moObj.documentation  = null;
						moObj.performerType_assignee = null;
						moObj.assignee = null; 
					}
				}
			}
		}
		
		//每次执行画图命令后都会调用的方法，此方法用于自动识别首尾人物节点，机制为：只要连接了开始或结束节点的，都会赋予申请和结束
		var portDraggleInterface = function(){
			//alert("this is test!");
			var xml = workflow.toXML();
			//alert(xml);
			//alert(_xml);
			var XMLObject = toXmlDom(xml);
			var startArray = ["start","startevent1"];
			var endArray  = ["end","endevent1"];
			//alert($(XMLObject).find('sequenceFlow').length);
			resetFiguresDocumentation();
			$(XMLObject).find('sequenceFlow').each(function(i){
				//alert($(this).attr('targetRef'));
				//alert($.inArray("start",startArray));
				//alert($.inArray($(this).attr('sourceRef'),startArray) >= 0);
				if($.inArray($(this).attr('sourceRef'),startArray) >= 0){
					//alert($(this).attr('sourceRef')+"==="+$(this).attr('targetRef'));
					var target = overrideFigures($(this).attr('targetRef'));
					//alert(target.taskId);
					target.documentation = "isApplicationTask";
					target.performerType_assignee = "assignee";
					target.assignee = "\${authenticatedUserId}";
				}
				if($.inArray($(this).attr('targetRef'),endArray) >= 0){
					//alert($(this).attr('sourceRef')+"==="+$(this).attr('targetRef'));
					var target = overrideFigures($(this).attr('sourceRef'));
					//alert(target.taskId);
					target.documentation = "isEndTask";
				}
				/* if($.inArray($(this).attr('sourceRef'),startArray) < 0 && $.inArray($(this).attr('targetRef'),endArray) < 0){
					var target_left  = overrideFigures($(this).attr('sourceRef'));
					if(target_left.type == "draw2d.UserTask")target_left.documentation  = null;
					var target_right = overrideFigures($(this).attr('targetRef'));
					if(target_right.type == "draw2d.UserTask")target_right.documentation = null;
					alert(target_left.type+"=="+target_right.type);
				} */
			}); 
		}
	</script>
</body>
</html>