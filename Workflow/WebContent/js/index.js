 $(document).ready(function () {
				  /**首页幻灯片开始**/
		        $.showbox = $('#fullSlider > li'); //总图片div
		        len = $.showbox.length; //计算列表总长度(个数)
		        pages = Math.ceil(len / 1); //计算展示版面数量
		        var li = '';
		        for (i = 0; i < len; i++) { li += '<li></li>'; }
		        var w = 30 * len - 5; //显示条的总宽度
		        $('#slideMark').css({ 'width': w }).append(li).find('li:last').css({ 'marginRight': 0 });
		        $.tab = $('#slideMark > li');
		        $.showbox.eq(0).show(); //默认显示第一张
		        $.tab.eq(0).addClass('cur'); //默认显示第一张
		        var timer = setInterval(imgRotation, 5000);
		        var index = 1;
		        $.tab.mouseover(function () {
		            clearInterval(timer);
		            index = $.tab.index(this);
		            $.showbox.hide();
		            $.showbox.eq(index).fadeIn(500);
		            $.tab.eq(index).addClass('cur').siblings().removeClass('cur');
		            index++;
		            timer = setInterval(imgRotation, 5000);
		        })

		        function imgRotation() {
		            if (index > (pages - 1)) {
		                index = 0;
		            }
		            $.showbox.hide();
		            $.showbox.eq(index).fadeIn(500);
		            $.tab.eq(index).addClass('cur').siblings().removeClass('cur');
		            index++;
		        }
		        /**首页幻灯片结束**/
				
				

				  
			  })

