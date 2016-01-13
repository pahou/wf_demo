<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/js/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>流程示例图概况</title>
<script type="text/javascript">
var opt = '<s:property value="opt"/>';
function setGridParam() {
	//(1) 定义请求参数json,这里是根据后台的参数自由设置的
	var queryParam = {};
	queryParam.procKey = '<s:property value="procKey"/>';
	queryParam.processInstanceId = '<s:property value="processInstanceId"/>';
	
	//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
	var girdParamJson = {};
	girdParamJson.gridname = "grid";
	girdParamJson.rqstparam = queryParam;
	
	
	//(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
	var gridRqstJson = [];
	gridRqstJson.push(girdParamJson);
	
	//(4) 最终例子形如 ：[{"gridname":"tt","restparam":{"jsId":1,"jsId2":2}}]
	//alert(JSON.stringify(treeRqstJson)); 
	return gridRqstJson;
}

$(function(){
	$('#grid').datagrid({
		onClickRow:function(rowIndex, rowData){
			var title = "选定下一任务办理人:"+rowData.name;
			parent.$('#choiceBox').dialog('setTitle',title)
			parent.setNextAssignee(rowData.id);
		}
	})
})

function cancel(){
	parent.$('#choiceBox').dialog('setTitle',"选定下一任务办理人")
	parent.setNextAssignee(null);
}
</script>
</head>
<body class="easyui-layout">
	<div region="center" fit="true" title="">
		<table id="grid"></table>
	</div>
</body>
</html>