//function createQueryForm(span,formid,method,fields,dataUrl,onclick,gridname){
function createdialogForm(span,formid,method,fields,dataUrl,onclick,gridname,lazy){
	var queryParam = {};
	try{
		var paramjson = setFormParam();//获取页面抽象方法设置的值
	}catch(e){
		throw new Error('页面setFormParam()方法');
	}
	if(paramjson!=null){
	for(var i=0;i<paramjson.length;i++){//循环拿到对应form的数据
		var formParamJson = paramjson[i];
		if(formParamJson.formname == formid){
			queryParam = formParamJson.rqstparam;
			break;
		}
	}
	}
	//定义变量保存form里的标签
	var fieldsString = "";
	//要使用js生成事件或控件的需要数组来保存ID
	var comboElement = [];
	var dateboxElement = [];
	var startdateboxElement = [];
	var enddateboxElement = [];
	var datetimeboxElement = [];
	var startdatetimeboxElement = [];
	var enddatetimeboxElement = [];
	var textareaElement = [];
	var hiddenElement = []; 
	var iconElement = []; 
	//遍历生成form里面的标签
	for ( var i = 0; i < fields.length; i++) {
		if(fields[i].type == "text"||fields[i].type == "password"){
			if(fields[i].classStyle=="easyui-comboicons"){
				iconElement.push(fields[i]);
			}
			if(fields[i].editable==true){
				fieldsString += 
					'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
				+'<tr>'
				+'<td class="dialogname">'+ fields[i].label +'</td>'
				+'<td class="dialogint"><input placeholder="'+fields[i].missingMessage+'" type="'
				+ fields[i].type + '" name="' + fields[i].name
				+ '" value="' + fields[i].value + '" id="'
				+ fields[i].id + '" class="' + fields[i].classStyle
				+ '" /></td>'
				+'</tr>'
				+'</table>'
				+'</div>';
			}else{
				fieldsString += 
					'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
				+'<tr>'
				+'<td class="dialogname">'+ fields[i].label +'</td>'
				+'<td class="dialogint"><input readOnly = true type="'
				+ fields[i].type + '" name="' + fields[i].name
				+ '" value="' + fields[i].value + '" id="'
				+ fields[i].id + '" class="' + fields[i].classStyle
				+ '" /></td>'
				+'</tr>'
				+'</table>'
				+'</div>';
			}
		}else if(fields[i].type == "hidden"){
			hiddenElement.push(fields[i]);
		}else
			if (fields[i].type.indexOf("combo") != -1) {
				comboElement.push(fields[i]);
				if(fields[i].editable==true){
					fieldsString += 
						'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
					+'<tr>'
					+'<td class="dialogname">'+ fields[i].label +'</td>'
					+'<td class="dialogint"><input class="excombo" type="'
					+ fields[i].type + '" name="' + fields[i].name
					+ '" value="' + fields[i].value + '" id="'
					+ fields[i].id + '"/></td>'
					+'</tr>'
					+'</table>'
					+'</div>';
				}else{
					fieldsString += 
						'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
					+'<tr>'
					+'<td class="dialogname">'+ fields[i].label +'</td>'
					+'<td class="dialogint"><input class="excombo" readOnly = true type="'
					+ fields[i].type + '" name="' + fields[i].name
					+ '" value="' + fields[i].value + '" id="'
					+ fields[i].id + '"/></td>'
					+'</tr>'
					+'</table>'
					+'</div>';
				}
				continue;
			} else if(fields[i].type == "datebox"){
				dateboxElement.push(fields[i]);
				if(fields[i].editable==true){
					fieldsString += 
						'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
					+'<tr>'
					+'<td class="dialogname">'+ fields[i].label +'</td>'
					+'<td class="dialogint"><input class="excombo" type="'
					+ fields[i].type + '" name="' + fields[i].name
					+ '" value="' + fields[i].value + '" id="'
					+ fields[i].id + '"/></td>'
					+'</tr>'
					+'</table>'
					+'</div>';
				}else{
					fieldsString += 
						'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
					+'<tr>'
					+'<td class="dialogname">'+ fields[i].label +'</td>'
					+'<td class="dialogint"><input class="excombo" readOnly = true type="'
					+ fields[i].type + '" name="' + fields[i].name
					+ '" value="' + fields[i].value + '" id="'
					+ fields[i].id + '"/></td>'
					+'</tr>'
					+'</table>'
					+'</div>';
				}
				continue;
			}else if(fields[i].type == "startdatebox"){
				startdateboxElement.push(fields[i]);
				fieldsString += 
					'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
				+'<tr>'
				+'<td class="dialogname">'+ fields[i].label +'</td>'
				+'<td class="dialogint"><input class="excombo" type="'
				+ fields[i].type + '" name="' + fields[i].name
				+ '" value="' + fields[i].value + '" id="'
				+ fields[i].id + '"/></td>'
				+'</tr>'
				+'</table>'
				+'</div>';
			}else if(fields[i].type == "enddatebox"){
				enddateboxElement.push(fields[i]);
				fieldsString += 
					'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
				+'<tr>'
				+'<td class="dialogname">'+ fields[i].label +'</td>'
				+'<td class="dialogint"><input class="excombo" type="'
				+ fields[i].type + '" name="' + fields[i].name
				+ '" value="' + fields[i].value + '" id="'
				+ fields[i].id + '"/></td>'
				+'</tr>'
				+'</table>'
				+'</div>';
			} else if(fields[i].type == "datetimebox"){
				datetimeboxElement.push(fields[i]);
				fieldsString += 
					'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
				+'<tr>'
				+'<td class="dialogname">'+ fields[i].label +'</td>'
				+'<td class="dialogint"><input class="excombo" type="'
				+ fields[i].type + '" name="' + fields[i].name
				+ '" value="' + fields[i].value + '" id="'
				+ fields[i].id + '"/></td>'
				+'</tr>'
				+'</table>'
				+'</div>';
			}else if(fields[i].type == "startdatetimebox"){
				startdatetimeboxElement.push(fields[i]);
				fieldsString += 
					'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
				+'<tr>'
				+'<td class="dialogname">'+ fields[i].label +'</td>'
				+'<td class="dialogint"><input class="excombo" type="'
				+ fields[i].type + '" name="' + fields[i].name
				+ '" value="' + fields[i].value + '" id="'
				+ fields[i].id + '"/></td>'
				+'</tr>'
				+'</table>'
				+'</div>';
			}else if(fields[i].type == "enddatetimebox"){
				enddatetimeboxElement.push(fields[i]);
				fieldsString += 
					'<div class="dialgobox" id="'	+ fields[i].id + '_div"><table class="dialog-table">'
				+'<tr>'
				+'<td class="dialogname">'+ fields[i].label +'</td>'
				+'<td class="dialogint"><input class="excombo" type="'
				+ fields[i].type + '" name="' + fields[i].name
				+ '" value="' + fields[i].value + '" id="'
				+ fields[i].id + '"/></td>'
				+'</tr>'
				+'</table>'
				+'</div>';
			}
			else if(fields[i].type=="textarea"){
				textareaElement.push(fields[i]);
			}
	}
	for(var t=0;t<textareaElement.length;t++){
		if(textareaElement[t].editable==true){
			fieldsString += 
				'<div  class="dialgobox" id="'	+ textareaElement[t].id + '_div"><table class="tabarea">'
			+'<tr>'
			+'<td class="dialogname">'+ textareaElement[t].label +'</td>'
			+'<td class="dialogtext"><textarea name="' + textareaElement[t].name
			+ '" value="' + textareaElement[t].value + '" id="'
			+ textareaElement[t].id + '" class="' + textareaElement[t].classStyle+ '"/></td>'
			+'</tr>'
			+'</table>'
			+'</div>';
		}else{
			fieldsString += 
				'<div  class="dialgobox" id="'	+ textareaElement[t].id + '_div"><table class="tabarea">'
			+'<tr>'
			+'<td class="dialogname">'+ textareaElement[t].label +'</td>'
			+'<td class="dialogtext"><textarea readOnly = true name="' + textareaElement[t].name
			+ '" value="' + textareaElement[t].value + '" id="'
			+ textareaElement[t].id + '" class="' + textareaElement[t].classStyle+ '"/></td>'
			+'</tr>'
			+'</table>'
			+'</div>';
		}
	}
	for(var h=0;h<hiddenElement.length;h++){
		fieldsString += 
			'<div name="hidden_div" style="display: none;"  class="dialgobox" id="'	+ hiddenElement[h].id + '_div"><table class="dialog-table">'
		+'<tr>'
		+'<td class="dialogint"><input type="'
		+ hiddenElement[h].type + '" name="' + hiddenElement[h].name
		+ '" value="' + hiddenElement[h].value + '" id="'
		+ hiddenElement[h].id + '" class="' + hiddenElement[h].classStyle
		+ '" /></td>'
		+'</tr>'
		+'</table>'
		+'</div>';
	}
	
	//生成form标签
	var formString = "<form id='"+formid+"' method='"+method+"'><div  class='dialogForm'>"+fieldsString+"</div></form>";
	//把form添加到页面的span里
	var formele = $(formString).appendTo("#"+span);

/*	$("#"+formid).thform({
		root:root
	});*/
	
	$.parser.parse(formele); // 重新加载JQ
	
	//标签添加到页面后开始绑定JS
	//var in_width = fixWidth()-50;
	var in_width = $('#'+formid+' input[class!="combo-text"][class!="excombo"]')[0].clientWidth;
	for(var j = 0; j < comboElement.length; j++){
		var comboOpts = {};
		comboOpts.url =  comboElement[j].comboUrl;
		comboOpts.required = comboElement[j].formValidateInfo.required;
		comboOpts.width = in_width;
		if (comboElement[j].type == "combobox") {
			comboOpts.valueField = comboElement[j].comboValueField;
			comboOpts.textField = comboElement[j].comboTextField;
			comboOpts.onSelect = (function(j){
				return function(record){//把Id set 到隐藏列
		 		    var value = record[comboElement[j].comboValueField];
		 		    $('#'+comboElement[j].valueToHiddenField).val(value);
				};
				})(j);
			$('#' + comboElement[j].id).combobox(comboOpts);
			if(comboElement[j].value != ""){
				$('#' + comboElement[j].id).combobox("select",comboElement[j].value);
			}
		}else if (comboElement[j].type == "combotree") {
			comboOpts.onClick = (function(j){
				return function(node){//把Id set 到隐藏列
					var reference = comboElement[j].reference;
					var treevalueToHidden = comboElement[j].valueToHiddenField;
					var fieid = treevalueToHidden==""?reference+"id":treevalueToHidden;
					$('#'+fieid).val(node.id);
				};
			})(j);
			comboOpts.editable = false;
			$('#' + comboElement[j].id).combotree(comboOpts);
		}else if (comboElement[j].type == "combogrid") {
			var fparams = {};
			var grid = comboElement[j].gridVo;
			var url = grid.url;
			var isPage = grid.page;
			var idField = grid.idField;
			var sortOrder = grid.sortOrder;
			var columns = grid.columns;
			var cols = eval("("+columns+")");
			for(var i=0;i<cols.length;i++){
				var col = cols[i];
				if(col.editor == ""){
					delete col.editor;
				}
			}
			var columnArr = [];
			columnArr.push(cols);
			fparams.fieldsInfo = JSON.stringify(columnArr);
			var fparamss = {
					params : JSON.stringify(fparams)
			};
			var columnArray = [];
			var colss = eval("("+columns+")");
			for(var i=0;i<colss.length;i++){
				if(colss[i].editor == "combobox"){
					var hiddenField = colss[i].valueToHiddenField;
					var valueField = colss[i].comboValueField;
					var t = {
							"type":"combobox",
							"options":{
								"url":colss[i].comboUrl,
								"valueField": colss[i].comboTextField,    
								"textField": colss[i].comboTextField,
								onSelect : function(record){
									var ed = $('#'+tableId).datagrid('getEditor', {index:editingIndex,field:hiddenField});
									$(ed.target).text('setValue', record[valueField]);
									
								}
							}
					};
					colss[i].editor = t;
				}
				
			}
			//构造Grid
			columnArray.push(colss); 
			comboOpts.url = url;
			var gridcomboTextField = comboElement[j].comboTextField;
			comboOpts.textField = gridcomboTextField;
			comboOpts.idField = gridcomboTextField;
			comboOpts.columns = columnArray;
			comboOpts.pagination = isPage;
			comboOpts.sortName = idField;
			comboOpts.sortOrder = sortOrder;
			comboOpts.queryParams = fparamss;
			var gridvalueToHidden = comboElement[j].valueToHiddenField;
			comboOpts.onClickRow = function(rowIndex, rowData){
				$('#'+gridvalueToHidden).val(rowData.id);
			};
			$('#' + comboElement[j].id).combogrid(comboOpts);
		}
	}
	
	for(var c=0;c<iconElement.length;c++){
		$('#'+iconElement[c].id).combo({
			width : in_width+6
		});
	}
	
	for(var i=0;i<dateboxElement.length;i++){
		$('#'+dateboxElement[i].id).datebox({    
			required : dateboxElement[i].formValidateInfo.required,
			width : in_width
		});
	}
	
	for(var i=0;i<datetimeboxElement.length;i++){
		$('#'+datetimeboxElement[i].id).datetimebox({    
			required : datetimeboxElement[i].formValidateInfo.required,
			width : in_width
		});
	}
	for ( var i = 0; i < fields.length; i++) {
		if (fields[i].type == "text" || fields[i].type == "hidden" || fields[i].type == "password"|| fields[i].type == "textarea") {
				if (fields[i].editable==true) {
					if(fields[i].formValidateInfo != null) {
						var validateJson = {};
						validateJson.required = fields[i].formValidateInfo.required;
						if(fields[i].formValidateInfo.validateTypes != ""){
							var validates = [];
							if(fields[i].formValidateInfo.validateTypes.indexOf(";")>-1){
								validates = fields[i].formValidateInfo.validateTypes.split(";");
							}else{
								validates.push(fields[i].formValidateInfo.validateTypes);
							}
							validateJson.validType = validates;
						}
						$('#' + fields[i].id).validatebox(
								validateJson
						); 
					}
				}
			}
		}
	
	//范围日期
	for(var i=0;i<startdateboxElement.length;i++){
		date_init(startdateboxElement[i].id,enddateboxElement[i].id,in_width);
	}
	
	//范围时间
	for(var i=0;i<startdatetimeboxElement.length;i++){
		datetime_init(startdatetimeboxElement[i].id,enddatetimeboxElement[i].id,in_width);
	}
	
	var urlTemp = dataUrl.substring(0,dataUrl.length-3).split('!'); 
	//alert(urlTemp);
	if("queryById" == urlTemp[1]){
		for ( var i = 0; i < fields.length; i++) {
				delete fields[i].gridVo;
		}
		queryParam.elementsInfo = JSON.stringify(fields);
	}
	if (id != null && id != "") {
		queryParam.id = id;
	}
	if(dataUrl != ""){
		if ("queryById" != urlTemp[1] || (queryParam.id != null && queryParam.id != "")) {
			$.ajax({
				type : "POST",
				url : dataUrl,
				data : "params="+JSON.stringify(queryParam),
				success : function(data) {
					$('#'+formid).form('load',data);
				}
			});
			queryParam.elementsInfo = JSON.stringify(fields);

		}
	}
}

