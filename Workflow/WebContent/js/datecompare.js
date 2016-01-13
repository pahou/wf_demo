/**
 * Date数据转字符串数据 格式:"YYYY-MM-DD"
 * 
 * @param date_tmp
 * @returns {String}
 */
function getDateFormat(date_tmp) {
	var date = new Date(date_tmp);
	var _year = date.getFullYear();
	var _month = date.getMonth() + 1;
	var _day = date.getDate();
	return _year + "-" + _month + "-" + _day;
}

/**
 * 获取时间字符串数据 格式:"YYYY-MM-DD"
 * 
 * @returns {String}
 */
function getDate() {
	var _tmp_time = new Date();
	var _year = _tmp_time.getFullYear();
	var _month = _tmp_time.getMonth() + 1;
	var _day = _tmp_time.getDate();
	return _year + "-" + _month + "-" + _day;
}



/**
 * 开始查询时间与结束查询时间对比功能
 */
function date_init(startbox,endbox,in_width) {
	var _re1, _re2;
	$('#'+startbox).datebox({
		//value : getDate(),// 初始化一个时间字符串
		width : in_width,
		onSelect : function(date) {
			$('#'+startbox).datebox('setValue', getDateFormat(date));// 设置开始查询时间值
			var v1arr = $('#'+startbox).datebox('getValue').split("-");
			var v2arr = $('#'+endbox).datebox('getValue').split("-");
			var v1 = new Date(v1arr[0],v1arr[1],v1arr[2])// 获取开始查询时间值
			var v2 = new Date(v2arr[0],v2arr[1],v2arr[2])
			//var v1 = new Date($('#'+startbox).datebox('getValue'));// 获取开始查询时间值
			//var v2 = new Date($('#'+endbox).datebox('getValue'));// 获取结束时间值
			if (v1.getTime() > v2.getTime()) {// 开始时间大于结束时间处理
				$.messager.alert('警告', '开始时间必须小于结束时间');// 弹出警告对话框
				$('#'+startbox).datebox('setValue', _re1);// 将值设为之前的有效记录
			}
			else {// 开始时间小于结束时间处理
				$('#'+startbox).datebox('setValue', getDateFormat(date));// 将值设置为当前获取的日期
				_re1 = getDateFormat(date);// 记录有效日期
			}
		}
	});
	$('#'+endbox).datebox({
		//value : getDate(),// 初始化一个时间字符串
		width : in_width,
		onSelect : function(date) {
			$('#'+endbox).datebox('setValue', getDateFormat(date));
			var v1arr = $('#'+startbox).datebox('getValue').split("-");
			var v2arr = $('#'+endbox).datebox('getValue').split("-");
			var v1 = new Date(v1arr[0],v1arr[1],v1arr[2])//new Date($('#'+startbox).datebox('getValue'));// 获取开始查询时间值
			var v2 = new Date(v2arr[0],v2arr[1],v2arr[2])
			//var v1 = new Date($('#'+startbox).datebox('getValue'));
			//var v2 = new Date($('#'+endbox).datebox('getValue'));
			if (v1arr.length<=1||v1.getTime() <= v2.getTime()) {
				$('#'+endbox).datebox('setValue', getDateFormat(date));
				_re2 = getDateFormat(date);
			}
			else {
				$.messager.alert('警告', '结束时间必须大于开始时间');
				$('#'+endbox).datebox('setValue', _re2);
			}
		}
	});
}

function GetTimeTest(testdate) {
	var s, t; // 声明变量。
	var MinMilli = 1000 * 60; // 初始化变量。
	var HrMilli = MinMilli * 60;
	var DyMilli = HrMilli * 24;
	t = Date.parse(testdate); // 解析 testdate。
	s = "There are "; // 创建返回的字符串。
	s += Math.round(Math.abs(t / DyMilli)) + " days ";
	s += "between " + testdate + " and 1/1/70 ";
	s += "and parse-data:" + t;
	return (s); // 返回结果。
}
