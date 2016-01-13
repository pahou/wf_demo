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
	
/* 选择TAB时刷新内容
	$('#tabs').tabs({
        onSelect: function (title) {
            var currTab = $('#tabs').tabs('getTab', title);
            var iframe = $(currTab.panel('options').content);

			var src = iframe.attr('src');
			if(src)
				$('#tabs').tabs('update', { tab: currTab, options: { content: createFrame(src)} });

        }
    });
*/
})
var isLoaded = false;
  AddStyle = function(rules) {
    var styleElement = document.createElement('style');
	styleElement.type = 'text/css';
	if ( window.attachEvent ) {   //判断IE浏览器
	  styleElement.styleSheet.cssText = rules;
	}
	else {
	  var frag = document.createDocumentFragment();
	  frag.appendChild(document.createTextNode(rules));
	  styleElement.appendChild(frag);
	}
	function append() {
	  document.getElementsByTagName('head')[0].appendChild(styleElement);
	}
	//IE 无法取到document
	if (!window.attachEvent || isLoaded) { 
	  append();
	}
	else {
	  window.attachEvent('onload', function() {
	        isLoaded = true;
	        append();
	      });
	    }
  };
//初始化左侧
function InitLeftMenu() {
	$("#nav").accordion({animate:false,fit:true,border:false});
	var selectedPanelname = '';
	var num = 0;
	var numTab=0;
	var friTabName = "";
	var friTabUrl = "";
    $.each(_menus.menus, function(i, n) {
		var menulist ='';
		menulist +='<ul class="navlist">';
		AddStyle('.changeC'+n.menuid+'{ background:url(images/easyui/icons.gif) no-repeat;background-position: '+n.icon+';left:7px;top: 13px;}');
        $.each(n.menus, function(j, o) {
        	
			if(num==0){
				menulist += '<li><div ><a ref="'+o.menuid+'" href="#" rel="' + o.url + '" ><span class="icon" style="background-position:'+o.icon+';">&nbsp;</span><span class="nav">' + o.menuname + '</span></a></div> ';
			}else{
				menulist += '<li><div><a ref="'+o.menuid+'" href="#" rel="' + o.url + '" ><span class="icon" style="background-position:'+o.icon+';">&nbsp;</span><span class="nav">' + o.menuname + '</span></a></div> ';
			}
			if(o.child && o.child.length>0)
			{
				//li.find('div').addClass('icon-arrow');
				menulist += '<ul class="third_ul">';
				$.each(o.child,function(k,p){
					menulist += '<li><div><a ref="'+p.menuid+'" href="#" rel="' + p.url + '" ><span class="icon" style="background-position:'+p.icon+';">&nbsp;</span><span class="nav">' + p.menuname + '</span></a></div> </li>'
				});
				menulist += '</ul>';
			}
			
			menulist+='</li>';
			
			if(numTab==0){
				friTabName = o.menuname;
				friTabUrl = o.url;
			}
			numTab++;
        })
		menulist += '</ul>';

		$('#nav').accordion('add', {
            title: n.menuname,
            content: menulist,
				border:false,
            iconCls: 'icon ' + 'changeC'+n.menuid
        });

		if(i==0){
			selectedPanelname =n.menuname;
			//alert(friTabName+" :: " +friTabUrl);
			addTab(friTabName,friTabUrl,"");
		}
			

    });
	$('#nav').accordion('select',selectedPanelname);


	$('.navlist li a').click(function(){
		var tabTitle = $(this).children('.nav').text();

		var url = $(this).attr("rel");
		var menuid = $(this).attr("ref");
		var icon = $(this).find('.icon').attr('class');
		//alert(url);
		var third = find(menuid);
		if(third && third.child && third.child.length>0)
		{
			$('.third_ul').slideUp();

			var ul =$(this).parent().next();
			if(ul.is(":hidden"))
				ul.slideDown();
			else
				ul.slideUp();



		}
		else{
			addTab(tabTitle,url,icon);
			$('.navlist li div').removeClass("selected");
			$(this).parent().addClass("selected");
		}
	}).hover(function(){
		$(this).parent().addClass("hover");
	},function(){
		$(this).parent().removeClass("hover");
	});





	//选中第一个
	//var panels = $('#nav').accordion('panels');
	//var t = panels[0].panel('options').title;
    //$('#nav').accordion('select', t);
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
