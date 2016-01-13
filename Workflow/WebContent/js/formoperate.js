	function clearForm(formId){
		$("#"+formId).form("clear");
	}
	
	function saveForm(formId,actionName){
		var loaddata =  $("#"+formId).thform("getUpdateBeforeData");
		var root = $("#"+formId).thform('getRoot');
		loaddata = loaddata[root];
		$("#"+formId+" input[name], #"+formId+" textarea[name]").each(function(i,ele){
			var name = ele.name;
			var keyarr = name.split(".");
//			var packJson;
			if(keyarr.length==1){
				loaddata[name] = ele.value;
//				packJson = "{\"" + ele.name + "\":\"" + ele.value + "\"}";
//				var reg = new RegExp("\n","g");
//				packJson = packJson.replace(reg,"\\n");
//				if (targetJson == "") {
//					targetJson = $.parseJSON(packJson);
//				} else {
//					targetJson = $.extend(targetJson, $.parseJSON(packJson));
//				}
			}else if(keyarr.length>1){
				loaddata = getJsonData(loaddata,name,formId,name);
//				alert(name);
//				alert(JSON.stringify(getJsonData(loaddata,name,formId,name)));
//				var tempdata = loaddata;
//    			for(var i=0;i<keyarr.length;i++){
//    				tempdata = tempdata[keyarr[i]];
//    			}
//    			loaddata[name] = tempdata;
			}
		});
		 $.ajax({
				type : "POST",
				url : actionName+"!saveForm.do",
				data:'params={"savedata":\''+JSON.stringify(loaddata)+'\'}',
//				data : 'params={"savedata":'
//						+ JSON.stringify(saveJSONByFormId(tableIDs,//构造保存格式，适合主从表与单独一个form
//								entityNames, formId)) + '}',
				success : function() {
					location.href = successurl;
				}
			}); 
	}
	
	function getJsonData(json,key,formId,name){
		var keyarr = key.split(".");
		if(keyarr.length>1){
			if(keyarr[keyarr.length-1]=="id"){
				var newkey = "";
				for(var i=1;i<keyarr.length;i++){
					newkey += keyarr[i];
				}
				json[keyarr[0]] = getJsonData(json[keyarr[0]], newkey, formId, name);
				return json;
			}else{
				return;
			}
		}else{
			json[key] = $("#"+formId+" input[name='"+name+"']").val();
			return json;
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
	
	
	function hiddenElement(formId, hiddenids){
		var elelen = $('#'+formId+' div[class="doc-table"][name!="hidden_div"]').length;
		var hidelen = hiddenids.length;
		for(var i=0;i<hidelen;i++){
			$('#'+hiddenids[i]).hide();
		}
		if((elelen-hidelen)%2==0){
			$('#'+formId+' div[name="type_div"]').show();
		}else{
			$('#'+formId+' div[name="type_div"]').hide();
		}
	}
	
	function showElement(formId, hiddenids){
		var elelen = $('#'+formId+' div[class="doc-table"][name!="hidden_div"]').length;
		var hidelen = hiddenids.length;
		for(var i=0;i<hidelen;i++){
			$('#'+hiddenids[i]).show();
		}
		if((elelen+hidelen)%2==0){
			$('#'+formId+' div[name="type_div"]').show();
		}else{
			$('#'+formId+' div[name="type_div"]').hide();
		}
	}