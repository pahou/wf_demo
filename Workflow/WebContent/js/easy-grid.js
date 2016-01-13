function createGrid(tableId,url,isPage,columns,idfield,method,btns,isEdit,sortOrder, isLinkage, singleSelect, queryform,isLazyShowToolbar,sortName, linkageMethod,autoRowHeight){
	var queryParam = {};
	try{
		var paramjson = setGridParam();//需要额外传送到后台的数据
	}catch(e){
		throw new Error('页面setGridParam()方法');
	}
	var editingIndex = 0;
	//var lastIndex = null;alert
	if(paramjson!=null){
		for(var i=0;i<paramjson.length;i++){
			var gridParamJson = paramjson[i];
			if(gridParamJson.gridname == tableId){
				queryParam = gridParamJson.rqstparam;
				break;
			}
		}
	}
	var cols = eval("("+columns+")");//执行json字符串
	for(var i=0;i<cols.length;i++){
		var col = cols[i];
		if(col.editor == ""){
			delete col.editor;
		}
	}
	
	 var columnArr = [];
	 columnArr.push(cols);
	 
	 var columnArray = [];
	 var colss = eval("("+columns+")");
	 for(var i=0;i<colss.length;i++){
		//判断editor类型，加载combobox
		 if(colss[i].editor == "combobox"){
			 var comboboxField = colss[i].valueToHiddenField;
			 var comboboxValue = colss[i].comboValueField;
			 var t = {
				   "type":"combobox",
				   "options":{
	    		   "url":colss[i].comboUrl,
	    		   "valueField": colss[i].comboTextField,    
	               "textField": colss[i].comboTextField,
            	   onSelect : function(record){//把Id set 到隐藏列
            		   var value = record[comboboxValue];
	             	   var ed = $('#'+tableId).datagrid('getEditor', {index:editingIndex,field:comboboxField});
	             	   $(ed.target).val(value);
	              }
			   }
			 };
			 colss[i].editor = t;
		 }
		//判断editor类型，加载combotree
		 if(colss[i].editor == "combotree"){
			 var comboTreeField = colss[i].valueToHiddenField;
			 var comboTreeValue = colss[i].comboValueField;
			 colss[i].editor ={
					 type:"combotree",
					 options:{
						 url:colss[i].comboUrl,
						 valueField : colss[i].comboTextField,    
			             textField : colss[i].comboTextField,
			             
						 onSelect : function(record){//把Id set 到隐藏列
		            		   var value = record[comboTreeValue];
			             	   var ed = $('#'+tableId).datagrid('getEditor', {index:editingIndex,field:comboTreeField});
			             	   $(ed.target).val(value);
			             	 
			              }
					 }
			 };
			 
		 }
		 //判断editor类型，加载combogrid
		 if(colss[i].editor == "combogrid"){
			 var cbgcolumns=[];
			 var cbgcol = [];
			 var comBoGridCols;
			 var girdHidenFieldId;
			 var id ;
			 if(colss[i].dgCombogrid != null){
				 comBoGridCols = colss[i].dgCombogrid.comBoGridColumns;
				 girdHidenFieldId = colss[i].valueToHiddenField;
				 id = colss[i].comboValueField;
				 for(var j=0;j<comBoGridCols.length;j++){
					 var cbgcoljson = {
							 field:comBoGridCols[j].field,
							 title:comBoGridCols[j].title,
							 width:comBoGridCols[j].width
					 };
					 cbgcol.push(cbgcoljson);
				 }
				 cbgcolumns.push(cbgcol);
				 colss[i].editor = {
						 type:"combogrid",
						 options:{
							 url:colss[i].dgCombogrid.url,
							 idField : colss[i].comboTextField,    
							 textField : colss[i].comboTextField,
							 panelWidth : colss[i].panelWidth,
							 singleSelect : true,
							 editable : false, 
							 columns : cbgcolumns,
							 onClickRow : function(rowIndex, rowData) {//把Id set 到隐藏列
								 var combogirdId =rowData[id];
								 var ed = $('#'+tableId).datagrid('getEditor', {index:editingIndex,field:girdHidenFieldId});
								 $(ed.target).val(combogirdId);
							 }
						 }
				 };
			 }
			
			 
		 }
		 
		 
	 }
	 
	 columnArray.push(colss); 

	 if(btns!=null){
		 for(var i=0;i<btns.length;i++){
			 btns[i].handler = eval("0,("+ 'function(){'+btns[i].onClick+'}'+")");
			 delete btns[i].onClick;
		 }
	 }
	 
	var urlTemp = url.substring(0,url.length-3).split('!'); 
	/*if('toEdit' == method){
		queryParam.masterId = id;
	}*/
	if('list' == urlTemp[1]||'listByObj' == urlTemp[1]||'listBySQL' == urlTemp[1]){
		queryParam.fieldsInfo = JSON.stringify(columnArr);
	}
	createHiddenInfo(tableId,JSON.stringify(columnArr));
	var queryParams = {
			params : JSON.stringify(queryParam)
	};
	try{
		if(opt == "add"){
			url = "";
		}
	}catch(e){
		throw new Error('页面没有opt变量');
	}
	var griddata = {
			fit: true,
			iconCls:'icon-save',
			nowrap: false,
			striped: true,
			sortName:sortName,  
			sortOrder:sortOrder,
			collapsible:true,
			singleSelect:singleSelect,//是否单选
			url:url,
			fitColumns:true, 	//充满整个datagrid
			remoteSort: false,
			//method: "get",
			idField:idfield,
			columns:columnArray,
			//pagination:isPage,
			rownumbers:true,
			//pageSize: 15,//每页显示的记录条数，默认为10  
			//pageList:[15,30,45,60,100],
			queryParams:queryParams,
			toolbar:btns,
		};
	if(!singleSelect){
		griddata.frozenColumns = [[{field:'ck',checkbox:true}]];//冻结勾选列在最前面
	}
	
	if(isPage){
		griddata.pagination = isPage;
		griddata.pageSize = 15,//每页显示的记录条数，默认为10
		griddata.pageList = [15,30,45,60,100];
	}
	
		if (isEdit) {
			griddata.onBeforeLoad = function () {
				$(this).datagrid('rejectChanges');
			};
			griddata.onDblClickCell = function (index, field, value) {
				var colOption = $(this).datagrid('getColumnOption', field);
				if (colOption.editor) {
					$(this).datagrid('beginEdit', index);
					lastIndex = index;
				}
				var ed = $(this).datagrid('getEditor', {index:index,field:field});
				if (ed!= null) {
					$(ed.target).focus();
					$(ed.target).blur(function() {
						$('#' + tableId).datagrid('endEdit', index);
					});
				}
			};
			griddata.onClickRow = function (rowIndex) {
				if(isLinkage){
					//getRowLink();
					eval("0,("+linkageMethod+"())");
				}
				editingIndex = rowIndex;
				if (lastIndex != rowIndex) {
					//不验证结束编辑
					$(this).datagrid('endEdit', lastIndex);
					lastIndex = rowIndex;
				}
			};
			griddata.onAfterEdit = function (rowIndex, rowData, chanages) {};
			griddata.onHeaderClickCell = function(e,field) {
					$(this).datagrid('endEdit', editingIndex);//单击标题行关闭编辑状态
			};
	}else{
		griddata.onClickRow = function (rowIndex) {
			if(isLinkage){
				//getRowLink();
				eval("0,("+linkageMethod+"())");
			}
		};
	}
		$('#'+tableId).datagrid(griddata);
		if (queryform != null) {
			formElements = queryform.formElements;
			successGrid = tableId;
			queryformid = queryform.id;
			var value = {};
			value.formElements = JSON.stringify(queryform.formElements);
			value.queryformid = queryform.id;
			createHiddenValue("query"+tableId, JSON.stringify(value));
			if (!queryform.lazy) {
				createForm(queryform.span, queryform.id,
						queryform.method, queryform.formElements,
						queryform.dataUrl, queryform.buttons[0].onClick,
						name,queryform.lazy,queryform.text,queryform.showText);
			} else {
				lazyQueryForm.push(queryform);
			}
		}
}
//扩展combogird
$.extend($.fn.datagrid.defaults.editors, {
    combogrid: {
        init: function (container, options) {
            var input = $('<input type="text" class="datagrid-editable-input">').appendTo(container);
            input.combogrid(options);
            return input;
        },
        destroy: function (target) {
            $(target).combogrid('destroy');
        },
        getValue: function (target) {
            return $(target).combogrid('getValue');
        },
        setValue: function (target, value) {
            $(target).combogrid('setValue', value);
        },
        resize: function (target, width) {
            $(target).combogrid('resize', width);
        }
    },
    combotree: {
        //初始化编辑器并返回目标对象
        init: function (container, target) {
            var input = $("<input type=\"text\">").appendTo(container);
            input.combotree(target);
            return input;
        },
        destroy: function (target) {
            $(target).combotree("destroy");
        },
        getValue: function (target) {
            return $(target).combotree("getText");
        },
        setValue: function (target, value) {
            $(target).combotree("setValue", value);
        },
        /*getText: function (target) {
            return $(target).combotree("getValue");
        },
        setText: function (target, value) {
            $(target).combotree("setValue", value);
        },*/
        resize: function (target, width) {
            $(target).combotree("resize", width);
        }
    }

});
