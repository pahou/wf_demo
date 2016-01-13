<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"  import="org.apache.struts2.ServletActionContext,java.util.*,com.gdth.util.Constants,com.gdth.sys.entity.TXtYh"%>
<!doctype html>
<html> 
<head>
<meta charset="utf-8">
<title>清远市地方税务局-工作流引擎系统</title>

<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet" type="text/css" href="css/public.css">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/easyui1.3.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="js/easyui1.3.4/plugins/jquery.panel.js"></script>
<script type="text/javascript" src="js/easyui1.3.4/plugins/jquery.linkbutton.js"></script>
<script type="text/javascript" src="js/easyui1.3.4/plugins/jquery.parser.js"></script>
<script type="text/javascript" src="js/easyui1.3.4/plugins/jquery.tabs.js"></script>
<!-- 换肤引入cookie插件  -->
<script type="text/javascript" src="js/easyui1.3.4/jquery.cookie.js"></script>
<link id="easyuiTheme" rel="stylesheet" href="js/easyui1.3.4/themes/gray/easyui.css" type="text/css"></link>
<!-- 动态菜单 -->
<script type="text/javascript" src='js/trendsMenu.js'> </script>
<link href="js/easyui1.3.4/icons/jeasyui-extensions/jeasyui.extensions.css" rel="stylesheet" type="text/css" />
<link href="js/easyui1.3.4/icons/icons/icon-all.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/default.css">
<style type="text/css">

</style>
<%
Map<String,Object> sessionMap = ServletActionContext.getContext().getSession();
String menuStr = (String) sessionMap.get(Constants.JSON_MENU_MAP_KEY);
System.out.println("================================================================");
System.out.println("==================菜单信息：：：："+menuStr);
System.out.println("================================================================");
%>
<script type="text/javascript">
var _menus = {<%=menuStr%>};

function addTab(title, url){
	if ($('#tabs').tabs('exists', title)){
		$('#tabs').tabs('select', title);//选中并刷新
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if(url != undefined && currTab.panel('options').title != 'Home') {
			$('#tabs').tabs('update',{
				tab:currTab,
				options:{
					content:createFrame(url)
				}
			});
		}
	} else {
		var content = createFrame(url);
		$('#tabs').tabs('add',{
			title:title,
			content:content,
			closable:true
		});
	}
	tabClose();
}
function createFrame(url) {
	var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:99%;"></iframe>';
	return s;
}
		
function tabClose() {
	/*双击关闭TAB选项卡*/
	$(".tabs-inner").dblclick(function(){
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close',subtitle);
	})
	/*为选项卡绑定右键*/
	$(".tabs-inner").bind('contextmenu',function(e){
		$('#mm').menu('show', {
			left: e.pageX,
			top: e.pageY
		});

		var subtitle =$(this).children(".tabs-closable").text();

		$('#mm').data("currtab",subtitle);
		$('#tabs').tabs('select',subtitle);
		return false;
	});
}		
//绑定右键菜单事件
function tabCloseEven() {
	//刷新
	$('#mm-tabupdate').click(function(){
		var currTab = $('#tabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		if(url != undefined && currTab.panel('options').title != 'Home') {
			$('#tabs').tabs('update',{
				tab:currTab,
				options:{
					content:createFrame(url)
				}
			})
		}
	})
	//关闭当前
	$('#mm-tabclose').click(function(){
		var currtab_title = $('#mm').data("currtab");
		$('#tabs').tabs('close',currtab_title);
	})
	//全部关闭
	$('#mm-tabcloseall').click(function(){
		$('.tabs-inner span').each(function(i,n){
			var t = $(n).text();
			if(t != 'Home') {
				$('#tabs').tabs('close',t);
			}
		});
	});
	//关闭除当前之外的TAB
	$('#mm-tabcloseother').click(function(){
		var prevall = $('.tabs-selected').prevAll();
		var nextall = $('.tabs-selected').nextAll();		
		if(prevall.length>0){
			prevall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				if(t != 'Home') {
					$('#tabs').tabs('close',t);
				}
			});
		}
		if(nextall.length>0) {
			nextall.each(function(i,n){
				var t=$('a:eq(0) span',$(n)).text();
				if(t != 'Home') {
					$('#tabs').tabs('close',t);
				}
			});
		}
		return false;
	});
	//关闭当前右侧的TAB
	$('#mm-tabcloseright').click(function(){
		var nextall = $('.tabs-selected').nextAll();
		if(nextall.length==0){
			//msgShow('系统提示','后边没有啦~~','error');
			alert('后边没有啦~~');
			return false;
		}
		nextall.each(function(i,n){
			var t=$('a:eq(0) span',$(n)).text();
			$('#tabs').tabs('close',t);
		});
		return false;
	});
	//关闭当前左侧的TAB
	$('#mm-tabcloseleft').click(function(){
		var prevall = $('.tabs-selected').prevAll();
		if(prevall.length==0){
			alert('到头了，前边没有啦~~');
			return false;
		}
		prevall.each(function(i,n){
			var t=$('a:eq(0) span',$(n)).text();
			$('#tabs').tabs('close',t);
		});
		return false;
	});

	//退出
	$("#mm-exit").click(function(){
		$('#mm').menu('hide');
	})
}

