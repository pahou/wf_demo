//创建树hidden变量
function createTreeHidden(id){
	var editjson = {};// 存储修改的json
	editjson.data = [];
	createHiddenValue(id+"editjson", JSON.stringify(editjson));// 存储修改的json
	var deljson = {};// 删除json
	deljson.data = [];
	createHiddenValue(id+"deljson", JSON.stringify(deljson));// 删除json
	createHiddenValue(id+"nodeid", "0");// 新增加节点的id
	var addjson = {};// 增加json
	addjson.data = [];
	createHiddenValue(id+"addjson", JSON.stringify(addjson));// 增加json
	var alljson = {};// 所有json数据
	alljson.items = [];
	createHiddenValue(id+"alljson", JSON.stringify(alljson));// 所有json数据
}

//清空树的隐藏变量
function cleanTreeHidden(id){
	var editjson = {};// 存储修改的json
	editjson.data = [];
	setHiddenValue(id+"editjson", JSON.stringify(editjson));// 存储修改的json
	var deljson = {};// 删除json
	deljson.data = [];
	setHiddenValue(id+"deljson", JSON.stringify(deljson));// 删除json
	setHiddenValue(id+"nodeid", "0");// 新增加节点的id
	var addjson = {};// 增加json
	addjson.data = [];
	setHiddenValue(id+"addjson", JSON.stringify(addjson));// 增加json
	var alljson = {};// 所有json数据
	alljson.items = [];
	setHiddenValue(id+"alljson", JSON.stringify(alljson));// 所有json数据
}

//加载树对应form的数据
function findnodedata(formid, nodeid, actionname) {
	var FieldsInfo = $('#' + formid + 'info').val();
	if (FieldsInfo != null && FieldsInfo != "") {
		$.ajax({
			type : "POST",
			url : actionname + '!queryById.do',
			data : 'params={"elementsInfo":'+ FieldsInfo + ',"id":' + nodeid + '}',
			success : function(data) {
				$('#'+formid).form('load',data);
			}
		});
//		$('#' + formid).form(
//				'load',
//				actionname + '!queryById.do?params={"elementsInfo":'
//						+ FieldsInfo + ',"id":' + nodeid + '}'); // form读取信息...
	}
}

//取消所有勾选
function uncheckTree(treeId){
	var checknodes = $("#" + treeId).tree("getChecked");
	for(var i=0;i<checknodes.length;i++){
		$("#" + treeId).tree("uncheck",checknodes[i].target);
	}
}


//查询对应树勾选节点的Id数组后勾选节点
function checkTree(treeId, nodeId, actionname) {
	uncheckTree(treeId);//去除所有勾选
	$.ajax({
		type : "POST",
		url : actionname + "!checkTree.do",
		data : "params={id:" + nodeId + "}",
		success : function(data) {
			for ( var i = 0; i < data.length; i++) {
				var node = $("#" + treeId).tree("find", data[i].id);
				$("#" + treeId).tree("check", node.target);
			}
		}
	});

}

//查询对应树勾选节点的Id数组后勾选节点(级联勾选树勾选使用)
function checkCascadeTree(treeId, nodeId, actionname) {
	uncheckTree(treeId);//去除所有勾选
	$.ajax({
		type : "POST",
		url : actionname + "!checkTree.do",
		data : "params={id:" + nodeId + "}",
		success : function(data) {
			var options = $("#"+treeId).tree("options");
			options.cascadeCheck = false;
			for ( var i = 0; i < data.length; i++) {
				var node = $("#" + treeId).tree("find", data[i].id);
				if(node!=null){
					$("#" + treeId).tree("check", node.target);
				}
			}
			options.cascadeCheck = true;
		}
	});

}

//查询对应树勾选节点的Id数组后勾选节点,自定义方法名
function checkTreeByMethod(treeId, nodeId, actionname,method) {
	uncheckTree(treeId);
	$.ajax({
		type : "POST",
		url : actionname + "!"+method+".do",
		data : "params={id:" + nodeId + "}",
		success : function(data) {
			for ( var i = 0; i < data.length; i++) {
				var node = $("#" + treeId).tree("find", data[i].id);
				$("#" + treeId).tree("check", node.target);
			}
		}
	});
}
//传值重新加载数据
function loadTree(treeId,loadparam){
	var options = $('#'+treeId).tree('options');
	var url = options.url;
	url = url.split("=");
	if(((loadparam instanceof String) || (typeof loadparam).toLowerCase() == 'string')){
		$('#'+treeId).tree({
			method:"GET",
			url:url[0]+'='+loadparam
		});
	}else{
		$('#'+treeId).tree({
			method:"GET",
			url:url[0]+'='+JSON.stringify(loadparam)
		});
	}
	$('#'+treeId).tree('reload');
}


