 $(document).ready(function () {
				  /**��ҳ�õ�Ƭ��ʼ**/
		        $.showbox = $('#fullSlider > li'); //��ͼƬdiv
		        len = $.showbox.length; //�����б��ܳ���(����)
		        pages = Math.ceil(len / 1); //����չʾ��������
		        var li = '';
		        for (i = 0; i < len; i++) { li += '<li></li>'; }
		        var w = 30 * len - 5; //��ʾ�����ܿ��
		        $('#slideMark').css({ 'width': w }).append(li).find('li:last').css({ 'marginRight': 0 });
		        $.tab = $('#slideMark > li');
		        $.showbox.eq(0).show(); //Ĭ����ʾ��һ��
		        $.tab.eq(0).addClass('cur'); //Ĭ����ʾ��һ��
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
		        /**��ҳ�õ�Ƭ����**/
				
				

				  
			  })

