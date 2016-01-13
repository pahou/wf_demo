<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工作流人员配置页面</title>
<%@include file="/js/common.jsp"%><!-- 必须引入commo -->
<style>
	#panelType{position:absolute;top:4px;right:0;width:180px;z-index:10000;}
	.exist{color:gray;}
	.search-form{width:100%;height:33px;}
	.search-field{width:40%;height:33px;line-height:33px;float:left;overflow:hidden;}
	.search-toolbar, .search-lable, .search-box{float:left;}
	.search-lable{width:20%;text-align:center;}
	.search-box{width:76%;margin:5.5px auto;}
	.search-input{width:80%;height:20px;line-height:20px;}
	.search-toolbar{width:18%;margin:4px auto;}
	.processConfig{
		line-height:9px;
		border:1px solid #dddddd;
    	width:35%;
    	max-width:66px;
    	height:25px;
    	cursor:pointer;
    	background-color:#0092dc;
    	color:#fff;
    	font-weight:bold;
    	font-size:12px;
	}
	.processConfig:hover{background-color:red;}
	.combo-text{width:45px;}
</style>
</head>
<body class="easyui-layout">
	<div region="center">
		<div id="panel-table" class="easyui-panel" fit="true" title="角色">
			<div id="panel-grid" class="easyui-layout" fit="true">
				<div region="center">
					<table id="widget-table"></table>
				</div>
			</div>
		</div>
		<div id="panel-tree" class="easyui-panel" fit="true" title="部门"><ul id="dep"></ul><span id="tree_menu"></span></div>
		<div id="panelType"><div style="width:100%;height:100%;">请选择配置类型：<input id="cc" /></div></div>
	</div>
	<div region="west" style="width:350px;"><table id="group"></table></div>
	<div class="search-form" style="display:none;">
		<div class="search-field">
			<div class="search-lable">账号：</div>
			<div class="search-box"><input class="search-input"/></div>
		</div>
		<div class="search-field">
			<div class="search-lable">编号：</div>
			<div class="search-box"><input class="search-input"/></div>
		</div>
		<div class="search-field">
			<div class="search-lable">名称：</div>
			<div class="search-box"><input class="search-input"/></div>
		</div>
		<div class="search-field">
			<div class="search-lable">备注：</div>
			<div class="search-box"><input class="search-input"/></div>
		</div>
		<div class="search-toolbar">
		<div style="display:block; width:0; height:0; overflow:hidden;"><button onclick="quickSearch();">IE8回车触发后续button</button></div>
			<button onclick="resetsf();" class="processConfig">重置</button>
			<button onclick="quickSearch();" class="processConfig"  style="margin-left:15px;">查询</button>
		</div>
	</div>
	<script>
	var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
	
	var procKey = '<s:property value="procKey"/>';
	var taskDefKey = '<s:property value="taskDefKey"/>';
	var _taskDefKeyId = '<s:property value="taskDefKeyId"/>';
	
	//alert(_taskDefKeyId);
	var count = 0;
	var $grid = $('#widget-table');
	var isSearch = false;
	var typeAry = null;
	
	var groupdata = {};
		groupdata.add = [];
		groupdata.del = [];
		groupdata.taskdefconId = _taskDefKeyId;  //taskDefConId;
	
	function setFormParam(){}
	function setTreeParam(){
		var queryParam = {};
			queryParam.type = 'dep';
			
		var treeParamJson = {};
			treeParamJson.tree = 'dep';
			treeParamJson.rqsrparam = queryParam;
			
		var treeRqstJson = [];
			treeRqstJson.push(treeParamJson);
			
		return treeRqstJson;
	}
	
	function setGridParam(){
		//(1) 定义请求参数json,这里是根据后台的参数自由设置的
		var queryParam = {};
			queryParam.hqlinfo = "";
			queryParam.taskDefConId = _taskDefKeyId;
		
		var queryParam1 = {};
			queryParam1.type = 'role';
			queryParam1.taskdefconId = _taskDefKeyId;

		//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
		var girdParamJson = {};
		girdParamJson.gridname = "group";
		girdParamJson.rqstparam = queryParam;
		
		var girdParamJson2 = {};
		girdParamJson2.gridname = "widget-table";
		girdParamJson2.rqstparam = queryParam1;
		
		//(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
		var gridRqstJson = [];
		gridRqstJson.push(girdParamJson);
		gridRqstJson.push(girdParamJson2);
		
		//(4) 最终例子形如 ：[{"gridname":"tt","restparam":{"jsId":1,"jsId2":2}}]
		//alert(JSON.stringify(treeRqstJson)); 
		return gridRqstJson;
	}

	$(function(){
		//$('#panelType').css({height:$('ul.tabs').height()});
		$('#cc').combobox({    
			//height:$('ul.tabs').height()-3,
			height:20,
			width:66,
			panelWidth:66,
		    valueField:'id',    
		    textField:'text',
		    data:[{    
		        "id":'role',    
		        "text":"角色",    
		        "selected":true  
		    },{    
		        "id":'user',    
		        "text":"用户"   
		    },{    
		        "id":'dep',    
		        "text":"部门"   
		    },{    
		        "id":'job',
		        "text":"职能"   
		    },{    
		        "id":'other',    
		        "text":"其他"   
		    }],
		    onSelect:function(record){
		    	$('#panel-table').panel('setTitle',record.text);
		    	if(record.id == 'dep'){
		    		var treeParam = {type:'dep',taskdefconId: _taskDefKeyId};
		    		$('#dep').tree({url:'processList!getConfigData.do?params='+JSON.stringify(treeParam)});
		    		$('#panel-table').panel('panel').toggle('slow');
		    		$('#panel-tree').panel('panel').show(600);
		    	}else{
		    		//$('#panel-tree').panel('panel').hide();
		    		loadSelect(record.id);
		    		//$grid.datagrid({url:'processList!getConfigData.do'});
		    		$('#panel-table').panel('panel').slideDown('slow');
		    		constructSearchForm(record.id);
		    	}
		    }
		});
		
		/* $grid.datagrid({
			onLoadSuccess:function(data){
				var searchRow = {id:'',name:''};
				addSearchRow(searchRow);
			}
		}); */
	});
	
	function constructSearchForm(type){
		function csf(ary){
			if($('div.note').length > 0){
			$('div.note').find('div.search-field')
						.hide().end()
						.find('div.search-field:eq('+ary[0]+')')
						.show().end()
						.find('div.search-field:eq('+ary[1]+')')
						.show();
			}
			typeAry = ary;
		}
		switch(type){
			case 'user':csf([0,2]);break;
			case 'role':csf([2,3]);break;
			case 'job' :csf([1,2]);break;
			default	   :
		}
	}
	
	function loadSelect(select){
		var tempParam = eval("(" +$grid.datagrid('options').queryParams.params+")");
		tempParam.type = select;
		tempParam.taskdefconId = _taskDefKeyId;
		$grid.datagrid('options').queryParams.params = JSON.stringify(tempParam);
		$grid.datagrid('load');
	}
	
	function addToGroup(gridId){
		//var grid = $('#'+gridId);
		var rows = $grid.datagrid('getChecked');
		//alert(rows.length+'---'+gridId);
		for(var i=0;i<rows.length;i){	//这里有个问题，rows.length是随动的，也就是说，如果带有移除操作，那么长度会缩减，然而，如果i依旧自增，则实际操作的行只有当初选择的一半。如果，每次操作，都是数组中的第一个，因此i不必自增，即可保持操作正确
			//alert(JSON.stringify(rows[i])+"=="+rows.length);
			var index = $grid.datagrid('getRowIndex',rows[i].id);
			var comboValue = $('#cc').combobox('getValue') == 'user'?'user':'group';
			var thisId = null;
			switch($('#cc').combobox('getValue')){
			case 'user':thisId = rows[i].id;break;
			case 'role':thisId = 'js'+rows[i].id;break;
			case 'job' :thisId = 'zn'+rows[i].id;break;
			default	   :
			}
			$('#group').datagrid('insertRow',{index:0,row:{'conMc':rows[i].name,'conName':comboValue,'id':thisId,'isNew':'new'}});
			$grid.datagrid('deleteRow',index);
			count++;
		}
	}
	
	function delGroup(){	//移出权限组 
		var rows = $('#group').datagrid('getChecked');
		for(var i=0;i<rows.length;i){	//这里有个问题，rows.length是随动的，也就是说，如果带有移除操作，那么长度会缩减，然而，如果i依旧自增，则实际操作的行只有当初选择的一半。如果，每次操作，都是数组中的第一个，因此i不必自增，即可保持操作正确
			if(rows[i].isNew != 'new'){ groupdata.del.push(rows[i].id); }
			else{
				count--;
			}
			var index = $('#group').datagrid('getRowIndex',rows[i]);	//索引值
			$('#group').datagrid('deleteRow',index);	//删除行
		}
	}
	
	function toStart(){
		$('#group').datagrid('load');
		if($('#cc').combobox('getValue') == 'dep'){$('#dep').tree('reload');}
			else{$grid.datagrid('load');}
	}
	
	function toSearchRole(){
		/* var searchRow = {id:'',name:''};
		isSearch = true;
		addSearchRow(searchRow); */
		var contents = $('div.search-form').clone().addClass('note');
		$(contents).find('input').each(function(i){$(this).attr('id','field'+i);});
		if(!isSearch){
			$('#panel-grid').layout('add',{
				region:'north',
				content:contents,
				height:35
			});
			constructSearchForm($('#cc').combobox('getValue'));
			$('div.note').removeAttr('style');
			isSearch = true;
		}else{
			$('#panel-grid').layout('remove','north');
			isSearch = false;
		}
	}
	
	function resetsf(){
		$('.search-input').val('');
	}
	
	function quickSearch(){
		var temp = [];
			temp.push({id : $('#field'+typeAry[0]).val(),name : $('#field'+typeAry[1]).val()});
		var tempParam = eval("(" +$grid.datagrid('options').queryParams.params+")");
			tempParam.type = $('#cc').combobox('getValue');
			tempParam.temp = temp;
			$grid.datagrid('options').queryParams.params = JSON.stringify(tempParam);
			$grid.datagrid('load');
	}
	
	function saveChange(){
		//alert(count);
		if(count > 0){
			for(var i=0;i<count;i++){
				$('#group').datagrid('selectRow',i);
				var row = $('#group').datagrid('getSelected');
				if(row.isNew != ""){
					var addjson = {
						"conMc"	   :	row.conMc,
						"conName"  :	row.conName,
						"conValue" :	row.id
					};
					groupdata.add.push(addjson);
				}
				$('#group').datagrid('unselectAll');
			}
		}
		//alert(JSON.stringify(groupdata));
		$.ajax({
			type : "POST",
			url : "processOperate!saveConfig.do",
			data : "params="+JSON.stringify(groupdata),
			//error:function(){alert(0);},
			cache: false,
			success : function(data){
				//alert(0);
				alert('保存成功！');
				groupdata.add = [];	//重置
				groupdata.del = [];
				$('#group').datagrid('reload');
				count=0;
			}
		});
	}
	
	
	$(function(){
		//$('#cc').combobox('select','department');
		$('#group').datagrid({
			onCheck:function(rowIndex,rowData){
				
			},
			rowStyler: function(index,row){
				if(row.isNew == 'new'){
					return "color:#c1c1c1;";
				}
				/* if(row.conName == 'group'){
					for(var i=0;i<roledata.data.length;i++){
						if(roledata.data[i].id == row.id){
							return "color:#c1c1c1;";
							break;
						}else{
							continue;
						}
					}
				}
				if(row.conName == 'user'){
					for(var i=0;i<userdata.data.length;i++){
						if(userdata.data[i].id == row.id){
							return "color:#c1c1c1;";
							break;
						}else{
							continue;
						}
					}
				} */
			}
		});
		
		$grid.datagrid({
			onSelect:function(rowIndex,rowData){
				//alert(rowData.id);
			},
			onLoadSuccess:function(data){
				var fields = ['zh','bh','name','bz'];
				for(var i=0;i<4;i++){
					$grid.datagrid('hideColumn',fields[i]);
				}
				if(typeAry != null){
					$.each(typeAry,function(index){
						$grid.datagrid('showColumn',fields[this]);
					});
				}else{
					$.each([2,3],function(index){
						$grid.datagrid('showColumn',fields[this]);
					});
				}
			}
		});
		
		$('#dep').tree({
			
			formatter:function(node){
				if(typeof node.attributes != 'undefined' && node.attributes == 'exists')
					return "<span class=\"exist\">"+node.text+"</span>";
					else return node.text;
			}, 
			onDblClick:function(node){
				//if($('#dep').tree('isLeaf',node.target)){
				//alert(node.attributes);
				if(node.attributes != 'exists'){
					$('#group').datagrid('insertRow',{index:0,row:{'conMc':node.text,'conName':'group','id':node.id,'isNew':'new'}});
					$('#dep').tree('update', {
						target: node.target,
						attributes: 'exists'
					});
					count++;
				}
				//}
			}
		});
	});
	</script>
</body>
</html>