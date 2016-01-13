<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%@include file="/js/common.jsp"%>


<script>
function getObjIndex(rows, o) {
	for ( var i = 0, count = rows.length; i < count; i++) {
		if (rows[i] == o) {
			return i;
		}
	}
	return -1;
} 
$.extend($.fn.datagrid.methods, {
	editend : function(jq, index) {
		return jq.each(function() {
			var revert = false;
			
			var opts = $.data(this, "datagrid").options;
			var updatedRows = $.data(this, "datagrid").updatedRows;
			var insertedRows = $.data(this, "datagrid").insertedRows;
			var tr = opts.finder.getTr(this, index);
			var row = opts.finder.getRow(this, index);
			if (!revert) {
				/* if (!validateRow(this, index)) {
					return;
				} */
				var changed = false;
				var newValues = {};
				tr.find("div.datagrid-editable").each(function() {
					var field = $(this).parent().attr("field");
					var ed = $.data(this, "datagrid.editor");
					var value = ed.actions.getValue(ed.target);
					if (row[field] != value) {
						row[field] = value;
						changed = true;
						newValues[field] = value;
					}
				});
				changed = true;
				if (changed) {
					if (getObjIndex(insertedRows, row) == -1) {
						if (getObjIndex(updatedRows, row) == -1) {
							updatedRows.push(row);
						}
					}
				}
				
				function getObjectIndex(rows, o) {
					for ( var i = 0, count = rows.length; i < count; i++) {
						if (rows[i] == o) {
							return i;
						}
					}
					return -1;
				};
				
				tr.removeClass("datagrid-row-editing");
				destroyEditor(this, rowIndex);
				$(this).datagrid("refreshRow", index);
				if (!revert) {
					opts.onAfterEdit.call(this, index, row, newValues);
				} else {
					opts.onCancelEdit.call(this, index, row);
				}
				
			}
		});
	}
	
});

var opt = '<s:property value="opt"/>';


function setGridParam(){
	//(1) 定义请求参数json,这里是根据后台的参数自由设置的
	var queryParam = {};
	queryParam.yhid = id;
	
	//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个grid而定
	var girdParamJson = {};
	girdParamJson.gridname = "samplegrid";
	girdParamJson.rqstparam = queryParam;
	
	var girdParamJson2 = {};
	girdParamJson2.gridname = "sample2grid";
	girdParamJson2.rqstparam = queryParam;
	
	// (3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
	var gridRqstJson = [];
	gridRqstJson.push(girdParamJson);
	gridRqstJson.push(girdParamJson2);
	
	//(4) 最终例子形如 ：[{"gridname":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
	return gridRqstJson;
}

