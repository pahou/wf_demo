//获取当前网址，如： http://localhost:8088/test/test.jsp  
var curPath=window.document.location.href;  
//获取主机地址之后的目录，如： test/test.jsp  
var pathName=window.document.location.pathname;  
var pos=curPath.indexOf(pathName);  
//获取主机地址，如： http://localhost:8088  
var localhostPath=curPath.substring(0,pos);  
//获取带"/"的项目名，如：/test  
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);  

function completeTask(taskName, varJson) {
	if (!varJson) {
		varJson = {};
	}
	varJson.processInstanceId = processInstanceId;
	if($('#commentInfo').val() != '' && $('#commentInfo').val() != null){
		varJson.commentInfo = $('#commentInfo').val();
	}else{
		alert('您还未填写点评！');
		return null;
	}
	$.ajax({
		type : "POST",
		url : getbasePath() + "/workflow/processOperate!completeTask.do",
		data : 'params=' + JSON.stringify(varJson),
		success : function() {
			afterComplete(taskName);
		}
	});
}

function rollBackToAssign(taskName, varJson) {
	if (!varJson) {
		varJson = {};
	}
	varJson.processInstanceId = processInstanceId;
	if($('#commentInfo').val() != '' && $('#commentInfo').val() != null){
		varJson.commentInfo = $('#commentInfo').val();
	}else{
		alert('您还未填写点评！');
		return null;
	}
	$.ajax({
		type : "POST",
		url : getbasePath() + "/workflow/processOperate!rollBackToAssign.do",
		data : 'params=' + JSON.stringify(varJson),
		success : function() {
			afterComplete(taskName);
		}
	});
}

function rollBackToPrev(taskName, varJson) {
	if (!varJson) {
		varJson = {};
	}
	varJson.processInstanceId = processInstanceId;
	if($('#commentInfo').val() != '' && $('#commentInfo').val() != null){
		varJson.commentInfo = $('#commentInfo').val();
	}else{
		alert('您还未填写点评！');
		return null;
	}
	$.ajax({
		type : "POST",
		url : getbasePath() + "/workflow/processOperate!rollBackToPrev.do",
		data : 'params=' + JSON.stringify(varJson),
		success : function() {
			afterComplete(taskName);
		}
	});
}

