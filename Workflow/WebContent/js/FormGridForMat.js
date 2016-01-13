//格式化主从表数据，form+grid 单个form也可以用（适用于页面只有一个form）
function saveJSONForMat(tableIDs, entityNames) {
	var targetJson = "";
	var FieldsInfo = $.parseJSON($('#' + saveformid + 'info').val());//form的input信息
	var reference = "";
	//把form的reference遍历出来
	for(var i=0;i<FieldsInfo.length;i++){
		if(FieldsInfo[i].reference!=""){
			var tempJson = "{\"" + FieldsInfo[i].name + "\":\"" + FieldsInfo[i].reference + "\"}";
			if(reference==""){
				reference = $.parseJSON(tempJson);
			}else{
				reference = $.extend(reference, $.parseJSON(tempJson));
			}
		}
	}
	//form里全部input数据
	$("#" + saveformid + " input[name], #" + saveformid + " textarea").each(function(i, value) {
		var packJson;
		//获取datebox数据
		if($("#"+value.name).attr("type")=="datebox"){
			packJson = "{\"" + value.name + "\":\"" + $("#"+value.name+"+span input[type=text]").val() + "\"}";
			
		}else{
			packJson = "{\"" + value.name + "\":\"" + value.value + "\"}";
		}
		var reg = new RegExp("\n","g");
		packJson = packJson.replace(reg,"\\n");
		if (targetJson == "") {
			targetJson = $.parseJSON(packJson);
		} else {
			targetJson = $.extend(targetJson, $.parseJSON(packJson));
		}
	});
	
	//遍历form数据删除含有reference的数据（保留reference+id命名的）
	for ( var key in targetJson) {
		for ( var key2 in reference) {
			if (key == key2) {
				var restr = reference[key2];
				var rearr = restr.split(".");
				if (rearr.length == 1) {
					if (key == reference[key2] + "id") {
						targetJson[reference[key2]] = targetJson[key];
						delete targetJson[key];
					}else {
						delete targetJson[key];
					}
				}else if(rearr.length > 1){
					if(rearr[rearr.length-1]=="id"){
						targetJson[rearr[0]] = targetJson[key];
						delete targetJson[key];
					}else{
						delete targetJson[key];
					}
				}
			}
		}
	}
	//到这里单个form的数据格式构造完成
	targetJson = $.parseJSON(forMatJSON(targetJson, "",
			targetJson.id == "" ? "add" : "edit"));
	//含有从表的把修改过的数据加入
	if (tableIDs != null && tableIDs != "") {
		var subTargetJson = "";
		for ( var i = 0; i < tableIDs.length; i++) {
			var table = tableIDs[i];
			var changes_ins = getChanges(table, "inserted");
			var changes_upd = getChanges(table, "updated");
			var changes_del = getChanges(table, "deleted");
			if(changes_ins!=null&&changes_ins!=""||changes_upd!=null&&changes_upd!=""||changes_del!=null&&changes_del!=""){
				for(var j = 0 ; j<changes_ins.length ; j++){
					if (subTargetJson == "") {
						subTargetJson = $.parseJSON(forMatJSON(changes_ins[j], entityNames[i],"add"));
					} else {
						subTargetJson.items.push($.parseJSON(assembleJSON(changes_ins[j], entityNames[i],"add")));
					}
				}
				for(var k = 0 ; k<changes_upd.length ; k++){
					if (subTargetJson == "") {
						subTargetJson = $.parseJSON(forMatJSON(changes_upd[k], entityNames[i],"edit"));
					} else {
						subTargetJson.items.push($.parseJSON(assembleJSON(changes_upd[k], entityNames[i], "edit")));
					}
				}
				for(var l = 0 ; l<changes_del.length ; l++){
					if (subTargetJson == "") {
						subTargetJson = $.parseJSON(forMatJSON(changes_del[l], entityNames[i],"delete"));
					} else {
						subTargetJson.items.push($.parseJSON(assembleJSON(changes_del[l], entityNames[i], "delete")));
					}
				}
				targetJson.items.push(subTargetJson);
		}
		}
	}
	return targetJson;
}
//格式化主从表数据，form+grid 单个form也可以用（适用于页面有多个form）
function saveJSONByFormId(tableIDs, entityNames, formId) {
	var targetJson = "";
	var FieldsInfo = $.parseJSON($('#' + formId + 'info').val());//form的input信息
	var reference = "";
	//把form的reference遍历出来
	for(var i=0;i<FieldsInfo.length;i++){
		if(FieldsInfo[i].reference!=""){
			var tempJson = "{\"" + FieldsInfo[i].name + "\":\"" + FieldsInfo[i].reference + "\"}";
			if(reference==""){
				reference = $.parseJSON(tempJson);
			}else{
				reference = $.extend(reference, $.parseJSON(tempJson));
			}
		}
	}
	//form里全部input数据
	$("#" + formId + " input[name], #" + formId + " textarea").each(function(i, value) {
		var packJson;
		//获取datebox数据
		if($("#"+value.name).attr("type")=="datebox"){
			packJson = "{\"" + value.name + "\":\"" + $("#"+value.name+"+span input[type=text]").val() + "\"}";
			
		}else{
			packJson = "{\"" + value.name + "\":\"" + value.value + "\"}";
		}
		var reg = new RegExp("\n","g");
		packJson = packJson.replace(reg,"\\n");
		if (targetJson == "") {
			targetJson = $.parseJSON(packJson);
		} else {
			targetJson = $.extend(targetJson, $.parseJSON(packJson));
		}
	});
	
	//遍历form数据删除含有reference的数据（保留reference+id命名的）
	for ( var key in targetJson) {
		for ( var key2 in reference) {
			if (key == key2) {
				var restr = reference[key2];
				var rearr = restr.split(".");
				if (rearr.length == 1) {
					if (key == reference[key2] + "id") {
						targetJson[reference[key2]] = targetJson[key];
						delete targetJson[key];
					}else {
						delete targetJson[key];
					}
				}else if(rearr.length > 1){
					if(rearr[rearr.length-1]=="id"){
						targetJson[rearr[0]] = targetJson[key];
						delete targetJson[key];
					}else{
						delete targetJson[key];
					}
				}
			}
		}
	}
	//到这里单个form的数据格式构造完成
	targetJson = $.parseJSON(forMatJSON(targetJson, "",
			targetJson.id == ""||targetJson.id == 0 ? "add" : "edit"));
	//含有从表的把修改过的数据加入
	if (tableIDs != null && tableIDs != "") {
		var subTargetJson = "";
		for ( var i = 0; i < tableIDs.length; i++) {
			var table = tableIDs[i];
			var changes_ins = getChanges(table, "inserted");//$('#' + table).datagrid("getChanges","inserted");
			var changes_upd = getChanges(table, "updated");//$('#' + table).datagrid("getChanges","updated");
			var changes_del = getChanges(table, "deleted");//$('#' + table).datagrid("getChanges","deleted");
			if(changes_ins!=null&&changes_ins!=""||changes_upd!=null&&changes_upd!=""||changes_del!=null&&changes_del!=""){
				for(var j = 0 ; j<changes_ins.length ; j++){
					if (subTargetJson == "") {
						subTargetJson = $.parseJSON(forMatJSON(changes_ins[j], entityNames[i],"add"));
					} else {
						subTargetJson.items.push($.parseJSON(assembleJSON(changes_ins[j], entityNames[i],"add")));
					}
				}
				for(var k = 0 ; k<changes_upd.length ; k++){
					if (subTargetJson == "") {
						subTargetJson = $.parseJSON(forMatJSON(changes_upd[k], entityNames[i],"edit"));
					} else {
						subTargetJson.items.push($.parseJSON(assembleJSON(changes_upd[k], entityNames[i], "edit")));
					}
				}
				for(var l = 0 ; l<changes_del.length ; l++){
					if (subTargetJson == "") {
						subTargetJson = $.parseJSON(forMatJSON(changes_del[l], entityNames[i],"delete"));
					} else {
						subTargetJson.items.push($.parseJSON(assembleJSON(changes_del[l], entityNames[i], "delete")));
					}
				}
				targetJson.items.push(subTargetJson);
		}
		}
	}
	return targetJson;
}


