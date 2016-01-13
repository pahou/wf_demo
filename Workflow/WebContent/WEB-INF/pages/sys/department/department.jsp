<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
</head>
<%@include file="/js/common.jsp"%>
<style>
.tabs li{width:115px;}
.tabs li a.tabs-inner {width:90px;}
.tabs li.tabs-selected a.tabs-inner{width:90px;}  
</style>
<script>
var opt = '<s:property value="opt"/>';
var load = 0;
var oldbh;
$.extend($.fn.form.defaults, {
	onLoadSuccess : function(data) {
		oldbh = $("#bh").val();
		//禁用分配按钮
		document.getElementById("addrole").style.visibility="hidden";
		document.getElementById("removerole").style.visibility="hidden";
	}
}); 

$(function() {
	loadSelectRoot("departmenttree");
	fixrownum('yyjs');
	fixrownum('wyjs');
	noInput("ff"); //初始状态下不允许输入
	$('#can li').click(
			function() { //模块内容切换
				$(this).parent().find('li').removeClass('cur');
				$(this).addClass('cur');
				var index = $(this).parent().find('li').index(this); //获取当前元素的索引值  
				$(this).parents('#menu').find('#main').find('.fogo ')
						.removeClass('on').eq(index).addClass('on');
			});
	$('#bh').validatebox({    
	    required: true,    
	    validType: "remote['../validator/validator!bmbhValidator.do','validatorValue']"  ,
	    invalidMessage: '有重复账号，请重新填写' 
	}); 
	
	$('#bh').validatebox("disableValidation");
	//禁用分配按钮
	document.getElementById("addrole").style.visibility="hidden";
	document.getElementById("removerole").style.visibility="hidden";
});

function setTreeParam() {
	/* var queryParam = {};
	queryParam.treeload = "";
	
	var treeParamJson = {};
	treeParamJson.treename = "functiontree";
	treeParamJson.rqstparam = queryParam;
	
	var treeRqstJson = [];
	treeRqstJson.push(treeParamJson);
	
	return treeRqstJson;  */
}
function setFormParam() {

}