function addchild(treeId) { /* 【增加子节点】 */
	load = 1;
	var nodeid = getHiddenValue(treeId+"nodeid");
	nodeid++; // 伪id自增
	var node = $('#' + treeId).tree('getSelected'); // 选中父节点
	var mc = "新建节点 ";
	var datas = [ { // 新节点的信息
		"id" : nodeid,
		"text" : mc,
		"attributes" : "newing"// new表示这个节点是新增的
	} ];
	$('#' + treeId).tree('append', { // 前端生成伪节点
		parent : node.target,
		data : datas
	});
	// 选中新增子节点
	var childnodes = $('#' + treeId).tree('getChildren', node.target); // 以下语句选中新增节点，由于没有id，使用attribute属性来找，找到第一个为止break

	for ( var i = 0; i < childnodes.length; i++) {
		if ((childnodes[i].id == nodeid)
				&& (childnodes[i].attributes == "newing")) {
			$('#' + treeId).tree('expand', node.target);
			$('#' + treeId).tree('select', childnodes[i].target);
			$('#' + $.parseJSON($("#"+treeId+"info").val())["formId"]).form('clear');
			changeState(treeId);
			break;
		}
	}
	setHiddenValue(treeId+"nodeid",nodeid);
}

function addroot(treeId) { /* 【增加根节点】 */
	load = 1;
	var nodeid = getHiddenValue(treeId+"nodeid");
	nodeid++;
	var mc = "新建根节点 ";
	tempdata = [ {
		"id" : nodeid,
		"text" : mc,
		"attributes" : "newing"// new表示这个节点是新增的
	} ];
	$('#' + treeId).tree('append', {
		data : tempdata
	});

	var roots = $('#' + treeId).tree('getRoots'); // 以下语句选中新增节点，由于没有id，使用attribute属性来找，找到第一个为止break

	for ( var i = 0; i < roots.length; i++) {
		if ((roots[i].id == nodeid) && (roots[i].attributes == "newing")) {
			$('#' + treeId).tree('select', roots[i].target);
			$('#' + $.parseJSON($("#"+treeId+"info").val())["formId"]).form('clear');
			changeState(treeId);
			break;
		}
	}
	setHiddenValue(treeId+"nodeid",nodeid);
}

function removenode(treeId) { /* 【删除节点】 */
	var node = $('#' + treeId).tree('getSelected');
	var children = $('#' + treeId).tree('getChildren', node.target);
	if (children.length == 0) { // 现判定是否为叶节点
		if (node.attributes == "newing") {
			var addjson = $.parseJSON(getHiddenValue(treeId+"addjson"));
			for ( var i = 0; i < addjson.data.length; i++) {
				if (addjson.data[i] != null) {
					if (node.id == addjson.data[i].data.id) {
						$('#' + treeId).tree('remove', node.target);
						delete addjson.data[i]; // 移除数据
						$('#' + $.parseJSON($("#"+treeId+"info").val())["formId"]).form('clear');
						var info = $.parseJSON(getHiddenInfo(treeId));
						noInput(info.formId);
					}
				}
			}
			setHiddenValue(treeId+"addjson",JSON.stringify(addjson));
		} else { // 非新增的属性节点
			var tempdata = {
				"id" : node.id
			};
			var deljson = $.parseJSON(getHiddenValue(treeId+"deljson"));
			deljson.data.push(JSON.parse(assembleJSON(tempdata, "", "delete"))); 
			setHiddenValue(treeId+"deljson",JSON.stringify(deljson));
			var editjson = $.parseJSON(getHiddenValue(treeId+"editjson"));
			if(editjson.data!=null){
				for ( var i = 0; i < editjson.data.length; i++) { // 从编辑json中移除该条编辑
					if (node.id == editjson.data[i].data.id) {
						delete editjson.data[i];
						break;
					}
				}
				setHiddenValue(treeId+"editjson",JSON.stringify(editjson));
			}
			// deljson.data.push(tempdata); //
			$('#' + treeId).tree('remove', node.target);
			$('#' + $.parseJSON($("#"+treeId+"info").val())["formId"]).form('clear');
		}
	} else if (children.length > 0) { // 父节点
		$.messager.confirm("提示", "该节点包含子节点,不可执行删除 操作！", function(row) {
		});
	}
	$('#'+getButtonId()).linkbutton('enable');
	//选中根节点
	var root = $('#'+treeId).tree("getRoot");
	$('#'+treeId).tree("select",root.target);
}

