//对combobox组件的扩展：
//考虑到下拉面板的值长度可能会超过输入框的宽度，但是easyui本身并不会自动适应
//所以需要扩展该组件，从而不必多次设置，即可自动适应不同长度的数据
//此处保留一个问题，就是当下拉“树”的时候，如果多级下拉，可能需要补充...
$.extend($.fn.combobox.defaults, {
	onShowPanel:function(){
		var comboobj = $(this).combobox('getData');		//获取下拉面板的值
		var combotext =  $(this).combobox('textbox');	//获取组件输入框内的值
	    panel_width = $(this).width();  //初始化最小宽度，等同输入框宽度
		for(var i = 0;i<comboobj.length;i++){
			if(comboobj[i].text){
				var str = comboobj[i].text.replace(/[^\x00-\xff]/g,"aa");   //正则，将中文转化为两个英文字符以计数
				if(panel_width<str.length*7){panel_width = (str.length)*7;}   //获取最长选项，每个字7px
			}
		}
		$(this).combobox({panelWidth:panel_width});		//设置下拉宽度
		$('.combo input').attr('readonly','readonly');	//会重置输入框的输入限制，要重新设置
		$(this).combobox('setValue',combotext.val());	//由于下拉时会重置输入框内的值，需重新设置以保持输入框内的值不变
	}
});
