<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
</head>
<%@include file="/js/common.jsp"%>

<body id="cc" class="easyui-layout" style="width: 100%; height: 100%;">
	<script>
	$(function() {
		fixrownum('jsgrid');
		fixrownum('usergrid');
		fixrownum('yyyh');
		fixrownum('wyyh');
		createQueryLazyForm();
	});
		var opt = '<s:property value="opt"/>';
		
		function getRowLink() { //grid联动  
			var select = $('#jsgrid').datagrid('getSelected'); //点击grid触发
			gridreload('usergrid',{hql:"selectjs",jsid:select.id});
			gridreload('yyyh',{hql:"selectjs",jsid:select.id});
			gridreload('wyyh',{hql:"jsidfindnotyh",jsid:select.id});
		}

		function setTreeParam() {

		}

		function setGridParam() {
			//(1) 定义请求参数json,这里是根据后台的参数自由设置的
			var queryParam = {};
			queryParam.hql = "not";
			var queryParam2 = {};
			queryParam2.hqlid = "yyjs";
			//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
			var girdParamJson = {};
			girdParamJson.gridname = "jsgrid";
			girdParamJson.rqstparam = queryParam2;
			
			var girdParamJson1 = {};
			girdParamJson1.gridname = "usergrid";
			girdParamJson1.rqstparam = queryParam;

			//(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
			var gridRqstJson = [];
			gridRqstJson.push(girdParamJson);
			gridRqstJson.push(girdParamJson1);

			//(4) 最终例子形如 ：[{"gridname":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
			//alert(JSON.stringify(treeRqstJson)); 
			return gridRqstJson;

		}
		function deletejscy() { //删除当前角色的用户按钮方法
			var selectjs = $('#jsgrid').datagrid('getSelected');
			var selectyh = $('#usergrid').datagrid('getSelections');
			if (selectyh == null || selectyh.length == 0) { //没选中对象
				$.messager.alert('提示', '没有选中用户', "info");
				return;
			} else {
				$.messager.confirm('确认', '请确认删除',function(row) {
					if (row) {
						var rowlength = selectyh.length;
						for (var i = 0; i < rowlength; i++) {
							if (selectyh[i].id != null&& selectyh[i].id != "") {
								$.ajax({
									type : "POST",
									url : "jscyoperate!deletejscy.do",
									data : 'params={"jsid":'+ selectjs.id + ',"yhid":'+ selectyh[i].id + '}',
									success : function() {
										$('#usergrid').datagrid('reload'); //重新加载内容
									}
								});
							}
						}
					}
				})
			}
		}

		function jscyfp() { //分配角色按钮方法
			infoList();
			var rowDatas = $('#jsgrid').datagrid('getSelected');
			if (rowDatas == null) { //没选中对象
				$.messager.alert('提示', '没有选中角色', "info");
				return;
			} else {
				$('#yyyh').datagrid('reload'); //重新加载内容	
				$('#wyyh').datagrid('reload'); //重新加载内容
				infoDialogByMoreForm('fpyh', {
					title : '分配角色',
					width : 700,
					height : 500,
					resizable : true,
					closed : false,
					cache : false,
					modal : true,
					buttons : [ {
						text : '保存',
						handler : function() {
							//var yyyhJson = getGridChanges("yyyh","TXtJsYh"); //获取修改过的数据
							var select = $('#jsgrid').datagrid('getSelected');//获取选中的角色数据
							$.ajax({
								type : "POST",
								url : "jscyoperate!savefpyh.do",
								data : 'params={"yyyh":{"addlist":"'+addlist+'","deletelist":"'+deletelist+'"},"jsid":' + select.id + '}',
								success : function() {
									$('#fpyh').window('close');
									$.messager.alert("提示信息", "保存成功！");
									$('#usergrid').datagrid('reload'); //重新加载内容
								}
							});
						}
					} ]
				},new Array('wyyh_ff','yyyh_ff'));
			}
		}
		
		//双列选择器，清空数组
		function infoList(){
			deletelist = new Array();
			addlist = new Array();
			var options1 =  $("#yyyh").datagrid('options');
			var param1 = options1.queryParams.params;
			param1 = eval("(" + param1 + ")");
			var options2 =  $("#wyyh").datagrid('options');
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
		
		function setFormParam(){
			
		}
		
		//修复角色成员维护的分配角色dialog，查询后重置，不能重新load grid的问题
		function _searchById_yyyh() {
			_searchById('yyyh');
			
		}

		//修复角色成员维护的分配角色dialog，查询后重置，不能重新load grid的问题
		function _searchById_wyyh(){
			_searchById('wyyh');
		}
	</script>
	<div region="west" split="true" title="" style="width: 300px;">
		<table id="jsgrid"></table>
	</div>
	<div id="userRight" region="center" title="" split="true">
		<table id="usergrid"></table>
	</div>
	<div id="fpyh">
	     <div  class="easyui-layout" style="width:100%;height:100%;" fit="true" >	
	
	      <div region="north" split="true" title="" style="height:200px;">
	          <div  class="easyui-layout" style="width:100%;height:100%;" fit="true" >
	             	 <div region="west" split="true" title="" style="width:250px;">
	             	  <span id="yyyh_form"> </span>
	             	 </div>
	             	  <div region="center" split="true" title="分配用户角色">
	             	    <table id="yyyh"></table>
	             	  </div>
	          </div>
	      </div>
	      
	      
	      <div  region="center" split="true" title="" >
		      <div  class="easyui-layout" style="width:100%;height:100%;" fit="true" >
	             	 <div region="west" split="true" title="" style="width:250px;">
	             	 <span id="wyyh_form"> </span>
	             	 </div>
	             	  <div region="center" split="true" title="未分配用户角色">
	             	  <table id="wyyh"></table>
	             	  </div>
	          </div>
	     </div>

</div>
	
	
	
	
	
	
	<!-- <div id="cc" class="easyui-layout" style="width: 100%; height: 100%;" fit="true">
			<div region="north" title="分配用户角色" split="true" style="height: 200px;">
			
				<span id="yyyh_form"> </span>
				<table id="yyyh"></table>
			</div>
			<div region="center" title="未分配用户角色" split="true">
				<span id="wyyh_form"> </span>
				<table id="wyyh"></table>
			</div>
		</div>
		 -->	
	</div>
</body>
</html>
