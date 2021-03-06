function createDialogQueryForm(span,formid,method,fields,dataUrl,onclick,gridname,lazy){
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
	//判断是不是queryform，queryform使用不同的class
	var formclass = "changefrm";
	if((onclick == null&&gridname!=null)||(onclick != null&&gridname!=null)){
		formclass = "searchfrm";
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
	var divcs = "doc-table";
	var tablecs = "divtable";
	var tabnamecs = "tabname";
	var tabintcs = "tabint";
	var combocs = "excombo";
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
	
	//queryform生成按钮
	var querybtn = "";
	//修复角色成员维护的分配角色dialog，查询后重置，不能重新load grid的问题，clearForm()的参数变成了2个
	if(onclick == null&&gridname!=null){
		querybtn += '<div id="brbtn"  class="toolbar"><a href="#" class="easyui-linkbutton" plain="true" data-options="iconCls:\'icon-search\'" onclick="_search()" >查询</a><a href="#" class="easyui-linkbutton" plain="true" data-options="iconCls:\'icon-undo\'" onclick="clearForm(\''+ formid+'\',\'_search()\')">重置</a></div>';
	}else if(onclick != null&&gridname!=null){
		querybtn += '<div id="brbtn"  class="toolbar"><a href="#" class="easyui-linkbutton" plain="true" data-options="iconCls:\'icon-search\'" onclick="'+onclick+'" >查询</a><a href="#" class="easyui-linkbutton" plain="true" data-options="iconCls:\'icon-undo\'" onclick="clearForm(\''+ formid+'\',\''+ onclick+'\')">重置</a></div>';
	}
	var textmas = "修改信息";
	if(formclass == "searchfrm"){
		textmas = "查询信息";
	}
	//生成form标签
	var formString = "<div class='tabinfo'><span class='infospan'>"+textmas+"</span>"+querybtn+"</div><form id='"+formid+"' method='"+method+"'><div  class='dialogForm'>"+fieldsString+"</div></form>";
	//把form添加到页面的span里
	var formele = $(formString).appendTo("#"+span);

/*	$("#"+formid).form({
		root:root
	});*/
	
	$.parser.parse(formele); // 重新加载JQ
	
	if($('#'+formid+' div[class="doc-table"][name!="hidden_div"]').length%2!=0){
		$('#'+formid+' div[name="type_div"]').hide();
	}
	
	//标签添加到页面后开始绑定JS
	var in_width = fixWidth_role(span)+2;
	for(var j = 0; j < comboElement.length; j++){
		var comboOpts = {};
		comboOpts.url =  comboElement[j].comboUrl;
		comboOpts.required = comboElement[j].formValidateInfo.required;
		if(comboElement[j].longElement){
			comboOpts.width = longWidth(span);
		}else{
			comboOpts.width = in_width;
		}
		comboOpts.tipPosition = 'bottom';
		//comboOpts.deltaX = "15";
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
		var elewidth = "";
		if(iconElement[c].longElement){
			elewidth = longWidth(span);
		}else{
			elewidth = in_width;
		}
		$('#'+iconElement[c].id).combo({
			width : elewidth
		});
	}
	
	for(var i=0;i<dateboxElement.length;i++){
		var elewidth = "";
		if(dateboxElement[i].longElement){
			elewidth = longWidth(span);
		}else{
			elewidth = in_width;
		}
		$('#'+dateboxElement[i].id).datebox({    
			required : dateboxElement[i].formValidateInfo.required,
			width : elewidth
		});
	}
	
	for(var i=0;i<datetimeboxElement.length;i++){
		var elewidth = "";
		if(dateboxElement[i].longElement){
			elewidth = longWidth(span);
		}else{
			elewidth = in_width;
		}
		$('#'+datetimeboxElement[i].id).datetimebox({    
			required : datetimeboxElement[i].formValidateInfo.required,
			width : elewidth
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
							if(fields[i].formValidateInfo.invalidMessage!=""){
								validateJson.invalidMessage = fields[i].formValidateInfo.invalidMessage;
							}
						}
						validateJson.tipPosition = "bottom";
						//validateJson.deltaX = "15";
						$('#' + fields[i].id).validatebox(
								validateJson
						); 
					}
				}
			}
		}
	
	//范围日期
	for(var i=0;i<startdateboxElement.length;i++){
		var elewidth = "";
		if(startdateboxElement[i].longElement){
			elewidth = longWidth(span);
		}else{
			elewidth = in_width;
		}
		date_init(startdateboxElement[i].id,enddateboxElement[i].id,elewidth);
	}
	
	//范围时间
	for(var i=0;i<startdatetimeboxElement.length;i++){
		var elewidth = "";
		if(startdateboxElement[i].longElement){
			elewidth = longWidth(span);
		}else{
			elewidth = in_width;
		}
		datetime_init(startdatetimeboxElement[i].id,enddatetimeboxElement[i].id,elewidth);
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
	if(dataUrl != ""&&formclass != "searchfrm"){
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
//返回某字符串出现的次数
function getCount(str, select){
	 return str.split(select).length-1;
}


