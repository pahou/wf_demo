//获取当前网址，如： http://localhost:8088/test/test.jsp  
var curPath=window.document.location.href;  
//获取主机地址之后的目录，如： test/test.jsp  
var pathName=window.document.location.pathname;  
var pos=curPath.indexOf(pathName);  
//获取主机地址，如： http://localhost:8088  
var localhostPath=curPath.substring(0,pos);  
//获取带"/"的项目名，如：/test  
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);  

//每张图片的样式（可修改upload.css的样式控制视频展示的大小和视频之间的距离）
var veo_li = "video-li";
var veo = "video-sty";

/*上传视频初始化*/
function uploadInitVeo(uploadId) {
	$('#'+ uploadId).pluploadQueue({
			runtimes : 'gears,flash,silverlight,browserplus,html5,html4',
			url:projectName+"/sys/video/videoUpload!videoUpload.do",
			max_file_size : '100mb',//最大接收100mb的文件
			unique_names : true,
			dragdrop : true,
			chunk_size : '1mb',//字节片大小,把大文件切割成小片进行上传,因为有些浏览器对很大的文件比如几G的一些文件无法上传。
			filters : [ {
				title : "vedio files",
				extensions : "mp4,swf,avi"
			}, ],
			flash_swf_url :  projectName+'/js/plupload/js/plupload.flash.swf',
			silverlight_xap_url :projectName+'/js/plupload/js/plupload.silverlight.xap',
			//实例对象的init()方法进行初始化
			init : {
				UploadComplete : function(up, file) {
					//由于是上传视频，文件比较大，所以必须设置时间延迟
					setTimeout("location.reload()",2000);
				}

			}
		});
};

/* 开始上传视频 */
function startUploadVeo(uploadId) {
	$('#' + uploadId).dialog({
		title : '文件上传',
		width : 750,
		height : 400,
		closed : false,
		cache : false,
		modal : true
	});
	uploadInitVeo(uploadId);
};

/* 视频编辑*/
function veoEdit(){
	$(".ve-del ").toggle();
	if($(".ve-del ").css("display")=="none" ){
		$("#image-li #image-a").removeAttr("onclick");
	}else{
		$("#image-li #image-a").attr("onclick","return false");
	}
}

/*删除视频*/
function deleteVeo(){
	$(".ve-del").click(function(){
		if(confirm("确定要删除该视频吗?")){
			var veoName = $(this).attr("veoName");
			var veoThumName = $(this).attr("veoThumName");
			var video = $(this);
			 $.ajax({
				url:projectName+"/sys/video/videoOpt!veodel.do",
				type:"POST",
				data : 'params={"veoName":'+ JSON.stringify(veoName) + ',"veoThumName":'
							+ JSON.stringify(veoThumName) + '}',
				success:function(){
					video.parent().remove();//局部刷新
				}
			}); 
		}
		
	});
}

/*遍历显示视频*/
function showVeo(names){
	//存放视频的虚拟路径
	var veoPath = projectName + "/upload/";
	//定义一个上传的
	$('body').append('<div id="showVeo" style="height: 500px;  width: 1110px; margin: 6px auto; border: 1px solid #D5D5D5;" fit="true"><ul></ul></div>');
	//获取后台传过来的JSONArray格式的视频名
	var veoNames = names[0].names;	
	var veoThumNames = names[1].thumNames;	
	for(var i=0;i<veoNames.length;i++){
		var liTemp = 
			"<li id = 'videoid' class='"+veo_li+"'>"+
				"<video class='"+veo+" video-js vjs-default-skin vjs-big-play-centered' controls preload='none' poster='"+veoPath+"tmpvideos/"+veoThumNames[i]+"' data-setup='{}'>"+
					"<source src='"+veoPath+"videos/"+veoNames[i]+"' type='video/mp4'/>"+
				"</video>"+
				"<a href='#' class='icon-no ve-del' veoName='"+veoNames[i]+"' veoThumName='"+veoThumNames[i]+"'>.</a>"+
			"</li>";
		$('#showVeo ul').append(liTemp);
	};
}

$(function(){
	/*遍历显示视频---start*/
	$.ajax({
		async : false,
		type : "POST",
		url:projectName+"/sys/video/showVideo!showVeo.do",
		data: "",  
		success : function(names) {
			showVeo(names);
		}
	});
	/*遍历显示视频---end*/
	
	/*删除视频*/
	deleteVeo();
	
});