function deletenode(treeId,actionname) {
	$.messager.confirm('提示信息', '是否删除该节点？', function(r) {
		if (r) {
			var info =  JSON.parse(getHiddenInfo(treeId));
			$.ajax({
				type : "POST",
				url : actionname+"!hasChildren.do",
				data : 'params={"id":"' + id + '","recursionField":"'+info.recursionField+'"}',
				success : function(has) {
					if (!has) {
						$.ajax({
							type : "POST",
							url : actionname+"!deleteById.do",
							data : 'params={"id":"' + id + '"}',
							success : function() {
								$('#' + treeId).tree('reload'); //重置树节点
								$.messager.alert("提示信息", "删除成功！","info",function(){
									//清空
									cleanTreeHidden('#' + treeId);
									//选中根节点
									var root = $('#' + treeId).tree("getRoot");
									$('#' + treeId).tree("select",root.target);
								});
							}
						});
					} else {
						$.messager.alert("提示信息", "该节点含有子节点，无法删除！");
					}
				}
			});
		}
	});
}

function subTreeDel(treeId, node, datajson) { /* 有子节点的【真实】节点的【递归删除】 */
	var children = $('#' + treeId).tree('getChildren', node.target);
	for ( var i = 0; i < children.length; i++) {
		var tempdata = {
			"id" : children[i].id
		};
		datajson.data.push(JSON.parse(assembleJSON(tempdata, "", "delete"))); //
		subTreeDel(treeId, children[i]); // 递归
	}
}

function newTreeDel(treeId, node, datajson) { /* 有子节点的【伪】节点的【递归删除】 */
	var children = $('#' + treeId).tree('getChildren', node.target);
	var addjson = getHiddenValue(treeId+"addjson");
	for ( var i = 0; i < children.length; i++) {
		for ( var j = 0; j < datajson.data.length; j++) {
			if (children[i].id == datajson.data[j].data.id) {
				delete addjson.data[j]; // 从修改JSON中移除已被删除的节点信息
			}
		}
		subTreeDel(treeId, children[i]); // 递归
	}
	setHiddenValue(treeId+"addjson",JSON.stringify(addjson));
}

function editnode(treeId) { /* 【修改节点信息】 */
	var node = $('#' + treeId).tree('getSelected'); // 获得节点
	if ((node.attributes == "newing") || (node.attributes == "editing")) {
		// 避免对同一节点重复右键新增or修改操作
		alert("无效操作");
	} else {
		$('#' + treeId).tree('update', { // 变更节点状态
			target : node.target,
			attributes : "editing" // 编辑中
		});
		node = $('#' + treeId).tree('getSelected'); // update之后需要再次选中才可以更改状态
		changeState(treeId);
	}
}

