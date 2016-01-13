var addlist = new Array();
var deletelist = new Array();
var addinfo = "";
var deleteinfo = "";

//传参重新加载grid,弃用
function gridload(gridId,paramjson){
	var options = $("#"+gridId).datagrid('options');
	options.queryParams = paramjson;
	$('#'+gridId).datagrid('load'); 
}

//传参重新加载grid（推荐使用）
function gridreload(gridId,paramjson){
	var json = {};
	json = JSON.stringify(paramjson);
	json = $.parseJSON(json);
	json.fieldsInfo = $('#'+gridId+'info').val();
	var params = {};
	params.params = JSON.stringify(json);
	var options = $("#"+gridId).datagrid('options');
	options.queryParams = params;
	$('#'+gridId).datagrid('load'); 
}


//双列选择器的添加删除方法
function dualListSelection(gridId1, gridId2) {
	var rowDatas = $('#' + gridId2).datagrid('getSelections');
	if (rowDatas.length <= 0) { // 没选中对象
		$.messager.alert('提示', '没有选中数据', "info");
		return;
	} else {
		var datalength = rowDatas.length;
		for (var i = 0; i < datalength; i++) {
			//添加
			$('#' + gridId1).datagrid('insertRow', {
				index : 0, // 索引从0开始
				row : rowDatas[0]
			});
			//删除
			_index = $('#' + gridId2).datagrid('getRowIndex', rowDatas[0]); // 根据obj获取行号索引index
			$('#' + gridId2).datagrid('deleteRow', _index); // 删除行
		}
	}
}

//双列选择器，设置params
function dualListsetParams(grid1,grid2){
	var options1 =  $("#"+grid1).datagrid('options');
	var param1 = options1.queryParams.params;
	param1 = eval("(" + param1 + ")");
	var options2 =  $("#"+grid2).datagrid('options');
	var param2 = options2.queryParams.params;
	param2 = eval("(" + param2 + ")");
	//修改查询时传递的参数
	param1.addlist = addlist.qc();
	param1.deletelist = deletelist.qc();
	param2.addlist = addlist.qc();
	param2.deletelist = deletelist.qc();
	options1.queryParams = {params : JSON.stringify(param1)};
	options2.queryParams = {params : JSON.stringify(param2)};
}


//双列选择器添加事件
function dualListAdd(gridId1, gridId2) {
	var rowDatas = $('#' + gridId2).datagrid('getSelections');
	if (rowDatas.length <= 0) { // 没选中对象
		$.messager.alert('提示', '没有选中数据', "info");
		return;
	} else {
		var datalength = rowDatas.length;
		for (var i = 0; i < datalength; i++) {
			//添加
			$('#' + gridId1).datagrid('insertRow', {
				index : 0, // 索引从0开始
				row : rowDatas[0]
			});
			var haslist = false;
			//循环删除记录移除list中的数据
			for(var j=0;j<deletelist.length;j++){
				if(deletelist[j]==rowDatas[0].id){
					haslist = true;
					deletelist=deletelist.del(j);
				}
			}
			if(!haslist){
				addlist.push(rowDatas[0].id);
			}
			//删除
			_index = $('#' + gridId2).datagrid('getRowIndex', rowDatas[0]); // 根据obj获取行号索引index
			$('#' + gridId2).datagrid('deleteRow', _index); // 删除行
		}
		dualListsetParams(gridId1, gridId2);
		var indexnub = $('#'+gridId2).datagrid('getRows');
		if(indexnub.length==0){
			$('#'+gridId2).datagrid('load');
		}
	}
}

//双列选择器删除事件
function dualListDelete(gridId1, gridId2) {
	var rowDatas = $('#' + gridId2).datagrid('getSelections');
	if (rowDatas.length <= 0) { // 没选中对象
		$.messager.alert('提示', '没有选中数据', "info");
		return;
	} else {
		var datalength = rowDatas.length;
		for (var i = 0; i < datalength; i++) {
			//添加
			$('#' + gridId1).datagrid('insertRow', {
				index : 0, // 索引从0开始
				row : rowDatas[0]
			});
			var haslist = false;
			//循环删除记录添加list中的数据
			for(var j=0;j<addlist.length;j++){
				if(addlist[j]==rowDatas[0].id){
					haslist = true;
					addlist=addlist.del(j);
				}
			}
			if(!haslist){
				deletelist.push(rowDatas[0].id);
			}
			//删除
			_index = $('#' + gridId2).datagrid('getRowIndex', rowDatas[0]); // 根据obj获取行号索引index
			$('#' + gridId2).datagrid('deleteRow', _index); // 删除行
		}
		dualListsetParams(gridId1, gridId2);
		var indexnub = $('#'+gridId2).datagrid('getRows');
		if(indexnub.length==0){
			$('#'+gridId2).datagrid('load');
		}
	}
}

