<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%--  <% String contextPath = request.getContextPath();%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@include file="/js/common.jsp"%>
<title>查看流程图</title>
</head>
<body>
	<div  id="cc" class="easyui-layout" fit="true">
		<div id="tteast" region="east" split="true" collapsed ="false"  collapsible="true" style="width:500px;">
			<div  id="cc2" class="easyui-layout" fit="true">
				<div id="ttnorth" region="north" split="true"  style="height:300px;">
					<table id="processgrid"></table>
				</div>
				<div region="center">
					<table id="catgrid"></table>
				</div>
			</div>
		</div>
		<div region="center">
			<img id="image" alt="显示图片" split="true" src="" style="padding: 10px;"></img>
		</div>
	</div>
</body>
<script type="text/javascript">
		var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
		var processInstanceId = '<s:property value="processInstanceId"/>';
		var processDefinitionId = '<s:property value="processDefinitionId"/>'
		//alert(processDefinitionId);
		var processType = '<s:property value="processType"/>';
		function setGridParam() {
			
		}
		$(function() {
			initPageTitle();
			var url = 'processInstanceId='+processInstanceId;
			if(processType==0){
				url = 'processInstanceId='+processInstanceId;
			}else if(processType==1){
				url = 'processDefinitionId='+processDefinitionId;
			}
			var src = 'processList!showDiagram.do?' + url;
			$('#image').attr("src", src);
			 $('#processgrid').datagrid({
				url : 'processList!getProcessComments.do?processInstanceId='+processInstanceId
			});
			$('#catgrid').datagrid({
				url : 'processList!getCats.do?processDefinitionId='+processDefinitionId+'&processInstanceId='+processInstanceId
			});
		});
		
	</script>
</html>