function saveTemp(treeId, node) { // 临时存储,传参，否则出现未定义orNULL
	var count = 0;
	var nodeid = getHiddenValue(treeId+"nodeid");
	var addjson =  $.parseJSON(getHiddenValue(treeId+"addjson"));
	var editjson = $.parseJSON(getHiddenValue(treeId+"editjson"));
	if (node) { // 如果node存在
		if (node.attributes == "newing") {
			count = coverJson(node, addjson);
		}
		if (node.attributes == "editing") {
			count = coverJson(node, editjson);
		}

		var parentnode = $('#' + treeId).tree('getParent', node.target); // 父节点id
		if (parentnode) {
			if (count != 1) { // id无重复
				if (node.attributes == "newing") { // 只有新建和编辑的才能放入json，否则其他节点均为只读,newing的id是假的，editing的id是真的
					var tempdata = "";
					$("#" + saveformid + " input[name], #" + saveformid + " textarea").each(
							function(i, value) {
								if (value.name != id) {
									var packJson = "{\"" + value.name + "\":\""
											+ value.value + "\"}";
									//处理换行符
									var reg = new RegExp("\n","g");
									packJson = packJson.replace(reg,"\\n");
									if (tempdata == "") {
										tempdata = $.parseJSON(packJson);
									} else {
										tempdata = $.extend(tempdata, $
												.parseJSON(packJson));
									}
								}
							});
					var tempjson = '{"id" : '+nodeid+', "'+$.parseJSON($("#"+treeId+"info").val())["recursionField"]+'":'+parentnode.id+'}';
					tempdata = $.extend(tempdata, JSON.parse(tempjson));
					addjson.data.push(JSON.parse(assembleJSON(tempdata, "",
							"add"))); //
				}
				if (node.attributes == "editing") { // 编辑的id是node.id，新增的id是nodeid
					var tempdata = "";
					$("#" + saveformid + " input[name], #" + saveformid + " textarea").each(
							function(i, value) {
								if (value.name != id) {
									var packJson = "{\"" + value.name + "\":\""
											+ value.value + "\"}";
									//处理换行符
									var reg = new RegExp("\n","g");
									packJson = packJson.replace(reg,"\\n");
									if (tempdata == "") {
										tempdata = $.parseJSON(packJson);
									} else {
										tempdata = $.extend(tempdata, $
												.parseJSON(packJson));
									}
								}
							});
					var tempjson = '{"id" : '+node.id+', "'+$.parseJSON($("#"+treeId+"info").val())["recursionField"]+'":'+parentnode.id+'}';
					tempdata = $.extend(tempdata, JSON.parse(tempjson));
					editjson.data.push(JSON.parse(assembleJSON(tempdata, "",
							"edit")));
				}
			}
		} else {
			if (count != 1) { // id无重复
				if (node.attributes == "newing") { // 只有新建和编辑的才能放入json，否则其他节点均为只读,newing的id是假的，editing的id是真的
					var tempdata = "";
					$("#" + saveformid + " input[name], #" + saveformid + " textarea").each(
							function(i, value) {
								if (value.name != id) {
									var packJson = "{\"" + value.name + "\":\""
											+ value.value + "\"}";
									//处理换行符
									var reg = new RegExp("\n","g");
									packJson = packJson.replace(reg,"\\n");
									if (tempdata == "") {
										tempdata = $.parseJSON(packJson);
									} else {
										tempdata = $.extend(tempdata, $
												.parseJSON(packJson));
									}
								}
							});
					var tempjson = '{"id" : '+nodeid+', "'+$.parseJSON($("#"+treeId+"info").val())["recursionField"]+'":0}';
					tempdata = $.extend(tempdata, JSON.parse(tempjson));
					addjson.data.push(JSON.parse(assembleJSON(tempdata, "",
							"add"))); //
				}
				if (node.attributes == "editing") { // 编辑的id是node.id，新增的id是nodeid
					var tempdata = "";
					$("#" + saveformid + " input[name], #" + saveformid + " textarea").each(
							function(i, value) {
								if (value.name != id) {
									var packJson = "{\"" + value.name + "\":\""
											+ value.value + "\"}";
									//处理换行符
									var reg = new RegExp("\n","g");
									packJson = packJson.replace(reg,"\\n");
									if (tempdata == "") {
										tempdata = $.parseJSON(packJson);
									} else {
										tempdata = $.extend(tempdata, $
												.parseJSON(packJson));
									}
								}
							});
					var tempjson = '{"id" : '+node.id+', "'+$.parseJSON($("#"+treeId+"info").val())["recursionField"]+'":0}';
					tempdata = $.extend(tempdata, JSON.parse(tempjson));
					editjson.data.push(JSON.parse(assembleJSON(tempdata, "",
							"edit")));
				}
			}
		}
	}
	setHiddenValue(treeId+"addjson",JSON.stringify(addjson));
	setHiddenValue(treeId+"editjson",JSON.stringify(editjson));
}

function coverJson(node, datajson) { /* 【覆盖已存在的data】 */
	if (node) {
		for ( var i = 0; i < datajson.data.length; i++) {
			if (datajson.data[i] != null) {
				if (node.id == datajson.data[i].data.id) {
					$("#" + saveformid + " input[name], #" + saveformid + " textarea")
							.each(
									function(j, value) {
										if (value.name != id) {
											datajson.data[i].data[value.name] = value.value;
										}
									});
					return 1;
					break;
				}
			}
		}
	}
}

function noInput(formId) {
	$('#'+formId+' input[name], #'+formId+' textarea').each(function(i,value){
		value.readOnly = true;
	});
} /* 【不允许form输入】 */