//双列选择器，清空数组
function infoList(gridId1, gridId2){
	deletelist = new Array();
	addlist = new Array();
	var options1 =  $("#"+gridId1).datagrid('options');
	var param1 = options1.queryParams.params;
	param1 = eval("(" + param1 + ")");
	var options2 =  $("#"+gridId2).datagrid('options');
	var param2 = options2.queryParams.params;
	param2 = eval("(" + param2 + ")");
	//修改查询时传递的参数
	delete param1["addlist"];
	delete param2["addlist"];
	delete param1["deletelist"];
	delete param2["deletelist"];
	options1.queryParams = {params : JSON.stringify(param1)};
	options2.queryParams = {params : JSON.stringify(param2)};
}


//在页面删除一行
function subdeleteInfo(gridId) {
			var rowDatas = $('#'+gridId).datagrid('getSelections');
			if (rowDatas.length <= 0) { //没选中对象
				$.messager.alert('提示', '没有选中数据', "info");
				return;
			} else {
				$.messager.confirm('确认', '请确认删除', function(row) {
					if (row) {
						var datalength = rowDatas.length;
						for(var i = 0 ; i < datalength ; i++){
									_index = $('#'+gridId).datagrid('getRowIndex', rowDatas[0]); //根据obj获取行号索引index
									$('#'+gridId).datagrid('deleteRow',_index); //删除行
						}
					}
				});
			}
		}

//绑定按钮事件与实现保存
function savebtn(btnId, actionName, tableIDs, entityNames, successurl) {
	$('#'+btnId).bind(
			'click',
			function() {
				if($("#"+saveformid).form('validate')){
					 $.ajax({
						type : "POST",
						url : actionName+"!saveData.do",
						data : 'params={"savedata":'
								+ JSON.stringify(saveJSONForMat(tableIDs,//构造保存格式，适合主从表与单独一个form
										entityNames)) + '}',
						success : function() {
							location.href = successurl;
						}
					}); 
				}else{
					$.messager.alert('提示','信息填写有误');   
				}
			});
}

//绑定按钮事件与实现保存,使用于页面含有多个form
function savebtnByFormId(btnId, actionName, tableIDs, entityNames, successurl, formId) {
	$('#'+btnId).bind(
			'click',
			function() {
				if($("#"+formId).form('validate')){
					 $.ajax({
						type : "POST",
						url : actionName+"!saveData.do",
						data : 'params={"savedata":'
								+ JSON.stringify(saveJSONByFormId(tableIDs,//构造保存格式，适合主从表与单独一个form
										entityNames, formId)) + '}',
						success : function() {
							location.href = successurl;
						}
					}); 
				}else{
					$.messager.alert('提示','信息填写有误');   
				}
			});
}
//保存主从表方法
function saveFormGrid(actionName, tableIDs, entityNames, successurl, formId) {
	if($("#"+formId).form('validate')){
		 $.ajax({
			type : "POST",
			url : actionName+"!saveData.do",
			data : 'params={"savedata":'
					+ JSON.stringify(saveJSONByFormId(tableIDs,//构造保存格式，适合主从表与单独一个form
							entityNames, formId)) + '}',
			success : function() {
				location.href = successurl;
			}
		}); 
	}else{
		$.messager.alert('提示','信息填写有误');   
	}
}

