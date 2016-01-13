/***********************************************************************


**********************************************************/

window.onload = function(){
	$('#loading-mask').fadeOut();
}

var onlyOpenTitle="欢迎使用";//不允许关闭的标签的标题

$(function(){
	InitLeftMenu();
	tabClose();
	tabCloseEven();
	
});
//初始化左侧
function InitLeftMenu() {
	$("#nav").accordion({animate:false,fit:true,border:false});
	var selectedPanelname = '';
	//先初始化html标签
    $.each(_menus.menus, function(i, n) {
		//menulist += '<ul class="navlist" id="tt'+n.menuid+'"></ul>';如果添加了class进去则会出现树下拉被下面节点覆盖的情况
		//每个根节点写成accordion，每个accordion下面添加一棵树
		$('#nav').accordion('add', {
            title: n.menuname,
            content: '<ul id="tt'+n.menuid+'"></ul>',
			border:false,
			iconCls:n.icon
        });
		//默认选中第一个，打开
		if(i==0){
			selectedPanelname =n.menuname;
		}
			

    });
    //再将html标签转化为easyuitree
    $.each(_menus.menus, function(i, n) {
		var menuParam = {};
		menuParam.parentid = n.menuid;
		$('#tt'+n.menuid).tree({
			checkbox : false,
			url : 'menu/menuTree!tree.do?params=' + JSON.stringify(menuParam),
			cascadeCheck:true,
			dnd : false,
			onSelect : function(node) {
				addTab(node.text, node.attributes);
			}
		});
    });
    
	$('#nav').accordion('select',selectedPanelname);
}

//获取左侧导航的图标
function getIcon(menuid){
	var icon = 'icon ';
	$.each(_menus.menus, function(i, n) {
		 $.each(n.menus, function(j, o) {
		 	if(o.menuid==menuid){
				icon += o.icon;
			}
		 })
	})

	return icon;
}

function find(menuid){
	var obj=null;
	$.each(_menus.menus, function(i, n) {
		 $.each(n.menus, function(j, o) {
		 	if(o.menuid==menuid){
				obj = o;
			}
		 });
	});

	return obj;
}

function addTab(subtitle,url,icon){
	if(!$('#tabs').tabs('exists',subtitle)){
		$('#tabs').tabs('add',{
			title:subtitle,
			content:createFrame(url),
			closable:true
			//,
			//icon:icon
		});
	}else{
		$('#tabs').tabs('select',subtitle);
		$('#mm-tabupdate').click();
	}
	tabClose();
}

function createFrame(url)
{
	var s = '<iframe id="'+url+'" scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>'
	;
	//+ '<iframe name="newiframe" width="0" height="0"></iframe>';
	return s;
}

function tabClose()
{
	/*双击关闭TAB选项卡*/
	$(".tabs-inner").dblclick(function(){
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close',subtitle);
	})
	/*为选项卡绑定右键*/
	$(".tabs-inner").bind('contextmenu',function(e){
		$('#mm').menu('show', {
			left: e.pageX,
			top: e.pageY
		});

		var subtitle =$(this).children(".tabs-closable").text();

		$('#mm').data("currtab",subtitle);
		$('#tabs').tabs('select',subtitle);
		return false;
	});
}


//绑定右键菜单事件
function tabCloseEven() {

    $('#mm').menu({
        onClick: function (item) {
            closeTab(item.id);
        }
    });

    return false;
}

function closeTab(action)
{
    var alltabs = $('#tabs').tabs('tabs');
    var currentTab =$('#tabs').tabs('getSelected');
	var allTabtitle = [];
	$.each(alltabs,function(i,n){
		allTabtitle.push($(n).panel('options').title);
	})


    switch (action) {
        case "refresh":
            var iframe = $(currentTab.panel('options').content);
            var src = iframe.attr('src');
            $('#tabs').tabs('update', {
                tab: currentTab,
                options: {
                    content: createFrame(src)
                }
            })
            break;
        case "close":
            var currtab_title = currentTab.panel('options').title;
            $('#tabs').tabs('close', currtab_title);
            break;
        case "closeall":
            $.each(allTabtitle, function (i, n) {
                if (n != onlyOpenTitle){
                    $('#tabs').tabs('close', n);
				}
            });
            break;
        case "closeother":
            var currtab_title = currentTab.panel('options').title;
            $.each(allTabtitle, function (i, n) {
                if (n != currtab_title && n != onlyOpenTitle)
				{
                    $('#tabs').tabs('close', n);
				}
            });
            break;
        case "closeright":
            var tabIndex = $('#tabs').tabs('getTabIndex', currentTab);

            if (tabIndex == alltabs.length - 1){
                alert('亲，后边没有啦 ^@^!!');
                return false;
            }
            $.each(allTabtitle, function (i, n) {
                if (i > tabIndex) {
                    if (n != onlyOpenTitle){
                        $('#tabs').tabs('close', n);
					}
                }
            });

            break;
        case "closeleft":
            var tabIndex = $('#tabs').tabs('getTabIndex', currentTab);
            if (tabIndex == 1) {
                alert('亲，前边那个上头有人，咱惹不起哦。 ^@^!!');
                return false;
            }
            $.each(allTabtitle, function (i, n) {
                if (i < tabIndex) {
                    if (n != onlyOpenTitle){
                        $('#tabs').tabs('close', n);
					}
                }
            });

            break;
        case "exit":
            $('#closeMenu').menu('hide');
            break;
    }
}


//弹出信息窗口 title:标题 msgString:提示信息 msgType:信息类型 [error,info,question,warning]
function msgShow(title, msgString, msgType) {
	$.messager.alert(title, msgString, msgType);
}
