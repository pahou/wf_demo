//获取当前网址，如： http://localhost:8088/test/test.jsp  
var curPath=window.document.location.href;  
//获取主机地址之后的目录，如： test/test.jsp  
var pathName=window.document.location.pathname;  
var pos=curPath.indexOf(pathName);  
//获取主机地址，如： http://localhost:8088  
var localhostPath=curPath.substring(0,pos);  
//获取带"/"的项目名，如：/test  
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);  

//每张图片的样式（可修改upload.css的样式控制图片展示的大小和图片之间的距离）
var img_li = "image-li";
var img_a = "image-a";
var img = "image";

/* 上传图片初始化 */
function uploadInitImg(uploadId) {
	$('#'+ uploadId).pluploadQueue({
		runtimes : 'gears,flash,silverlight,browserplus,html5,html4',
		url : projectName+'/sys/upload/imageUpload!imageUpload.do',
		max_file_size : '10mb',	//上传的图片不能超过10MB
		unique_names : true,
		dragdrop : true,
		filters : [ {
			title : "Image files",
			extensions : "jpg,jpeg,gif,png"
		}],
		flash_swf_url :  projectName+'/js/plupload/js/plupload.flash.swf',
		silverlight_xap_url :projectName+'/js/plupload/js/plupload.silverlight.xap',
		resize : {	//裁剪上传的图片
			width : 600,
			height : 600,
			preserve_headers : false
		},
		init : {	//实例对象的init()方法进行初始化
			UploadComplete : function(up, file) {
				window.location.reload();	//上传完后刷新
				}
			}
		});
	};
	
/* 开始上传图片 */
function startUploadImg(uploadId){
	$('#'+uploadId).dialog({
		 	title: '文件上传',    
		    width: 750,    //上传文件框的大小
		    height: 400,    
		    closed: false,    
		    cache: false,  
		    modal: true   
	});
	uploadInitImg(uploadId);
}
  
/*删除图片*/
function deleteImg(){
	$(".del").click(function(){
	if(confirm("确定要删除改图片吗?")){
		var name = $(this).attr("imgname");
		var img = $(this);
		 $.ajax({
			url:projectName+"/sys/upload/imageOpt!imgdel.do",
			type:"POST",
			data : 'params={"imageName":'+ JSON.stringify(name) + '}',
			success:function(){
				img.parent().remove();
				window.location.reload();
			}
		}); 
	}	
});
}

/*图片编辑*/
function imgEdit(){
	$(".del ").toggle();
	if($(".del ").css("display")=="none" ){
		$("#"+img_li+" #"+img_a).removeAttr("onclick");
	}else{
		$("#image-li #image-a").attr("onclick","return false");
	}
}

/*弹出隐藏层*/
function showMaskLayer(show_div, bg_div,src) {
	$('#'+show_div).css("display","block");
	$('#'+bg_div).css("display","block");
    $("#" + show_div).html('<img src = "' + src + '" />');
    var bgdiv = document.getElementById(bg_div);
    bgdiv.style.height = $(document).height();
    bgdiv.style.width = document.body.scrollWidth;
    $("#" + bg_div).height($(document).height());
    $("#" + bg_div).width($(document).width());
};

/*关闭弹出层*/
function closeMaskLayer(show_div, bg_div) {
    document.getElementById(show_div).style.display = 'none';
    document.getElementById(bg_div).style.display = 'none';
};

/*点击图片-遮罩层*/
function maskLayer(){
	//点击图片放大
	$("a."+img_a).click(function(){
		var src = localhostPath+$(this).attr('imgName');
		showMaskLayer('MyDiv','fade',src);    
    });

	//点击放大的图片消失
	$("#maskLayer").click(function(){
		closeMaskLayer('MyDiv','fade');    
    });
}

/*遍历显示图片*/
function showImg(names){
	//图片存放的虚拟路径
	var imgPath = projectName + "/upload/";
	//定义一个上传的
	$('body').append('<div id="showImg" style="height: 500px;  width: 1110px; margin: 6px auto; border: 1px solid #D5D5D5;" fit="true"><ul></ul></div>');
	//获取后台传过来的JSONArray格式的图片名
	var imgNames = names;
	for(var i=0;i<imgNames.length;i++){
		var liTemp = '<li class="'+ img_li +'">'
						+'<a class="'+img_a + '"imgName="'+imgPath + "images/"+imgNames[i]+'" href="#"><img class="'+ img + '" src="'+imgPath+"tmpimages/"+imgNames[i]+'"/></a>'
						+'<a href="#" class="icon-no del" imgname="'+imgNames[i]+'"></a>'
						+'</li>';
		$('#showImg ul').append(liTemp);
	};
}

$(function(){
	//遍历显示图片
	$.ajax({
		async : false,
		type : "POST",
		url:projectName+"/sys/upload/showImage!showImg.do",
		data: "",  
		success : function(names) {
			showImg(names);
		}
	});

	deleteImg();	//删除图片
	maskLayer();	//点击图片-遮罩层
});

