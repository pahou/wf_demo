<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <% String contextPath = request.getContextPath();%>
    <% String name = request.getParameter("caseNumber"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="../css/style.css">
<link rel="stylesheet" type="text/css" href="../js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../js/easyui/themes/icon.css">
<script type="text/javascript" src="../js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="../js/easyui/jquery.easyui.min.js"></script>

<title>资料列表</title>
</head>
<body class="easyui-layout" fit="true">
<div style="margin-left:15%;width:70%">
<div style="margin-top:20px; margin-left:50%"><h2>案件编号：<%=name %>资料汇总</h2></div>
<div style="width:100%; height:500px"><table id="dg" class="easyui-datagrid"></table></div>
</div> 

<script type="text/javascript">
var param = {
		   "total":"2",
		   "rows":[{"name":"巡查信息登记表"},
		  			{"name":"现场照片"}
		   ]
		 
};


$('#dg').datagrid({  
	 //url:"AjcxAction!printText.do",
	 //pagination:true,
	 fit:true,
	 fitColumns:true,
	 striped:true,
	 rownumbers:true,
	 singleSelect:true,
   columns:[[    
       {field:'name',title:'名称',align:'center',width:100,formatter:gotojsp}
  
   ]]
   
    
});
	
$("#dg").datagrid("loadData", param);

function gotojsp(value,row,index){
	
	return "<a href='test2.jsp?caseNumber="+row.caseNumber+"'>"+value+"</a>";
	//return "<a href='AjcxAction!go.do?caseNumber="+row.caseNumber+"'>查看</a>";
}
</script>
</body>
</html>