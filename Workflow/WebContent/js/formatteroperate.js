	function formatsex(value,row,index){
		if (value==1){
			return "男";
		} else {
			return "女";
		}

	}
	
	function formatDeal(value,row,index){
		if (value==1){
			return "未化解";
		} else {
			return "已化解";
		}

	}
	
	function formatFollow(value,row,index){
		if (value==1){
			return "未跟进";
		} else {
			return "有跟进";
		}

	}
	
	function formatDesc(value, row, index){
		if(value.length>18){
			//return "<div>"+value+"</div><div>"+value.substring(0,18)+"</div>";
			return '<a " title="'+value+'" class="easyui-tooltip">'+value.substring(0,30)+'</a>';
			//return value.substring(0,18);
		}else{
			return value;
		}
	}
	
	function format_assignee(value,row,index){
		return value == "未受理" ? "" : value;
	}
	
	function format_assignStat(value,row,index){
		return row.assigneeName == "未受理" ? "未受理" : "已受理";
	}
	
	function showTaskTitle(value,row,index){
		var simpleTitle = row.taskTitle.substring(0,20);
		var title = row.taskTitle;
		var result = '<a href="#" title="'+ title +'" class="easyui-tooltip">'+ simpleTitle +'</a>'
		return result;
	}
	
	function CN_systemName(value,row,index){
		//没有系统字典管理，如有新系统自行添加键值对
		var tempName = [{
			id:'weixin',
			text:'微信公众号管理平台'
		},{
			id:'kqgl',
			text:'考勤管理'
		}];
		function getCN(id_){
			var thisText = id_;
			$.each(tempName,function(index){
				if(this.id == id_) {
					thisText = this.text;
					return false;
				}
			});
			if(thisText == id_) thisText = "其他";
			return thisText;
		}
		return getCN(row.systemName);
	}
	
	function EX_empty(value,row,index){
		return typeof value == "object"?"":value;
	}