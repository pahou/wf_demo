var formElements="";
var successGrid = ""; //关联的gridId
var queryformid = "";//查询form的ID
//对表格查询的方法
function _search(){
	var formdataArr = [];
	for(var i=0;i<formElements.length;i++){
		var queryPropertiesVo = formElements[i].queryPropertiesVo;
		if(queryPropertiesVo==null){
			continue;
		}
		if(formElements[i].type == "combobox"){
			var formdata = {};
			formdata.key = formElements[i].name;
			formdata.value = $('#'+formElements[i].id).combobox("getValue");//把combobox的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(formElements[i].type == "datebox"||formElements[i].type == "startdatebox"||formElements[i].type == "enddatebox"){
			var formdata = {};
			formdata.key = formElements[i].name;
			formdata.value = $('#'+formElements[i].id).datebox("getValue");//把datebox的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(formElements[i].type == "datetimebox"||formElements[i].type == "startdatetimebox"||formElements[i].type == "enddatetimebox"){
			var formdata = {};
			formdata.key = formElements[i].name;
			formdata.value = $('#'+formElements[i].id).datetimebox("getValue");//把datetimebox的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(formElements[i].type == "text"){
			var formdata = {};
			formdata.key = formElements[i].name;
			formdata.value = $('#'+formElements[i].id).val();//把text的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(formElements[i].type == "hidden"){
			var formdata = {};
			formdata.key = formElements[i].name;
			formdata.value = $('#'+formElements[i].id).val();//把text的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(formElements[i].type == "combotree"){
			var formdata = {};
			formdata.key = formElements[i].name;
			formdata.value = $('#'+formElements[i].id).combotree("getValue");
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}

	}
/*	formdata.hqlTitle = "hqltitle";
	formdata.hqlOpt = "hqlopt";*/
	//alert("名称 ："+formdata.name+" 年龄： "+formdata.age+" 性别： "+formdata.sex+" 地址： "+formdata.address+" 开始时间： "+formdata.starttime+" 结束时间： "+formdata.endtime);
	//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个form而定
	var options =  $("#"+successGrid).datagrid('options');
	var param = options.queryParams.params;
	param = eval("(" + param + ")");
	param.formname = queryformid;
	param.queryparam = JSON.stringify(formdataArr);
	//修改查询时传递的参数
	options.queryParams = {
			params:JSON.stringify(param)
	};
	$('#'+successGrid).datagrid("load");
}


//对表格查询的方法,参数是gridid
function _searchById(gridId){
	var queryValue = $.parseJSON(getHiddenValue("query"+gridId));
	var query_formElements = $.parseJSON(queryValue.formElements);
	var formdataArr = [];
	for(var i=0;i<query_formElements.length;i++){
		var queryPropertiesVo = query_formElements[i].queryPropertiesVo;
		if(queryPropertiesVo==null){
			continue;
		}
		if(query_formElements[i].type == "combobox"){
			var formdata = {};
			formdata.key = query_formElements[i].name;
			formdata.value = $('#'+query_formElements[i].id).combobox("getValue");//把combobox的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(query_formElements[i].type == "datebox"||query_formElements[i].type == "startdatebox"||query_formElements[i].type == "enddatebox"){
			var formdata = {};
			formdata.key = query_formElements[i].name;
			formdata.value = $('#'+query_formElements[i].id).datebox("getValue");//把datebox的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(query_formElements[i].type == "datetimebox"||query_formElements[i].type == "startdatetimebox"||query_formElements[i].type == "enddatetimebox"){
			var formdata = {};
			formdata.key = query_formElements[i].name;
			formdata.value = $('#'+query_formElements[i].id).datetimebox("getValue");//把datetimebox的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(query_formElements[i].type == "text"){
			var formdata = {};
			formdata.key = query_formElements[i].name;
			formdata.value = $('#'+query_formElements[i].id).val();//把text的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(query_formElements[i].type == "hidden"){
			var formdata = {};
			formdata.key = query_formElements[i].name;
			formdata.value = $('#'+query_formElements[i].id).val();//把text的值set入formdata中
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}else if(query_formElements[i].type == "combotree"){
			var formdata = {};
			formdata.key = query_formElements[i].name;
			formdata.value = $('#'+query_formElements[i].id).combotree("getValue");
			formdata["hqlAlias"] = queryPropertiesVo.hqlAlias;
			formdata["hqlOpt"] = queryPropertiesVo.hqlOpt;
			formdata["hqlOr"] = queryPropertiesVo.hqlOr;
			formdataArr.push(formdata);
		}
	}
	var options =  $("#"+gridId).datagrid('options');
	var param = options.queryParams.params;
	param = eval("(" + param + ")");
	param.formname = queryValue.queryformid;
	param.queryparam = JSON.stringify(formdataArr);
	//修改查询时传递的参数
	options.queryParams = {
			params:JSON.stringify(param)
	};
	$('#'+gridId).datagrid("load");
}