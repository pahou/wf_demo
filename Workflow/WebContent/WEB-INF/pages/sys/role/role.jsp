<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
</head>
<%@include file="/js/common.jsp"%>
<script type="text/javascript">
var opt = '<s:property value="opt"/>';
$(function() {
	fixrownum('yyjs');
	createLazyForm();
});

	function setTreeParam() {
	}
	function setFormParam() {
	}
	function setGridParam(){

		//(1) 定义请求参数json,这里是根据后台的参数自由设置的
		var queryParam = {};
		queryParam.hqlid = "yyjs";
		
		//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
		var girdParamJson = {};
		girdParamJson.gridname = "yyjs";
		girdParamJson.rqstparam = queryParam;
		
		 //(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
		var gridRqstJson = [];
		gridRqstJson.push(girdParamJson);
	
		
		//(4) 最终例子形如 ：[{"gridname":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
		//alert(JSON.stringify(treeRqstJson)); 
		return gridRqstJson;
	}

	function getRowLink() {//grid与树联动
		var select = $('#yyjs').datagrid('getSelected');
		checkCascadeTree('tt',select.id, 'roleOperate');
	}
	
	function addjs(){//增加角色dialog
		$('#df').form('clear');
		infoDialog('add', {
			title: '增加角色 ',    
		    width: 400,    
		    height: 300,
		    resizable:true,
		    closed: false,    
		    cache: false,    
		    modal: true, 
		    buttons:[{
				text:'保存',
				handler:function() {
					if($("#df").form('validate')){
					var formGridJson = saveJSONForMat();
						$.ajax({
							type : "POST",
							url : "roleOperate!saveyyjs.do",
							data:'params='+JSON.stringify(formGridJson),
							success : function() {
								$.messager.alert("提示信息","保存成功！");
								$('#add').dialog('close');
								$('#yyjs').datagrid('reload');
							}
						});
					 }else{
			 	  			$.messager.alert('提示','信息不完整');   
			 	  		 }
				}
			}]
		},'df');

	}
	function editjs(){//修改角色dialog
		var data=$('#yyjs').datagrid('getSelected');
		$('#df').form('load',data); 
		if(data==null){
			$.messager.alert('提示', '没有选中用户');
			return;
		}else{
			infoDialog('add', {
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
						if($("#df").form('validate')){
							var formGridJson = saveJSONForMat();
									$.ajax({
										type : "POST",
										url : "roleOperate!saveyyjs.do",
										data:'params='+JSON.stringify(formGridJson),
										success : function() {
											$.messager.alert("提示信息","保存成功！");
											$('#add').dialog('close');
											$('#yyjs').datagrid('reload');
											}
										});
					 	  		 }else{
					 	  			$.messager.alert('提示','信息不完整');   
					 	  		 }
			   			 }
					  }]
				  }, 'df');
	    	}
    	 }
	
	
	
	function saveJsGn(){//保存勾选树 
		var checkid = gettreeCheck("tt");//得到勾选的Id数组
		var row = $("#yyjs").datagrid('getSelected');
		$.ajax({
			type : "POST",
			url : "roleOperate!saveJsGn.do",
			data:'params={"checkid":"'+checkid +'","idfieldvalue":"'+row.id+'"}',
			success : function() {
				$.messager.alert("提示信息","保存成功！");
			}
			
		});
	
	}
	
</script>

<body class="easyui-layout" style="width:100%;height:100%;" fit="true">

	<span id='menu'></span>
	<!--左侧  -->

	<div  region="center" split="true" title="" >
	   <div id="cc" class="easyui-layout" fit="true" >
	        <div region="north"  title="" split="true" style="height: 73px; overflow:hidden;">
				     <span id="queryform"> </span>
		    </div>
		    <div region="center" split="true">
				<table id="yyjs"></table>
			</div>
	    </div>
	</div>  

	<!--查询对话框  -->
	<div id = "add" style="height: 140px;overflow:hidden;" >
				<span id="dialogform"> </span>
	</div>
	
	<!--右侧 -->
	<div region="east" title="" split="true"  style="width: 400px;">
		<ul id="tt"></ul>
	</div>
	
</body>
</html>