function noInputbyboolean(formId,temp){
	if(temp == true){	//不可复制内容
		$('#'+formId+' input').focus(function() {  
			this.blur();
		});
		$('#'+formId+' textarea').focus(function() {
			this.blur();
		});
		$('.combo input').attr('readonly','readonly');
		$('.combo-arrow').hide();
	}
	if(temp == false){	  //可以复制内容
		$('input').attr('readonly','readonly');
		$('textarea').attr('readonly','readonly');
		$('.combo input').attr('readonly','readonly'); 
		$('.combo-arrow').hide();
	}
	if(temp == null){	//取消输入限制，可读可写
		$('input').attr('readonly',false);
		$('textarea').attr('readonly',false);
        $('.combo input').attr('readonly','readonly');
        $('.combo-arrow').show();
	}
} /* 【不允许form输入】只读模式，为true时，不可复制内容，为false时可以复制内容 */

function changeState(treeId) { /* 【允许form输入】 */
	var treeinfo = $.parseJSON(getHiddenInfo(treeId));
	//$('#'+treeinfo.formId+' input').unbind( "focus" );//删除input上获得焦点事件
	$('#'+treeinfo.formId+' input[name], #'+treeinfo.formId+' textarea').each(function(i,value){
		value.readOnly = false;
	});//删除input上获得焦点事件
	//$('input').off(); // 解除所有附加在input上的js
	//$('#' + $.parseJSON($("#"+treeId+"info").val())["textField"]).focus();
	//$('#'+getButtonId()).show();
	$('#'+getButtonId()).linkbutton('enable');
	//document.getElementById('bt').innerHTML = "<input id='btn' type='button' value='确认信息' onclick='saveTree("+treeId+")' />";
}

function putToAll(treeId) { /* 【整合所有json】 */
	var alljson = $.parseJSON(getHiddenValue(treeId+"alljson"));
	var addjson = $.parseJSON(getHiddenValue(treeId+"addjson"));
	for ( var i = 0; i < addjson.data.length; i++) {
		alljson.items.push(addjson.data[i]);
	}
	var editjson = $.parseJSON(getHiddenValue(treeId+"editjson"));
	for ( var i = 0; i < editjson.data.length; i++) {
		alljson.items.push(editjson.data[i]);
	}
	var deljson = $.parseJSON(getHiddenValue(treeId+"deljson"));
	for ( var i = 0; i < deljson.data.length; i++) {
		alljson.items.push(deljson.data[i]);
	}
	setHiddenValue(treeId+"alljson",JSON.stringify(alljson));
}


//保存树修改后的数据（勾选状态除外）
function saveTree(treeId,actionName) { /* 【提交操作JSON】 */
	var info = $.parseJSON($("#"+treeId+"info").val());
	if($("#"+info["formId"]).form('validate')){
		var node = $('#'+treeId).tree('getSelected'); //
		saveTemp(treeId, node);
		putToAll(treeId);
		$.ajax({
			type : "POST",
			url : actionName+"!saveTree.do",
			data : 'params={"textField":"'+info["textField"]+'", "fieldId":"'+info["sortField"]+'", "sjIdField":"'+info["recursionField"]+'","savedata":' + getHiddenValue(treeId+"alljson") + '}',
			success : function() {
				$('#'+getButtonId()).linkbutton('disable');
				$.messager.alert("提示信息","保存成功！");
				$('#'+treeId).tree('reload');   //重置树节点
			}
		}); 
		//清空
		cleanTreeHidden(treeId);
	}else{
		$.messager.alert('提示','信息填写有误','info');
	}
}
//得到树勾选的Id数组
function gettreeCheck(treeId){
	var checkid = new Array();
	var nodes = $("#"+treeId).tree('getChecked',
			[ 'checked', 'indeterminate' ]);
	for ( var i = 0; i < nodes.length; i++) {
		checkid.push(nodes[i].id);
	}
	return checkid;
}
//保存树勾选
function saveTreeCheck(treeId,actionName, idfieldvalue) {
	var checkid = gettreeCheck(treeId);
	$.ajax({
		type : "POST",
		url : actionName+"!saveTreeCheck.do",
		data : 'params={"checkid":"'+checkid +'","idfieldvalue":'+idfieldvalue+ '}',//idfieldvalue可以是JSON也可以是值，看后台需要什么来传值
		success : function() {
			$.messager.alert("提示信息","保存成功！");
		}
	});
}

//加载时选中第一个节点,需要在页面写一个load变量
function loadSelectRoot(treeId){
	$('#'+treeId).tree({
		onLoadSuccess: function(node, data){
			if(load==0){
				var root = $('#'+treeId).tree("getRoot");
				$('#'+treeId).tree("select",root.target);
			}
		}
	});
}

