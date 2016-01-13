<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@include file="/js/common.jsp"%><!-- 必须引入commo -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产信息管理配置页面</title>
<script type="text/javascript" src="<%=contextPath %>/js/easyui1.3.4/plugins/datagrid-detailview.js"></script>
<script type="text/javascript"
		src="<%=basePath%>/js/activiti_operate.js"></script>
<link rel="stylesheet" href="<%=basePath %>/css/upload.css">
<style>
	.taskUrl{width:300px;height:25px;font-size:13px;padding:2px;}
	.div_tr{width:100%;text-align:center;height:20%;margin-top:30px;}
	.div_tr_btn{width:100%;text-align:center;margin-top:20px;}
	.div_td_1{width:25%;text-align:center;float:left;line-height:30px;}
	.div_td_2{width:70%;text-align:center;float:left;}
	.button{
width: 77px;
height:28px;
text-align: center;
font-weight: bold;
color: #fff;
text-shadow:1px 1px 1px #333;
border-radius: 5px;
margin:0 20px 20px 0;
position: relative;
overflow: hidden;
}

.button.gray{
color: #8c96a0;
text-shadow:1px 1px 1px #fff;
border:1px solid #dce1e6;
box-shadow: 0 1px 2px #fff inset,0 -1px 0 #a8abae inset;
background: -webkit-linear-gradient(top,#fff,#f2f3f7);
background: -moz-linear-gradient(top,#fff,#f2f3f7);
background: linear-gradient(top,#fff,#f2f3f7);
}
.button.gray:hover{ cursor:pointer; }

.gray:hover{
background: -webkit-linear-gradient(top,#fefefe,#ebeced);
background: -moz-linear-gradient(top,#f2f3f7,#ebeced);
background: linear-gradient(top,#f2f3f7,#ebeced);
}

.gray:active{
top:1px;
box-shadow: 0 1px 2px #d0d0d0 inset,0 2px 0 #fff;
background: -webkit-linear-gradient(top,#e4e8ec,#e4e8ec);
background: -moz-linear-gradient(top,#e4e8ec,#e4e8ec);
background: linear-gradient(top,#e4e8ec,#e4e8ec);
}
.state{z-index:999;}
.change{width:66px;height:15px;margin-left:10px;background:url() no-repeat;cursor:pointer;}
</style>
<!-- <script type="text/javascript">
	function completeTask(){
		alert(123);
		var url="processOperate!completeTask.do";
		var data="params={processInstanceId:7501}";
		function callback(){
			alert(123);
		}
		$.post(url,data,callback());
	}
</script> -->
</head>
<script>
</script>
<body>
<!-- <a href="processOperate!startProcess.do">按钮</a>
<a href="javascript:completeTask();">完成按钮</a> -->
	<div id="config" class="easyui-panel" fit="true" title="abc">
		
	</div>
	<div id="diagram" class="easyui-panel" fit="true" title="abc" >
		
	</div>
	<div  id="cc" class="easyui-layout" fit="true">
	<span id='menu'></span>
	<div id="tteast" region="east"  collapsed ="true"  collapsible="false" style="width:400px;">
		<!-- <span id="menu"></span> -->
		<ul id="processtree"></ul>
		<img id="processGraph" style="display:none;"/>
	</div>
	<div region="center">
		<table id="processgrid"></table>
	</div>
	<div id="win" style="display:none;">
		<div class="div_tr">
			<div class="div_td_1">当前表单url:</div>
			<div class="div_td_2"><input class="taskUrl" readonly="readonly" id="taskUrl_old"></div>
		</div>
		<div class="div_tr">
			<div class="div_td_1">配置表单url:</div>
			<div class="div_td_2"><input class="taskUrl" id="taskUrl_new"></div>
		</div>
		<div class="div_tr_btn">
			<button onclick="saveChange()" class="button gray">保存</button>
			<button onclick="notChange()" class="button gray">取消</button>
		</div>
	</div>
	<div id="uploader">
	</div>
	</div>
	<script>
		var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
		var taskdefconId = null;
		var taskUrl = null;
		function setGridParam(){}
		function setFormParam(){}
		function setTreeParam(){}
		var subGridState = new Object();
		function isEmptyObject(obj){
			for(var n in obj){return false;}return true;
		}
		//console.log(isEmptyObject(subGridState));
		function addToTab(tabTitle,url){	//在系统根文档追加标签
		 	var title=''+tabTitle;
				if (parent.$('#tabs').tabs('exists', title)){
				parent.$('#tabs').tabs('select', title);//选中并刷新
				var currTab = parent.$('#tabs').tabs('getSelected');
			  //	var url = $(currTab.panel('options').content).attr('src');
				if(url != undefined && currTab.panel('options').title != 'Home') {
					parent.$('#tabs').tabs('update',{
						tab:currTab,
						options:{
							content:createFrame(url)
						}
					});
				}
				} else {
				var content = createFrame(url);
				parent.$('#tabs').tabs('add',{
					title:title,
					content:content,
					closable:true
				});
			}
		}
		
		function createFrame(url) {
			var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
			return s;
		}
		
		function newTabPage(str){
			var isApp = '';
			if((str+'') == 'undefined'){
				str = "配置";
			}
			var node = $('#processtree').tree('getSelected');
			if($('#processtree').tree('isLeaf',node.target)){
				var _node = $('#processtree').tree('getParent',node.target);
				var title = "["+str+"]"+node.text;
				if(typeof node.attributes != 'undefined' && node.attributes != '')
					isApp = ",'taskDescription':'"+node.attributes+"'";
				//alert(isApp);	//如果有则为isStart，如果没有就是undefined
				var param = "{'procKey': '" + _node.id +"', 'taskDefKey': '" + node.id +"'"+isApp+"}";
				var url = "<%=contextPath%>/workflow/processView!toConfig.do?params=" + param + '&sessionId=<s:property value="sessionId"/>';
				openLocalPage('config',title,url);
				//$('#config').parent().delay(2000).slideDown('slow');
				//addToTab(title,url);
			}
		}
		
		function toHandleUrl(procKey, taskDefKey, isApply, processInstanceId,
				title) {	//procKey是根节点id,taskDefKey是子节点id,即任务节点id
			$.ajax({
				async : false,
				type : "POST",
				url : isApply ? "processOperate!GetApplyJson.do"
						: "processOperate!getTaskHandleJson.do",
				data : "params={'procKey':'" + procKey + "','taskDefKey':'"
						+ taskDefKey + "','processInstanceId':'"
						+ processInstanceId + "'}",
				success : function(data) {
					if(data.id != null){
						taskdefconId = data.id;
					}
					if(data.taskHandleUrl == null){
						$('#taskUrl_old').val('当前节点未被配置url').css('color','#0092dc');
					}else{
						taskUrl = data.taskHandleUrl;
						$('#taskUrl_old').val(data.taskHandleUrl).css('color','black');
					}
					$('#win').window('open');
					$('#taskUrl_new').focus();
					/* $.messager.prompt('重定向处理页面','新表单页面URL:',function(r){
						if(r){
							//alert(r);
							if(r == taskUrl){
								//输入结果不变
							}else{
								
							}
						}
					});
					$('input.messager-input').val(data.taskHandleUrl); */
				}
			});
		}
		
		function nodeGroupConfig(){	//用户群配置
			newTabPage();
		}
		
		function nodeUrlConfig(){	//处理表单url配置
			var node = $('#processtree').tree('getSelected');
			//alert(node.attributes);
			if($('#processtree').tree('isLeaf',node.target)){
				$('#taskUrl_new').val('');
				var _node = $('#processtree').tree('getParent',node.target);	//获取到父节点，也就是根节点
				//alert(_node.id+'====='+node.id); 
				$('#win').window({title:'[ <span style="color:#0092dc;">'+node.text+'</span> ]节点表单url配置'});
				toHandleUrl(_node.id,node.id,false);
			}
		}
		
		function notChange(){
			function closeWin(){
				$('#win').slideUp(300,function(){
			    	$('#win').window('close');
			    });
			}
			if($('#taskUrl_new').val().length > 0){
				$.messager.confirm('系统提示','地址已被编辑，是否放弃当前编辑结果？',function(r){
					if (r){
					    // 退出操作;
					   closeWin();
					}
				});
			}else{
				closeWin();
			}
		}
		
		function saveChange(){
			var resultjson = null;
			var node = $('#processtree').tree('getSelected');
			var _node = $('#processtree').tree('getParent',node.target);
			if(taskdefconId == null){	//id为null，说明数据库中并没有该条记录，要创建记录，在读取节点URL时，并没有同时创建记录，而是选择在用户确认保存时才进行创建
				resultjson = {
						'taskHandleUrl' : encodeURIComponent($('#taskUrl_new').val()),
						'procKey'	 : _node.id,
						'taskDefKey' : node.id,
						'taskDescription':node.attributes
				};
			}else{	//反之，则已存在该条记录，可直接修改记录
				resultjson = {
						'taskHandleUrl'  : encodeURIComponent($('#taskUrl_new').val()),
						'taskdefconId'	 : taskdefconId,
						'taskDescription':node.attributes
				};
			}
			$.ajax({
				async : false,
				type : "POST",
				url : "processOperate!saveConfig.do",
				data : "params="+ JSON.stringify(resultjson),
				success : function(data) {
					$('#win').window('close');
					alert('保存成功！');
				}
			});
		}
		
		function getAllExpander(width){
			//console.log($('#processgrid').datagrid('getPanel'));
			//$('#processgrid').datagrid('selectAll');
			
			var allRows = $('#processgrid').datagrid('getRows');
			$.each(allRows,function(i){
				//console.log(selectAll[i]);
				var expander = $('#processgrid').datagrid('getExpander',i);
				if (expander.hasClass('datagrid-row-collapse')){
					//console.log(selectAll[i]);
					$('#'+i+'_dgrid').datagrid('resize',{'width':width});
				}
			});
			//$('#processgrid').datagrid('unselectAll');
		}
		
		function loadGraph(processDefinationKey){
			var img = new Image();
			/* var select_row = $("#processgrid").datagrid('getSelected'); //获取该行对象
			if (select_row) { */
			img.src =  'processList!showDiagram.do?processDefinitionId=' + processDefinationKey;
				
			$('#processGraph').attr('src',img.src);
				
			$(img).load(function (data) {
				 if(img.complete){
                		$('#processGraph').css({
          				  display:'block'
          				  });
				 }else{
					 //未完成,loading...
					 
				 }
	        });
		}
		
		function getStartNodeId(treeId){
			var hasStart = null;
			var root = $('#'+treeId).tree('getRoot');
			var child = $('#'+treeId).tree('getChildren', root.target);
			for(var i=0;i<child.length;i++){
				var nodeObj = $('#'+treeId).tree('getNode', child[i].target);
				if(nodeObj.attributes){
					hasStart = nodeObj.id;
				}
			}
			return hasStart;
		}
		
		function newProcess(){
			var hasStart = getStartNodeId('processtree');
			var select_row = $('#processgrid').datagrid('getSelected'); //获取该行对象
			if (hasStart != null) {
				toTaskUrl(select_row.processName,hasStart,null,false,null);
			}
		}
		
		function changeProState(){
			this.reqServer = function(gridId,index_,row_){
				$.ajax({
					async : false,
					type : "POST",
					url : "processOperate!switchProcessActivity.do?processDefinitionId="+row_.definitionId,
					success : function(data) {
						alert(data.info);
						if(gridId == 'processgrid'){
							//如果父级被更新了，那会导致附表消失，逻辑合理
							$('#'+gridId).datagrid('collapseRow',index_);
						}
						$('#'+gridId).datagrid('updateRow',{index:index_,row:{processState:row_.processState=="已发布"?"未发布":"已发布"}});
					},error:function(data){
						//
					}
				});
			};
			this.reqMsg = function(state){
				var msg = '';
				if(state == "未发布") msg = "发布该流程后，可以开启流程实例，确定发布吗";
					else msg = "停用该流程后，不能再开启该流程的实例，但未结束的实例仍然正常进行，确定停用吗";
				return msg;
			};
			if(!isEmptyObject(subGridState)){
				//说明是选中了，改变流程状态
				$.messager.confirm('变更发布状态',this.reqMsg(subGridState.selectRow.processState),function(r){
					if(r){
						this.reqServer(subGridState.id,subGridState.selectIndex,subGridState.selectRow);
					}else{
						//
					}
				});
			}else{
				var selected = $('#processgrid').datagrid('getSelected');
				var rowIndex = $('#processgrid').datagrid('getRowIndex',selected);
				if(selected != null){
					//流程状态
					$.messager.confirm('变更流程状态',this.reqMsg(selected.processState),function(r){
						if(r){
							this.reqServer('processgrid',rowIndex,selected);
						}else{
							//
						}
					});
				}else{
					alert("请先选中一条流程");
				}
			}
		}
		
		function designDiagram(){
			window.location.href = 'processView!toDraw.do?sessionId=<s:property value="sessionId"/>';
		}
		
		function designDiagramEdit(){
			var param = '';
			if(!isEmptyObject(subGridState)){
				param = '?processDefinitionId='+subGridState.selectRow.processName+'&deploymentId='+subGridState.selectRow.deploymentId+'&sessionId=<s:property value="sessionId"/>';
				window.location.href = 'processView!toDraw.do'+param;
			}else{
				var selected = $('#processgrid').datagrid('getSelected');
				if(selected != null){
					param = '?processDefinitionId='+selected.processName+'&deploymentId='+selected.deploymentId+'&sessionId=<s:property value="sessionId"/>';
					window.location.href = 'processView!toDraw.do'+param;
				}else{
					alert("请先选中一条流程");
				}
			}
		}
		
		function showForm(){
			var hasStart = getStartNodeId('processtree');
			var select_row = $('#processgrid').datagrid('getSelected'); //获取该行对象
			if (select_row && hasStart != null) {
				toTaskUrl(select_row.processName,hasStart,null,true,'[只读]流程业务处理页面');
			}
		}
		
		function deleteSelectedProcess(){
			if(!isEmptyObject(subGridState)){
				deleteProcess(subGridState.id);
			}else{
				deleteProcess('processgrid');
			}
		}
		
		function exportSelectedProcess(){
			if(!isEmptyObject(subGridState)){
				exportProcess(subGridState.id,'stream');
			}else{
				exportProcess('processgrid','stream');
			}
		}
		
		$(function(){
			$('#processgrid').datagrid({
				view: detailview,
				detailFormatter:function(index,row){
					return '<table id="'+index+'_dgrid" class="ddv"></table>';
				}, 
				onSelect:function(rowIndex, rowData){
					//if($('#pro_dg').linkbutton('options').text == "流程图模式"){
					$('#processtree').tree({
						url:'processOperate!processTree.do?procKey='+rowData.processKey+'&version='+rowData.version
					});
					if(!isEmptyObject(subGridState)){
						$('#'+subGridState.id).datagrid('unselectAll'); 
						subGridState = new Object();
					}
					if(rowData.processState == "已发布"){
						//当前选中已发布的行，按钮应该为停用标识
						$('#pro_state').linkbutton({
							iconCls : 'icon-no',
							text : '停用流程'
						});
					}else if(rowData.processState == "未发布"){
						//当前选中已发布的行，按钮应该为停用标识
						$('#pro_state').linkbutton({
							iconCls : 'icon-standard-accept',
							text : '发布流程'
						});
					}
					//}
					//if($('#pro_dg').linkbutton('options').text == "树节点模式"){
						//loadGraph(rowData.processKey);
					//}
				//$('#processtree').tree('reload');
				
				},
				onDblClickRow:function(rowIndex, rowData){
					//$('#processgrid').datagrid('unselectAll');
				},
				/* ,
				
				onUnselect:function(rowIndex, rowData){
					$('#processtree').hide();
					$('#cc').layout('collapse','east');
				} */
				onExpandRow: function(index,row){
					if(row.version <= 1){return false;}
					var ddv = $('#'+index+'_dgrid');//$(this).datagrid('getRowDetail',index).find('table.ddv');
					ddv.datagrid({
						//id:index+'_dgrid',
						url : 'processList!deploymentList.do?systemName=<s:property value="systemName"/>&processKey='+row.processKey,
						//fit:true,
						fitColumns:true,
						singleSelect:true,
						rownumbers:true,
						striped:true,
						pagination:true,
						//height:320,
						columns:[[
							{field:'processName',title:'流程名称',width:100,align:'center'},
							{field:'version',title:'版本号',width:25,align:'center',sortOrder:'desc'},
							{field:'deployTime',title:'发布时间',width:100,align:'center'},
							{field:'systemName',title:'系统名称',width:100,align:'center',formatter:CN_systemName},
							{field:'processState',title:'发布状态',width:50,align:'center'},
							{field:'definitionId',title:'definitionId',width:0,hidden:true},
							{field:'deploymentId',title:'deploymentId',width:0,hidden:true},
							{field:'processKey',title:'processKey',width:0,hidden:true}
						]],
						onResize:function(){
							$('#processgrid').datagrid('fixDetailRowHeight',index);
						},
						onLoadSuccess:function(){
							setTimeout(function(){
								$('#processgrid').datagrid('fixDetailRowHeight',index);
								/* $('.state').bind('mouseenter',function(e){
									//alert(this);
									//console.log(this);
									$('<button class="change">123</button>').appendTo(this).bind('click',function(e){
										
									});
								});
								$('.state').bind('mouseleave',function(e){
									//alert(this);
									//console.log(this);
									$(this).find('button').remove();
								}); */
							},0);
						},
						onClickCell:function(rowIndex, field, value){
							//alert(this.tagName);
						},
						onDblClickRow:function(rowIndex, rowData){
							//viewDgrm(rowData.processdefid);
						},
						onSelect:function(rowIndex, rowData){
								$('#processtree').tree({
									url:'processOperate!processTree.do?procKey='+rowData.processKey+'&version='+rowData.version
								});
								if(!isEmptyObject(subGridState)){
									if(subGridState.id != index+'_dgrid')
										$('#'+subGridState.id).datagrid('unselectAll'); 
									subGridState = new Object();
								}
								subGridState.id = index+'_dgrid';
								subGridState.selectIndex = rowIndex;
								subGridState.selectRow = rowData;
								$('#processgrid').datagrid('unselectAll'); 
								//console.log(subGridState);
								if(rowData.processState == "已发布"){
									//当前选中已发布的行，按钮应该为停用标识
									$('#pro_state').linkbutton({
										iconCls : 'icon-no',
										text : '停用流程'
									});
								}else if(rowData.processState == "未发布"){
									//当前选中已发布的行，按钮应该为停用标识
									$('#pro_state').linkbutton({
										iconCls : 'icon-standard-accept',
										text : '发布流程'
									});
								}
						}/* ,
						loadFilter:function(data){
							var data_ = data;
							$.each(data_.rows,function(i){
								if(this.version == row.version){data_.rows.splice(i,1);data_.total--;return false;}
							});
							return data_;
						} */
					});
					$('#processgrid').datagrid('fixDetailRowHeight',index);
				},
				onResize:function(width,height){
					getAllExpander(width-50);
				}
			});
			
			$('#processtree').tree({
				/* loadFilter:function(data,parent){	//只显示被选择的流程树，树和表暂不在后台过滤
					var _data = data;
					var row = $('#processgrid').datagrid('getSelected');
					if(row != null){
						for(var i=0;;i){	//死循环
							if(_data[i] == null){
								break;
							}else{
								if(row.processKey != _data[i].id){
									_data.splice(i,1);
									i--;	//成功移除，则数组长度会减少1
								}
							}
							i++;
						}
						//alert(JSON.stringify(_data));
					}
					return _data;
				},
				onDblClick:function(node){
					//newTabPage();
				}, */
				onLoadSuccess:function(){
					$('#cc').layout('expand','east');
					//console.log($('#processgrid').datagrid('getAllExpander'));
				}
			});
			
			$('#diagram').parent().hide();
			$('#config').parent().hide();
			$('#win').window({
				width : 450,
				height: 250,
				closed: true,
				minimizable: false,
				maximizable: false,
				collapsible: false,
				closable:false,
				onClose:function(){
					taskdefconId = null;
				},
				onOpen:function(){
					$('#win').slideDown(300);
				}
			});
			initProcessViewBean();
			$('#processgrid').datagrid({
				url : 'processList!deploymentList.do?systemName=<s:property value="systemName"/>'
			});
		});
		</script>
</body>
</html>