/**
 * 该工具类用来存放“选择候选人”功能的一系列共用操作
 * 属性：nextAssignee ---- 完成当前节点任务时，如需指明下一节点办理人，需要将该参数传给相应接口
 * 方法：
 * 	1、initChoiceBox----如该项目打算用其他形式（如tab）来打开候选人选择栏，可以重写该方法
 * 	2、chooseAssignee----打开“选择候选人”的容器
 * 	3、createChoiceBoxFrame----创建iframe，指定iframe内容，该方法仅提供参考，需要第三方重写
 * 		iframe的url需要指向工作流的processView!toCandidateList.do
 * 		且需要提供两个参数中的任意一个就ok，两个参数为：
 * 		①processInstanceId----流程实例id
 * 		②procKey----流程定义key
 * 	注意，参数名固定，不能随意更改，否则工作流方接收不了参数
 */

var nextAssignee = "";//全局变量，用于存放下个任务的办理人id

//存放一系列初始化操作
$(function(){
	initChoiceBox();
});

//该方法供iframe子页面调用，如"parent.setNextAssignee(id)"
function setNextAssignee(id){
	nextAssignee = id;
}

//该方法初始化选择候选人的dialog
function initChoiceBox(){
	//初始化阅读状况窗口
	$('#choiceBox').dialog({
		title : '选定下一任务办理人',
		width : 600,
		height : 400,
		resizable : false,
		closed : false,
		cache : false,
		modal : true,
		content:createChoiceBoxFrame(),
		buttons : [ {
				text : '确认',
				handler : function() {
					$('#choiceBox').dialog('close');
				}
			} ]
	});
	
	$('#choiceBox').dialog('close');//初始化好后先关闭
}

//打开选择候选人的选窗口
function chooseAssignee(){
	$('#choiceBox').dialog('open');
}

//创建iframe子窗口的方法，用在initChoiceBox的content属性
function createChoiceBoxFrame() {
	var processInstanceid ='7501';
	var processKey = null;
	var param = "?processInstanceId="+processInstanceid+"&procKey="+ processKey;
	var url = "http://150.84.11.92/Workflow/workflow/processView!toCandidateList.do"+param;
	var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:99%;"></iframe>';
	return s;
}