//保存主从表方法
function saveMoreFormGrid(actionName, tableIDs, entityNames, successurl, formIds) {
	var validateforms = true;
	for(var i=0;i<formIds.length;i++){
		if(!$('#'+formIds[i]).form('validate')){
			validateforms = false;
		}
	}
	if(validateforms){
		 $.ajax({
			type : "POST",
			url : actionName+"!saveData.do",
			data : 'params={"savedata":'
					+ JSON.stringify(saveJSONByMoreForm(tableIDs,//构造保存格式，适合主从表与单独一个form
							entityNames, formIds)) + '}',
			success : function() {
				location.href = successurl;
			}
		}); 
	}else{
		$.messager.alert('提示','信息填写有误');   
	}
}

//删除grid的行（持久化）
function deleteInfo(gridId, actionName) {
	var rowDatas = $('#' + gridId).datagrid('getSelections');
	if (rowDatas == null || rowDatas.length == 0) { // 没选中对象
		$.messager.alert('提示', '没有选中数据', "info");
		return;
	} else {
		$.messager.confirm('确认', '请确认删除', function(row) {
			if (row) {
				var rowlength = rowDatas.length;
				for ( var i = 0; i < rowlength; i++) {
					if (rowDatas[0].id != null && rowDatas[0].id != "") {
						$.ajax({
							type : "POST",
							url : actionName + "!deleteById.do",
							data : 'params={"id":' + rowDatas[0].id + '}',
							success : function(data){
								_index = $('#' + gridId).datagrid('getRowIndex',
										rowDatas[0]); // 根据obj获取行号索引index
								$('#' + gridId).datagrid('deleteRow', _index); //删除行
							}
						});
					}
					
				}
			}
		});
	}
}
//获取Grid修改后的数据
function getGridChanges(gridId, entityname){
	//grid修改后的数据
	var changes_ins = getChanges(gridId, "inserted");
	var changes_upd = getChanges(gridId, "updated");
	var changes_del = getChanges(gridId, "deleted");  
	var gridjson = "";
	//循环修改数据的数组，构造JSON格式
	if(changes_ins!=null&&changes_ins!=""||changes_upd!=null&&changes_upd!=""||changes_del!=null&&changes_del!=""){
		for(var j = 0 ; j<changes_ins.length ; j++){
			if (gridjson == "") {
				gridjson = $.parseJSON(forMatJSON(changes_ins[j], entityname,"add"));
			} else {
				gridjson.items.push($.parseJSON(assembleJSON(changes_ins[j], entityname,"add")));
			}
		}
		for(var k = 0 ; k<changes_upd.length ; k++){
			if (gridjson == "") {
				gridjson = $.parseJSON(forMatJSON(changes_upd[k], entityname,"edit"));
			} else {
				gridjson.items.push($.parseJSON(assembleJSON(changes_upd[k], entityname, "edit")));
			}
		}
		for(var l = 0 ; l<changes_del.length ; l++){
			if (gridjson == "") {
				gridjson = $.parseJSON(forMatJSON(changes_del[l], entityname,"delete"));
			} else {
				gridjson.items.push($.parseJSON(assembleJSON(changes_del[l], entityname, "delete")));
			}
		}
	}
	return gridjson;
}
		//跳转到新增页面
		function addInfo(actionName) {
			location.href = actionName+"!toEdit.do?opt=add";
		}
		
		//传递rowID并跳转到修改页面
		function editInfo(gridId,actionName) {
			var rowDatas = $('#'+gridId).datagrid('getSelected');
			
			if (rowDatas == null) { //没选中对象
				$.messager.alert('提示', '没有选中数据', "info");
				return;
			} else {
				location.href = actionName+"!toEdit.do?id=" + rowDatas.id;
			}
		}
		
		//在页面增加一行并进入编辑
		function subAddInfo(gridId) {
			$('#'+gridId).datagrid('insertRow',{
				index: 0,	// 索引从0开始
				row: {}
			});
			lastIndex = 0;
			$('#'+gridId).datagrid('beginEdit', 0);
			var rows = $('#'+gridId).datagrid('getRows').length;
			if(rows>1)
				for(var i=1;i<rows;i++){
					$('#'+gridId).datagrid('endEdit', i);
				}
			var ed = $('#'+gridId).datagrid('getEditors',0);
			if (ed[0] != null) {
				$(ed[0].target).focus();
				$(ed[0].target).blur(function() {
					$('#'+gridId).datagrid('endEdit', 0);
				});
			}
		}