//cookie换肤方法--开始
function changeTheme(themeName) {
	var $easyuiTheme = $('#easyuiTheme');
	var url = $easyuiTheme.attr('href');
	var href = url.substring(0, url.indexOf('themes')) + 'themes/' + themeName + '/easyui.css';
	$easyuiTheme.attr('href', href);

	var $iframe = $('iframe');
	if ($iframe.length > 0) {
		for ( var i = 0; i < $iframe.length; i++) {
			var ifr = $iframe[i];
			$(ifr).contents().find('.easyuichange').attr('href', '../../'+href);
		}
	}
	if ($.cookie('easyuiThemeName')) {
		$.cookie('easyuiThemeName', null);
	}
	$.cookie('easyuiThemeName', themeName, {
		expires : 7,
		secure: false
	});
};
//cookie换肤方法--结束

function closeIndex(){
	parent.window.close();
}

$(function() {
	$('#oldpw').validatebox({    		//修改密码验证框
	    required: true,    
	    missingMessage:'原密码不能为空'  
	}); 
	$('#newpw').validatebox({    
	    required: true,    
	    missingMessage:'新密码不能为空'  
	}); 
	$('#checkpw').validatebox({    
	    required: true,    
	    validType: 'equals["#newpw"]',
	    missingMessage:'确认密码不能为空'  
	}); 
	
	tabCloseEven();
	$('.cs-navi-tab').click(function() {
		var $this = $(this);
		var href = $this.attr('src');
		var title = $this.text();
		addTab(title, href);
	});
	//初始化读取cookie
	if ($.cookie('easyuiThemeName')) {
		changeTheme($.cookie('easyuiThemeName'));
	}
	
});

</script>

</head>

