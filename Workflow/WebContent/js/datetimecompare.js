function getDatetimeFormat(date_tmp) {
	// var date = new Date(date_tmp.toLocaleDateString());
	// var _time = date_tmp.toTimeString();
	var date = new Date(date_tmp);
	var _year = date.getFullYear();
	var _month = date.getMonth();
	var _day = date.getDate();
	var _hour = date.getHours();
	var _minute = date.getMinutes();
	var _second = date.getSeconds();
	return _year + "-" + (_month + 1) + "-" + _day + " " + _hour + ":" + _minute + ":" + _second;
}

function getDatetime() {
	var _tmp_time = new Date();
	var _year = _tmp_time.getFullYear();
	var _month = _tmp_time.getMonth();
	var _day = _tmp_time.getDate();
	var _hour = _tmp_time.getHours();
	var _minute = _tmp_time.getMinutes();
	var _second = _tmp_time.getSeconds();
	return _year + "-" + (_month + 1) + "-" + _day + " " + _hour + ":" + _minute + ":" + _second;
}


/**
 * 开始查询时间与结束查询时间对比功能
 */
function datetime_init(startbox,endbox,in_width) {
	var _re1, _re2;
	$('#'+startbox).datetimebox({
		//value : getDatetime(),// 初始化一个时间字符串
		width : in_width,
		onSelect : function(date) {
			$('#'+startbox).datetimebox('setValue', getDatetimeFormat(date));// 设置开始查询时间值
			var v1 = new Date($('#'+startbox).datetimebox('getValue'));// 获取开始查询时间值
			var v2 = new Date($('#'+endbox).datetimebox('getValue'));// 获取结束时间值
			if (v1.getTime() > v2.getTime()) {// 开始时间大于结束时间处理
				$.messager.alert('警告', '开始时间必须小于结束时间');// 弹出警告对话框
				$('#'+startbox).datetimebox('setValue', _re1);// 将值设为之前的有效记录
			}
			else {// 开始时间小于结束时间处理
				$('#'+startbox).datetimebox('setValue', getDatetimeFormat(date));// 将值设置为当前获取的日期
				_re1 = getDatetimeFormat(date);// 记录有效日期
			}
		}
	});
	$('#'+endbox).datetimebox({
		//value : getDatetime(),// 初始化一个时间字符串
		width : in_width,
		onSelect : function(date) {
			$('#'+endbox).datetimebox('setValue', getDatetimeFormat(date));
			var v1 = new Date($('#'+startbox).datetimebox('getValue'));
			var v2 = new Date($('#'+endbox).datetimebox('getValue'));
			if ($('#'+startbox).datetimebox('getValue')==""||v1.getTime() <= v2.getTime()) {
				$('#'+endbox).datetimebox('setValue', getDatetimeFormat(date));
				_re2 = getDatetimeFormat(date);
			}
			else {
				$.messager.alert('警告', '结束时间必须大于开始时间');
				$('#'+endbox).datetimebox('setValue', _re2);
			}
		}
	});
}