function setFormParam(){
	
}
function saveSample(){
	saveFormGrid('sampleYhOperate', new Array('samplegrid','sample2grid'), new Array('Sample','Sample2'), 'sampleYh!toTree.do', 'ff');
}
//显示Dialog
function showDialog(opt){
	//构造延迟显示的Form
	createLazyForm();
	//设置dialog格式
	$('#sample2dialogform').dialog({
		title: '修改角色 ',    
	    width: 400,    
	    height: 300,
	    resizable:true,
	    closed: false,    
	    cache: false,    
	    modal: true, 
	    buttons:[{
			text:'保存',
			handler:function() {
				//验证Form
				if($("#dialogff").form('validate')){
					if(opt=="add"){
						//判断是新增数据的直接显示
						addDialogToGrid();
					}else if(opt=="edit"){
						//编辑数据的要查询所选列
						var data = $('#sample2grid').datagrid('getSelected');
						var rowsIndex = $('#sample2grid').datagrid('getRowIndex',data);
						$('#sample2grid').datagrid('beginEdit', rowsIndex,false);
						//编辑数据的添加到Grid方法，参数是所选列的index
						addDialogToGrid(rowsIndex);
						//插入数据后要结束编辑，Grid才可以读取到
						$('#sample2grid').datagrid('editend', rowsIndex);
					}
	 	  		 }else{
	 	  			$.messager.alert('提示','信息不完整');   
	 	  		 }
	   			 }
			  }]
		  });    
}
//按钮方法入口，参数是add或edit
function DialogOTP(opt){
	if(opt=="edit"){
		var data = $('#sample2grid').datagrid('getSelected');
		if(data!=null){
			//显示dialog
			showDialog(opt);
			$('#dialogff').form('load', data);
		}else{
			$.messager.alert('提示', '没有选中数据');
			return;
		}
	}else if("add"){
		//显示dialog
		showDialog(opt);
	}
}
//将Form的数据添加到表格
function addDialogToGrid(rowsIndex){
	var targetJson = "";
	//遍历Form所有Input与textarea读取数据
	$("#dialogff input[name], #dialogff textarea").each(function(i, value) {
		var packJson = "";
		//因combo的value保存的是id
		//所以要先请求查询出名称
		//isNaN(value.value)是判断是否已经是数字，已经是ID就不用请求
		if(value.name == 'sampleBmmc'&&!isNaN(value.value)){
			$.ajax({
				async:false,
				type : "POST",
				url : "sampleYhOperate!getNameById.do",
				data : 'params={"id":' + value.value + '}',
				success : function(data) {
					packJson = "{\"" + value.name + "\":\"" + data.mc + "\"}";
				}
			});
		}
		//因combo的value保存的是id
		//所以要先请求查询出名称
		//isNaN(value.value)是判断是否已经是数字，已经是ID就不用请求
		else if(value.name == 'sampleBm3mc'&&!isNaN(value.value)){
			$.ajax({
				async:false,
				type : "POST",
				url : "sampleYhOperate!getNameById.do",
				data : 'params={"id":' + value.value + '}',
				success : function(data) {
					packJson = "{\"" + value.name + "\":\"" + data.mc + "\"}";
				}
			});
		}else{
			packJson = "{\"" + value.name + "\":\"" + value.value + "\"}";
		}
		if (targetJson == "") {
			targetJson = $.parseJSON(packJson);
		} else {
			targetJson = $.extend(targetJson, $.parseJSON(packJson));
		}
	});
	//没有参数rowsIndex的是新增列，直接在Gri新增一列
	if(rowsIndex==null){
		$('#sample2grid').datagrid('insertRow', {
			index : 0, // 索引从0开始
			row : targetJson
		});
	//有参数rowsIndex的是编辑列，通过index更新所选列数据
	}else{
		$('#sample2grid').datagrid('updateRow', {
			index : rowsIndex, // 索引从0开始
			row : targetJson
		});
	}
	//关闭dialog
	$('#sample2dialogform').dialog('close');
	//清空Form数据
	$('#dialogff').form('clear');
}
</script>
<body class="easyui-layout" style="width: 100%; height: 100%;"
	fit="true" oncontextmenu="return false" onselectstart="return false">
	<!--查询对话框  -->
	<div id = "sample2dialogform" style="height: 140px;overflow:hidden;" >
			<span id="dialogform"> </span>
	</div>
	
	<div id="userRight" region="center" split="true" title="">
		<div id="cc" class="easyui-layout" fit="true">
			<div region="north" split="true" title="" style="height: 150px;">
				<div class="toolbar">
					<a href="#" class="easyui-linkbutton" plain="true"
						iconCls="icon-save" id="btn" onClick="saveForm('ff','sampleYhOperate')">保存</a> <a
						href="#" class="easyui-linkbutton" plain="true"
						iconCls="icon-back" onClick="javascript:history.back(-1);">取消</a>
				</div>
				<span id="form"> </span>
			</div>
			<div region="center" split="true" title="">
				<div id="ccc" class="easyui-layout" fit="true">
					<div region="north" split="true" title="" style="height: 150px;">
						<table id="samplegrid"></table>
					</div>
					<div region="center" split="true" title="">
						<table id="sample2grid"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