<body class="easyui-layout"  id="index_body">
	<div region="north" border="true" class="cs-north">
		<div class="cs-north-bg">
			<div class="cs-north-logo">
				 <img src="images/szds.jpg" />
				 <img src="images/sysName.png" />
			</div>
			<div class="csRight">
			  <ul>
			     <li>
			       <dl>
					<dt><a href="#" onclick="closeIndex();"><img src="images/exit.png" width="30"  height="30"/></a></dt>
				    <dd><a href="#" onclick="closeIndex();">退出</a></dd>
				   </dl>
			    </li>
			</ul>
			</div>
		</div>
	</div>
	<div region="west" border="true" split="true" title="主菜单" class="cs-west" id="west">

				<div id="nav">
					<!--  导航内容 -->
				
				</div>
	</div>
	 <div id="mainPanle" region="center" border="true" border="false">
		 <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
                <!-- <div title="Home">
				<div class="cs-home-remark">
					<h1>工作流程引擎</h1> <br>
					
				</div>
				</div> -->
        </div>
	</div> 

	<div region="south" border="false" class="cs-south">  <p>CopyRight &copy 2015  清远市地方税务局</p></div>
	
	<div id="dd">
		<div class="userForm"  style="display:none;width:100%;height:100%;overflow:hidden;">
		<form method="post" id="cf">
			<div>
			  <label>原密码:</label> 
			  <input type="password" id="oldpw" name="oldpw" class="text-1"/>
			</div>
			<div>
			   <label>新密码:</label> 
			   <input type="password" id="newpw" name="newpw" class="text-1"/>
			</div>
			<div>
			  <label>确认密码:</label> 
			  <input type="password" id="checkpw" name="checkpw" class="text-1"/>
			</div>
		</form>
		</div>
	</div>
	<script type="text/javascript">
//初始化菜单
$('#mainmenu').menubutton({   
	menu: '#mm-mainmenu',
	plain:true
});
//菜单事件
$('#mm-mainmenu').menu({
	onClick:function(item){
		switch(item.id){
		case 'mm-memupwd':
			addTab('修改密码', './sys/user/changePwd.jsp');
			break;
		case 'mm-menuhelp':
			window.location.href='#';
			break;
		case 'mm-menuexit':
			$.messager.confirm('系统信息', '确定退出系统吗?', function(r){
				if (r){
					window.location.href='${pageContext.request.contextPath}/sys/user/logout.action';
				}
			});
			break;
		case 'mm-updatesystem':
			//execVerifyCode();
			break;
		default:
			break;
		}
	}
});

$(function(){
	
	$.extend($.fn.validatebox.defaults.rules, {     //自定义验证信息
	    equals: {    								//验证两次输入密码一样
	        validator: function(value,param){    
	            return value == $(param[0]).val();    
	        },    
	        message: '两次输入的字符不一至'   
	    }    
	});  
	
	$('#dd').dialog(
			{
				title : '修改用户密码',
				width : 450,
				height : 300,
				resizable : true,
				closed : true,
				cache : false,
				modal : true,
				buttons : [ {
					text : '保存',
					handler : function() {
						var newpw = document.getElementById("newpw").value;
						var oldpw = document.getElementById("oldpw").value;
						 $.ajax({
								async:false,
								type : "POST",
								url : "ChangePassword/ChangePassword!changepw.do",			//将数据传到后台保存
								data:'params={"newpw":'+ newpw +',"oldpw":'+ oldpw +'}',
								beforeSend: function(){										//验证不通过则不传送数据，留在本页面
				                	 if(!$("#cf").form('validate')){
				                		 return false;
				                	 }
				                	 else{
				                		 return true;
				                	 }
				                	},
								success : function(data) {
									if(data.changed==0){
										$.messager.alert("提示信息","修改密码成功，将返回登录页面！");
										setTimeout("location.href='tlogin.do'",3000);
									}else{
										$.messager.alert("提示信息","原密码输入不正确！");
									}
									
								}
							});  
					}
				}],
				onClose:function(){//关闭时，禁用验证
					   $('#oldpw').validatebox("disableValidation"); 
					   $('#newpw').validatebox("disableValidation"); 
					   $('#checkpw').validatebox("disableValidation"); 
				   },
				onBeforeOpen:function(){
					if($('div.userForm').css('display') == 'none') $('div.userForm').show();
				}
			
			});
});

function editpassword() {			//修改密码方法
	$('#cf').form('clear');
	//开启验证
	$('#oldpw').validatebox("enableValidation");
	$('#newpw').validatebox("enableValidation"); 
	$('#checkpw').validatebox("enableValidation");
	$('#dd').dialog('open');
	}
	</script>
</body>
</html>
