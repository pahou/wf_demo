<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="content-type" />

<title>Process Diagram</title>
<!-- framework CSS -->
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/css/style.css"/>
<!-- JQuery EasyUi CSS-->
<link type="text/css"
	href="<%=contextPath%>/js/processdesigner/jquery-easyui/themes/default/easyui.css"
	rel="stylesheet" title="blue" />
<link
	href="<%=contextPath%>/js/processdesigner/jquery-easyui/themes/icon.css"
	type="text/css" rel="stylesheet" />

<!-- JQuery validate CSS-->
<link
	href="<%=contextPath%>/js/processdesigner/validate/jquery.validate.extend.css"
	type="text/css" rel="stylesheet" />

<!-- JQuery AutoComplete -->
<link rel="stylesheet" type="text/css"
	href="<%=contextPath%>/js/processdesigner/jquery-autocomplete/jquery.autocomplete.css" />
<!--<link rel="stylesheet" type="text/css" href="<%=contextPath%>/js/processdesigner/jquery-autocomplete/lib/thickbox.css" />-->

<!-- JQuery-->
<script src="<%=contextPath%>/js/processdesigner/jquery-1.4.4.min.js"
	type="text/javascript"></script>
<!--<script src="<%=contextPath%>/js/processdesigner/jquery-1.6.min.js" type="text/javascript"></script>-->

<!-- JQuery EasyUi JS-->
<script
	src="<%=contextPath%>/js/processdesigner/jquery-easyui/jquery.easyui.min.js"
	type="text/javascript"></script>
<!-- JQuery validate JS-->
<script
	src="<%=contextPath%>/js/processdesigner/validate/jquery.validate.js"
	type="text/javascript"></script>
<script
	src="<%=contextPath%>/js/processdesigner/validate/jquery.metadata.js"
	type="text/javascript"></script>
<script
	src="<%=contextPath%>/js/processdesigner/validate/jquery.validate.method.js"
	type="text/javascript"></script>
<script
	src="<%=contextPath%>/js/processdesigner/validate/jquery.validate.extend.js"
	type="text/javascript"></script>

