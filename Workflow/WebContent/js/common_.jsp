<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
String contextPath = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/css/public.css">
<link  class="easyuichange" rel="stylesheet" href="<%=contextPath %>/js/easyui1.3.4/themes/gray/easyui.css" type="text/css"></link>
<script type="text/javascript" src="<%=contextPath %>/js/jquery-1.7.2.min.js"></script> 
<script type="text/javascript" src="<%=contextPath %>/js/dynamicLoad.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/easyui1.3.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/easyui1.3.4/locale/easyui-lang-zh_CN.js"></script> 
<script type="text/javascript" src="<%=contextPath %>/js/form.js"></script>
 <script type="text/javascript" src="<%=contextPath %>/js/easy-grid.js"></script> 
<script type="text/javascript" src="<%=contextPath %>/js/easy-form.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/easy-toolbar.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/easy-dialogForm.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/easy-dialogQueryForm.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/FormGridForMat.js"></script> 
<script type="text/javascript" src="<%=contextPath %>/js/gridoperate.js"></script> 
<script type="text/javascript" src="<%=contextPath %>/js/formoperate.js"></script> 
<script type="text/javascript" src="<%=contextPath %>/js/easy-tree.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/treeoperate.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/queryformoperate.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/datecompare.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/datetimecompare.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/formatteroperate.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/fixRownumber.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/validateType.js"></script>
<!-- 图标选择器  -->
<link href="<%=contextPath %>/js/easyui1.3.4/icons/icons/icon-all.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath %>/js/easyui1.3.4/icons/jeasyui-extensions/jeasyui.extensions.css" rel="stylesheet" type="text/css" />
<!-- easyui控件扩展 -->
<%-- <script type="text/javascript" src="<%=contextPath %>/js/extends.combo.js"></script> 
 --%><!-- 换肤引入cookie插件  -->
<script type="text/javascript" src="<%=contextPath %>/js/easyui1.3.4/jquery.cookie.js"></script>
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/js/easyui1.3.4/themes/icon.css">

</head>

<%@taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript">