function fixWidth_dialog(formId) { 
	return ($("#"+formId)[0].clientWidth)*0.8;
};
function fixWidth_dialogname(formId) { 
	return (fixWidth_dialog(formId))*0.3;
};
function fixWidth_dialogint(formId) { 
	return (fixWidth_dialog(formId))*0.7;
};

function fixWidth_dialogcombo(formId) { 
	return (fixWidth_dialogint(formId))-22;
};


function infoDialog(dialogId, data, formId){
	data.onClose = function(){
		$("#"+formId).form('disableValidation');
	};
	$('#'+dialogId).dialog(data);    
	var dialogTable_height = $("#"+formId).parent().parent()[0].clientHeight;
	var dialogForm_height = $("#"+formId)[0].clientHeight;
	
	var top = (dialogTable_height - dialogForm_height)/2;
	if(top>0){
		$("#"+formId).css({ "margin-top": (dialogTable_height - dialogForm_height)/2+"px" });
	}
	$("#"+formId).form('enableValidation');
	$('#'+formId+' .dialogForm .excombo').combo('resize',fixWidth_dialogint(formId));
	$('#'+formId+' .dialogForm ').css({'width':fixWidth_dialog(formId)+'px'});
	$('#'+formId+' .dialog-table ').css({'width':fixWidth_dialog(formId)+'px'});
	$('#'+formId+' .dialog-table .dialogname ').css({'width':fixWidth_dialogname(formId)+'px'});
	$('#'+formId+' .dialog-table .dialogint ').css({'width':fixWidth_dialogint(formId)+'px'});
	$('#'+formId+' .dialog-table .dialogint input').css({'width':fixWidth_dialogint(formId)+'px'});
	
	$('#'+formId+' .dialog-table .dialogint .combo').css({'width':fixWidth_dialogint(formId)+'px'});
	$('#'+formId+' .dialogint .combo .combo-text ').css({'width':fixWidth_dialogcombo(formId)+'px','height':'20px'});
	$('#'+formId+' .dialogint .combo .validatebox-text').css({'width':fixWidth_dialogcombo(formId)+'px','height':'20px'});
	
	//textarea
	$('#'+formId+' .dialogform ').css({'width':fixWidth_dialog(formId)+'px'});
	$('#'+formId+' .tabarea td').css({'padding':'5px 6px 5px 2px'});
	$('#'+formId+' .tabarea .dialogname').css({'width':fixWidth_dialogname(formId)+'px'});
	$('#'+formId+' .tabarea .dialogtext').css({'width':fixWidth_dialogint(formId)+'px'});
	$('#'+formId+' .tabarea .dialogtext textarea').css({'width':fixWidth_dialogint(formId)+'px','resize':'none'});
}