function setGridParam(){
 	//(1) 定义请求参数json,这里是根据后台的参数自由设置的
	var queryParam = {};
	queryParam.hqlid = "not";
	
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


function getLinkage() {//树联动方法
	$('#bh').validatebox("disableValidation");
	findnodedata("departmentform",id,"departmentOperate");
	gridreload('yyjs',{hqlid:"bmidfindjs",bmid:id});
	gridreload('wyjs',{hqlid:"bmidfindnotjs",bmid:id});
	checkTree('gxfwtree', id, 'departmentOperate');
	loadTree('functiontree',{loadparam:id});
}
//树保存的按钮ID
function getButtonId() {
	return 'btn';
}

	//保存部门所有数据
	function saveDepartment() {
		var newbh = $("#bh").val();
		if (newbh == oldbh) {
			$('#bh').validatebox("disableValidation");
		} else {
			$('#bh').validatebox("enableValidation");
		}
		if ($('#departmentform').form("validate")) {
			var checkid = gettreeCheck("gxfwtree");//得到勾选的Id数组
			var formGridJson = saveJSONForMat();//form的json数据
			//grid修改后的数据
			//var yyjsJson = getGridChanges("yyjs", "TXtJsBm");
			var select = $("#departmenttree").tree("getSelected");
			var fnode = $("#departmenttree").tree("getParent", select.target);
			var fid = "";
			if (fnode != null) {
				fid = fnode.id;
			}
			$.ajax({
				type : "POST",
				url : "departmentOperate!saveDepartment.do",
				data : 'params={"checkid":"' + checkid + '","yyjs":{"addlist":"'+addlist+'","deletelist":"'+deletelist+'"},"fid":"' + fid
						+ '","savedata":' + JSON.stringify(formGridJson) + '}',
				success : function() {
					$('#departmenttree').tree('reload'); //重置树节点
					$('#btn').linkbutton('disable');
					$.messager.alert("提示信息", "保存成功！","info",function(){
						//清空
						cleanTreeHidden("departmenttree");
						$('#bh').validatebox("disableValidation");
						//禁用分配按钮
						document.getElementById("addrole").style.visibility="hidden";
						document.getElementById("removerole").style.visibility="hidden";
					});
				}
			});
		}else{
			$.messager.alert('提示','信息填写有误');   
		}
	}

	function bmaddchild(treeId) { /* 【增加子节点】 */
		load = 1;
		$('#bh').validatebox("enableValidation");
		var nodeid = getHiddenValue(treeId + "nodeid");
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

		for (var i = 0; i < childnodes.length; i++) {
			if ((childnodes[i].id == nodeid)
					&& (childnodes[i].attributes == "newing")) {
				$('#' + treeId).tree('expand', node.target);
				$('#' + treeId).tree('select', childnodes[i].target);
				$('#' + $.parseJSON($("#" + treeId + "info").val())["formId"])
						.form('clear');
				changeState(treeId);
				break;
			}
		}
		setHiddenValue(treeId + "nodeid", nodeid);
		$('#fid').val(node.id);
		$('#fmc').val(node.text);
		//重新加载部门信息
		gridreload('yyjs', {
			hqlid : "not"
		});
		gridreload('wyjs', {
			bmid:0
		});
		loadTree('functiontree', '{loadparam:"0"}');
		uncheckTree("gxfwtree");
		//启用分配按钮
		document.getElementById("addrole").style.visibility="visible";
		document.getElementById("removerole").style.visibility="visible";
		//父部门不可编辑
		var fmc = document.getElementById("fmc");
		fmc.readOnly = true;
	}

	function addroot(treeId) { /* 【增加根节点】 */
		load = 1;
		$('#bh').validatebox("enableValidation");
		var nodeid = getHiddenValue(treeId + "nodeid");
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

		for (var i = 0; i < roots.length; i++) {
			if ((roots[i].id == nodeid) && (roots[i].attributes == "newing")) {
				$('#' + treeId).tree('select', roots[i].target);
				$('#' + $.parseJSON($("#" + treeId + "info").val())["formId"])
						.form('clear');
				changeState(treeId);
				break;
			}
		}
		setHiddenValue(treeId + "nodeid", nodeid);
		//重新加载部门信息
		gridreload('yyjs', {
			hqlid : "not"
		});
		gridreload('wyjs', {
			bmid:0
		});
		loadTree('functiontree', '{loadparam:"0"}');
		uncheckTree("gxfwtree");
		//启用分配按钮
		document.getElementById("addrole").style.visibility="visible";
		document.getElementById("removerole").style.visibility="visible";
		//父部门不可编辑
		var fmc = document.getElementById("fmc");
		fmc.readOnly = true;
	}

	function removenode(treeId) {
		$.messager.confirm('提示信息', '是否删除该节点？', function(r) {
			if (r) {
				var node = $('#' + treeId).tree('getSelected');
				// 选中父节点
				var parent = $('#' + treeId).tree('getParent', node.target);
				if (parent != null) {
					$.ajax({
						type : "POST",
						url : "departmentOperate!deleteById.do",
						data : 'params={"id":"' + id + '"}',
						success : function() {
							$('#departmenttree').tree('reload'); //重置树节点
							$('#btn').linkbutton('disable');
							$.messager.alert("提示信息", "删除成功！","info",function(){
								//清空
								cleanTreeHidden("departmenttree");
								//选中根节点
								var root = $('#departmenttree').tree("getRoot");
								$('#departmenttree').tree("select",root.target);
							});
						}
					});
				} else {
					$.messager.alert("提示信息", "该节点含有子节点，无法删除！");
				}
			}
		});
	}
	function editbmnode(treeId){
		editnode(treeId);
		//父部门不可编辑
		var fmc = document.getElementById("fmc");
		fmc.readOnly = true;
		document.getElementById("addrole").style.visibility="visible";
		document.getElementById("removerole").style.visibility="visible";
	}
</script>

<body id="cc" class="easyui-layout" style="width:100%;height:100%;" fit="true"  oncontextmenu="return false" onselectstart="return false">

	<div region="west" split="true" title="" style="width: 250px;">
		<ul id="departmenttree"></ul>
	</div>
	<div region="center" title="" split="true">
		<div class="easyui-layout"  fit="true">
			<div region="north" title="" split="true" style="height: 140px;">
			     <div class="toolbar">
			         <a  href="#" class="easyui-linkbutton" plain="true" iconCls="icon-save"  id="btn" onClick="saveDepartment()" disabled=true>保存</a>
		         </div> 
				<span id="form">
				 </span>
			</div>
			
			<div id="menu" region="east" iconCls="icon-reload" title="" split="true" style="width: 250px;">
                <div id="tt" class="easyui-tabs" style="height:250px;" fit="true">   
                 <div title="已有功能" >   
                    <ul id="functiontree"></ul>
                 </div>   
                 <div title="管辖范围"  >   
                     <ul id="gxfwtree"></ul> 
                 </div>   
             </div> 


			</div>
			<div region="center" title="" split="true">
				<div class="easyui-layout" fit="true">
					<div region="north" title="部门已分配角色" split="true" style="height: 200px;">
						<table id="yyjs"></table>
					</div>
					<div region="center" title="部门未分配角色" split="true">
						<table id="wyjs"></table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