var id = '<s:property value="id"/>';
var rqstMethod = '<s:property value="rqstMethod"/>';
var currentModuleName = '<s:property value="currentModuleName"/>';
var currentFunctionName = '<s:property value="currentFunctionName"/>';
var saveformid = "";
var lazyForm = [];
var lazyQueryForm = [];
var lastIndex;
 $(function(){
	 var hasGrid = '<s:property value="hasGrid"/>';
	 var hasForm = '<s:property value="hasForm"/>';
	 var hasTree = '<s:property value="hasTree"/>';
	 var hasToolBar = '<s:property value="hasToolBar"/>';
	if ("true" == hasTree) {
			var treesInfo = '<s:property value="treesInfo" escapeHtml="false" escapeJavaScript="true"/>';
			var treesjson = eval("(" + treesInfo + ")");
			for (var i = 0; i < treesjson.length; i++) {
				var name = treesjson[i].name;
				var url = treesjson[i].url;
				var checkbox = Boolean(treesjson[i].checkbox);
				var dnd = Boolean(treesjson[i].dnd);
				var onContextMenu = treesjson[i].onContextMenu;
				var click = treesjson[i].click;
				var multisave = treesjson[i].multisave;
				var cascadeCheck = treesjson[i].cascadeCheck;
				var savePro = treesjson[i].savePro;
				var treeIsLinkage = treesjson[i].linkage;
				var treeLinkageMethod = treesjson[i].linkageMethod;
				var textField = "";
				var sortField = "";
				var recursionField = "";
 				var formId = "";
				var operateAction = "";
				if(savePro!=null&&savePro!=""){
					textField = savePro.textField;
					sortField = savePro.sortField;
					recursionField = savePro.recursionField;
					formId = savePro.formId;
					operateAction = savePro.operateAction;
					//保存树的info值
					createHiddenInfo(name, '{'+'"textField":"'+textField+'","sortField":"'+sortField+'","recursionField":"'+recursionField+'","formId":"'+formId+'","operateAction":"'+operateAction+'"}');
				}
				createTreeHidden(name);//创建树隐藏属性
				if (onContextMenu != null && onContextMenu != "") {
					createTree(name, url, checkbox, dnd, click, multisave, cascadeCheck,
							textField, sortField, recursionField, formId, operateAction, onContextMenu.span, onContextMenu.menuId,
							onContextMenu.menuItems,treeIsLinkage,treeLinkageMethod);
				} else {
					createTree(name, url, checkbox, dnd, click, multisave, cascadeCheck,
							textField, sortField, recursionField, formId, operateAction, null, null, null,treeIsLinkage,treeLinkageMethod);
				}
			}
		}

		if ("true" == hasGrid) {

			var gridsInfo = '<s:property value="gridsInfo" escapeHtml="false" escapeJavaScript="true"/>';
			var gridjson = eval("(" + gridsInfo + ")");
			for (var i = 0; i < gridjson.length; i++) {
				var name = gridjson[i].name;
				var url = gridjson[i].url;
				var isPage = gridjson[i].page;
				var columns = gridjson[i].columns;
				var idField = gridjson[i].idField;
				var btnInfo = gridjson[i].toolBarVo.buttons;
				var isLazyShowToolbar = gridjson[i].toolBarVo.lazyShow;
				var isEdit = Boolean(gridjson[i].isEdit);
				var sortOrder = gridjson[i].sortOrder;
				var queryform = gridjson[i].queryForm;
				var isLinkage = gridjson[i].linkage;
				var singleSelect = gridjson[i].singleSelect;
				var sortName = gridjson[i].sortName;
				var linkageMethod = gridjson[i].linkageMethod;
				createGrid(name, url, isPage, columns, idField, rqstMethod,
						btnInfo, isEdit, sortOrder, isLinkage, singleSelect, queryform,isLazyShowToolbar,sortName, linkageMethod);
			}
		}

		if ("true" == hasForm) {
			//form的加载函数
			var formsInfo = '<s:property value="formsInfo" escapeHtml="false" escapeJavaScript="true"/>';
			var fjson = eval("(" + formsInfo + ")");
			for (var i = 0; i < fjson.length; i++) {
				var lazy = fjson[i].lazy;
				var fields = fjson[i].formElements;
				var fid = fjson[i].id;
				if (!lazy) {
					var span = fjson[i].span;
					saveformid = fid;
					var dataUrl = fjson[i].dataUrl;
					var method = fjson[i].method;
					var lazy = fjson[i].lazy;
					var text = fjson[i].text;
					//var root = fjson[i].root;
					createHiddenInfo(fid, JSON.stringify(fields));
					createForm(span, fid, method, fields, dataUrl,null,null,lazy,text);
					$("#"+span).addClass("form_span");
					//createForm(span, fid, method, fields, dataUrl,null,null,lazy,root);
				} else {
					createHiddenInfo(fid, JSON.stringify(fields));
					lazyForm.push(fjson[i]);
				}
				//createQueryForm(span,fid,method,fields,dataUrl);
			}
		}
		
		
		if ("true" == hasToolBar) {
			var toolBarInfo = '<s:property value="toolBarInfo" escapeHtml="false" escapeJavaScript="true"/>';
			var toolBarjson = eval("(" + toolBarInfo + ")");
			 for (var i = 0; i < toolBarjson.length; i++) {
				 crateToolBar(toolBarjson[i].buttons);
			} 
		}

		//cookie控制开始
		if ($.cookie('easyuiThemeName')) {
			var themeName = $.cookie('easyuiThemeName');
			//alert(themeName);
			//var $easyuiTheme = $('#easyuiTheme_common');
			var $easyuiTheme = $(".easyuichange");
			var url = $easyuiTheme.attr('href');
			var href = url.substring(0, url.indexOf('themes')) + 'themes/'
					+ themeName + '/easyui.css';
			$easyuiTheme.attr('href', href);

			var $iframe = $('iframe');
			if ($iframe.length > 0) {
				for (var i = 0; i < $iframe.length; i++) {
					var ifr = $iframe[i];
					$(ifr).contents().find('.easyuichange').attr('href',
							'../../' + href);
				}
			}
		} else {
			var $easyuiTheme = $('.easyuichange');
			var url = $easyuiTheme.attr('href');
			var href = url.substring(0, url.indexOf('themes'))
					+ 'themes/gray/easyui.css';
			$easyuiTheme.attr('href', href);

			var $iframe = $('iframe');
			if ($iframe.length > 0) {
				for (var i = 0; i < $iframe.length; i++) {
					var ifr = $iframe[i];
					$(ifr).contents().find('.easyuichange').attr('href',
							'../../' + href);
				}
			}
		}
		//cookie控制结束
		
/* 		 $("#index_body").layout("onResize",function(width, height){
			$('.form_span').each(function(i,value){
				addFormStyle(value.id);
			});
		}); */
		
		
/* 		 $(window).mouseup(function(){
			 alert(222);
		 }); */
		
 		$(window).resize(function () { 
			setTimeout("resizeeach()",300);
		 });  
		
 		//为ajax请求配置默认设置
		$.ajaxSetup({
			/* 			error : function(XMLHttpRequest, textStatus, errorThrown) {
							if (XMLHttpRequest.status == 403) {
								alert('您没有权限访问此资源或进行此操作');
								return false;
							}
						}, */
						cache: false, //close AJAX cache  
					    contentType:"application/x-www-form-urlencoded;charset=utf-8",   
					    //ajax请求加载完成时的处理
					    complete:function(XMLHttpRequest,textStatus){  
					    	//从XMLHttpRequest中获取返回文本
					        var resText = XMLHttpRequest.responseText;  
					    	//如果是拦截器中打印的出错字符串，则进行过期跳转处理
					        if(resText=='timeout'){    
					        	$.messager.show({
					        		title:'系统提示',
					        		msg:'登陆已超时，即将跳转至登陆页面',
					        		showType:'slide'
					        	});
					        	setTimeout("getTopWinow().location.href = '<%=contextPath%>/login.jsp';",
									3000);

						}
					}
				});
	});
 
 	function getTopWinow() {
		var p = window;
		while (p != p.parent) {
			p = p.parent;
		}
		return p;
	}
 	
	function createHiddenInfo(id, info) {
		$("#infospan").append("<input type='hidden' name='"+id+"info' value='"+info+"' id='"+id+"info' />");
	}
	function createHiddenValue(id, value) {
		$("#valuespan").append("<input type='hidden' name='"+id+"value' value='"+value+"' id='"+id+"value' />");
	}
	function getHiddenInfo(id) {
		return $('#'+id+'info').val();
	}
	function getHiddenValue(id) {
		return $('#'+id+'value').val();
	}
	function setHiddenValue(id,value) {
		return $('#'+id+'value').val(value);
	}
	
	function fixWidth_role(spanId) { 
		return ($('#'+spanId).parent()[0].clientWidth)*0.25;
		//return document.all.userRight.clientWidth*0.25;
	};
	function fixWidth_rolecombo(spanId) { 
		return ($('#'+spanId).parent()[0].clientWidth-90)*0.25;
		//return document.all.userRight.clientWidth*0.25;
	};
	function longWidth(spanId) { 
		return ($('#'+spanId).parent()[0].clientWidth+3)*0.75;
		//return (document.all.userRight.clientWidth+3)*0.75;
	};

	function nameWidth(spanId) { 
		return ($('#'+spanId).parent()[0].clientWidth)*0.25;
		//return document.all.userRight.clientWidth*0.25;
	};	
	
	function getButtonId(){}
	
	function resizeeach(){
		$('.form_span').each(function(i,value){
			addFormStyle(value.id);
		});
	}
	
	function addFormStyle(spanId){
			$('#'+spanId+' .docform .excombo').combo({ width:fixWidth_role(spanId)+2});
			$('#'+spanId+' .docform .exlongcombo').combo({ width:longWidth(spanId) });
			
			
			$('#'+spanId+' .divtable').css({'border-collapse':'collapse','border-spacing':'0','float':'left'});
			$('#'+spanId+' .divtable td').css({'border-bottom':'1px solid #d3d3d3','border-left':'1px solid #d3d3d3'});
			$('#'+spanId+' .divtable .tabname').css({'width':fixWidth_role(spanId)+'px','text-align':'right','background':'#f9f9f9','border-right':'1px solid #d3d3d3','padding':'5px 6px 5px 5px'});
			$('#'+spanId+' .divtable .tabint').css({'width':fixWidth_role(spanId)+'px','padding':'5px 6px 5px 5px'});
			//$('#'+spanId+' .divtable .tabint .text-1').css({'width':fixWidth_role(spanId)+'px'});
			//$('#'+spanId+' .divtable .tabint .validatebox-text').css({'width':fixWidth_role(spanId)+'px'});
			$('#'+spanId+' .divtable .tabint input').css({'width':fixWidth_role(spanId)+'px','color':'#000','font-family':'微软雅黑','font-size':'12px'});
			$('#'+spanId+'.divtable .tabint .combo ').css({'width':fixWidth_rolecombo(spanId)+'px','height':'20px','border':'0px solid #d3d3d3','display':'inline-block'});
	        $('#'+spanId+'.divtable .tabint .combo-arrow ').css({'width':'20px','height':'20px','background-position':'1px 3px'});
	    	$('#'+spanId+' .divtable .combo .combo-text').css({'width':fixWidth_rolecombo(spanId)+'px'});
	    	$('#'+spanId+' .divtable .combo .validatebox-text').css({'width':fixWidth_rolecombo(spanId)+'px'});
	        //combo-text validatebox-text
			//longtable		
			$('#'+spanId+'.longtable ').css({'border-collapse':'collapse','border-spacing':'0','float':'left' });
			$('#'+spanId+'.longtable td ').css({'border-bottom':'1px solid #d3d3d3','border-left':'1px solid #d3d3d3','height':'20px' });
			$('#'+spanId+'.longtable .longname').css({'width':nameWidth(spanId)+'px','text-align':'right','background':'#f9f9f9','border-right':'1px solid #d3d3d3','padding':'5px 6px 5px 5px'});
			$('#'+spanId+'.longtable .longint').css({'width':longWidth(spanId)+'px','height': '20px','padding':'5px 6px 5px 5px' });
			$('#'+spanId+'.longtable .longint input ').css({'width':longWidth(spanId)+'px','height':'20px','color':'#000','font-family':'微软雅黑','font-size':'12px'});
			$('#'+spanId+'.longtable .longint span ').css({'width':longWidth(spanId)+'px','height':'20px' });
			$('#'+spanId+'.longtable .longint .combo').css({'width':longWidth(spanId)+'px','height':'20px'});
			//$('#'+spanId+'.longtable .longint .combo input').css({'width':longWidth(spanId)+'px','height':'20px'});
			//$('#'+spanId+'.longtable .longint .combo ').css({'width':longWidth(spanId)+'px','height':'20px'});
			$('#'+spanId+'.longtable .longint .combo-arrow ').css({'width':'20px','height':'20px','background-position':'1px 3px'});
			//areatable
			$('#'+spanId+' .areatable ').css({'border-collapse':'collapse','border-spacing':'0','float':'left'});
			$('#'+spanId+' .areatable td').css({'border-bottom':'1px solid #d3d3d3','border-left':'1px solid #d3d3d3'});
			$('#'+spanId+' .areatable .tabname ').css({'width':nameWidth(spanId)+'px','text-align':'right','background':'#f9f9f9','border-right':' 1px solid #d3d3d3','padding':'5px 6px 5px 5px'});
			$('#'+spanId+' .areatable .tabtext').css({'width':longWidth(spanId)+'px','padding':'5px 4px 5px 5px'});
			$('#'+spanId+' .areatable .tabtext textarea').css({'width':longWidth(spanId)+'px','color':'#000','border':'1px solid #d3d3d3','font-family':'微软雅黑','font-size':'12px','resize':'none'});
	}
	
	function getbasePath(){
		return '<%=basePath %>';
	}

</script>
<body>
<span id = infospan></span>
<span id = valuespan></span>
</body>
</html>