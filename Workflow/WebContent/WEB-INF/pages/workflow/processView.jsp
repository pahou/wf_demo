<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="org.apache.struts2.ServletActionContext,java.util.*,com.gdth.util.Constants,com.gdth.sys.entity.TXtYh,java.net.URLEncoder"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>待办事项</title>
</head>
<%@include file="/js/common.jsp"%><!-- 必须引入commo -->
<body>
	<div id="diagram" class="easyui-panel" fit="true" title="abc">
		
	</div>
	<div  id="cc" class="easyui-layout" fit="true">
	<div id="qf_div" region="north" split="true" style="height: 170px;">
		<!-- <fieldset class="fieldset_nav">
			<legend>查询</legend> -->
		<span id="queryform"></span>
		<!-- </fieldset> -->
	</div>
	<div id="grid_div" region="center" split="true">
		<span id="taskGrid"></span>
	</div>
	</div>
	<script type="text/javascript"
		src="<%=basePath%>/js/activiti_operate.js"></script>
	<script>
		var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
		var showOrHide = true;
		var _userId = '<s:property value="userId"/>'
		;
		//使用了什么控件必须写一个相关的setParam方法
		function setGridParam() {
			var queryObject = new Object();
			queryObject.userId = '<s:property value="userId"/>';
			queryObject.systemName = '<s:property value="systemName"/>';
			queryObject.ccbh = '<s:property value="ccbh"/>';
			
			//(1) 定义请求参数json,这里是根据后台的参数自由设置的
			var queryParam = {};
			queryParam.queryObject = JSON.stringify(queryObject);
			
			//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
			var girdParamJson = {};
			girdParamJson.gridname = "taskGrid";
			girdParamJson.rqstparam = queryParam;
			
			//(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
			var gridRqstJson = [];
			gridRqstJson.push(girdParamJson);
			
			//(4) 最终例子形如 ：[{"gridname":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
			return gridRqstJson; 
		}
		function setFormParam() {
		}

		function assignToggle(tempValue) {
			$('#assign').linkbutton('enable');
			if (tempValue == true) {
				$('#assign').linkbutton({
					iconCls : 'icon-standard-basket-add',
					text : '业务受理'
				});
			} else if (tempValue == false) {
				$('#assign').linkbutton({
					iconCls : 'icon-standard-basket-delete',
					text : '取消受理'
				});
			} else if (tempValue == null) {
				$('#assign').linkbutton('disable');
			}
		}

		function doAssign() { //ajax向服务器请求变更状态
			var select_row = $('#taskGrid').datagrid('getSelected'); //获取该行对象
			if (select_row) {
				var select_index = $('#taskGrid').datagrid('getRowIndex',
						select_row); //获取该行的索引值
				$
						.ajax({
							async : false,
							type : "POST",
							url : "processOperate!changeAssign.do",
							data : 'params={"taskId":"' + select_row.taskId
									+ '","instanceId":"'
									+ select_row.instanceId + '"}',
							success : function(data) {
								if('error' in data){
									$.messager.alert('提示信息', data.error, "error");
								}else{
									//改变状态，然后format
									if (showOrHide == false) {
										showOrHide = true;
										select_row.identity = '未受理';
									} //操作前为已受理
									else if (showOrHide == true) {
										showOrHide = false;
										select_row.identity = '已受理';
									} //操作前为未受理
									assignToggle(showOrHide); //变更表格“业务受理”操作选项
									$('#taskGrid').datagrid('refreshRow',
											select_index); //刷新行,然而会附加取消选择状态
									$('#taskGrid').datagrid('selectRow',
											select_index); //重新选择
								}
							}
						});
			} else {
				$.messager.alert('提示信息', '请选择具体业务!', "error");
			}
		}
		
		$(function() {
			loadComboData();
			$('#taskGrid').datagrid({
				onSelect : function(rowIndex, rowData) {
					if (rowData.starterId == _userId) { //如果该行发起人与当前用户一致，则没有受理权限
						assignToggle(null);
					} else {
						if (rowData.identity == '已受理') {
							showOrHide = false;
						} else if (rowData.identity == '未受理') {
							showOrHide = true;
						}
						assignToggle(showOrHide);
					}
				},
			});

			$('#processKey').combobox({    
			    url:'processList!processCombo.do?systemName=<s:property value="systemName"/>'   
			});  
			assignToggle(null); //控制业务受理
			$('#diagram').parent().hide();
			//设置combo(日期，下拉框..)不可键盘输入
			$('.combo input').attr('readonly','readonly');
		});
	</script>
</body>
</html>