<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--  <% String contextPath = request.getContextPath();%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<title>功能菜单</title>
<%@include file="/js/common.jsp"%>

<script>
$(function() {
	loadSelectRoot("tt");
});

</script>
</head>
<style>

</style>
<body class="easyui-layout">
	<span id='menu'></span>
	<div id="userLeft" region="west" title="" style="width: 200px;">
		<ul id="tt"></ul>
	</div>
	<div id="userRight" region="center" title="">
		<fieldset class="fieldset_nav">
			<legend>功能菜单查询</legend>
			<span id="form"> </span>
		</fieldset>
		<div class="clear_nav"></div>
		<!-- 1为角色ID现在写死可以通过事件触发的，也可以是当前用户的ID或者点击修改是保存的一个参数 ，可以是JSON也可以是值，看后台需要什么来传值-->
  
  
        
		<!-- 公用form开始 -->
	    
	  <!-- 查询form开始 -->
	  <div> 查询form模板  </div>
	     <fieldset class="fieldset_nav">
			<legend>功能菜单</legend>
			<span id=""> 
			     <form  id="ff" class="searchfrm">
			         <div>
			            <label for=""> <nobr>名称名称名称</nobr></label>
			            <input type="text"  id="" value="" maxlength="" name="">
			         </div>
			         <div>
			            <label for=""><nobr>功能类别</nobr></label>
			            <input type="text"  id="" value="" maxlength="" comboname="">
			            <span class="combo" >
			               <input type="text" autocomplete="off" >
			                     <span>
			                        <span  ></span>
			                     </span>
			                     <input type="hidden"  name="" value="">
			                     </span>
			          </div>
			          <div>
			             <label for=""><nobr>功能链接</nobr></label>
			             <input type="text"  id="" value="" maxlength="" name="">
			          </div>
			          <div>
			             <label for=""><nobr>图&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp标</nobr></label>
			             <input type="text"  id="" value="" maxlength="" name="">
			          </div>
			          <div>
			             <label for=""><nobr>描述</nobr></label>
			             <input type="text"  id="" value="" maxlength="" name="ms">
			          </div>
			       </form>
			       <div id="brbtn">
			            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="" >查询</a>
			            <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-undo'" onclick="" >重置</a>
			          </div>
			  </span>
		</fieldset>
	
	
	  <!-- 修改公用form开始 -->
	    <div> 修改form模板  </div>
	    <span id=""> 
	             <div class="toolbar">
			         <a  href="#" class="easyui-linkbutton" plain="true" iconCls="icon-save">保存</a>
			         <a  href="#" class="easyui-linkbutton" plain="true" iconCls="icon-back" onClick="javascript:history.back(-1);">取消</a>
		         </div>
			     <form  id="ff" class="changefrm">
			         <div>
			            <label for=""> <nobr>名称名称名称</nobr></label>
			            <input type="text"  class="text-1" id="" value="" maxlength="" name="">
			         </div>
			         <div>
			            <label for=""><nobr>功能类别</nobr></label>
			            <input type="text" style=" display: none;" class="text-1" id="" value="" maxlength="" comboname="">
			            <span class="combo" >
			               <input type="text" autocomplete="off" class="combo-text">
			                     <span>
			                        <span class="combo-arrow" ></span>
			                     </span>
			                     <input type="hidden" class="combo-value" name="" value="">
			                     </span>
			          </div>
			          <div>
			             <label for=""><nobr>功能链接</nobr></label>
			             <input type="text"  class="text-1" id="" value="" maxlength="" name="">
			          </div>
			          <div>
			             <label for=""><nobr>图&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp标</nobr></label>
			             <input type="text"  class="text-1" id="" value="" maxlength="" name="">
			          </div>
			          <div>
			             <label for=""><nobr>描述</nobr></label>
			             <input type="text"  class="text-1" id="" value="" maxlength="" name="ms">
			          </div>
			       </form>
			  </span>
	
	<!-- 公用form结束 -->
		
	</div>
	
	
	
	
	
	<script type="text/javascript">
		function setTreeParam() {

			//(1) 定义请求参数json,这里是根据后台的参数自由设置的
			var queryParam = {};
			queryParam.jsId = 1;

			//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
			var treeParamJson = {};
			treeParamJson.treename = "tt"; // 这里是tree名称 ，对应
			treeParamJson.rqstparam = queryParam;

			//(3) 公共 js要用的，定义数组 格式为 ： [{"treename":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
			var treeRqstJson = [];
			treeRqstJson.push(treeParamJson);

			//(4) 最终例子形如 ：[{"treename":"tt","rqstparam":{"jsId":1,"jsId2":2}}]
			return treeRqstJson;
		}
		function setFormParam() {
		}

		function getLinkage() {
			var linkageparam = [];
			var formLinkage = {};
			formLinkage.tt = findnodedata("ff", id, "gncdOperate");
			linkageparam.push(formLinkage);
			return linkageparam;
		}

		function getButtonId() {
			return 'btn';
		}
/***
		$(function() {
			$("#ff").addClass("searchfrm easyui-form");//附加查询样式
			noInput(); //初始状态下不允许输入

			$('#lb').combobox({
				url : '../../combox_data.json', //目录受保护，置于WebRoot下
				valueField : 'id',
				textField : 'text',
				width : 200
			});
		});
		***/
	</script>
</body>
</html>