//格式化主从表数据，用于保存多个form
function saveJSONByMoreForm(tableIDs, entityNames, formIds) {
	var targetJson = "";
	var reference = "";
	for(var k=0;k<formIds.length;k++){
		var formId = formIds[k];
		var FieldsInfo = $.parseJSON($('#' + formId + 'info').val());//form的input信息
		//把form的reference遍历出来
		for(var i=0;i<FieldsInfo.length;i++){
			if(FieldsInfo[i].reference!=""){
				var tempJson = "{\"" + FieldsInfo[i].name + "\":\"" + FieldsInfo[i].reference + "\"}";
				if(reference==""){
					reference = $.parseJSON(tempJson);
				}else{
					reference = $.extend(reference, $.parseJSON(tempJson));
				}
			}
		}
		//form里全部input数据
		$("#" + formId + " input[name], #" + formId + " textarea").each(function(i, value) {
			var packJson;
			//获取datebox数据
			if($("#"+value.name).attr("type")=="datebox"){
				packJson = "{\"" + value.name + "\":\"" + $("#"+value.name+"+span input[type=text]").val() + "\"}";
				
			}else{
				packJson = "{\"" + value.name + "\":\"" + value.value + "\"}";
			}
			var reg = new RegExp("\n","g");
			packJson = packJson.replace(reg,"\\n");
			if (targetJson == "") {
				targetJson = $.parseJSON(packJson);
			} else {
				targetJson = $.extend(targetJson, $.parseJSON(packJson));
			}
		});
	}
	//遍历form数据删除含有reference的数据（保留reference+id命名的）
	for ( var key in targetJson) {
		for ( var key2 in reference) {
			if (key == key2) {
				var restr = reference[key2];
				var rearr = restr.split(".");
				if (rearr.length == 1) {
					if (key == reference[key2] + "id") {
						targetJson[reference[key2]] = targetJson[key];
						delete targetJson[key];
					}else {
						delete targetJson[key];
					}
				}else if(rearr.length > 1){
					if(rearr[rearr.length-1]=="id"){
						targetJson[rearr[0]] = targetJson[key];
						delete targetJson[key];
					}else{
						delete targetJson[key];
					}
				}
			}
		}
	}
	//到这里单个form的数据格式构造完成
	targetJson = $.parseJSON(forMatJSON(targetJson, "",
			targetJson.id == ""||targetJson.id == 0 ? "add" : "edit"));
	//含有从表的把修改过的数据加入
	if (tableIDs != null && tableIDs != "") {
		var subTargetJson = "";
		for ( var i = 0; i < tableIDs.length; i++) {
			var table = tableIDs[i];
			var changes_ins = getChanges(table, "inserted");//$('#' + table).datagrid("getChanges","inserted");
			var changes_upd = getChanges(table, "updated");//$('#' + table).datagrid("getChanges","updated");
			var changes_del = getChanges(table, "deleted");//$('#' + table).datagrid("getChanges","deleted");
			if(changes_ins!=null&&changes_ins!=""||changes_upd!=null&&changes_upd!=""||changes_del!=null&&changes_del!=""){
				for(var j = 0 ; j<changes_ins.length ; j++){
					if (subTargetJson == "") {
						subTargetJson = $.parseJSON(forMatJSON(changes_ins[j], entityNames[i],"add"));
					} else {
						subTargetJson.items.push($.parseJSON(assembleJSON(changes_ins[j], entityNames[i],"add")));
					}
				}
				for(var k = 0 ; k<changes_upd.length ; k++){
					if (subTargetJson == "") {
						subTargetJson = $.parseJSON(forMatJSON(changes_upd[k], entityNames[i],"edit"));
					} else {
						subTargetJson.items.push($.parseJSON(assembleJSON(changes_upd[k], entityNames[i], "edit")));
					}
				}
				for(var l = 0 ; l<changes_del.length ; l++){
					if (subTargetJson == "") {
						subTargetJson = $.parseJSON(forMatJSON(changes_del[l], entityNames[i],"delete"));
					} else {
						subTargetJson.items.push($.parseJSON(assembleJSON(changes_del[l], entityNames[i], "delete")));
					}
				}
				targetJson.items.push(subTargetJson);
		}
		}
	}
	return targetJson;
}