function afterComplete(taskName) {
	$.messager.alert('系统提示', taskName + '业务已完成', 'info', function() {
		var handleTab = parent.$('#tabs').tabs('getSelected');
		var url = 'workflow/processView!toList.do';
		if (parent.$('#tabs').tabs('exists', '待办事项')) {
			parent.$('#tabs').tabs('select', '待办事项');// 选中并刷新
			var currTab = parent.$('#tabs').tabs('getSelected');
			parent.$('#tabs').tabs('update', {
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}else{
			addTaskToTab('待办事项',url);
		}
		parent.$('#tabs').tabs('close', handleTab.panel('options').title);
	});
}

function afterApplication(taskName) {
	$.messager.alert('系统提示', taskName + '业务已完成', 'info', function() {
		var handleTab = parent.$('#tabs').tabs('getSelected');
		var url = 'workflow/processView!toApplicant.do';
		if (parent.$('#tabs').tabs('exists', '我的请求')) {
			parent.$('#tabs').tabs('select', '我的请求');// 选中并刷新
			var currTab = parent.$('#tabs').tabs('getSelected');
			parent.$('#tabs').tabs('update', {
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}else{
			addTaskToTab('我的请求',url);
		}
		parent.$('#tabs').tabs('close', handleTab.panel('options').title);
	});
}

function createFrame(url) {
	var s = '<iframe scrolling="auto" frameborder="0"  src="' + url
			+ '" style="width:100%;height:100%;"></iframe>';
	return s;
}

function LoadTaskComment(gridId) {
	$("#" + gridId).datagrid('options').url = getbasePath()
			+ "/workflow/processList!comment4CurrentTask.do?processInstanceId="
			+ processInstanceId;
	$('#' + gridId).datagrid('load');
}

function openLocalPage(panelId,panelTitle,url){
	$('#'+panelId).panel({
		title:panelTitle,
		content:createFrame(url),
		tools:[{
				iconCls:'icon-standard-cross',
				handler:function(){$('#'+panelId).parent().slideUp('slow');}
			  }]
	});
}

function showInstanceDiagram(gridId) {
	var select_row = $("#" + gridId).datagrid('getSelected'); // 获取该行对象
	if (select_row != null) {
		/*addTaskToTab('流程图',
				'workflow/processView!toDiagram.do?processInstanceId='
						+ select_row.instanceId);*/
		var url = 'processView!toDiagram.do?processDefinitionId='+select_row.definitionId+'&processInstanceId='+ select_row.instanceId + '&processType=0';
		//alert("showInstanceDiagram"+url);
		openLocalPage('diagram','流程图',url);
	} else {
		$.messager.alert('提示信息', '请选择具体业务!', "info");
	}
}

function showDefinitionDiagram(gridId) {
	var select_row = $("#" + gridId).datagrid('getSelected'); // 获取该行对象
	if (select_row != null) {
		/*addTaskToTab('流程图',
				'workflow/processView!toDiagram.do?processDefinitionId='
						+ select_row.definitionId);*/
		var url = 'processView!toDiagram.do?processDefinitionId='+select_row.definitionId+'&processInstanceId='+ select_row.instanceId+ '&processType=1';
		//alert("showDefinitionDiagram"+url);
		openLocalPage('diagram','流程图',url);
	} else {
		$.messager.alert('提示信息', '请选择具体业务!', "info");
	}
}

function showDiagram(gridId) {
	var select_row = $("#" + gridId).datagrid('getSelected'); // 获取该行对象
	if (select_row != null) {
		/*addTaskToTab('流程图',
				'workflow/processView!toDiagram.do?processDefinitionId='
						+ select_row.definitionId);*/
		var url = 'processView!toDiagram.do?processInstanceId='+ select_row.instanceId;
		//alert("showDefinitionDiagram"+url);
		openLocalPage('diagram','流程图',url);
	} else {
		$.messager.alert('提示信息', '请选择具体业务!', "info");
	}
}

function addTaskToTab(tabTitle, url) { // 在系统根文档追加标签
	var undefined = window.undefined;
	var title = '' + tabTitle;
	if (parent.$('#tabs').tabs('exists', title)) {
		parent.$('#tabs').tabs('select', title);// 选中并刷新
		var currTab = parent.$('#tabs').tabs('getSelected');
		if (url != undefined && currTab.panel('options').title != 'Home') {
			parent.$('#tabs').tabs('update', {
				tab : currTab,
				options : {
					content : createFrame(url)
				}
			});
		}
	} else {
		parent.$('#tabs').tabs('add', {
			title : title,
			content : createFrame(url),
			closable : true
		});
	}
}

function act_taskSearch(gridId) {
	var queryValue = $.parseJSON(getHiddenValue("query" + gridId));
	var query_formElements = $.parseJSON(queryValue.formElements);
	var queryObject = {};
	queryObject['userId'] = processViewBean.userId;
	queryObject['systemName'] = processViewBean.systemName;
	queryObject['ccbh'] = processViewBean.ccbh;
	for (var i = 0; i < query_formElements.length; i++) {
		if (query_formElements[i].type == "combobox") {
			queryObject[query_formElements[i].name] = $(
					'#' + query_formElements[i].id).combobox("getValue");
		} else if (query_formElements[i].type == "datebox"
				|| query_formElements[i].type == "startdatebox"
				|| query_formElements[i].type == "enddatebox") {
			queryObject[query_formElements[i].name] = $(
					'#' + query_formElements[i].id).datebox("getValue");// 把datebox的值set入formdata中
		} else if (query_formElements[i].type == "datetimebox"
				|| query_formElements[i].type == "startdatetimebox"
				|| query_formElements[i].type == "enddatetimebox") {
			queryObject[query_formElements[i].name] = $(
					'#' + query_formElements[i].id).datetimebox("getValue");// 把datetimebox的值set入formdata中
		} else if (query_formElements[i].type == "text"
				|| query_formElements[i].type == "hidden") {
			queryObject[query_formElements[i].name] = $(
					'#' + query_formElements[i].id).val();// 把text的值set入formdata中
		} else if (query_formElements[i].type == "combotree") {
			queryObject[query_formElements[i].name] = $(
					'#' + query_formElements[i].id).combotree("getValue");
		}
	}
	var options = $("#" + gridId).datagrid('options');
	var param = options.queryParams.params;
	param = eval("(" + param + ")");
	param.formname = queryValue.queryformid;
	param.queryObject = JSON.stringify(queryObject);
	// 修改查询时传递的参数
	options.queryParams = {
		params : JSON.stringify(param)
	};
	$('#' + gridId).datagrid("load");
}

function toTaskUrl(procKey, taskDefKey, processInstanceId, readonly, title) {
	var url = '';
	var readonlyParam = readonly?'readonly=true':'readonly=false';
	if (processInstanceId) {
		url = 'processOperate!getTaskHandleJson.do';
	} else {
		if (readonly) {
			url = 'processOperate!getTaskHandleJson.do';
		} else {
			url = 'processOperate!getApplyJson.do';
		}
	}
	$.ajax({
		async : false,
		type : "POST",
		url : url,
		data : "params={'procKey':'" + procKey + "','taskDefKey':'"
				+ taskDefKey + "'}",
		success : function(data) {
			if('error' in data){
				$.messager.alert('提示信息', '无法读取流程业务处理地址，请先在流程管理页面配置业务地址!', "info");
			}else if('taskHandleUrl' in data){
				var taskUrl = data.taskHandleUrl;
				if(taskUrl.indexOf('?')!=-1){
					taskUrl += '&' + readonlyParam;
				}else{
					taskUrl += '?' + readonlyParam;
				}
				if (!processInstanceId&&!readonly) {
					taskUrl += "&processInstanceId=" + data.processInstanceId;
				} else {
					taskUrl += "&processInstanceId=" + processInstanceId;
				}
				if (!title) {
					title = '流程业务处理页面';
				}
				//addTaskToTab(title, taskUrl);
				window.location.href = taskUrl;
			}
		}
	});
}

function showForm(gridId,readonly,title){
	var select_row = $('#' + gridId).datagrid('getSelected'); //获取该行对象
	if (select_row) {
		toTaskUrl(select_row.processName, select_row.taskDefKey, select_row.instanceId, readonly, title||select_row.taskName);
	} else {
		if(gridId == 'processGrid'){
			$.messager.alert('提示信息', '请选择要开启的流程!', "info");
		}else if(gridId == 'taskGrid'){
			$.messager.alert('提示信息', '请选择具体业务!', "info");
		}
		
	}
}

function exportProcess(gridId){
	var select_row = $('#' + gridId).datagrid('getSelected');
	if(select_row != null){
		$.messager.confirm('提示信息','是否要导出所选流程？',function(r){
			if(r){
				location.href = getbasePath()
				+ "/workflow/processOutput!exportProcess.do?deploymentId="
				+ select_row.deploymentId + "&contentType=stream";
			}
		});
	}else{
		$.messager.alert('提示信息', '请选择要导出的流程', "info");
	}
}

function deleteProcess(gridId){
	var select_row = $('#' + gridId).datagrid('getSelected');
	if(select_row != null){
		$.messager.confirm('提示信息','删除后将无法进行相关业务操作，是否真的要删除所选流程？',function(r){
			if(r){
				$.messager.confirm('提示信息','是否同时删除相关业务的流程实例？',function(r){
					var varJson = {};
					varJson.cascade = r;
					varJson.deploymentId = select_row.deploymentId;
					varJson.processDefinitionId = select_row.definitionId;
					$.ajax({
						type : "POST",
						url : getbasePath() + "/workflow/processOperate!deleteProcess.do",
						data : 'params=' + JSON.stringify(varJson),
						complete : function(XMLHttpRequest,strStatus) {
							if(strStatus = 204){
								$.messager.alert('提示信息', '删除流程成功', "info");
								$('#'+gridId).datagrid('reload');
								$('#'+gridId).datagrid('unselectAll');
							}else if(strStatus = 404){
								$.messager.alert('提示信息', '删除流程失败，请与管理员联系', "error");
							}
						}
					});
				});
			}
		});
	}
}

function importProcess(divID) {
	$('#'+divID).dialog({
	 	title: '文件上传',    
	    width: 750,    //上传文件框的大小
	    height: 400,    
	    closed: false,    
	    cache: false,  
	    modal: true,
	    onClose:function(){    
	    	//location.reload();   
	    }    
	});
	$('#' + divID).pluploadQueue({
		runtimes : 'gears,flash,silverlight,browserplus,html5,html4',
		url : getbasePath() + '/workflow/processOutput!upLoadProcessDefinition.do',
		urlstream_upload: true,
		max_file_size : '10mb', // 上传的图片不能超过10MB
		unique_names : true,
		dragdrop : true,
		filters : [ {
			title : "Bpmn files",
			extensions : "zip,bar,bpmn"
		} ],
		flash_swf_url : getbasePath()
				+ '/js/plupload/js/plupload.flash.swf',
		silverlight_xap_url : getbasePath()
				+ '/js/plupload/js/plupload.silverlight.xap',
		init : {	//实例对象的init()方法进行初始化
			FileUpLoaded : function(uploader, file, response){
				var keyExists = null;
				var fileName = file.name;
				var targetName = file.target_name;
				$.ajax({
					async : false,
					type : "POST",
					url : getbasePath() + '/workflow/processOutput!processKeyExists.do',
					data : "name=" + targetName,
					success : function(data) {
						if('exist' in data){
							keyExists = data.exist;
						}
					}
				});
				if(keyExists=="error"){
					$.ajax({
						async : false,
						type : "POST",
						url : getbasePath() + '/workflow/processOutput!removeTempDefinitionFile.do',
					});
					$.messager.alert('提示信息', '发布' + fileName + '流程失败，流程文件格式不正确，请发布符合bpmn规则的流程文件', "error");
				}else{
					if(keyExists){
						$.messager.confirm('提示信息','已存在与' + fileName + '的id相同的流程定义文件，是否进行版本更新？',function(r){
							if(r){
								$.ajax({
									async : false,
									type : "POST",
									url : getbasePath() + '/workflow/processOutput!deployProcessDefinition.do',
									data : "name=" + targetName,
									success : function(data) {
										if('error' in data){
											if(data.error == 'io'){
												$.messager.alert('提示信息', '发布' + fileName + '流程失败，无法读取上传的流程文件，请重新发布', "error");
											}else if(data.error == 'all'){
												$.messager.alert('提示信息', '发布' + fileName + '流程失败，流程文件格式不正确，请发布符合bpmn规则的流程文件', "error");
											}
										}else{
											$.messager.alert('提示信息', '更新' + fileName + '流程成功', "info");
										}
									}
								});
							}else{
								$.ajax({
									async : false,
									type : "POST",
									url : getbasePath() + '/workflow/processOutput!removeTempDefinitionFile.do',
								});
								$.messager.alert('提示信息', fileName + '发布已取消', "error");
							}
						});
					}else{
						$.ajax({
							async : false,
							type : "POST",
							url : getbasePath() + '/workflow/processOutput!deployProcessDefinition.do',
							data : "name=" + targetName,
							success : function(data) {
								if('error' in data){
									if(data.error == 'io'){
										$.messager.alert('提示信息', '发布' + fileName + '流程失败，无法读取上传的流程文件，请重新发布', "error");
									}else if(data.error == 'all'){
										$.messager.alert('提示信息', '发布' + fileName + '流程失败，流程文件格式不正确，请发布符合bpmn规则的流程文件', "error");
									}
								}else{
									$.messager.alert('提示信息', '发布' + fileName + '流程成功', "info");
								}
							}
						});
					}
				}
			},
		}
	});
}

function loadComboData(){
	$('#processKey').combobox({
		onSelect : function(record) {
			$('#processName').val(record.text);
		}
	});
	$('#taskName').combobox({
		onShowPanel : function() {
			var key = $('#processKey').combobox('getValues');
			var data_ = null;
			if(key){
				data_ = 'params={"processKey":"' + key + '"}';
			}
			$.ajax({
				async : false,
				type : "POST",
				url : "processList!taskCombo.do",
				data : data_,
				success : function(data) {
					$('#taskName').combobox({
						url : null,
						valueField : 'id',
						textField : 'text',
						data : data
					});
				}
			});
		}
	});
}