function infoDialogByMoreForm(dialogId, data, formIds){
	var onclose = "";
	var resize = "";
	for(var i=0;i<formIds.length;i++){
		var input_width = $('#'+formIds[i]+' input:not([class*="combo"])')[0].clientWidth;
		input_width+=2;
		onclose+="$('#"+formIds[i]+"').form('disableValidation');";
	}
	data.onClose = eval("0,("+ 'function(){'+onclose+'}'+")");
	$('#'+dialogId).dialog(data);
	for(var i=0;i<formIds.length;i++){
		var dialogTable_height = $("#"+formIds[i]).parent().parent()[0].clientHeight-33;
		var dialogForm_height = $("#"+formIds[i])[0].clientHeight;
		var top = (dialogTable_height - dialogForm_height)/2;
		if(top>0){
			$("#"+formIds[i]).css({ "margin-top": (dialogTable_height - dialogForm_height)/2+"px" });
		}
		$("#"+formIds[i]).form('enableValidation');
		$('#'+formIds[i]+' .dialogForm .excombo').combo('resize',fixWidth_dialogint(formIds[i]));
		$('#'+formIds[i]+' .dialogForm ').css({'width':fixWidth_dialog(formIds[i])+'px'});
		$('#'+formIds[i]+' .dialog-table ').css({'width':fixWidth_dialog(formIds[i])+'px'});
		$('#'+formIds[i]+' .dialog-table .dialogname ').css({'width':fixWidth_dialogname(formIds[i])+'px'});
		$('#'+formIds[i]+' .dialog-table .dialogint ').css({'width':fixWidth_dialogint(formIds[i])+'px'});
		$('#'+formIds[i]+' .dialog-table .dialogint input').css({'width':fixWidth_dialogint(formIds[i])+'px'});
		
		$('#'+formIds[i]+' .dialog-table .dialogint .combo').css({'width':fixWidth_dialogint(formIds[i])+'px'});
		$('#'+formIds[i]+' .dialogint .combo .combo-text ').css({'width':fixWidth_dialogcombo(formIds[i])+'px','height':'20px'});
		$('#'+formIds[i]+' .dialogint .combo .validatebox-text').css({'width':fixWidth_dialogcombo(formIds[i])+'px','height':'20px'});
		
		//textarea
		$('#'+formIds[i]+' .dialogform ').css({'width':fixWidth_dialog(formIds[i])+'px'});
		$('#'+formIds[i]+' .tabarea td').css({'padding':'5px 6px 5px 2px'});
		$('#'+formIds[i]+' .tabarea .dialogname').css({'width':fixWidth_dialogname(formIds[i])+'px'});
		$('#'+formIds[i]+' .tabarea .dialogtext').css({'width':fixWidth_dialogint(formIds[i])+'px'});
		$('#'+formIds[i]+' .tabarea .dialogtext textarea').css({'width':fixWidth_dialogint(formIds[i])+'px','resize':'none'});
	}

}