//格式化单条数据
function forMatJSON(data, entityname, opt) {
	var format = {
		"items" : [ {
			"data" : data,
			"_option" : {
				"entityname" : entityname,
				"opt" : opt
			}
		} ]
	};
	return JSON.stringify(format);
}
//从表格式化单条数据（不含items）
function assembleJSON(data, entityname, opt) {
	var assemble = {
		"data" : data,
		"_option" : {
			"entityname" : entityname,
			"opt" : opt
		}
	};
	return JSON.stringify(assemble);
}

//拿grid中修改过的数据（已过滤reference）
function getChanges(tableId, opt) {
	var changedata = $("#" + tableId).datagrid('getChanges', opt);
	var jsonarr = new Array();
	var jsonobj = "";
	for ( var i = 0; i < changedata.length; i++) {
		jsonobj = changedata[i];
		var jsontemp = {};
		for ( var key in jsonobj) {
			var colOption = $("#" + tableId).datagrid('getColumnOption', key);
			if (colOption != null) {
				var reference = colOption.reference;
				if (reference != "" && reference != null) {
					var rearr = reference.split(".");
					if (rearr.length == 1) {
					if (key == (reference + "id")) {
						jsontemp[reference] = jsonobj[key];
					} 
					}else if(rearr.length > 1){
						if(rearr[rearr.length-1]=="id"){
							jsontemp[rearr[0]] = jsonobj[key];
						}
					}
				}else{
					jsontemp[key] = jsonobj[key];
				}
			}
		}
		jsonarr.push(jsontemp);
	}
	return jsonarr;
}