<!-- JQuery form Plugin -->
<script src="<%=contextPath%>/js/processdesigner/jquery.form.js"
	type="text/javascript"></script>

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
	
	.userTaskProperties,.lineProperties,.forCondition{display:none;}
	.properties,.propertyRow,.propertyValue{}
	.properties,.propertiesOpt{width:100%;float:left;}
	.propertyRow{width:25%;float:left;text-align:right;height:40px;line-height:40px;}
	.propertyValue{text-align:center;width:69%;float:left;padding-top:10px;height:30px;}
	.nodeInput{width:200px;height:20px;padding-left:6px;}
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
	input,.input_normal{border:1px solid gray;}
	.proDescribe{height:85px;width:200px;font-size:12px;font-family:'微软雅黑';line-height:20px;border:1px solid gray;resize:none;}
	.input_empty{border:1px solid red;}
	.task-header{line-height:11px;}
	.tabs-tool{background:none;border:none;}
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
			<a href="##" class="easyui-linkbutton" plain="true"
				iconCls="user-task-icon" wfModel="UserTask">用户任务</a><br/>
			 <a href="##" class="easyui-linkbutton" plain="true"
				iconCls="exclusive-gateway-icon" wfModel="ExclusiveGateway"
				iconImg="<%=contextPath%>/js/processdesigner/designer/icons/type.gateway.exclusive.png">唯一网关</a><br/>
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
			<div region="north" iconCls="properties-icon" title="" style="height: 220px;">
				<div class="easyui-layout" fit="true">
					<div region="south" iconCls="properties-icon" title="" border="false" style="height: 30px;text-align:center;">
						<!-- <button onclick="saveProcessGramConfig();" class="processConfig">写入xml</button> -->
						<button onclick="saveProcess();" class="processConfig">保存流程</button>
						<button onclick="saveProcess();" class="processConfig">发布流程</button>
						<button onclick="" class="processConfig">取消</button>
					</div>
					<div region="center" iconCls="properties-icon" title="" border="false">
						<div class="properties">
							<div class="propertyRow">流程&nbspkey：</div>
							<div class="propertyValue"><input id="processId" onblur="saveProcessGramConfig();" onkeydown="saveProcessGramConfig();" class="nodeInput"/></div>
						</div>
						<div class="properties">
							<div class="propertyRow">流程名称：</div>
							<div class="propertyValue"><input id="processName" onblur="saveProcessGramConfig();" onkeydown="saveProcessGramConfig();" class="nodeInput"/></div>
						</div>
						<div class="properties">
							<div class="propertyRow">流程描述：</div>
							<div class="propertyValue"><textarea id="processDescribe" class="nodeInput proDescribe"></textarea></div>
						</div>
					</div>
				</div>
			</div>
			<div region="center" iconCls="properties-icon" title="">
				<div class="userTaskProperties identifyclass">
			<div class="properties">
				<div class="propertyRow">节点&nbspkey：</div>
				<div class="propertyValue"><input id="nodeId" onblur="saveTaskGeneral(getConfigData());" onkeydown="saveTaskGeneral(getConfigData());" class="nodeInput"/></div>
			</div>
			<div class="properties">
				<div class="propertyRow">节点名称：</div>
				<div class="propertyValue"><input id="name" onblur="saveTaskGeneral(getConfigData());" onkeydown="saveTaskGeneral(getConfigData());" class="nodeInput"/></div>
			</div>
			<!-- <div class="properties">
				<div class="propertyRow">是否含有写业务表单:</div>
				<div class="propertyValue">
					<input id="hasform" class="easyui-combobox" name="hasform"/>     
				</div>
			</div> -->
		</div>
		<div class="lineProperties identifyclass">
			<div class="properties">
				<div class="propertyRow">箭头&nbspkey：</div>
				<div class="propertyValue"><input id="lineId" onblur="saveLineProperties();" onkeydown="saveLineProperties();" class="nodeInput"/></div>
			</div>
			<div class="properties">
				<div class="propertyRow">箭头名称：</div>
				<div class="propertyValue"><input id="lineExpression" onblur="saveLineProperties();" onkeydown="saveLineProperties();" class="nodeInput"/></div>
			</div>
			<div class="properties">
				<div class="propertyRow">是否含有条件：</div>
				<div class="propertyValue"><input id="isCondition" class="nodeInput"/></div>
			</div>
			<div class="forCondition">
			<div class="properties">
				<div class="propertyRow">条件类型：</div>
				<div class="propertyValue"><input id="conditionType" class="nodeInput easyui-combobox"/></div>
			</div>
			<div class="properties">
				<div class="propertyRow">判断符号：</div>
				<div class="propertyValue"><input id="symbol" class="nodeInput easyui-combobox"/></div>
			</div>
			<div class="properties">
				<div class="propertyRow">条件值：</div>
				<div class="propertyValue"><input id="conditionValue"  onblur="saveLineProperties();" onkeydown="saveLineProperties();"  class="nodeInput"/></div>
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
	<!-- form configuration window -->
	<div id="form-win" title="Form Configuration"
		style="width: 750px; height: 500px;"></div>
	<!-- listener configuration window -->
	<div id="listener-win" title="Listener Configuration"style="width: 750px; height: 500px;"></div>
	<!-- candidate configuration window -->
	<div id="task-candidate-win" title=""style="width: 750px; height: 500px;"></div>
	<script type="text/javascript">
		var workflow;	//= new draw2d.MyCanvas("paintarea");	//含有process对象
		
		var txtGnid = '<s:property value="txtGnid"/>';
		var txtGnmc = '<s:property value="txtGnmc"/>';
		var txtGnjc = '<s:property value="txtGnjc"/>';
		var processDefinitionId='<s:property value="processDefinitionId"/>';
		
		var processDefinitionName="";
		var processDefinitionVariables="";
		var _process_def_provided_listeners="";
		var is_open_properties_panel = false;//false
		var task;	// = new draw2d.UserTask(openTaskProperties);	//继承了Task
		var line;
		
		var taskJson = [];
		var lineJson = [];
		
		$(function(){
			
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
			
			/* $('#hasform').combobox({
				width:$('.nodeInput').width(),
				panelHeight:88,
				editable:false,
				valueField:'id',    
			    textField:'text',
			    value:2,
			    data:[{    
			        "id":1,    
			        "text":"是"   
			    },{    
			        "id":2,    
			        "text":"否"   
			    }],  
			    onSelect:function(record){
			    	
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
					saveLineProperties();
			    }
			});
			$('#conditionType').combobox({
				width:$('.nodeInput').width(),
				//panelHeight:88,
				editable:false,
				required:true,
				valueField:'id',    
			    textField:'text',
			    data:[{    
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
			    },{
			    	"id":'value',
			    	"text":"自定义"
			    }],
			    onSelect:function(record){
			    	//alert(record.text); //record为当前选择的数据
			    	if(record.text == "自定义"){
			    		$('#conditionType').combobox({editable:true});
			    		$('#conditionType').next('span.combo').find('input:eq(0)').focus();
			    	}else{
			    		if($('#conditionType').combobox('options').editable == true){
			    			$('#conditionType').combobox({editable:false});
			    		}
			    	}
			    	
			    	saveLineProperties();
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
			    		/* $('#conditionValue').val(null);
			    		$('#conditionType').combobox('clear');	//天数,数量,..
						$('#symbol').combobox('clear'); //符号 */
						line.isExpression = true;
			    		$('.forCondition').slideDown();
			    	}else{
			    		line.isExpression = false;
			    		$('.forCondition').slideUp();
			    	}
			    	
			    	saveLineProperties();
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
			
		});	
		
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
		 * 打开任务属性
		 */
		function openTaskProperties(t){
			if(!is_open_properties_panel)
				_designer.layout('expand','east');
			task=t;
			if(task.type=="draw2d.UserTask"){
				//_properties_panel_obj.panel('refresh','processView!toUserTaskProperties.do');
				$('#nodeId').val(task.taskId);
				$('#name').val(task.taskName);
				/* if(task.documentation != null){
						$('#hasform').combobox('select','是');
					}else{
						$('#hasform').combobox('select','否');
					} */
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

		function openProcessDef(processDefinitionId){
			/* $.ajax({
				//url:"../processDesigner/wf/procdef/procdef!getProcessDefXML.action?procdefId="+processDefinitionId,
				url:"../designer/processDesigner!loadProcess.do?processDefinitionId="+processDefinitionId,
				type: 'POST',
				dataType:'xml',
				error:function(XMLHttpRequest, textStatus, errorThrown){
					console.log(textStatus);
					$.messager.alert("解析出错！","错误");
					return "";
				},
				success:parseProcessDescriptor	
			});  */
		}
	
		/**
		 * 打开流程线属性
		 */
		function openFlowProperties(l){
			//alert(id);
			if(!is_open_properties_panel)
				_designer.layout('expand','east');
			line=l;
			$('#lineId').val(line.lineId);
			$('#lineExpression').val(line.lineName);
			//line.condition=$('#condition').val();
			//alert(line.condition);
			if(line.isExpression == true){
				$('#isCondition').combobox('select',1);
				$('#conditionValue').val(line.condition);  //条件值
				$('#conditionType').combobox('select',line.field);	//天数,数量,..
				$('#symbol').combobox('select',line.decision); //符号
			}else{
				$('#isCondition').combobox('select',2);
				$('#conditionValue').val(null);  //条件值
				$('#conditionType').combobox('clear');	//天数,数量,..
				$('#symbol').combobox('clear'); //符号
				
			}
			
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
		function saveProcessDef(){
			var xml = workflow.toXML();
			//alert(workflow.process.getVariablesJSONObject());
			//alert(workflow.process.getVariablesJSONObject());
			//return;
			$.ajax({
				url:"processOutput!upLoadProcessDefinition.do",
				type: 'POST',
				data:'data='+workflow.toXML(),
				dataType:'json',
				error:function(){
					return "123";
				},
				success:function(data){
					if(data.result){
						$.messager.alert('Info','Save Successfully!','info');
					}else{
						$.messager.alert('Error',data.message,'error');
					}
				}	
			}); 
			
		}
		function exportProcessDef(obj){
			//obj.href="../wf/procdef/procdef!exportProcessDef.action?procdefId="+processDefinitionId+"&processName="+processDefinitionName;
		}

		/**
		 * 发布流程
		 */
		function deploy(){
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
		}

		function parseProcessDescriptor(data){
						var descriptor = $(data);
						var definitions = descriptor.find('definitions');
						var process = descriptor.find('process');
						var startEvent = descriptor.find('startEvent');
						var endEvent = descriptor.find('endEvent');
						var userTasks = descriptor.find('userTask');
						var exclusiveGateway = descriptor.find('exclusiveGateway');
						var parallelGateway = descriptor.find('parallelGateway');
						var lines = descriptor.find('sequenceFlow');
						var shapes = descriptor.find('[nodeName=bpmndi:BPMNShape]');
						var edges = descriptor.find('[nodeName=bpmndi:BPMNEdge]');
						//workflow.process.category=definitions.attr('targetNamespace');
						workflow.process.category="http://activiti.org/bpmn20";
						workflow.process.id=process.attr('id');
						workflow.process.name=process.attr('name');
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
							var tid = $(this).attr('id');
							task.id=tid;
							var tname = $(this).attr('name');
							var assignee=$(this).attr('activiti:assignee');
							var candidataUsers=$(this).attr('activiti:candidateUsers');
							var candidataGroups=$(this).attr('activiti:candidateGroups');
							var formKey=$(this).attr('activiti:formKey');
							if(assignee!=null&&assignee!=""){
								task.isUseExpression=true;
								task.performerType="assignee";
								task.expression=assignee;
							}else if(candidataUsers!=null&&candidataUsers!=""){
								task.isUseExpression=true;
								task.performerType="candidateUsers";
								task.expression=candidataUsers;
							}else if(candidataGroups!=null&&candidataGroups!=""){
								task.isUseExpression=true;
								task.performerType="candidateGroups";
								task.expression=candidataGroups;
							}
							if(formKey!=null&&formKey!=""){
								task.formKey=formKey;
							}
							var documentation = trim($(this).find('documentation').text());
							if(documentation != null && documentation != "")
								task.documentation=documentation;
							task.taskId=tid;
							task.taskName=tname;
							if(tid!= tname)
								task.setContent(tname);
							var listeners = $(this).find('extensionElements').find('[nodeName=activiti:taskListener]');
							task.setListeners(parseListeners(listeners,"draw2d.Task.Listener","draw2d.Task.Listener.Field"));
							var performersExpression = $(this).find('potentialOwner').find('resourceAssignmentExpression').find('formalExpression').text();
							if(performersExpression.indexOf('user(')!=-1){
								task.performerType="candidateUsers";
							}else if(performersExpression.indexOf('group(')!=-1){
								task.performerType="candidateGroups";
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
							});
							shapes.each(function(i){
								var id = $(this).attr('bpmnElement');
								if(id==task.id){
									var x=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('x'));
									var y=parseInt($(this).find('[nodeName=omgdc:Bounds]').attr('y'));
									workflow.addModel(task,x,y);
									return false;
								}
							});
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
								var x = parseInt($(this).find(
										'[nodeName=omgdc:Bounds]').attr('x'));
								var y = parseInt($(this).find(
										'[nodeName=omgdc:Bounds]').attr('y'));
								workflow.addModel(gateway, x, y);
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
				var condition = $(this).find('conditionExpression').text();
				var sourceRef = $(this).attr('sourceRef');
				var targetRef = $(this).attr('targetRef');
				var source = workflow.getFigure(sourceRef);
				var target = workflow.getFigure(targetRef);
				edges.each(function(i) {
					var eid = $(this).attr('bpmnElement');
					if (eid == lid) {
						var startPort = null;
						var endPort = null;
						var points = $(this).find('[nodeName=omgdi:waypoint]');
						var startX = $(points[0]).attr('x');
						var startY = $(points[0]).attr('y');
						var endX = $(points[1]).attr('x');
						var endY = $(points[1]).attr('y');
						var sports = source.getPorts();
						for ( var i = 0; i < sports.getSize(); i++) {
							var s = sports.get(i);
							var x = s.getAbsoluteX();
							var y = s.getAbsoluteY();
							if (x == startX && y == startY) {
								startPort = s;
								break;
							}
						}
						var tports = target.getPorts();
						for ( var i = 0; i < tports.getSize(); i++) {
							var t = tports.get(i);
							var x = t.getAbsoluteX();
							var y = t.getAbsoluteY();
							if (x == endX && y == endY) {
								endPort = t;
								break;
							}
						}
						if (startPort != null && endPort != null) {
							var cmd = new draw2d.CommandConnect(workflow,startPort, endPort);
							var connection = new draw2d.DecoratedConnection();
							connection.id = lid;
							connection.lineId = lid;
							connection.lineName = name;
							if (lid != name)
								connection.setLabel(name);
							if (condition != null && condition != "") {
								connection.condition = condition;
								var zf = condition.substring(condition.indexOf("{") + 1, condition.indexOf("}"));
								var hasa = "";
								var hasb = "";
								var jc = "";
								var fh = "";
								var value = "";
								if (zf.indexOf("<=") > 0) {
									hasa = zf.indexOf("<=");
								} else if (zf.indexOf(">=") > 0) {
									hasa = zf.indexOf(">=");
								} else if (zf.indexOf("==") > 0) {
									hasa = zf.indexOf("==");
								} else if (zf.indexOf(">") > 0) {
									hasb = zf.indexOf(">");
								} else if (zf.indexOf("<") > 0) {
									hasb = zf.indexOf("<");
								}
								if (hasa > 0) {
									jc = zf.substring(0, hasa);
									fh = zf.substring(hasa, hasa + 2);
									value = zf.substring(hasa + 2, zf.length);
								} else if (hasb > 0) {
									jc = zf.substring(0, hasb);
									fh = zf.substring(hasb, hasb + 1);
									value = zf.substring(hasb + 1, zf.length);
								}
								//alert(jc);
								//alert(fh);
								//alert(value);
								connection.field = jc;
								connection.decision = fh;
								connection.condition = value;
							}
							cmd.setConnection(connection);
							workflow.getCommandStack().execute(cmd);
						}
						return false;
					}
				});
			});

			if (typeof setHightlight != "undefined") {
				setHightlight();
			}
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
						workflow.process.id="工作流设计";
						workflow.process.name="工作流设计"; 
						//初始状态下，显示流程信息给用户
						$('#processId').val(workflow.process.id);
						$('#processName').val(workflow.process.name);
						
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
					//documentation:$('#hasform').combobox('getValue')
			};
			
			//这里需要判断是否修改task的id和name
			/* if(taskAttributes.baseAttributes.taskId != '' && taskAttributes.baseAttributes.taskId != null){
					taskAttributes.candidateUser =  "\${processService.getTaskCatedidates('"+workflow.process.id+"','"+taskAttributes.baseAttributes.taskId+"','user')}";
					taskAttributes.candidateGroup =  "\${processService.getTaskCatedidates('"+workflow.process.id+"','"+taskAttributes.baseAttributes.taskId+"','group')}";
				}else{
						taskAttributes.candidateUser =  "\${processService.getTaskCatedidates('"+workflow.process.id+"','"+task.taskId+"','user')}";//{increment:3,size:3,data:[1,2,3]},
						taskAttributes.candidateGroup =  "\${processService.getTaskCatedidates('"+workflow.process.id+"','"+task.taskId+"','group')}";
					 } */
			
			return taskAttributes;
			
		}
		
		
		//此方法可以调用task.js里面定义的属性，对选定的模型进行配置属性
		function saveTaskGeneral(options){
			var defaults = {
				taskId:'',		//临时数据的标识
				taskName:'',
				isUseExpression:false,
				assignee:'',
				candidateUser:'',
				candidateGroup:'',
				//documentation:''
			};
			
			var opts = $.extend({},defaults,options);
			
			task.isUseExpression = opts.isUseExpression;
			
			if(opts.taskId !=null && opts.taskId != ''){
				task.taskId = opts.taskId;
			}
			
			if(opts.taskName != null && opts.taskName != ''){
				task.taskName = opts.taskName;	//设置userTask的名称
				task.setContent(opts.taskName);
			}
			/* if(opts.documentation == true){
				task.documentation = "mark";	//标记标签，形式：<userTask><documentation></documentation></userTask>
			}else{
				task.documentation = null;
			} */
			//指定受理人
			if(opts.assignee != ''&& opts.assignee != null){
				task.performerType_assignee = "assignee";
				task.assignee = opts.assignee;
			}
			//配置候选用户
			if(opts.candidateUser != ''&& opts.candidateUser != null){
				task.performerType_candidateUsers = "candidateUsers";
				if(opts.isUseExpression == false){
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
				if(opts.isUseExpression == false){
					task.candidateGroups.increment = opts.candidateGroup.increment;
					task.candidateGroups.size = opts.candidateGroup.size;
					task.candidateGroups.data = opts.candidateGroup.data;
				}else{
					task.expression_candidateGroups = opts.candidateGroup;
				}
			}
			
			/* if(isRepeat(task.taskId,taskJson) == null){	//如果是一个新的节点，就追加记录
				taskJson.push({taskId:opts.taskId});
			} */
			
			//alert(taskJson.length);
			//以下为一个节点的数据
			/* {
				taskId:123,
				config:[{type:'user',data:[1,2,...,n],opt:'add'},{type:'group',data:[1,2,...,n],opt:'del'}]
			   } */
		} 
		
		//查找临时数据中的节点
		function isRepeat(thisId,examineJson){
			for(var i=0;i<examineJson.length;i++){
				if(thisId == examineJson[i].taskId){
					return i;
				}
			}
			return null;
		}
		
		//流程配置
		function saveProcessGramConfig(){
			if($('#processId').val() != null && $('#processId').val() != ''){
				workflow.process.id = $('#processId').val();
				$('#processId').removeClass('input_empty').addClass('input_normal');
			}
			
			if($('#processName').val() != null && $('#processName').val() != ''){
				workflow.process.name = $('#processName').val();
				$('#processName').removeClass('input_empty').addClass('input_normal');
				var tab = $('#process-definition-tab').tabs('getSelected');
				$('#process-definition-tab').tabs('update', {
					tab: tab,
					options: {
						title: workflow.process.name	//流程名称
					}
				});
			}
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
		
		//线上配置
		function saveLineProperties(){
			line.lineId=$('#lineId').val();
			line.lineName=$('#lineExpression').val();
			//line.condition=$('#condition').val();
			if(line.isExpression == true){
				var conditionValue = $('#conditionValue').val();  //条件值
				var field = $('#conditionType').combobox('getValue');	//天数,数量,..
				var symbol = $('#symbol').combobox('getValue'); //符号
				
				line.field=field;
				line.condition=/* ""+fieldId+symbol+ */conditionValue;	//条件表达式
				///line.conditionValue = conditionValue;
				line.decision = symbol;
				line.setLabel(''+line.field+line.decision+line.condition);
			}else if(line.isExpression == false){
				line.field=null;
				line.condition=null;	//条件表达式
				//line.conditionValue = null;
				line.decision = null;
				//line.setLabel($('#lineExpression').val());
			}else{
				//line.setLabel($('#lineExpression').val());
			}
			
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
		
		function saveProcess(){
			var mark_id = null,mark_name = null;
			if($('#processId').val() == null || $('#processId').val() == ''){
				$('#processId').addClass('input_empty');
				mark_id = true;
				
			}
			if($('#processName').val() == null || $('#processName').val() == ''){
				$('#processName').addClass('input_empty');
				mark_name = true;
			}
			if(mark_id == true && mark_name == true){
				alert('[ 流程key ]和[ 流程名称 ]都不能为空！');
				return ;
				}else if(mark_name == true){
					alert('[ 流程名称 ]不能为空！');
					return ;
					}else if(mark_id == true){
						alert('[ 流程key ]不能为空！');
						return ;
						}
			//alert(workflow.toXML());
			saveProcessDef();
		}
		
		function lineCheck(){
			if($('#isCondition').combobox('getText') == "是"){
				if($('#conditionValue').val() == null || $('#conditionValue').val() == ''){  //条件值
					$('#conditionValue').addClass('input_empty');
				}
				if($('#conditionValue').val() != null && $('#conditionValue').val() != '' && $('#conditionValue').hasClass('input_empty')){  //条件值
					$('#conditionValue').removeClass('input_empty');
				}
			}
		}
		
	</script>
</body>
</html>
