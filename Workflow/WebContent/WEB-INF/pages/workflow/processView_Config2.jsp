<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产信息管理配置页面</title>
<%@include file="/js/common.jsp"%><!-- 必须引入commo -->
<style>
	#taskUrl{font-size:15px;}
	.button{
width: 77px;
height:28px;
text-align: center;
font-weight: bold;
color: #fff;
text-shadow:1px 1px 1px #333;
border-radius: 5px;
margin:0 20px 20px 0;
position: relative;
overflow: hidden;
}
.button.gray{
color: #8c96a0;
text-shadow:1px 1px 1px #fff;
border:1px solid #dce1e6;
box-shadow: 0 1px 2px #fff inset,0 -1px 0 #a8abae inset;
background: -webkit-linear-gradient(top,#fff,#f2f3f7);
background: -moz-linear-gradient(top,#fff,#f2f3f7);
background: linear-gradient(top,#fff,#f2f3f7);
}
.button.gray:hover{ cursor:pointer; }

.gray:hover{
background: -webkit-linear-gradient(top,#fefefe,#ebeced);
background: -moz-linear-gradient(top,#f2f3f7,#ebeced);
background: linear-gradient(top,#f2f3f7,#ebeced);
}

.gray:active{
top:1px;
box-shadow: 0 1px 2px #d0d0d0 inset,0 2px 0 #fff;
background: -webkit-linear-gradient(top,#e4e8ec,#e4e8ec);
background: -moz-linear-gradient(top,#e4e8ec,#e4e8ec);
background: linear-gradient(top,#e4e8ec,#e4e8ec);
}
</style>
</head>
<body  class="easyui-layout">
	<div region="center">
		<div id="pvc" class="easyui-layout" fit="true">
			<div region="north" style="height:300px;" split="true">
				<div id="us" class="easyui-layout" fit="true">
					<div region="east" collapsed="true" style="width:300px;"><span id="queryform_for_user"></span></div>
					<div region="center"><table id="user"></table></div>
				</div>
			</div>
			<div region="center">
				<div id="ro" class="easyui-layout" fit="true">
					<div region="east" collapsed="true" style="width:300px;"><span id="queryform_for_role"></span></div>
					<div region="center"><table id="role"></table></div>
				</div>
			</div>
		</div>
	</div>
	<div region="west" style="width:350px;"><table id="group"></table></div>
	<script>
		
	</script>
	<!-- <div region="center"><table id="group"></table></div>
		<div region="east" border="0" style="width:350px;" split="true">
		<div class="easyui-layout" fit="true">
			<div region="north" style="height:35px;">
					<button onclick="saveChange()" class="button gray">保存</button>
					<button onclick="notChange()" class="button gray">返回</button>
				</div>
				<div region="center" border="0">
					<table id="user"></table>
			</div>
		</div>
	</div>
	<div region="center" border="0">
		<div class="easyui-layout" fit="true">
			<div region="north" border="0" style="height:35px;">
				<div class="easyui-layout" fit="true">
					<div region="west" style="width:350px;">
						<div style="width:100%;height:100%;text-align:center;line-height:35px;font-size:18px;">XX任务节点URL</div>
							</div>
							<div region="center" border="0" style="text-align:center;">
						<input style="width:80%;height:25px;margin-top:5px;" id="taskUrl">
					</div>
				</div>
			</div>
			<div region="center">
				<div id="rolepanel" class="easyui-layout" fit="true">
					<div id="this_west" region="west" border="0" style="width:350px;" split="true">
						<table id="role"></table>
					</div>
					<div region="center" border="0">
						<div class="easyui-layout" fit="true">
							<div region="west" style="width:50px;">
							</div>
							<div region="east" style="width:50px;">
							</div>
							<div region="center" border="0" style="text-align:center;">
								<table id="group"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> -->
	<script>
		var opt = '<s:property value="opt"/>';//这是Grid要写的参数，判断增加跳转还是修改跳转
		
		var procKey = '<s:property value="procKey"/>';
		var taskDefKey = '<s:property value="taskDefKey"/>';
		var _taskDefKeyId = '<s:property value="taskDefKeyId"/>';
		
		//alert(_taskDefKeyId);
		
		var groupdata = {};
			groupdata.add = [];
			groupdata.del = [];
			groupdata.taskdefconId = _taskDefKeyId;  //taskDefConId;
		var roledata = {};
			roledata.type = 'group';
			roledata.data = [];
		var userdata = {};
			userdata.type = 'user';
			userdata.data = [];
			
		var isFirst = 0;
		function setFormParam(){}
		
		function setGridParam(){
			//(1) 定义请求参数json,这里是根据后台的参数自由设置的
			var queryParam = {};
			queryParam.hqlinfo = "";
			queryParam.taskDefConId = _taskDefKeyId;
			
			var queryParam2 = {};
			queryParam2.hqlid = 'workflow';
			queryParam2.taskDefConId = _taskDefKeyId;
			
			var queryParam3 = {};
			queryParam3.hql = 'workflow';
			queryParam3.hqlinfo = "";
			queryParam3.taskDefConId = _taskDefKeyId;

			//(2) 用一个json装住 ，这段是重复的，是根据页面有多少个tree而定
			var girdParamJson = {};
			girdParamJson.gridname = "group";
			girdParamJson.rqstparam = queryParam;
			
			var girdParamJson2 = {};
			girdParamJson2.gridname = "role";
			girdParamJson2.rqstparam = queryParam2;
			
			var girdParamJson3 = {};
			girdParamJson3.gridname = "user";
			girdParamJson3.rqstparam = queryParam3;
			
			//(3) 公共 js要用的，定义数组 格式为 ： [{"gridname":"树的表格名","rqstparam":{"XXX":value,"YYY":value,.....}}]
			var gridRqstJson = [];
			gridRqstJson.push(girdParamJson);
			gridRqstJson.push(girdParamJson2);
			gridRqstJson.push(girdParamJson3);
			
			//(4) 最终例子形如 ：[{"gridname":"tt","restparam":{"jsId":1,"jsId2":2}}]
			//alert(JSON.stringify(treeRqstJson)); 
			return gridRqstJson;
		}
		
		function addToGroup(temp){	//加入权限组按钮事件
			var grouptype = '';
			var rows = $('#'+temp).datagrid('getChecked');
			//alert(rows.length+'---'+temp);
			if(temp == 'user'){grouptype = 'user';}
				else if(temp == 'role'){grouptype = 'group';}
					else {}
			for(var i=0;i<rows.length;i){	//这里有个问题，rows.length是随动的，也就是说，如果带有移除操作，那么长度会缩减，然而，如果i依旧自增，则实际操作的行只有当初选择的一半。如果，每次操作，都是数组中的第一个，因此i不必自增，即可保持操作正确
				var row = rows[i];
				var	tempdata = {id:row.id,mc:row.xm};
				if(temp == 'user'){
					userdata.data.push(tempdata);
				}
				if(temp == 'role'){
					roledata.data.push(tempdata);	
				}
				var index = $('#'+temp).datagrid('getRowIndex',row);
				$('#group').datagrid('appendRow',{'conMc':row.xm,'conName':grouptype,'id':row.id,'isNew':'new'});
				$('#'+temp).datagrid('deleteRow',index);
			}
			//alert(JSON.stringify(userdata)+'======'+JSON.stringify(roledata));
			if(temp == 'user'){
				_setGridParam('user',userdata);
			}
			if(temp == 'role'){
				_setGridParam('role',roledata);
			}
		}
		
		function _setGridParam(tableId,gridjson){
			var arylist = new Array;
			
			for(var i=0;i<gridjson.data.length;i++){
				if(gridjson.data[i] == null){continue;}
				arylist[i] = gridjson.data[i].id;
			}
			
			var tempStr = eval("(" +$('#'+tableId).datagrid('options').queryParams.params+")");
			if(tableId == 'user'){
				tempStr.userList = arylist;
			}
			if(tableId == 'role'){
				tempStr.roleList = arylist;
			}
			
			//alert(JSON.stringify(tempStr));
			$('#'+tableId).datagrid('options').queryParams.params = JSON.stringify(tempStr);
			//alert(JSON.stringify(gridjson));
		}
		
		function delGroup(){	//移出权限组 
			var uc = false,rc = false;	//移出，意味着是其他表的回退，这里判断两个表是否都有回退，如果没有，则没有必要刷新
			var rows = $('#group').datagrid('getChecked');
			for(var i=0;i<rows.length;i){	//这里有个问题，rows.length是随动的，也就是说，如果带有移除操作，那么长度会缩减，然而，如果i依旧自增，则实际操作的行只有当初选择的一半。如果，每次操作，都是数组中的第一个，因此i不必自增，即可保持操作正确
				var row = rows[i];
				if(row.isNew == 'new'){
					//临时数据
					if((row.conName == 'group')&&(roledata.data.length > 0)){
						//角色
						rc = true;
						for(var j=0;j<roledata.data.length;j++){
							//这里的非空判断是必要的，否则会报错，因为delete后，会出现null数据
							if((roledata.data[j] != null)&&(roledata.data[j].id == row.id)){
								roledata.data.splice(j);
								break;
							}
						}
					}
					if((row.conName == 'user' )&&(userdata.data.length > 0)){
						//用户
						uc = true;
						for(var k=0;k<userdata.data.length;k++){
							//这里的非空判断是必要的，否则会报错，因为delete后，会出现null数据
							if((userdata.data[k] != null)&&(userdata.data[k].id == row.id)){
								userdata.data.splice(k);
								break;
							}
						}
					}
				}else{
					//真实数据
					groupdata.del.push(row.id);
				}
				
				var index = $('#group').datagrid('getRowIndex',row);	//索引值
				$('#group').datagrid('deleteRow',index);	//删除行
				//alert(i<row.length);
			}
			if(uc == true){
				_setGridParam('user',userdata);
				$('#user').datagrid('reload');
			}
			if(rc == true){
				_setGridParam('role',roledata);
				$('#role').datagrid('reload');
			}
		}
		
		function toSearchRole(){}
		function toSearchUser(){}
		
		function addRows(aimjson,optdata){
			for(var i=0;i<optdata.data.length;i++){
				var addRow = {'conMc':optdata.data[i].mc,'conName':optdata.type,'id':optdata.data[i].id,'isNew':'new'};
				aimjson.rows.push(addRow);
				//$('#group').datagrid('appendRow',addRow);
			}
			return aimjson;
		}
		window.onload = function(){
		$('#group').datagrid({
			onCheck:function(rowIndex,rowData){
				
			},
			rowStyler: function(index,row){
				if(row.isNew == 'new'){
					return "color:#c1c1c1;";
				}
				/* if(row.conName == 'group'){
					for(var i=0;i<roledata.data.length;i++){
						if(roledata.data[i].id == row.id){
							return "color:#c1c1c1;";
							break;
						}else{
							continue;
						}
					}
				}
				if(row.conName == 'user'){
					for(var i=0;i<userdata.data.length;i++){
						if(userdata.data[i].id == row.id){
							return "color:#c1c1c1;";
							break;
						}else{
							continue;
						}
					}
				} */
			},
			loadFilter: function(data){
				var _data = data;
				if(isFirst > 1){
					if(roledata.data.length > 0){
						addRows(_data,roledata);
					}
					if(userdata.data.length > 0){
						addRows(_data,userdata);
					}
				}
				if(isFirst < 2){
					isFirst++;
				} 
				//alert(isFirst+" Filter: "+JSON.stringify(_data)+JSON.stringify(roledata));
				return _data;
				//alert(JSON.stringify(data));
			}
			/* onLoadSuccess:function(data){
				alert(JSON.stringify(data));
				if(isFirst == false){
					if(roledata.data.length > 0){
						addRows(roledata);
					}
					if(userdata.data.length > 0){
						addRows(userdata);
					}
				}
				if(isFirst == true){
					isFirst = false;
				} 
			} */
		});
		};
		function msgConfirm(tableId){
			$('#'+tableId).datagrid('getPager').pagination({
				onBeforeRefresh:function(pageNumber, pageSize){
					if(tableId == 'group'){
						$.messager.confirm('确认对话框', '刷新用户群列表 将导致已分配至权限组的、未保存的数据被移除,是否继续？', function(r){
							if (r){
							    // 确定;
								$('#'+tableId).datagrid('load');
							}else{
								
							}
						});
						
					}
					
					return false;	//禁止刷新
				}
			});
		}
		
		function mainGrid(tableId){
			var tempStr = eval("(" +$('#'+tableId).datagrid('options').queryParams.params+")");
			
			tempStr.hqlinfo = null;
			tempStr.taskDefConId = _taskDefKeyId;
			
			//alert(JSON.stringify(tempStr));
			$('#'+tableId).datagrid('options').queryParams.params = JSON.stringify(tempStr);
			
			$('#'+tableId).datagrid('reload');
			
		} 
		
		function toHandleUrl(procKey, taskDefKey, isApply, processInstanceId,
				title) {	//procKey是根节点id,taskDefKey是子节点id,即任务节点id
			$.ajax({
				type : "POST",
				url : isApply ? "processOperate!GetApplyJson.do"
						: "processOperate!getTaskHandleJson.do",
				data : "params={'procKey':'" + procKey + "','taskDefKey':'"
						+ taskDefKey + "','processInstanceId':'"
						+ processInstanceId + "'}",
				success : function(data) {
					//alert(JSON.stringify(data));
					if(data.id != null){
						taskdefconId = data.id;
					}
					taskDefConId = data.id;
					groupdata.taskdefconId = taskDefConId;
					
					//初始状态下，需要先请求到用户群id才能读取对应数据，文档加载时，此时id还没请求到页面
					//setGridParam()在此请求之前已经被调用，因此无法实现在set方法中写进id
					mainGrid('group');
					mainGrid('role');
					mainGrid('user');
				}
			});
		}
		
		function addToFinal(optdata){
			if(optdata.data.length > 0){
				for(var i=0;i<optdata.data.length;i++){
					if(optdata.data[i] != null){
						groupdata.add.push({'conValue':optdata.data[i].id,'conName':optdata.type,'conMc':optdata.data[i].mc});
					}
				}
			}
		}
		
		function saveChange(){
			addToFinal(userdata);
			addToFinal(roledata);
			//alert(JSON.stringify(groupdata));
			//alert(_taskDefKeyId);
			$.ajax({
				type : "POST",
				url : "processOperate!saveConfig.do",
				data : "params="+JSON.stringify(groupdata),
				success : function(data){
					//alert(0);
					alert('保存成功！');
					groupdata.taskHandlerUrl = '';
					groupdata.add = [];	//重置
					groupdata.del = [];
					userdata.data = [];
					roledata.data = [];
					//成功后重置两表筛选条件
					_setGridParam('user',userdata);
					_setGridParam('role',roledata);
					
				}
			});
		}

		window.onresize = function(){
		};
		
		$(function(){
			/* if($('body').width()*0.35 > 450){
				$('body').layout('panel','east').panel('resize',{width:450});
			}else if($('body').width()*0.35 < 300){
				$('body').layout('panel','east').panel('resize',{width:300});
			}else{
				$('body').layout('panel','east').panel('resize',{width:$('body').width()*0.35});
			} */
			//mainGrid('group');
			//mainGrid('role');
			//mainGrid('user');
			//toHandleUrl(procKey,taskDefKey,false);
			//msgConfirm('user','用户');
			//msgConfirm('role','角色');
			msgConfirm('group');
		});
		
	</script>
</body>
</html>