function crateToolBar(toolBararr){
	var buttonString = "";
	for (var i = 0; i < toolBararr.length; i++) {
		var disabled = toolBararr[i].disabled;
		var iconCls = toolBararr[i].iconCls;
		var id = toolBararr[i].id;
		var onClick = toolBararr[i].onClick;
		var text = toolBararr[i].text;
		buttonString += '<a plain="true" id="'+id+'" href="#" disable="'+disabled+'" class="easyui-linkbutton" data-options="iconCls:\''+iconCls+'\'" onclick="'+onClick+'">'+text+'</a>';
	} 
	var toolbarString = '<div class="toolbar">'+buttonString+'</div>';
	var toolbarele = $(toolbarString).appendTo("#thtoolbar");
	$.parser.parse(toolbarele); // 重新加载JQ
}