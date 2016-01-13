<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <% String contextPath = request.getContextPath();%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>案件查询</title>
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=contextPath %>/js/easyui/themes/icon.css">
<script type="text/javascript" src="<%=contextPath %>/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=contextPath %>/js/easyui/jquery.easyui.min.js"></script>
</head>
<body class="easyui-layout">
<form id="searchCondition" method="post" > 
<h2 style="margin-left:15%;margin-top:10px;align:center;width:70%">案件信息查询</h2> 
<fieldset style="width:70%;  margin-left:15% ; margin-top:20px">
<legend>查询条件</legend>
<div id="requirement"  style="width:100%; align:center; margin-left:10px;">
<div>
    <div id="requirement1" style="margin-top:20px; margin-left:20px;float:left;">   
        <label for="caseNumber">案件编号:</label>   
        <input class="easyui-validatebox" type="text" id="caseNumber" name="caseNumber" data-options="required:true" />   
    </div>   
    <div style="margin-top:20px; float:left;">   
        <label for="name">名称:</label>   
        <input  type="text"   id="name" name="name"  />   
    </div> 
    <div style="margin-top:20px; float:left">   
        <label for="identityCard">身份证号码:</label>   
        <input  type="text"  id="identityCard" name="identityCard"  />   
    </div>   
    </div>
    <div style="margin-left:20px; float:left">
    <div style="margin-top:20px; float:left">
	    区域：<!-- <select id="localtion" class="easyui-combobox" id="localtion" name="localtion" style="width:200px;">   
	     
	    <option>洲心街道办</option>
	    <option>横河街道办</option>    
	    <option>凤城街道办</option>   
	    <option>龙塘镇</option>   
	    <option>石角镇</option>   
	    </select>  -->
	    <input id="localtion" name="localtion" value=""/>  

	    
    
    </div>
    <div style="margin-top:20px; float:left">
    	<div style="margin-left:20px;">
  				<label for="starttime">时间段：</label>  <label for="starttime">开始时间：</label> <input id="starttime" name="starttime" type="text"></input> <label for="endtime">结束时间：</label>  <input id="endtime" name="endtime" type="text"></input> 
    		</div>
    </div>
    </div>
    <div style="margin-top:20px; margin-left:50%; width:70%; float:left; align:certer;">
   		<input id="submit" type="button" onClick="cx()" value="查询"></input>
   	
    </div>
</div>  
</fieldset> 
</form>
<div style="margin-top:20px; width:70%; margin-left:15%">
    	<table id="dg" width='60%'></table> 
    </div> 
<script type="text/javascript">	

 $('#starttime').datebox({
	
}); 
$('#endtime').datebox({    
     
}); 
 
$('#localtion').combobox({    
	url:'bmMap!bmmcMap.do',
	   valueField: 'id',    
    textField: 'text',  
});  



/*datagrid*/
 $('#dg').datagrid({  
	 url:"AjcxAction!printText.do",
	 striped:true,
	 pagination:true,
	 singleSelect:true,
    columns:[[    
        {field:'caseNumber',title:'案件编号',width:100}, 
        {field:'name',title:'名称',width:100},
        {field:'identityCard',title:'身份证号码',width:100},
        {field:'localtion',title:'所属区域',width:100},
        {field:'title',title:'案件标题',width:100},    
        {field:'principal',title:'负责人',width:100},
        {field:'happenTime',title:'发生时间',width:100 },
        {field:'detail',title:'详细',width:100,formatter:gotojsp}
        
        
    ]]    
});
 $('#dg').datagrid('getPager').pagination({
		beforePageText:'第',
		afterPageText:'页',
		displayMsg:'当前显示{from}到{to}条记录   共{total}条记录',
		/*  onSelectPage:function(pageNumber,pageSize){  
	         
	        } */ 
	});
 $('#dg').datagrid('reload',{
	 caseNumber : $("#caseNumber").val(),
		name :  $("#name").val(),
		identityCard : $("#identityCard").val(),
		localtion : $("#localtion").combobox("getValue"),
		starttime : $("#starttime").datebox("getValue"),
		endtime : $("#endtime").datebox("getValue")
		
	});
  

function gotojsp(value,row,index){
	
	return "<a href='test.jsp?caseNumber="+row.caseNumber+"'>查看</a>";
	//return "<a href='AjcxAction!go.do?caseNumber="+row.caseNumber+"'>查看</a>";
}

function cx(){
 	alert($("#localtion").combobox("getValue"));
	   $.ajax({ 
                //客户端向服务器发送请求时采取的方式
                type: "post", 
                 
                cache: false, 
                 
                //服务器返回的数据类型，可选 XML, Json, jsonp, script, html, text。
                dataType: 'Json',
                 
                //指明客户端要向哪个页面里面的哪个方法发送请求
                 url: "AjcxAction!printText.do",
                 
                data:{
                	
                		caseNumber : $("#caseNumber").val(),
                		name :  $("#name").val(),
                		identityCard : $("#identityCard").val(),
                		localtion : document.getElementById("localtion").value,//$("#localtion").combobox("getValue"),
                		starttime : $("#starttime").datebox("getValue"),
                		endtime : $("#endtime").datebox("getValue")
                		
                	
                 },
                 success:function(data){    
                	 $("#dg").datagrid("loadData", data);
                 } 
	   }); 
	   
	
	
}


</script>
</body>
</html>