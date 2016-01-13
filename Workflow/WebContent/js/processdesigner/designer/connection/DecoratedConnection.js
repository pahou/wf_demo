draw2d.DecoratedConnection=function(){
	draw2d.Connection.call(this);
	var decorator = new draw2d.ArrowConnectionDecorator();
	var black = new draw2d.Color(0,0,0);
	decorator.setBackgroundColor(black);
	this.setTargetDecorator(decorator);
	this.setRouter(new draw2d.ManhattanConnectionRouter());
	this.setLineWidth(1);
	this.setColor(black);
	this.lineId=null;
	this.lineName=null;
	this.condition=null;
	this.listeners=new draw2d.ArrayList();
	this.label=null;
};
draw2d.DecoratedConnection.prototype=new draw2d.Connection();
draw2d.DecoratedConnection.prototype.type="DecoratedConnection";
draw2d.DecoratedConnection.prototype.getConditionXML=function(){
	var xml = '';
	if(this.condition != null&&this.condition!=''){
		xml = '<conditionExpression xsi:type="tFormalExpression"><![CDATA[${'/*+this.field+this.decision*/+this.condition+'}]]></conditionExpression>\n';
	}
	return xml;
}

draw2d.DecoratedConnection.prototype.toXML=function(){
	
	function getTypeId(node){
		//node是指节点，将返回该节点的id
		var typeId = null;
		if(node.type=='draw2d.Start'){
			typeId = node.eventId;
		}else if(node.type=='draw2d.End'){
			typeId = node.eventId;
		}else if(node.type=='draw2d.ExclusiveGateway'){
			typeId = node.gatewayId;
		}else if(node.type=='draw2d.ParallelGateway'){
			typeId = node.gatewayId;
		}else{
			typeId = node.taskId;
		}
		return typeId;
	}
	
	var sourceId = getTypeId(this.getSource().getParent());
	var targetId = getTypeId(this.getTarget().getParent());
	
	if(sourceId == "start" && targetId == "end"){
		//禁止开始直接连接到结束节点
		this.workflow.getCommandStack().execute(new draw2d.CommandDelete(this));
		$.messager.alert("错误操作","不能从开始节点直接连接到结束节点！");
		return false;
	}
	if(targetId == "start"){
		//禁止终端为开始节点
		this.workflow.getCommandStack().execute(new draw2d.CommandDelete(this));
		$.messager.alert("错误操作","不能以开始节点最为连接线的终端！");
		return false;
	}
	if(sourceId == "end"){
		//禁止终端为开始节点
		this.workflow.getCommandStack().execute(new draw2d.CommandDelete(this));
		$.messager.alert("错误操作","不能以结束节点最为连接线的输入端！");
		return false;
	}
	if(this.getSource().getParent().type == 'draw2d.ExclusiveGateway' && targetId == "end"){
		//起点为关口，终端却是结束
		this.workflow.getCommandStack().execute(new draw2d.CommandDelete(this));
		$.messager.alert("错误操作","任务判断的连接终端不能是结束节点！");
		return false;
	}
	/*else if(this.getSource().getParent().type != 'draw2d.ExclusiveGateway'){
		
	}*/
	else{
		var currentCommandDelete = new draw2d.CommandDelete(this);
		var currentLines = this.workflow.getLines();
		for ( var i = 0; i < currentLines.getSize(); i++) {	//根据id遍历查找
			var lineObj = currentLines.get(i);
			if(lineObj.lineId == this.lineId){
				//console.log(this.lineId);
				continue;
			}else{
				if(getTypeId(lineObj.getSource().getParent()) == sourceId && getTypeId(lineObj.getTarget().getParent()) == targetId){
					//此处判断，从一个模型多次连向同一个模型
					lineObj.workflow.getCommandStack().execute(new draw2d.CommandDelete(this));
					$.messager.alert("重复的连接","您已经拥有该连接，无法对两个模型多次直接地连接！");
					return false;
				}
				if(lineObj.getSource().getParent().type != 'draw2d.ExclusiveGateway'){
					for(var j=0;j<currentLines.getSize();j++){
						var lineObj_ = currentLines.get(j);
						if(lineObj_.lineId == lineObj.lineId){
							//二次遍历对比，如果是本身，则跳过
							continue;
						}else{
							if(getTypeId(lineObj_.getSource().getParent()) == getTypeId(lineObj.getSource().getParent())){
								lineObj.workflow.getCommandStack().execute(new draw2d.CommandDelete(lineObj_));
								$.messager.alert("重复的连接","如果需要从模型输出多条分支，最好使用[任务判断]模型来输出！");
								return false;
							}
						}
					}
				}
			}
		}
	}
	var name = this.lineId;
	var lineName = trim(this.lineName);
	if(lineName != null && lineName != "")
		name = lineName;
	var xml = '<sequenceFlow id="'+this.lineId+'" name="'+name+'" sourceRef="'+sourceId+'" targetRef="'+targetId+'">\n';
	xml = xml+this.getConditionXML();
	xml = xml+'</sequenceFlow>\n';
	return xml;
};
draw2d.DecoratedConnection.prototype.setLabel=function(text){
	if(this.label == null){
		this.label=new draw2d.Label(text);
		this.label.setFontSize(10);
		this.label.setAlign("left");
		//label.setBackgroundColor(new draw2d.Color(230,230,250));
		//label.setBorder(new draw2d.LineBorder(1));
		this.addFigure(this.label,new draw2d.ManhattanMidpointLocator(this));
	}else{
		this.label.setText(text);
	}
};
draw2d.DecoratedConnection.prototype.toBpmnDI=function(){
	var xml='<bpmndi:BPMNEdge bpmnElement="'+this.lineId+'" id="BPMNEdge_'+this.lineId+'">\n';
	var startX = this.getSource().getAbsoluteX();
	var startY = this.getSource().getAbsoluteY();
	var endX = this.getTarget().getAbsoluteX();
	var endY = this.getTarget().getAbsoluteY();
	var aimPort_start = this.sourcePort.name;
	var aimPort_end = this.targetPort.name;
	//console.log(startX+" : "+startY+" , "+endX+" : "+endY);
	//
	function addPoint(subLine){
		//此方法将返回线上生成的转折点坐标，并构造xml中的路径
		var lineObject = new Object();
			lineObject.point_ = [];
			
			function realLine(subLine_){
				//此方法将返回除了构造箭头的div外，所有的真实的子线div对象，循环到不符合条件为止结束return false
				var realSubLine = new Array();
				$.each(subLine_,function(){
					if(($(this).height() == 1 && $(this).width() >= 21) || ($(this).width() == 1 && $(this).height() >= 21)){
						realSubLine.push(this);
					}else{
						return false;
					}
				});
				return realSubLine;
			}
			
		var realLineObject = realLine(subLine);
		$.each(realLineObject,function(index){
			//结束条件是循环到倒数第二个元素后，就结束循环，最后一个忽略掉，因为最后一个是终端
			if(index == realLineObject.length -1) return false;
			var point_ = new Object();
			
			function otherLinesPoint(obj,index_){
				if($(obj).width() == 1){
					if(index_ < realLineObject.length-1)
						point_.x = lineObject.point_[index_-1].x;
					else 
						point_.x = endX;
					if(endY < startY){
						//垂直方向为向上
						point_.y = lineObject.point_[index_-1].y - $(obj).height();
					}else if(endY >startY){
						//垂直方向为向下
						point_.y = lineObject.point_[index_-1].y + $(obj).height();
					}else{
						//同一水平线上
					}
				}
				if($(obj).height() == 1){
					if(index_ < realLineObject.length-1)
						point_.y = lineObject.point_[index_-1].y;
					else
						point_.y = endY;
					if(lineObject.point_[index_-1].x > endX){
						//水平向左
						point_.x = lineObject.point_[index_-1].x - $(obj).width();
						
					}else if(lineObject.point_[index_-1].x < endX){
						//水平向右
						point_.x = lineObject.point_[index_-1].x + $(obj).width();
					}else{
						//同一垂直线上
					}
				}
			}
			
			switch(aimPort_start){
			case "rightOutputPort":
				if(index == 0){
					point_.x = startX + $(this).width();
					point_.y = startY;
				}else{
					//从第二个子线开始
					otherLinesPoint(this,index);
				}
				break;
			case "leftOutputPort":
				if(index == 0){
					point_.x = startX - $(this).width();
					point_.y = startY;
				}else{
					//从第二个子线开始,倒数第二个节点截止
					otherLinesPoint(this,index);
				}
				break;
			case "topOutputPort":
				if(index == 0){
					point_.x = startX;
					point_.y = startY - $(this).height();
				}else{
					//从第二个子线开始
					otherLinesPoint(this,index);
				}
				break;
			case "bottomOutputPort":
				if(index == 0){
					point_.x = startX;
					point_.y = startY + $(this).height();
				}else{
					//从第二个子线开始
					otherLinesPoint(this,index);
				}
				break;
			default:
			}
			lineObject.point_.push(point_);
			point_ = null;
		});
		
		return lineObject.point_;
	}
	var $subLine = $('#'+this.id).find('div').children();
	/*$.each($subLine,function(index){
		if($subLine.length > 25 && (index >= $subLine.length-25)) return false;
		console.log($(this).width());
	});*/
	//console.log(addPoint($subLine));
	
	function _isLostTrue(param1,param2){
		if(parseInt(param1-param2) == 0) return true;
			else return false;
	}
/*	
	function examPort(ports){
		var thisPort = null;
		for(var i=0;i<ports.getPorts().getSize();i++){
			var t = ports.getPorts().get(i);
			
			var x = t.getAbsoluteX();
			var y = t.getAbsoluteY();
			
			if(x == startX && y == startY){
				console.log(ports.type+" : "+i+" "+" : (x:"+x+" , y:"+y+")"+" s:(x:"+startX+",y:"+startY+")");
				console.log(ports.getPorts());
			}
			
			if(x == endX && y == endY){
				console.log(ports.type+" : "+i+" "+" : (x:"+x+" , y:"+y+")"+" e:(x:"+endX+",y:"+endY+")");
				console.log(ports.getPorts());
			}
		}
		return thisPort;
	}*/
	//console.log("startPort:"+this.sourcePort.name+" endPort:"+this.targetPort.name);
	//examPort(this.getSource().getParent());
	xml=xml+'<omgdi:waypoint x="'+startX+'" y="'+startY+'"/>\n';
	/*function addSubPoint(pointAry){
		for(var i=0;i<pointAry.length;i++){
			var subPoint_x = ary[i].x;
			var subPoint_y = ary[i].y;
			xml=xml+'<omgdi:waypoint x="'+subPoint_x+'" y="'+subPoint_y+'"/>\n';
		}
	}
	//function addSubPoint(){
		if(startX > endX){	//2a2455f2-bea7-2699-41b6-b710fd2dfc52
			if(this.sourcePort.name == "rightOutputPort"){
				var ary = [{"x":startX+21,"y":startY},{"x":startX+21,"y":(startY+endY)/2},{"x":endX-21,"y":(startY+endY)/2},{"x":endX-21,"y":endY}];
				addSubPoint(ary);
			}
		}
		if(startX == endX){
			var ary = [{"x":startX+21,"y":startY},{"x":startX+21,"y":(startY+endY)/2},{"x":startX,"y":(startY+endY)/2}];
			addSubPoint(ary);
		}
		if(startX < endX){}*/
	//}
	//addSubPoint();
	//xml=xml+'<omgdi:waypoint x="200" y="200"/>\n';
	var subLines = addPoint($subLine);
	//console.log($subLine);
	//console.log(subLines);
	$.each(subLines,function(i){
		xml=xml+'<omgdi:waypoint x="'+subLines[i].x+'" y="'+subLines[i].y+'"/>\n';
	});
    xml=xml+'<omgdi:waypoint x="'+endX+'" y="'+endY+'"/>\n';
	xml=xml+'</bpmndi:BPMNEdge>\n';
	return xml;
};
draw2d.DecoratedConnection.prototype.onDoubleClick=function(){
	//this.addPoint({x:200,y:200});
	openFlowProperties(this);
	
};
draw2d.DecoratedConnection.prototype.getContextMenu=function(){
	if(this.workflow.disabled)return null;
	var menu =new draw2d.ContextMenu(100, 50);
	var data = {line:this};
	menu.appendMenuItem(new draw2d.ContextMenuItem("属性", "properties-icon",data,function(x,y)
	{
		var data = this.getData();
		var line = data.line;
		if(typeof openFlowProperties != "undefined"){
			openFlowProperties(line);
		}
	}));
	menu.appendMenuItem(new draw2d.ContextMenuItem("删除", "icon-remove",data,function(x,y)
	{
		var data = this.getData();
		var line = data.line;
		var lid = line.getId();
		var wf = line.getWorkflow();
		wf.getCommandStack().execute(new draw2d.CommandDelete(line));
		//wf.removeFigure(line);
	}));
	
	return menu;
};
draw2d.DecoratedConnection.prototype.getListener=function(id){
	for(var i=0;i<this.listeners.getSize();i++){
		var listener = this.listeners.get(i);
		if(listener.getId()=== id){
			return listener;
		}
	}
};
draw2d.DecoratedConnection.prototype.deleteListener=function(id){
	var listener = this.getListener(id);
	this.listeners.remove(listener);
};
draw2d.DecoratedConnection.prototype.setListener=function(listener){
	this.listeners.add(listener);
};