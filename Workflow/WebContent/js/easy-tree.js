function createTree(name, url, checkbox, dnd, click, multisave, cascadeCheck, textField, sortField, recursionField, formId, operateAction, span, menuId,
		menuItems,treeIsLinkage,treeLinkageMethod) {
	var queryParam = {};
	try{
		var paramjson = setTreeParam();//获取前台页面setTreeParam方法设置的值
	}catch(e){
		throw new Error('页面setTreeParam()方法');
	}
	if (paramjson != null) {
		for (var i = 0; i < paramjson.length; i++) {
			var treeParamJson = paramjson[i];
			if (treeParamJson.treename == name) {//判断前台jsp传过来的值与形参的值是否一致
				queryParam = treeParamJson.rqstparam;//引用前台传过来的值
				break;
			}
		}
	}
	if (menuId != "" && menuId != null) {
		var MenuString = "";
		for (var i = 0; i < menuItems.length; i++) {
			// var menuid = menuItems[i].id;
			// var disabled = menuItems[i].disabled;
			var onclick = menuItems[i].onclick;
			var text = menuItems[i].text;
			var iconCls = menuItems[i].iconCls;
			// var href = menuItems[i].href;
			MenuString += '<div iconCls="' + iconCls + '" onclick="' + onclick
					+ '">' + text + '</div>';
		}
		var formString = '<div id="' + menuId
				+ '" class="easyui-menu" style="width: 120px;">' + MenuString
				+ '</div>';
		$(formString).appendTo("#" + span);
		$.parser.parse("#" + span);
		$('#' + name).tree({
			onContextMenu : function(e, node) {
				e.preventDefault();
				// select the node
				$('#' + name).tree('select', node.target);
				// display context menu
				$('#' + menuId).menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
	}
	if (click == true) {
		if (multisave == true) {
			$('#' + name).tree({onBeforeSelect : function(node) { // 实现临时存储的关键所在
									var n = $('#' + name).tree('getSelected');
									if (n) {
										if ((n.attributes == "newing")
												|| (n.attributes == "editing")) {
											$('#' + name)
													.tree(
															'update',
															{ // 改变选中之前更名
																target : n.target,
																text : $("#"+textField).val()//document.getElementById(textField).value
															});
											saveTemp(name, n); // 改变选中之前保存当前form
										}
									}
								},
								onSelect : function(node) {
									$('#' + getButtonId()).linkbutton(
									'disable');
									var deljson = $.parseJSON(getHiddenValue(name+"deljson"));
									if (deljson.data.length > 0) { // 只要执行过删除真实节点的操作，就要保存
										$('#' + getButtonId()).linkbutton(
												'enable');
										// $('#'+getButtonId()).show();
										// document.getElementById('bt').innerHTML
										// =
										// "<input id='btn' type='button'
										// value='确认信息'
										// onclick='saveTree("+treeId+")' />";
									}
									if (node.attributes == "newing") {
										$('#' + getButtonId()).linkbutton(
												'enable');
										$('#' + formId).form('clear');
										var addjson = $.parseJSON(getHiddenValue(name+"addjson"));
										for (var i = 0; i < addjson.data.length; i++) {
											// Salert(JSON.stringify(addjson));
											// //提交之后，reload，树节点属性就会清空。
											if (addjson.data[i] != null) {
												if (node.id == addjson.data[i].data.id) {
													$('#' + formId)
															.form(
																	'load',
																	addjson.data[i].data);
													changeState(name); //
													break;
												}
											}
										}
									} else if (node.attributes == "editing") {
										$('#' + getButtonId()).linkbutton(
												'enable');
										$('#' + formId).form('clear');
										var editjson = $.parseJSON(getHiddenValue(name+"editjson"));
										for (var i = 0; i < editjson.data.length; i++) {
											if (node.id == editjson.data[i].data.id) {
												$('#' + formId).form(
														'load',
														editjson.data[i].data);
												changeState(name); //
												break;
											}
										}
									} else {
										id = node.id;
										if(treeIsLinkage){
											eval("0,("+treeLinkageMethod+"())");//执行前台的getLinkage（）方法,参数0，兼容ie8
										}
//										var linkage = getLinkage();
//										for (var i = 0; i < linkage.length; i++) {
//											var linkagei = linkage[i];
//											for ( var key in linkagei) {
//												if (key == name) {
//													eval("0,(" + linkagei[key]
//															+ ")");
//												}
//											}
//										}
										if (deljson.data.length == 0) { // 只要没有删除真实的节点id，就没必要执行保存
											noInput(formId);
										}
									}
								}
							});
		} else {
			//单个保存方法
			var bid = getButtonId();
			$('#' + name).tree({
				onBeforeSelect :function(node) {  //node是即将换选的节点
					var n = $('#' + name).tree('getSelected');   //n为当前节点
					if (n) {
						//alert(n.text);
						if ((n.attributes != "newing")
								&& (n.attributes != "editing")) {   //如果是新增和修改中的
								return true;
						}else{
							if(confirm('是否放弃当前操作？')){   //选择“确认”
								if(n.attributes == "newing"){   //如果是new，直接删
						    		$('#' + name).tree('remove',n.target);
						    	}
						    	if(n.attributes == "editing"){   //如果是编辑就转换属性，不用reload
						    		$('#' + name).tree('update',{
						    			target:n.target,
						    			attributes:"null"
						    		});
						    	}
						    	if(bid!=null){
						    		$('#' + bid).linkbutton('disable');
						    	}
							}else{
								return false;   //返回false取消select
							}
						}
					}
				},
				onSelect : function(node) {
					var deljson = $.parseJSON(getHiddenValue(name+"deljson"));
					if (deljson.data.length > 0) { // 只要执行过删除真实节点的操作，就要保存
						if(bid!=null){
				    		$('#' + bid).linkbutton('enable');
				    	}
						// $('#'+getButtonId()).show();
						// document.getElementById('bt').innerHTML
						// =
						// "<input id='btn' type='button'
						// value='确认信息'
						// onclick='saveTree("+treeId+")' />";
					}
					if (node.attributes == "newing") {
						if(bid!=null){
				    		$('#' + bid).linkbutton('enable');
				    	}
						$('#' + formId).form('clear');
						var addjson = $.parseJSON(getHiddenValue(name+"addjson"));
						for (var i = 0; i < addjson.data.length; i++) {
							// Salert(JSON.stringify(addjson));
							// //提交之后，reload，树节点属性就会清空。
							if (addjson.data[i] != null) {
								if (node.id == addjson.data[i].data.id) {
									$('#' + formId)
											.form(
													'load',
													addjson.data[i].data);
									changeState(name); //
									break;
								}
							}
						}
					} else if (node.attributes == "editing") {
						if(bid!=null){
				    		$('#' + bid).linkbutton('enable');
				    	}
						$('#' + formId).form('clear');
						var editjson = $.parseJSON(getHiddenValue(name+"editjson"));
						for (var i = 0; i < editjson.data.length; i++) {
							if (node.id == editjson.data[i].data.id) {
								$('#' + formId).form(
										'load',
										editjson.data[i].data);
								changeState(name); //
								break;
							}
						}
					} else {
						id = node.id;
						if(treeIsLinkage){
							eval("0,("+treeLinkageMethod+"())");
						}
//						var linkage = getLinkage();
//						for (var i = 0; i < linkage.length; i++) {
//							var linkagei = linkage[i];
//							for ( var key in linkagei) {
//								if (key == name) {
//									eval("0,(" + linkagei[key]
//											+ ")");
//								}
//							}
//						}
						if (deljson.data.length == 0) { // 只要没有删除真实的节点id，就没必要执行保存
							noInput(formId);
						}
					}
				}
			});
		}
	}
	/**
	 * 添加url非空判断：
	 * 因为在tree控件初始化时，只要后面带了参数'?params=' + JSON.stringify(queryParam)
	 * 即使url为空，也会按照之前跳转的viewAciton路径进行跳转。
	 * 
	 * 如：工作流项目
	 * viewAction为： /Workflow/workflow/processView!toManeger.do
	 * tree初始化时，url为“空”
	 * 
	 * 但是，拦截器LoginInterceptor还是会拦截到这个 ""+'?params=' + JSON.stringify(queryParam)
	 * 并且，拦截到的方法是toManeger
	 * 相当于tree进行了Workflow/workflow/processView!toManeger.do?params={}这样的跳转
	 */
	if(url!=null&&url!=""){
		$('#' + name).tree({//使用easyui原生构造方法请求url和传递额外的queryParam参数
			checkbox : checkbox,
			url : url + '?params=' + JSON.stringify(queryParam),
			cascadeCheck:cascadeCheck,
			dnd : dnd
		});
	}
}
